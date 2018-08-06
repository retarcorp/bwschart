<?php

namespace Classes;

use Classes\App;
use Classes\Utils\TimeCalculator;
use Classes\Utils\Timestamp;
use Classes\Candle;
use Classes\DeltaCandle;

use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;

class FootprintCache{

	const TABLE_M1 = 1;
	const TABLE_M2 = -1;
	const TABLE_M5 = 2;
	const TABLE_M10 = 3;
	const TABLE_M15 = 4;
	const TABLE_M30 = 5;
	const TABLE_H1 = 6;
	const TABLE_H4 = 7;
	const TABLE_D1 = 0;
    #
	public static function putCandles($instrument, $timeframe, $candles){
		$name = $instrument->name;
        
		foreach($candles as $i=>$candle){
		    
			if( FootprintCache::isInCache($instrument, $timeframe, $candle) ){
				if( FootprintCache::isItLastCandle($instrument, $timeframe, $candle) ){
					FootprintCache::updateLastCandle($instrument, $timeframe, $candle);
				}else{
				    // if( !(FootprintCache::compareData($instrument, $timeframe, $candle)) ){
				    //     FootprintCache::updateCandle($instrument, $timeframe, $candle);
				    // }
				}
			}else{
				FootprintCache::putCandle($instrument, $timeframe, $candle);
			}			
		}
	}

	public static function getTableTimeframeFor($timeframe){
		$arr = [
			App::TF_M1 => self::TABLE_M1
			,App::TF_M2 =>self::TABLE_M2
			,App::TF_M5 => self::TABLE_M5
			,App::TF_M10 => self::TABLE_M10
			,App::TF_M15 => self::TABLE_M15
			,App::TF_M30 => self::TABLE_M30
			,App::TF_H1 => self::TABLE_H1
			,App::TF_H4 => self::TABLE_H4
			,App::TF_D1 => self::TABLE_D1
		];
		return $arr[$timeframe];
	}
	
	public static function getTableName($instrument){
		return "cache_fp_".$instrument->name;
	}
	
	public static function isItLastCandle($instrument, $timeframe, $candle){
		$sql = new RSql;
		$query = "SELECT id FROM ".self::getTableName($instrument)." 
			WHERE ts = ".$candle->startTS->getTimestamp()." 
			AND tf = ".self::getTableTimeframeFor($timeframe)."
			AND is_last = 1
			LIMIT 1";
		$data = $sql->getAssocArray($query);
		if($e = $sql->getLastError()){
			RLogger::error("FootprintCache\$isItLastCandle", $e);
		}

		return empty($data) ? false : true;
	}

	public static function updateLastCandle($instrument, $timeframe, $candle){
		$sql = new RSql;
		$candleTable = self::getTableName($instrument);
		$tf = self::getTableTimeframeFor($timeframe);
		$data = $candle->toArray();
		$is = ($_SERVER['REQUEST_TIME'] >= $candle->startTS->getTimestamp() + App::$Timeframe[$timeframe] * 60) ? 0 : 1;
        $ts = $candle->startTS->getTimestamp();
		
		unset($data['startTS']);
		unset($data['finished']);
		
		$json = json_encode($data);
        
		$query = "
			UPDATE $candleTable 
			SET data = '{$json}', is_last = $is
			WHERE ts = $ts
			AND tf = $tf;";
		$sql->query($query);
		if($e = $sql->getLastError()){
			RLogger::error("FootprintCache\$updateLastCandle", $e);
		}
	}

	public static function isInCache($instrument, $timeframe, $candle){
		$sql = new RSql;
        
		$query = "SELECT id FROM ".self::getTableName($instrument)." 
			WHERE ts = ".$candle->startTS->getTimestamp()." 
			AND tf = ".self::getTableTimeframeFor($timeframe)."
			LIMIT 1";
		$r = $sql->getAssocArray($query);
		
		if( empty($r) ){
		    return false;
		}
	    return true;
	}
	
	public static function compareData($instrument, $timeframe, $candle){
	    $sql = new RSql;

		$query = "SELECT id, data FROM ".self::getTableName($instrument)." 
			WHERE ts = ".$candle->startTS->getTimestamp()." 
			AND tf = ".self::getTableTimeframeFor($timeframe)."
			LIMIT 1";
		$r = $sql->getAssocArray($query);
		
		$data = json_decode($r[0]['data'], true);
		# RLogger::info("[1111]", print_r($data, true));
	   
	    if( $candle->start_price != +$data['start_price'] ){
    	    # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. StartPrice: {$candle->start_price} != {$data['start_price']}");
	        return false;
	    }
	    
	    if( $candle->last_price != +$data['last_price'] ){
    	    # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. LastPrice: {$candle->last_price} != {$data['last_price']}");
	        return false;
	    }
	    
	    if( $candle->tick_max_price != +$data['tick_max_price'] ){
    	    # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. MaxPrice: {$candle->tick_max_price} != {$data['tick_max_price']}");
	        return false;
	    }
	    
	    if( $candle->volume != +$data['volume'] ){
    	    # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. Volume: {$candle->volume} != {$data['volume']}");
	        return false;
	    }
	    
	    $minShadow = +$data['deltaShadow']['min'];
	    if( $candle->minShadow != $minShadow ){
    	    # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. MinShadow: {$candle->minShadow} != {$minShadow}");
	        return false;
	    }
	    
	    $maxShadow = +$data['deltaShadow']['max'];
	    if( $candle->maxShadow != $maxShadow ){
    	    # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. MaxShadow: {$candle->maxShadow} != {$maxShadow}");
	        return false;
	    }
	    
	    $prices = array_map(function($e){
	        return +$e[2];
	    }, $data['ticks']);
	    
	    foreach($candle->getTicks() as $tick){
	        if( !(in_array($tick[2], $prices)) ){
	            # RLogger::error("FPCache", "Candle {$candle->startTS->getTimestamp()}, cache {$r[0]['id']}. Tick {$tick[0]}, {$tick[1]}, {$tick[2]} doesn't exist");
    	        return false;
    	    }
	    }
	    
	    return true;
	}
	
	public static function updateCandle($instrument, $timeframe, $candle){
	    $sql = new RSql;
		$candleTable = self::getTableName($instrument);
		$tf = self::getTableTimeframeFor($timeframe);
		$data = $candle->toArray();
		$ts = $data['startTS'];
		unset($data['startTS']);
		unset($data['finished']);
		
		# Check if the candle is not empty
		if( !($data['start_price']) && !($data['volume'])){
		    return;
		}
		
		$json = json_encode($data);
		$query = "UPDATE $candleTable SET data = '$json' WHERE tf = $tf AND ts = $ts";
		$sql->query($query);
		
		RLogger::warn("Updating fp candle cache", "Candle $ts $tf have been updated");
		
		if($e = $sql->getLastError()){
			RLogger::error("FP\$updateCandle", $e);
		}
	}
	#
	public static function putCandle($instrument, $timeframe, $candle){
		$is_last = ($_SERVER['REQUEST_TIME'] >= $candle->startTS->getTimestamp() + App::$Timeframe[$timeframe] * 60) ? 0 : 1;
        
		$sql = new RSql;
		$candleTable = self::getTableName($instrument);
		$tf = self::getTableTimeframeFor($timeframe);
		$data = $candle->toArray();
		unset($data['startTS']);
		unset($data['finished']);
		
		# Check if the candle is not empty
		if( !($data['start_price']) && !($data['volume']) ){
		    return;
		}
		
		$json = json_encode($data);

		$query = "INSERT INTO $candleTable (id, tf, ts, data, is_last) 
    		VALUES(
    			DEFAULT
    			,$tf
    			,{$candle->startTS->getTimestamp()}
    			,'{$json}'
    			,$is_last
    		)";

		$sql->query($query);
		if($e = $sql->getLastError()){
			RLogger::error("Cache","[111] ".$e);
		}
	}

	public static function getCandleAmountBetween($timeframe, $startTS, $endTS){

		if($startTS->getTimestamp() == $endTS->getTimestamp()){
			return 1;
		}
		$mins = App::$Timeframe[$timeframe];
		$secs = $mins * 60;

		$s = $startTS->getTimestamp();
		$e = $endTS->getTimestamp();

		$s-= $s%$secs;
		$e-= $e%$secs;

		return ceil(($e-$s + 1)/$secs);
	}
	
	public static function getCandleAmountInCache($instrument,$timeframe, $startTS, $endTS){
		$sql = new RSql;

		$tf_secs = App::$Timeframe[$timeframe] * 60;
		$s = $startTS->getTimestamp();
		$e = $endTS->getTimestamp();
		$startTS = $startTS->getTimestamp();
		$startTS -= $startTS % $tf_secs;
		$endTS = $endTS->getTimestamp();
		$endTS -= $endTS % $tf_secs;

		$tf = self::getTableTimeframeFor($timeframe);
		$table = self::getTableName($instrument);
		
// 		$query = "SELECT COUNT(id) AS amount FROM $table WHERE ts>=$startTS AND ts <= $endTS AND tf = $tf AND is_last = 0";
        $query = "SELECT COUNT(id) AS amount FROM $table WHERE ts>=$startTS AND ts <= $endTS AND tf = $tf";
        
		$r = $sql->getArray($query);
		if($sql->getLastError()){
			RLogger::error("FPCache::getCandleAmountInCache", $sql->getLastError());
		}

		return intval($r[0]['amount']);
	}

	public static function containsInterval($instrument, $timeframe, $startTS, $endTS){
		// Get amount of candles in given interval by the given timeframe
		$amo = self::getCandleAmountBetween($timeframe, $startTS, $endTS);

		// Get amount of candles in cache between these points
		$dbamo = self::getCandleAmountInCache($instrument, $timeframe, $startTS, $endTS);
		return $amo <= $dbamo;


	}
	#
	public static function getCandles($instrument, $timeframe, $startTS, $endTS){
		$sql = new RSql;
        
		$tf_secs = App::$Timeframe[$timeframe] * 60;
        
		$startTS = $startTS->getTimestamp();
		$startTS -= $startTS % $tf_secs;
		$endTS = $endTS->getTimestamp();
		$endTS -= $endTS % $tf_secs - $tf_secs;
		$endTS += $tf_secs;
        
		$tf = self::getTableTimeframeFor($timeframe);
		$table = self::getTableName($instrument);
		$query = "SELECT * FROM $table WHERE ts >= $startTS AND ts <= $endTS AND tf = $tf";
		$r = $sql->getAssocArray($query);
		
		$candles = [];
		$markedAsLast = [];
		
		foreach($r as $i => $line){
			$candle = new Candle($timeframe, new Timestamp( intval($line['ts']) ));
			$data = json_decode($line['data'], true);
			
			$startPrice = floatval($data['start_price']);
			$lastPrice = floatval($data['last_price']);
			$tickMaxPrice = floatval($data['tick_max_price']);
			$volume = intval($data['volume']);
			$minShadow = intval($data['deltaShadow']['min']);
			$maxShadow = intval($data['deltaShadow']['max']);
			
			$candle->setStartPrice($startPrice);
			$candle->setLastPrice($lastPrice);
			$candle->setTickMaxPrice($tickMaxPrice);
			$candle->setVolume($volume);
			$candle->setMinShadow($minShadow);
			$candle->setMaxShadow($maxShadow);
			$candle->setTicks($data['ticks']);
            
			$is = $line['is_last'] ? false : true;
			$candle->setFinished($is);
			
			if( $line['is_last'] ){
			    $markedAsLast [] = $candle;
			}
            
            $candles [] = $candle;
		}
		
        FootprintCache::updateCandles($instrument, $timeframe, $markedAsLast);
        
		return $candles;
	}
	#
	public static function updateCandles($instrument, $timeframe, $candles){
	    $secs = App::$Timeframe[$timeframe] * 60;
	    
	    foreach($candles as $candle){
	        $endTS = new Timestamp($candle->startTS->getTimestamp() + $secs);
		    $computed = $instrument->getComputedCandles($timeframe, $candle->startTS, $endTS);
		    FootprintCache::putCandles($instrument, $timeframe, $computed);
		}
	}

	public static function cache($instrument, $timeframe, $startTS, $endTS){
		$instrument->getCandles($timeframe, $startTS, $endTS);
	}
	
	public static function test($instrument, $timeframe, $startTS, $endTS){
		$sql = new RSql;

		$tf_secs = App::$Timeframe[$timeframe] * 60;

		$startTS = $startTS->getTimestamp();
		$startTS -= $startTS % $tf_secs;
		$endTS = $endTS->getTimestamp();
		$endTS -= $endTS % $tf_secs - $tf_secs;
		$endTS += $tf_secs;

		$tf = self::getTableTimeframeFor($timeframe);
		$table = self::getTableName($instrument);
		$query = "SELECT * FROM $table WHERE ts >= $startTS AND ts <= $endTS AND tf = $tf";
		$r = $sql->getAssocArray($query);
		
		$candles = [];
		$markedAsLast = [];
		
		foreach($r as $i => $line){
		    $ts = intval($line['ts']);
			$candle = new Candle($timeframe, new Timestamp($ts));
			$data = json_decode($line['data'], true);
			
			$startPrice = floatval($data['start_price']);
			$lastPrice = floatval($data['last_price']);
			$tickMaxPrice = floatval($data['tick_max_price']);
			$volume = intval($data['volume']);
			$minShadow = intval($data['deltaShadow']['min']);
			$maxShadow = intval($data['deltaShadow']['max']);
			
			$candle->setStartPrice($startPrice);
			$candle->setLastPrice($lastPrice);
			$candle->setTickMaxPrice($tickMaxPrice);
			$candle->setVolume($volume);
			$candle->setMinShadow($minShadow);
			$candle->setMaxShadow($maxShadow);
			$candle->setTicks($data['ticks']);
            
			$is = $line['is_last'] ? false : true;
			$candle->setFinished($is);
			
			if( $line['is_last'] ){
			    $markedAsLast [] = $candle;
			}
            
            // if( !($candle->isEmpty()) ){
                $candles [] = $candle;
            // }
		}
		
        FootprintCache::updateCandles($instrument, $timeframe, $markedAsLast);
        
		return $candles;
	}
}