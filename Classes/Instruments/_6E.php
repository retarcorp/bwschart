<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;

class _6E extends Instrument{
    
    public $name = "6E";
    protected $table = "ticks_6E";
    
}