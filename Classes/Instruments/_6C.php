<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;

class _6C extends Instrument{
    
    public $name = "6C";
    protected $table = "ticks_6C";
    
}