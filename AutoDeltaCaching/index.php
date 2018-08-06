<?php

    $_SERVER['DOCUMENT_ROOT'] = "C:\inetpub\wwwroot";
    require_once "C:\inetpub\wwwroot\Core\Global.php";
    use Classes\Instruments\Instrument;
    use Classes\App;
    use Classes\Candle;
    use Classes\Utils\Timestamp;
    use Classes\Utils\JSONResponse;
    use Classes\Ticks\Tick;
    use Classes\Ticks\TickFactory;
    use Classes\Markets\Market;
    use Classes\Markets\MarketFactory;
    use Classes\Users\Auth;
    use Classes\Users\User;
    use Classes\FootprintCache;
    use Core\Classes\System\RSql;
    use Core\Classes\System\RLogger;
    
    header("Content-Type: text/plain");
    $start = microtime(true);
    
    $instruments = ['6A','6B','6C','6E','6J','6N','6S','CL','GC'];
    $delta = $argv[1];
    if(!$delta){
        $delta = $_GET['delta']*1;
    }
    
    if(!$delta){
        return;
    }
    
    foreach($instruments as $instrument){
        $instrumentName = "\\Classes\\Instruments\\_".$instrument;
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            RLogger::error("AutoDeltaCaching", "Invalid class name $instrumentName");
            return;
        }
        
        $candle = $instrument->getLastDeltaCandle($delta);
    }
     $time = date( "Y.m.d H:i:s", time() );
    $log = "End of automatic caching of delta $delta, endtime: $time. Estimated time=".round((-$start + microtime(true))*1000)."ms";
    echo $log;
   
    // RLogger::info("Delta Cache", $log);

?>