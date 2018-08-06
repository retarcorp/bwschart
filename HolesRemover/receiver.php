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

    date_default_timezone_set('GMT');
    $data = json_decode($_POST['data'], true);
    $sql = new RSql;
    $tableName = "temp_holes";
    
    foreach($data as $arr){
        foreach($arr as $i => $line){
            if( empty($line) ){
                continue;
            }
            
            $start  = intval(trim($line['start']));
            $end  = intval(trim($line['end']));
            $tf = $line['timeframe'];
            $instrument = $line['instrument'];
            
            $q = "SELECT id FROM $tableName 
                WHERE start = $start 
                AND end = $end 
                AND tf = '$tf'
                AND instrument = '$instrument'";
            $amoInfo = $sql->getAssocArray($q);
            if( $e = $sql->getLastError() ){
                RLogger::error('Holes receiver', $e);
            }
            
            if( !empty($amoInfo) ){
                continue;
            }else{
                $q = "INSERT INTO $tableName VALUES(default, $start, $end, '$tf', '$instrument')";
                $sql->query($q);
                
                // RLogger::info('', $q);
                if( $e = $sql->getLastError() ){
                    RLogger::error('Holes receiver', $e);
                }
            }
        }
    }
    
    die(json_encode("DONE"));
    
?>