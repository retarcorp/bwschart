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
    ini_set('display_errors', 1);
    header("Content-Type: text/plain");
    
    $instruments = ['6A','6B','6C','6E','6J','6N','6S','CL','GC'];

    $tfTimeCorrespondence = [
        'M1' => 3600,
        'M2' => 3600,
        'M5' => 3600,
        'M10' => 3600,
        'M15' => 3600,
        'M30' => 7200,
        'H1' => 14400,
        'H4' => 43200,
        'D1' => 86400
    ];

    $tfTimeCorrespondence = [
        'M1' => 600,
        'M2' => 1200,
        'M5' => 1800,
        'M10' => 3600,
        'M15' => 3600,
        'M30' => 7200,
        'H1' => 14400,
        'H4' => 43200,
        'D1' => 86400*2
    ];
    
    $timeframe = $argv[1];
    // $timeframe = $_GET['timeframe'];
    
    if(!$timeframe){
        $timeframe = $_GET['timeframe'];
        // echo $timeframe;
    }
    if(!$timeframe){
        return;
    }

    $started = microtime(true);

    // Закомментированный код использовался для старой реализации автоматического кеширования

    $period = $tfTimeCorrespondence[$timeframe];
    $endTS = new Timestamp( time() );
    $startTS = new Timestamp( ($endTS->getTimestamp() - $period) );
    $start = date("Y.m.d H:i:s", $startTS->getTimestamp());
    $end = date("Y.m.d H:i:s", $endTS->getTimestamp());

    foreach($instruments as $instrument){
        $instrumentName = "\\Classes\\Instruments\\_".$instrument;
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            RLogger::error("AutoFootprintCaching", "Invalid class name $instrumentName");
            return;
        }

        $candles = $instrument->getCandles($timeframe, $startTS, $endTS);
        // $instrument->getLastCandle($timeframe);
    }
         $time = date( "Y.m.d H:i:s", time() );

    $log = "End of automatic caching for timeframe $timeframe. Finished at $time. Estimated time=".round((-$started + microtime(true))*1000)."ms";
    echo $log;
    // RLogger::info("Footprint Cache", $log);

?>