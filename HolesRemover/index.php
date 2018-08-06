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
    
    $sql = new RSql;
    $tableName = "temp_holes";
    $q = "SELECT * FROM $tableName 
        ORDER BY id ASC
        LIMIT 1";
    $data = $sql->getAssocArray($q);

    foreach($data as $i => $holeInfo){
        $id = intval($holeInfo['id']);
        $className = "\\Classes\\Instruments\\_".$holeInfo['instrument'];
        $instrument = new $className;
        $tf = $holeInfo['tf'];
        
        $start = intval(trim($holeInfo['start']));
        $end = intval(trim($holeInfo['end']));
        
        $startTS = new Timestamp($start);
        $endTS = new Timestamp($end);
        
        $candles = $instrument->getCandles($tf, $startTS, $endTS);
        $delete = "DELETE FROM $tableName WHERE id = $id";
        $sql->query($delete);
    }

?>