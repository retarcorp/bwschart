<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;

class _6N extends Instrument{
    
    public $name = "6N";
    protected $table = "ticks_6N";
    
}