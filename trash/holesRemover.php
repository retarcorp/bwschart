<?php

    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
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
    
    $data = file_get_contents("holes.csv");
    $rows = explode("\r\n", $data);
    $sql = new RSql;
    $counter = 0;
    
    foreach($rows as $i => $value){
        $className = "\\Classes\\Instruments\\_6E";
        $instrument = new $className;
        $tf = "M1";
        $tfConst = FootprintCache::getTableTimeframeFor($tf);
        $tableName = "cache_fp_6E";
        
        $secs = $instrument->getValueForTimeframe($tf);
        $ts = intval(trim($value));
        
        // $q = "SELECT ts FROM $tableName
        //     WHERE ts > $ts
        //     AND tf = $tfConst
        //     ORDER BY ts ASC
        //     LIMIT 1";
        // $data = $sql->getAssocArray($q);
        // $till = $data[0]['ts'] * 1;
        
        $startTS = new Timestamp($ts);
        $endTS = new Timestamp( $startTS->getTimestamp() + $secs );
        
        $candles = $instrument->getCandles($tf, $startTS, $endTS);
        $counter++;
        print_r("Last is $value, $counter iteration\n");
    }

?>