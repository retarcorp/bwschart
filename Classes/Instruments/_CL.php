<?php
    
namespace Classes\Instruments;

use Core\Classes\System\RSql;
use Classes\Utils\Timestamp;
use Classes\App;
use Classes\Candle;
use Classes\Instruments\Instrument;

class _CL extends Instrument{
    
    public $name = "CL";
    protected $table = "ticks_CL";
    
}