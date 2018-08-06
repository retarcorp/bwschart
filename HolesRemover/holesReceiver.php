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

    $data = json_decode($_POST['data'], true);
    $sql = new RSql;
    $counter = 0;
    $tableName = "temp_holes";
    
    foreach($data as $i => $line){
        $start  = intval(trim($line['start']));
        $end  = intval(trim($line['end']));
        $tf = $line['timeframe'];
        $instrument = $line['instrument'];
        $q = "INSERT INTO $temp_holes VALUES(default, $start, $end, '$tf', '$instrument')";
        // $sql->query($q);
        // if( $e = $sql->getLastError() ){
        //     RLogger::error('Holes receiver', $e);
        // }
        $counter++;
    }
    
?>