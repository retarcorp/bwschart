<?php

    namespace Classes\Ticks;
    use Core\Classes\System\RSql;
    use Core\Classes\System\RLogger;
    use Classes\Utils\Timestamp;
    use Classes\App;
    use Classes\Instruments\Instrument;
    use Classes\Ticks\Tick;
    
    class TickFactory{
        
        public function arrayToInstance(array $data): Tick{
            sort($data['prices'], SORT_NUMERIC);
            $amo = count($data['prices']);
            
            $tick = new Tick();
            $tick->setSecs( intval($data['secs']) )
                ->setUsecs( intval($data['usecs']) )
                ->setDirection( intval($data['direction']) )
                ->setVolume( intval($data['volume']) )
                ->setMinPrice( floatval($data['prices'][0]) )
                ->setMaxPrice( floatval($data['prices'][$amo - 1]) )
                ->setOid($data['order_id']);
            return $tick;
        }
        
        public function getInstrumentTimeConst(int $time, int $currentTime): int{
            
            if( $time >= $currentTime - 3600 * 24 ){
                return Instrument::DAY;
            }elseif( $time >= $currentTime - 3600 * 24 * 7 ){
                return Instrument::WEEK;
            }else{
                return Instrument::ALL;
            }
        }
        
        public function getTicksInRange(Instrument $instrument, Timestamp $endTS, int $min, int $max, int $amount): array {
            #$start = microtime(true);
            
            global $GlobalTime, $LocalTime;
            
            $sql = new RSql;
            $till = $endTS->getTimestamp();
            $diff = $amount / 10 * 60; // 10 items = 60 secs
            $from = $till - $diff;
            $currentTime = time();
            
            $const = $this->getInstrumentTimeConst($from, $currentTime);
            $tableName = $instrument->getTableName($const);
            
            # Min must be less then max
            if( $min > $max && $max && $min ){
                $min = $max;
            }
            
            // $minCondition = $min ? "AND volume >= $min" : "";
            // $maxCondition = $max ? "AND volume <= $max" : "";
            
            $results = [];
            
            // $GlobalTime = microtime(true);
            // echo "Current time: ".$GlobalTime."\n";
            
            while( count($results) < $amount ){
                $q = "SELECT secs, usecs, direction, volume, price, order_id 
                    FROM $tableName 
                    WHERE secs <= $till
                    AND secs >= $from
                    ORDER BY secs DESC, usecs DESC";
                
                
                
                #RLogger::info("",$q);
            
                
                $temp = $sql->getAssocArray($q);
                
                // echo "\nEnd time: ".microtime(true)."\n";
                // echo "Delay: ".($GlobalTime - $LocalTime)."\n";
                
                if( $e = $sql->getLastError() ){
                    RLogger::error("TickFactory\$getTicksInRange", $e);
                }
                
                $results = array_merge($results, $temp);
                $till = $from - 1;
                $from = $till - $diff;
                $const = $this->getInstrumentTimeConst($from, $currentTime);
                $tableName = $instrument->getTableName($const);
            }
            
            $data = [];
            foreach($results as $i=> $line){
                $line ['prices'] = [ $line['price'] ];
                unset($line['price']);
                
                $amo = count($data);
                if( !$amo ){
                    $data [] = $line;
                    continue;
                }
                
                if( $data[$amo - 1]['order_id'] == $line['order_id'] ){
                    
                    $data[$amo - 1]['volume'] +=  $line['volume'];
                    $data[$amo - 1]['prices'][] = $line['prices'][0];
                    continue;
                }
            
                $data [] = $line;
            }
            
            $results = [];
            foreach($data as $i => $tickData){
                if( $this->isSuitableTick($tickData, $min, $max) ){
                    $results [] = $this->arrayToInstance($tickData);
                }
            }
            
            #$end = microtime(true);
            #print_r($end - $start);
            return array_slice($results, 0, $amount);
        }
        
        public function isSuitableTick(array $tickData, int $min, int $max): bool{
            $volume = $tickData['volume'];
            if($min && $max){
                return $volume >= $min && $volume <= $max;
            }elseif($max){
                return $volume <= $max;
            }elseif($min){
                return $volume >= $min;
            }
            return true;
        }
        
    }

?>