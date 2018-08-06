<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;
use Classes\FootprintCache;
use Core\Classes\System\RLogger;

class _6S extends Instrument{
    
    public $name = "6S";
    protected $table = "ticks_6S";

    // public function getCandles($timeframe, Timestamp $startTS, Timestamp $endTS){


    // 	if(FootprintCache::containsInterval($this, $timeframe, $startTS, $endTS)){
    // 		header("BWSCache: True");
    // 		return FootprintCache::getCandles($this, $timeframe, $startTS, $endTS);
    // 	}
    // 	$res = parent::getCandles($timeframe, $startTS, $endTS);
    // 	FootprintCache::putCandles($this, $timeframe, $res);
    	
    // 	return $res;
    // }
    
}