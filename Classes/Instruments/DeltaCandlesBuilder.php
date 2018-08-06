<?php

    namespace Classes\Instruments;
    
    use Core\Classes\System\RSql;
    use Core\Classes\System\RLogger;
    use Classes\Utils\Timestamp;
    use Classes\App;
    use Classes\Candle;
    use Classes\DeltaCandle;
    use Classes\Instruments\Instrument;
    use Classes\DeltaCache;
    
    class DeltaCandlesBuilder{
        private $temp_candles = [], $pointer, $isNotFirstCall = false;
        
        public function __construct($ptr){
            $this->pointer = $ptr;
        }
        
        public function getDeltaCandlesInInterval(int $delta, Timestamp $from, Timestamp $to){
            return DeltaCache::getDeltaCandlesInInterval($this->pointer, $delta, $from, $to);
        }
        
        public function getDeltaCandles($delta, $amount, $until){
            
            if(DeltaCache::containsAmount($this->pointer, $delta, $until, $amount)){
                header("BWSChart-Cache: true");
                return DeltaCache::getCandles($this->pointer, $delta, $until, $amount);
            }
            
            $this->findCandlesAndFillArray($delta, $amount, $until);
            $res =  array_reverse($this->temp_candles);
            
            DeltaCache::putCandles($this->pointer, $delta, $res);
            
            header("BWSChart-Cache: false");
            return $res;
        }
        
        public function getTwoLastDeltaCandles($delta){
            $this->findCandlesAndFillArray($delta, 2, new Timestamp( intval($_SERVER['REQUEST_TIME']) ) );
            return array_reverse($this->temp_candles);
        }

        public function getLastDeltaCandle($delta){
            $this->findCandlesAndFillArray($delta, 1, new Timestamp( intval($_SERVER['REQUEST_TIME']) ) );
            return $this->temp_candles[0];
        }
        
        private function findCandlesAndFillArray($delta, $amount, $until){
            ini_set("memory_limit","512M");
            
            if($amount <= 0){
                return [];
            }
            
            $sql = new RSql;
            date_default_timezone_set('GMT');
            $currTime = time();
            
            # from is equal 22:00 prev day
            # -2 hours from midnight
            $remainder = $until->getTimestamp() % (60 * 60 * 24);
            $from = $until->getTimestamp() - $remainder - 2 * 3600;
            if( $from + 3600 * 24 == $until->getTimestamp() ){
                $until = new Timestamp($until->getTimestamp() - 1);
            }
            
            # next jump is not using in this code
            $nextJump = $from + 3600 * 24;
            $diff = $currTime - $from;
            
            // RLogger::info('deltabuilder', print_r("remainder: $remainder, from: $from, till: {$until->getTimestamp()}, jump: $nextJump", true));
            
            if($diff < 60 * 60 * 24){
                $const = Instrument::DAY;
            }elseif($diff < 60 * 60 * 24 * 7){
                $const = Instrument::WEEK;
            }else{
                $const = Instrument::ALL;
            }
            
            $tableName = $this->pointer->getTableName($const);
            
            $endTime = $until->getTimestamp();
            
            $dataRecieved = false;
            $offset = 0;
            $limit = 10000;
            $candles = [];
            $isWholeDayEmpty = false;

            $storedCandleInfo = $this->getArrayForStoredCandleInfo(0, 0, 0, 0, 0, null, null, [], 0);
            
            while(!$dataRecieved){    
                $data = null;
                unset($data);
                gc_collect_cycles();
                
                $q = "SELECT secs, price, direction, volume FROM ".$tableName." WHERE secs >= $from AND secs <= $endTime ORDER BY secs, usecs LIMIT $limit OFFSET $offset";
                $data = $sql->getAssocArray($q);
                
                if(!empty($data)){
                    
                    $bidSum = $storedCandleInfo['bidSum'];
                    $askSum = $storedCandleInfo['askSum'];
                    $tickMaxPrice = $storedCandleInfo['maxPrice'];
                    $minshadow = $storedCandleInfo['minShadow'];
                    $maxshadow = $storedCandleInfo['maxShadow'];
                    $changing = $storedCandleInfo['changing'];
                    
                    $candleStartTS = $storedCandleInfo['startTs'] ? $storedCandleInfo['startTs'] : new Timestamp(intval($data[0]['secs']));
                    $startPrice = $storedCandleInfo['startPrice'] ? $storedCandleInfo['startPrice'] : floatval($data[0]['price']);
                    
                    $ticks=null;
                    unset($ticks);
                    
                    $ticks = $storedCandleInfo['ticks'];
                    $isCandleBuilt = false;
                    
                    foreach($data as $i => $line){
                        $currentTickPrice = floatval($line['price']);
                        $currentTime = intval($line['secs']);
                        $currentVolume = intval($line['volume']);
                        
                        $tickMaxPrice = ($currentTickPrice > $tickMaxPrice) ? $currentTickPrice : $tickMaxPrice;
                        
                        if($isCandleBuilt){
                            $bidSum = 0;
                            $askSum = 0;
                            $candleStartTS = new Timestamp($currentTime);
                            $startPrice = $currentTickPrice;
                            $tickMaxPrice = 0;
                            
                            $ticks  = null;
                            unset($ticks);
                            $ticks = [];
                            $isCandleBuilt = false;
                            $minshadow = null;
                            $maxshadow = null;
                            $changing = 0;
                        }
                        
                        $key = strval($currentTickPrice);
                        
                        if(!array_key_exists($key, $ticks)){
                            $ticks[$key][0] = 0;
                            $ticks[$key][1] = 0;
                            $ticks[$key][2] = $currentTickPrice;
                        }
                        
                        if($line['direction'] == App::TICK_BUY){
                            $bidSum += $currentVolume;
                            $ticks[$key][0] += $currentVolume;
                            $changing += $currentVolume;
                        }elseif($line['direction'] == App::TICK_SELL){
                            $askSum += $currentVolume;
                            $ticks[$key][1] += $currentVolume;
                            $changing -= $currentVolume;
                        }
                        
                        $minshadow = ( $changing < $minshadow || is_null($minshadow) ) ? $changing : $minshadow;
                        $maxshadow = ( $changing > $maxshadow || is_null($maxshadow) ) ? $changing : $maxshadow;
                        
                        $diff = $bidSum - $askSum;
                        
                        if( abs($diff) >= $delta ){
                            $candleEndTS = new Timestamp($currentTime);
                            $lastPrice = $currentTickPrice;
                            $volume = $bidSum + $askSum;
                            $candle = $this->createCandle($candleStartTS, $candleEndTS, $ticks, $startPrice, $lastPrice, $tickMaxPrice, $volume, $diff, $minshadow, $maxshadow, $delta);
                            
                            $isCandleBuilt = true;
                            // if($candle->getEndTimestamp() <= $until->getTimestamp()){
                                $candles [] = $candle;
                            
                            if(!DeltaCache::isInCache($this->pointer,$delta,$candle)){
                                DeltaCache::putCandle($this->pointer,$delta,$candle);
                            }
                            // }
                        }
                    }
                    
                    if(!$isCandleBuilt){
                        $storedCandleInfo = $this->getArrayForStoredCandleInfo($startPrice, $tickMaxPrice, $candleStartTS, $bidSum, $askSum, $minshadow, $maxshadow, $ticks, $changing);
                    }
                }else{
                    if(!$offset){
                        $isWholeDayEmpty = true;
                    }

                    $dataRecieved = true;
                    break;
                }
                
                $offset += $limit;
            }

            if( !$isWholeDayEmpty ){
                $lastPrice = $currentTickPrice ? $currentTickPrice : $storedCandleInfo['startPrice'];
                $candleEndTS = new Timestamp($currentTime);
                $volume = $storedCandleInfo['bidSum'] + $storedCandleInfo['askSum'];
                $realDelta = abs($storedCandleInfo['bidSum'] - $storedCandleInfo['askSum']);
                
                $candle = $this->createCandle($candleStartTS, $candleEndTS, $ticks, $startPrice, $lastPrice, $tickMaxPrice, $volume, $realDelta, $minshadow, $maxshadow, $delta);
                $candles [] = $candle;
            }
            
            $candlesAmount = count($candles);
            $candles = array_reverse($candles);
            
            for($i = 0; $i < $candlesAmount; $i++){
                if($i < $amount){
                    $this->temp_candles [] = $candles[$i];
                }else{
                    break;
                }
            }
            
            $currCandlesAmount = count($this->temp_candles);
            
            if($currCandlesAmount < $amount){
                $isNotFirstCall = true;
                $this->findCandlesAndFillArray($delta, $amount - $currCandlesAmount, new Timestamp($from - 1));
            }
        }

        private function createCandle($candleStartTS, $candleEndTS, $ticks, $startPrice, $lastPrice, $tickMaxPrice, $volume, $diff, $minshadow, $maxshadow, $delta){
            $candle = new DeltaCandle($candleStartTS, $candleEndTS);

            $keys = array_keys($ticks);
            sort($keys, SORT_NUMERIC);
            $orderedKeys = array_reverse($keys);
            $orderedTicks = [];
            
            foreach($orderedKeys as $k){
                $orderedTicks [] = $ticks[$k];
            }
            
            $candle->setData($delta, $startPrice, $lastPrice, $tickMaxPrice, $volume, $diff, $orderedTicks, $minshadow, $maxshadow);
            return $candle;
        }

        private function getArrayForStoredCandleInfo($startPrice, $tickMaxPrice, $candleStartTS, $bidSum, $askSum, $minshadow, $maxshadow, $ticks, $changing){
            return [
                'startPrice' => $startPrice,
                'maxPrice' => $tickMaxPrice,
                'startTS' => $candleStartTS,
                'bidSum' => $bidSum,
                'askSum' => $askSum,
                'minShadow' => $minshadow,
                'maxShadow' => $maxshadow,
                'changing' => $changing,
                'ticks' => $ticks
            ];
        }
    }