<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\DeltaCandle;
use Classes\Instruments\DeltaCandlesBuilder;
use Classes\FootprintCache;
use Classes\DeltaCache;


class Instrument{
    
    public $name = "None";
    protected $table = "";
    
    const DAY = 1;
    const WEEK = 7;
    const ALL = 8;
    
    public function getInstanceTable(){
        return $this->table;
    }
    
    public static $Instruments = [
        '6A','6B','6C','6E','6J','6N','6S','CL','GC'
    ];

    public static $TYPE_ROUND_CORRESPONDENCE = [
        '6A' => 4,
        '6B' => 4,
        '6C' => 5,
        '6E' => 5,
        '6J' => 7,
        '6N' => 4,
        '6S' => 4,
        'CL' => 2,
        'GC' => 1
    ];
    
    public function addTick(){
        
    }
    
    public function addTicks(){
        
    }
    
    public function getTableName(int $const){
        switch($const){
            case Instrument::DAY:
                return $this->getInstanceTable()."_day";
            case Instrument::WEEK:
                return $this->getInstanceTable()."_week";
            case Instrument::ALL:
                return $this->getInstanceTable();
        }
    }

    public function getCandles($timeframe, Timestamp $startTS, Timestamp $endTS){
        if( ($startTS->getTimestamp() != $endTS->getTimestamp())  && 
            FootprintCache::containsInterval($this, $timeframe, $startTS, $endTS) ){
            header("BWSCache: True");
            $candles = FootprintCache::getCandles($this, $timeframe, $startTS, $endTS);
            
            # mark last candle like not ended 
            if( !empty($candles) ){
                $candles[count($candles) - 1]->setFinished(false);
            }
            return $candles;
        }
        
        $res = self::getComputedCandles($timeframe, $startTS, $endTS);
        FootprintCache::putCandles($this, $timeframe, $res);
        header("BWSCache: False");
        
        if( !empty($res) ){
            $res[count($res) - 1]->setFinished(false);
        }
        return $res;
    }
    
    public function getComputedCandles($timeframe, Timestamp $startTS, Timestamp $endTS){
        date_default_timezone_set('GMT');
        $time = $this->getValueForTimeframe($timeframe);
        $startTS = $this->getStartTSForTimeframe($startTS, $timeframe);
        $endTS = $this->getEndTSForTimeframe($endTS, $timeframe);
        
        $diff = $endTS->getTimestamp() - $startTS->getTimestamp();
        
        if($diff < 60 * 60 * 24){
            $const = self::DAY;
        }elseif($diff < 60 * 60 * 24 * 7){
            $const = self::WEEK;
        }else{
            $const = self::ALL;
        }
        
        $tableName = $this->getTableName($const);
        
        $candlesAmount = floor(($endTS->getTimestamp() - $startTS->getTimestamp()) / $time) + 1;
        
        if(!$candlesAmount){
            $candle = new Candle($timeframe, $startTS);
            $this->fillCandle($startTS, $timeframe, $candle, $tableName);
            return [$candle];
        }
        
        $candles = [];
        $startTSValue = $startTS->getTimestamp();
        
        for($i = 0; $i < $candlesAmount; $i++){
            $startCandleTS = $startTSValue + $time * $i;
            $newTimestamp = new Timestamp($startCandleTS);
            $candle = new Candle($timeframe, $newTimestamp);
            $this->fillCandle($newTimestamp, $timeframe, $candle, $tableName);
            
            if( ($candle->isFinished()) || ( $candle->start_price && $candle->volume ) ){
                $candles [] = $candle;
            }
            
            if($startCandleTS + $time > time() ){
                break;
            }
        }
        
        return $candles;
    }
    
    public function getValueForTimeframe($timeframe){
        return App::$Timeframe[$timeframe] * 60;
    }
    
    public function getStartTSForTimeframe(Timestamp $startTS, $timeframe){
        $timeframe = $this->getValueForTimeframe($timeframe);
        if($remainder = $startTS->getTimestamp() % $timeframe){
            return $startTS->getEarlierForSeconds($remainder);
        }
        return $startTS;
    }
    
    public function getEndTSForTimeframe(Timestamp $endTS, $timeframe){
        $timeframe = $this->getValueForTimeframe($timeframe);
        if($remainder = $endTS->getTimestamp() % $timeframe){
            $endTS->subtractSeconds($remainder);
            return $endTS->getLaterForSeconds($timeframe);
        }
        return $endTS;
    }
    
    public function isFinished(Timestamp $startTS, $timeframe){
        $timeframe = $this->getValueForTimeframe($timeframe);
        
        if( ($timeframe + $startTS->getTimestamp()) <= $_SERVER['REQUEST_TIME'] ){
            return true;
        }else{
            return false;
        }
    }
    
    private function fillCandle(Timestamp $startTS, $timeframe, Candle $candle, $tableName){
        # Find timestamps
        $time = $this->getValueForTimeframe($timeframe);
        $sql = new RSql;
        $start = $startTS->getTimestamp();
        $end = $startTS->getLaterForSeconds($time)->getTimestamp();
        
        $finished = $this->isFinished($startTS, $timeframe);
        
        # Getting start, last prices and sum of values
        $this->fillPricesAndVolumeOfCandle($startTS, $timeframe, $candle, $tableName);
        
        # Getting max tick price and array of ticks
        $q = "SELECT price, direction, SUM(volume) AS sum FROM ".$tableName." 
            WHERE (secs >= $start AND secs < $end) 
            AND (direction = ".App::TICK_BUY." OR direction = ".App::TICK_SELL.") 
            AND (NOT price = 0) AND (NOT volume = 0)
            GROUP BY price, direction
            ORDER BY price DESC";
        $data = $sql->getAssocArray($q);
        // RLogger::info('', print_r($data, true));
        if( $e = $sql->getLastError() ){
            RLogger::error("Instrument\$fillCandle", $e);
        }

        $tickMaxPrice = empty($data) ? 0 :floatval($data[0]['price']);
        $ticks = [];
        $amount = 0;
        $changing = 0;
        $minShadow = null;
        $maxShadow = null;
        
        if( !empty($data) ){
            foreach($data as $i => $line){
                if( !(+$line['price']) && !(+$line['sum']) ){
                    continue;
                }
                
                $ticks[$amount][0] = 0;
                $ticks[$amount][1] = 0;
                $ticks[$amount][2] = floatval($line['price']);
                
                if($amount){
                    if($line['price'] == $data[$i - 1]['price']){
                        unset($ticks[$amount]);
                        $amount--;
                    }
                }
                
                $currentSum = intval($line['sum']);
                
                if($line['direction'] == App::TICK_BUY){
                    $ticks[$amount][0] = $currentSum;
                    $changing += $currentSum;
                }elseif($line['direction'] == App::TICK_SELL){
                    $ticks[$amount][1] = $currentSum;
                    $changing -= $currentSum;
                }
                
                $minShadow = ( $changing < $minShadow || is_null($minShadow) ) ? $changing : $minShadow;
                $maxShadow = ( $changing > $maxShadow || is_null($maxShadow) ) ? $changing : $maxShadow;
                $amount++;
            }
        }

        $candle->setFinished($finished);
        $candle->setTickMaxPrice($tickMaxPrice);
        $candle->setTicks($ticks);
        $candle->setMaxShadow( intval($maxShadow) );
        $candle->setMinShadow( intval($minShadow) );
    }
    
    private function fillPricesAndVolumeOfCandle(Timestamp $startTS, $timeframe, Candle $candle, $tableName){
        $time = $this->getValueForTimeframe($timeframe);
        $sql = new RSql;
        $start = $startTS->getTimestamp();
        $end = $startTS->getLaterForSeconds($time)->getTimestamp();
        
        $q = "(SELECT price FROM {$tableName} 
                WHERE secs >= '{$start}' 
                AND secs < '{$end}' 
                AND (NOT price = 0) 
                AND (NOT volume = 0)
                ORDER BY id 
                LIMIT 1
            )
            UNION ALL
            (SELECT price FROM {$tableName} 
                WHERE secs >= '{$start}' 
                AND secs < '{$end}' 
                AND (NOT price = 0) 
                AND (NOT volume = 0)
                ORDER BY id DESC 
                LIMIT 1
            )
            UNION ALL
            (SELECT SUM(volume) FROM {$tableName} 
                WHERE secs >= '{$start}' 
                AND secs < '{$end}'
            )";
        $info = $sql->getAssocArray($q);
        if($e = $sql->getLastError()){
            RLogger::error("Instrument\$fillPricesAndVolumeOfCandle", $e);
        }
        
        if(!empty($info)){
            $round = self::$TYPE_ROUND_CORRESPONDENCE[$this->name];
            $startPrice = round(($info[0]['price'] * 1), $round);
            $lastPrice = round(($info[1]['price'] * 1), $round);
            $volume = $info[2]['price'] * 1;
        }else{
            $startPrice = 0;
            $lastPrice = 0;
            $volume = 0;
        }
        
        $candle->setStartPrice($startPrice);
        $candle->setLastPrice($lastPrice);
        $candle->setVolume($volume);
    }
    
    public function getLastCandle($timeframe){
        $currTime = time();
        $currentTS = new Timestamp($currTime);
        $candle = $this->getComputedCandles($timeframe, $currentTS, $currentTS)[0];
        FootprintCache::updateLastCandle($this, $timeframe, $candle);
        
        $prev = $this->getPenultimateCandle($timeframe, $currTime);
        FootprintCache::updateLastCandle($this, $timeframe, $prev);
        
        // $candle = ($this->getCandles($timeframe, $currentTS , $currentTS))[0];
        return $candle;
    }
    
    public function getTwoLastCandles($timeframe){
        $currTime = time();
        $currentTS = new Timestamp($currTime);
        $last = $this->getLastCandle($timeframe);
        FootprintCache::updateLastCandle($this, $timeframe, $last);
        
        $prev = $this->getPenultimateCandle($timeframe, $currTime);
        FootprintCache::updateLastCandle($this, $timeframe, $prev);
        return [$prev, $last];
    }
    
    public function getPenultimateCandle($timeframe, $currTime){
        $secs = $currTime - $this->getValueForTimeframe($timeframe);
        $TS = new Timestamp($secs);
        $candle = $this->getComputedCandles($timeframe, $TS, $TS)[0];
        return $candle;
    }
    
    public function getUnCachedCandles($timeframe){
        $currTime = time();
        $currentTS = new Timestamp($currTime);
        $candle = $this->getComputedCandles($timeframe, $currentTS, $currentTS)[0];
        
        if( is_null($candle) ){
            return [new Candle($timeframe, $currentTS)];
        }
        
        if( FootprintCache::isInCache($this, $timeframe, $candle) ){
            FootprintCache::updateLastCandle($this, $timeframe, $candle);
            return [$candle];
        }
        
        FootprintCache::putCandle($this, $timeframe, $candle);
        $prev = $this->getPenultimateCandle($timeframe, $currTime);
        FootprintCache::updateLastCandle($this, $timeframe, $prev);
        return [$prev, $candle];
    }
    
    public function getNCandles($timeframe, Timestamp $endTS, int $n){
        //$startCalcTime = microtime(true);
        
        $endTS = $this->getEndTSForTimeframe($endTS, $timeframe);
        $secs = $this->getValueForTimeframe($timeframe);
        $startTime = $endTS->getTimestamp() - $secs * $n;
        $startTS = new Timestamp($startTime);
        $candles = $this->getCandles($timeframe, $startTS, $endTS);
        
        //$endCalcTime = microtime(true);
        //$duration = $endCalcTime - $startCalcTime;
        //RLogger::warn('Estimated time for model calculating', $duration);
        
        return array_slice($candles, 0, $n);
    }
    
    public function getDeltaCandles($delta, $amount, $until){
        $builder = new DeltaCandlesBuilder($this);
        $candles = $builder->getDeltaCandles($delta, $amount, $until);
        return $candles;
    }

    public function getLastDeltaCandle($delta){
        $builder = new DeltaCandlesBuilder($this);
        $candle = $builder->getLastDeltaCandle($delta);
        return $candle;
    }
    
    public function getTwoLastDeltaCandles($delta){
        $builder = new DeltaCandlesBuilder($this);
        $candles = $builder->getTwoLastDeltaCandles($delta);
        return $candles;
    }

    public function clearDayTicks(){
        $sql = new RSql;
        $time = time() - 86400;
        $table = $this->getTableName(Instrument::DAY);
        $query = "DELETE FROM $table WHERE secs < $time";
        $sql->query($query);
    }
    
    public function clearWeekTicks(){
        $sql = new RSql;
        $time = time() - 86400 * 7;
        $table = $this->getTableName(Instrument::WEEK);
        $query = "DELETE FROM $table WHERE secs < $time";
        $sql->query($query);
    }

    public function putRandomData($timeframe = null){
        $sql = new RSql;
        if(!is_null($timeframe)){
            $timeframe = $this->getValueForTimeframe($timeframe);
        }
        $currTime = time();
        
        $lastCandlePrice = ($sql->getAssocArray("SELECT price FROM {$this->table} WHERE secs < $currTime ORDER BY secs DESC LIMIT 1"))[0]['price'];
        
        $info = $sql->getAssocArray("SELECT secs FROM {$this->table} ORDER BY secs DESC LIMIT 1");
        
        $startTime = $info[0]['secs'] * 1;
        
        $currentTime = time();
        
        $step = 0.0005;
        $q = "INSERT INTO {$this->table} (secs, direction, volume, price) 
                VALUES";
        $insertValues = [];
        
        while($startTime < $currentTime){
            $amount = rand(6, 8);
            for($i = 0; $i < $amount; $i++){
                $lastPrice = $lastCandlePrice + $step * rand(-8, 8);
                $volume = rand(1, 10);
                $direction = rand(1, 2);
                $date = $startTime;
                
                $insertValues [] = "($date, $direction, $volume, $lastPrice)";
            }
            
            $startTime++;
        }
        
        if(!empty($insertValues)){
            $q = $q.implode(", ", $insertValues);
            $sql->query($q);
            
            if($sql->getLastError()){
                RLogger::info('fillData', print_r($sql->getLastError(), true));
            }
        }
        
        # Removing old records
        # @TODO  Optimize deleting process! Do it at most once in an hour
        $timeToClear = $currentTime - 60 * 60 * 24;
        #$sql->query("DELETE FROM {$this->table} WHERE secs < '$timeToClear'");
        
        if($sql->getLastError()){
            RLogger::info('deletingData', print_r($sql->getLastError(), true));
        }
        
        return;
        
    }
    
    public function test($timeframe, Timestamp $endTS, int $n){
        $endTS = $this->getEndTSForTimeframe($endTS, $timeframe);
        $secs = $this->getValueForTimeframe($timeframe);
        $startTime = $endTS->getTimestamp() - $secs * $n;
        $startTS = new Timestamp($startTime);
        $candles = $this->cloneTest($timeframe, $startTS, $endTS);
        return $candles;
    }
    
    public function cloneTest($timeframe, Timestamp $startTS, Timestamp $endTS){
        if( ($startTS->getTimestamp() != $endTS->getTimestamp())  && 
            FootprintCache::containsInterval($this, $timeframe, $startTS, $endTS) ){
            header("BWSCache: True");
            $candles = FootprintCache::test($this, $timeframe, $startTS, $endTS);
            
            # mark last candle like not ended 
            if( !empty($candles) ){
                $candles[count($candles) - 1]->setFinished(false);
            }
            return $candles;
        }
        
        $res = self::getComputedCandles($timeframe, $startTS, $endTS);
        FootprintCache::putCandles($this, $timeframe, $res);
        header("BWSCache: False");
        
        if( !empty($res) ){
            $res[count($res) - 1]->setFinished(false);
        }
        return $res;
    }
    
}