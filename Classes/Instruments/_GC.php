<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;

class _GC extends Instrument{
    
    public $name = "GC";
    protected $table = "ticks_GC";
    
}