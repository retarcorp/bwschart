<?php

namespace Classes;

use Classes\App;
use Classes\Utils\TimeCalculator;
use Classes\Utils\Timestamp;

class DeltaCandle{
    
    private $ticks = [];
    
    private $startTS, $endTS;
    private $finished, $start_price, $last_price, $tick_max_price, $volume, $realDelta, $maxDeltaShadow, $minDeltaShadow;
    
    public function __construct(Timestamp $start_timestamp, Timestamp $end_timestamp){
        # Class Candle is only for information purposes. It does NOT execute calculations, DB fetching and so on. All data is set to a Candle Object externally
        
        $this->startTS = $start_timestamp;
        $this->endTS = $end_timestamp;
        $this->setStartPrice(0);
        $this->setLastPrice(0);
        $this->setTickMaxPrice(0);
        $this->setVolume(0);
        $this->setRealDelta(0);
        $this->setMinDeltaShadow(0);
        $this->setMaxDeltaShadow(0);
    }
    
    public function toArray(){
        $finished = $this->finished ? 'true' : 'false';
        $arr = [
                "finished" => $finished
                ,"start_price" => $this->start_price
                ,"last_price" =>  $this->last_price
                ,"tick_max_price" => $this->tick_max_price
                ,"volume" => $this->volume
                ,"realDelta" => $this->realDelta
                ,'deltaShadow' => [
                    'min' => $this->minDeltaShadow
                    ,'max' => $this->maxDeltaShadow
                ]
                // ,"startTS" => date("Y-m-d H:i:s", $this->startTS->getTimestamp())
                // ,"endTS" => date("Y-m-d H:i:s", $this->endTS->getTimestamp())
                ,"startTS" => $this->startTS->getTimestamp()
                ,"endTS" => $this->endTS->getTimestamp()
            ];
            
        if(!empty($this->ticks)){
            $arr['ticks'] = $this->ticks;
        }else{
            $arr['ticks'] = [];
        }
        
        return $arr;
    }
    
    public function getStartTimestamp(){
        return $this->startTS->getTimestamp();
    }
    
    public function getEndTimestamp(){
        return $this->endTS->getTimestamp();
    }
    
    public function toJSON(){
        return json_encode($this->toArray());
    }

    public function setData($delta, $startPrice, $lastPrice, $maxPrice, $volume, $realDelta, $ticks, $minShadow, $maxShadow){
        $this->setStartPrice($startPrice);
        $this->setLastPrice($lastPrice);
        $this->setTickMaxPrice($maxPrice);
        $this->setVolume($volume);
        $this->setRealDelta($realDelta);
        $this->setTicks($ticks);
        $this->setMinDeltaShadow($minShadow);
        $this->setMaxDeltaShadow($maxShadow);
        $this->setFinished($delta);
    }
    
    public function isFinished(){
        return $this->finished;
    }
    
    public function setFinished($delta){
        // var $secs is using for checking is it last candle in the day
        $secs = 15;
        if( $this->endTS->getTimestamp() <= $_SERVER['REQUEST_TIME'] - $secs ){
            $this->finished = true;
        }else{
            $this->finished = abs($this->realDelta) >= $delta;
        }
        
    }
    
    public function setStartPrice($price){
        $this->start_price = $price;
    }
    
    public function setLastPrice($price){
        $this->last_price = $price;
    }
    
    public function setTickMaxPrice($price){
        $this->tick_max_price = $price;
    }
    
    public function setVolume(int $volume){
        $this->volume = $volume;
    }
    
    public function setTicks($ticks){
        $this->ticks = $ticks;
    }
    
    public function setRealDelta($delta){
        $this->realDelta = $delta;
    }

    public function setMinDeltaShadow($min){
        $this->minDeltaShadow = $min;
    }

    public function setMaxDeltaShadow($max){
        $this->maxDeltaShadow = $max;
    }
    
}