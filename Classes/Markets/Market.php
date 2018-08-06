<?php

    namespace Classes\Markets;
    use Classes\Utils\Timestamp;
    use Core\Classes\System\RSql;
    use Core\Classes\System\RLogger;
    
    class Market{
        
        private 
            $id,
            $uid,
            $graph,
            $instrument,
            $startTS,
            $endTS,
            $startPrice,
            $endPrcie,
            $timeframe,
            $delta;
            
        const GRAPH_FOOTPRINT = 1;
        const GRAPH_DELTA = 2;
        
        const TABLE_NAME = 'user_markets';
            
        public function __construct(int $id){
            $this->id = $id;
        }
        
        public function setUserId(int $uid): self{
            $this->uid = $uid;
            return $this;
        }
        
        public function setGraph(int $graph): self{
            $this->graph = $graph;
            return $this;
        }
        
        public function setInstrument(string $instrument): self{
            $this->instrument = $instrument;
            return $this;
        }
        
        public function setStartTS(Timestamp $startTS): self{
            $this->startTS = $startTS;
            return $this;
        }
        
        public function setEndTS(Timestamp $endTS): self{
            $this->endTS = $endTS;
            return $this;
        }
        
        public function setStartPrice(float $startPrice): self{
            $this->startPrice = $startPrice;
            return $this;
        }
        
        public function setEndPrice(float $endPrice): self{
            $this->endPrice = $endPrice;
            return $this;
        }
        
        public function setTimeframe(int $timeframe): self{
            $this->timeframe = $timeframe;
            return $this;
        }
        
        public function setDelta(int $delta): self{
            $this->delta = $delta;
            return $this;
        }
        
        public function toArray(){
            $arr = [];
            foreach($this as $field => $value){
                if(!$value){
                    continue;
                }
                
                if($value instanceof Timestamp){
                    $arr[$field] = $value->getTimestamp();
                }else{
                    $arr[$field] = $value;
                }
            }
            return $arr;
        }
        
        public function getId(): int{
            return $this->id;
        }
        
        public function editSelf(array $data){
            if( isset($data['id']) ){
                unset($data['id']);
            }
            
            if( isset($data['timeframe']) ){
                $column  = "timeframe";
                $value = $data['timeframe'];
            }else{
                $column  = "delta";
                $value = $data['delta'];
            }
            
            $sql = new RSql;
            
            $q = "UPDATE ".self::TABLE_NAME." 
                SET graph = {$data['graph']},
                instrument = '{$data['instrument']}',
                start_ts = {$data['startTS']},
                end_ts = {$data['endTS']},
                start_price = {$data['startPrice']},
                end_price = {$data['endPrice']},
                $column = $value
                WHERE id = {$this->id}";
            $sql->query($q);
            if($e = $sql->getLastError()){
                RLogger::error("Marker\$editSelf", $e);
            }
        }
        
        public function remove(): void{
            $sql = new RSql;
            $q = "DELETE FROM ".Market::TABLE_NAME."
                WHERE id = {$this->id}";
            $sql->query($q);
            if($e = $sql->getLastError()){
                RLogger::error("MarketFactory\$removeMarkets", $e);
            }
        }
        
    }
    
?>