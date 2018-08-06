<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;

class _6B extends Instrument{
    
    public $name = "6B";
    protected $table = "ticks_6B";
    
}