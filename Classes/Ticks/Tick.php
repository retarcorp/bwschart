<?php

    namespace Classes\Ticks;
    
    class Tick{
        private 
            $secs,
            $usecs,
            $direction,
            $volume,
            $minPrice,
            $maxPrice,
            $oid;

        const ASK = 1;
        const BID = 2;
            
        public function __construct(){
        }
        
        public function setSecs(int $secs): self{
            $this->secs = $secs;
            return $this;
        }
        
        public function setUsecs(int $usecs): self{
            $this->usecs = $usecs;
            return $this;
        }
        
        public function setDirection(int $direction): self{
            $this->direction = $direction;
            return $this;
        }
        
        public function setVolume(int $volume): self{
            $this->volume = $volume;
            return $this;
        }
        
        public function setMinPrice(float $price): self{
            $this->minPrice = $price;
            return $this;
        }
        
        public function setMaxPrice(float $price): self{
            $this->maxPrice = $price;
            return $this;
        }
        
        public function setOid(int $id): self{
            $this->oid = $id;
            return $this;
        }
        
        public function toArray(){
            $arr = [];
            foreach($this as $field => $value){
                // if( $field == 'oid' ){
                //     continue;
                // }
                $arr[$field] = $value;
            }
            return $arr;
        }
    }

?>