<?php

namespace Classes;
use Classes\App;
use Classes\Utils\TimeCalculator;
use Classes\Utils\Timestamp;
use Classes\Candle;
use Classes\DeltaCandle;
use Classes\Instruments\DeltaCandlesBuilder;

use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;
    
class DeltaCache{
        
    const TABLE_M1 = 1;
	const TABLE_M2 = -1;
	const TABLE_M5 = 2;
	const TABLE_M10 = 3;
	const TABLE_M15 = 4;
	const TABLE_M30 = 5;
	const TABLE_H1 = 6;
	const TABLE_H4 = 7;
	const TABLE_D1 = 0;


	public static function getTableName($instrument){
	    #print_r($instrument);
	    return "cache_delta_".$instrument->name;
	    
	}
	
	public static function putCandles($instrument, $delta, $candles){
	    
		file_put_contents($_SERVER['DOCUMENT_ROOT']."/delta_cache_log.txt",print_r($candles, true));
	
		foreach($candles as $i=>$candle){
		    if($candle->isFinished()){
		        
		       if(!self::isInCache($instrument, $delta, $candle)){
		           self::putCandle($instrument, $delta, $candle);
		       }
		    }
		}
	}

    public static function putCandle($instrument, $delta, $candle){
        $sql = new RSql;
	    $tableName = self::getTableName($instrument);
	    
        $c = [
            "ts"=> $candle->getStartTimestamp()
            ,"tse"=>$candle->getEndTimestamp()
            ,"data"=>($candle->toJSON())
        ];
        
		$query = "INSERT INTO ".$tableName." VALUES (DEFAULT, $delta, {$c['ts']}, {$c['tse']}, '{$c['data']}')";
		$sql->query($query);
		
		if($sql->getLastError()){
		    echo $sql->getLastError();
		}
		
	}
	
	public static function isInCache($instrument, $delta, $candle){
        #@TODO: implement method
        
        $sql = new RSql;
        $query = "SELECT id FROM ".self::getTableName($instrument)." WHERE ts={$candle->getStartTimestamp()} AND tse={$candle->getEndTimestamp()} AND delta={$delta} ";
        $r = $sql->getArray($query);
        
        if($sql->getLastError()){
		    echo $sql->getLastError();
		}
        
        return (count($r) != 0);
	}

	public static function getCandleAmountInCache($instrument, $delta, $startTS, $endTS){
        $sql = new RSql;
        $startTS = intval($startTS);
        $endTS = intval($endTS);
        $delta = intval($delta);
        $query = "SELECT COUNT(id) FROM ".self::getTableName($instrument)." WHERE ts>=$startTS AND tse<=$endTS AND delta=$delta";
        
        $r = $sql->getArray($query);
        
        if($sql->getLastError()){
		    echo $sql->getLastError();
		}
		
        return $r[0][0];
	}

	public static function containsAmount($instrument, $delta, $endTS, $amount){
        #@TODO : implement
        $sql = new RSql;

        $endTS = intval($endTS->getTimestamp());
        $delta = intval($delta);
        $query = "SELECT (id) FROM ".self::getTableName($instrument)." WHERE tse<=$endTS AND delta=$delta ORDER BY tse LIMIT $amount";
        
        
        $r = $sql->getAssocArray($query);
       
        
        return (count($r) == $amount);
	}

	public static function getCandles($instrument, $delta, $endTS, $amount){
	    $sql = new RSql;
        $endTS = intval($endTS->getTimestamp());
        $delta = intval($delta);
        $query = "SELECT DISTINCT ts, tse, delta, data FROM ".self::getTableName($instrument)." WHERE tse<=$endTS AND delta=$delta ORDER BY tse DESC LIMIT $amount";
        
        $r = $sql->getAssocArray($query);
        
        if($sql->getLastError()){
		    echo $sql->getLastError();
		}
        
        return self::validateCandles($r);
	}
	
	private static function validateCandles(array $r){
	    for($k=0; $k<count($r); $k++){
            for($i=0;$i<=4;$i++){
                unset($r[$k][$i]);
            }
        }
        
        $res = [];
        foreach($r as $i=>$l){
            $res []= new class{
                private $arr;
                public function toArray(){
                      return json_decode($this->arr);
                }
                public function setArray($v){
                    $this->arr = $v;
                }
            };
            $res[$i]->setArray(stripcslashes($l['data']));
        }

        return $res;
	}
	
	public function getDeltaCandlesInInterval(Instrument $instrument, int $delta, Timestamp $from, Timestamp $to){
	    $sql = new RSql;
	    $start = $from->getTimestamp();
	    $end = $to->getTimestamp();
	    $tableName = self::getTableName($instrument);
	    
	    $q = "SELECT DISTINCT ts, tse, delta, data 
	        FROM $tableName
	        WHERE tse <= end
	        AND ts > $start
	        AND delta = $delta
	        ORDER BY tse DESC";
	    
	    $data = $sql->getAssocArray($q);
	    
	    if( $e = $sql->getLastError() ){
	        RLogger::error(__METHOD__, $e);
	    }
	    
	    return self::validateCandles($data);
	}

	public static function cache($instrument, $delta, $startTS, $endTS){
		
	}
        
}
