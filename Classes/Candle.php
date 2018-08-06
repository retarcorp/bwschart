<?php

namespace Classes;

use Classes\App;
use Classes\Utils\TimeCalculator;
use Classes\Utils\Timestamp;

class Candle{
    
    private $ticks = [];
    private $timeframe = App::TF_M5;
    
    public $startTS;
    public $finished, $start_price, $last_price, $tick_max_price, $volume, $minShadow, $maxShadow;
    
    public function __construct($timeframe, Timestamp $start_timestamp){
        # Class Candle is only for information purposes. It does NOT execute calculations, DB fetching and so on. All data is set to a Candle Object externally.
        $this->timeframe = $timeframe;
        $this->startTS = $start_timestamp;
        $this->setStartPrice(0);
        $this->setLastPrice(0);
        $this->setTickMaxPrice(0);
        $this->setVolume(0);
        $this->setMinShadow(0);
        $this->setMaxShadow(0);
    }
    
    public function toArray(){
        $finished = $this->finished ? 'true' : 'false';
        $arr = [
                "finished" => $finished
                ,"start_price" => $this->start_price
                ,"last_price" =>  $this->last_price
                ,"tick_max_price" => $this->tick_max_price
                ,"volume" => $this->volume
                ,'deltaShadow' => [
                    'min' => $this->minShadow
                    ,'max' => $this->maxShadow
                ]
                // ,"timeframe" => $this->timeframe
                # ,"startTS" => date("Y-m-d H:i:s", $this->startTS->getTimestamp())
                ,"startTS" =>  $this->startTS->getTimestamp()
            ];
        if(!empty($this->ticks)){
            foreach($this->ticks as $tick){
                $arr['ticks'][] = $tick;
            }
        }else{
            $arr['ticks'] = [];
        }
        
        return $arr;
    }

    public function getTicks(){
        return $this->ticks;
    }
    
    public function toJSON(){
        return json_encode($this->toArray());
    }
    
    public function setFinished(bool $flag){
        $this->finished = $flag;
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

    public function setMinShadow($min){
        $this->minShadow = $min;
    }

    public function setMaxShadow($max){
        $this->maxShadow = $max;
    }

    public function isFinished(){
        return $this->finished;
    }
    
    public function isEmpty(): bool{
        return !($this->start_price)
            && !($this->last_price)
            && !($this->tick_max_price)
            && !($this->volume)
            && empty($this->ticks)
            && !($this->minShadow)
            && !($this->maxShadow);
    }
    
}