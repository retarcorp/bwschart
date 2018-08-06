<?php

namespace Classes\Utils;

// Second-accurate timestamp;
class Timestamp{
    
    private $ts = 0;
    public function __construct($str){
        
        if(is_string($str)){
            $this->ts = strtotime($str);
        }
        if(is_int($str)){
            $this->ts = $str;
        }
        
    }    
    
    public function __toString(){
        return $this->ts."";
    }
    
    public function getTimestamp(){
        return $this->ts;
    }
    
    public function addSeconds($secs){
        $this->ts+=$secs;
    }
    
    public function subtractSeconds($secs){
        $this->ts-=$secs;
    }
    
    public function addMinutes($mins){
        $this->ts+=$mins*60;    
    }
    
    public function subtractMinutes($mins){
        $this->ts-=$mins*60;
    }
    
    public function getLaterForSeconds($secs){
        return new Timestamp($this->ts+$secs);
    }
    
    public function getEarlierForSeconds($secs){
        return new Timestamp($this->ts-$secs);
    }
    
    public function getLaterForMinutes($mins){
        return new Timestamp($this->ts+$mins*60);
    }
    
    public function getEarlierForMinutes($mins){
        return new Timestamp($this->ts-$mins*60);
    }
}