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

    $instruments = ['6A','6B','6C','6E','6J','6N','6S','CL','GC'];
    $sql = new RSql;
    $instrument = "6E";
    $timeframe = FootprintCache::getTableTimeframeFor("M1");
    $ts = 1528882680;
    
    // foreach($instruments as $instrument){
        $tableName = "cache_fp_$instrument";
        // $tables = [$tableName, $tableName . '_day', $tableName . '_week'];
        
        // foreach($tables as $table){
            
        // }
        
        $q = "SELECT id, tf, ts FROM $tableName WHERE tf = $timeframe AND ts IN (
            	SELECT MAX(ts) AS ts FROM $tableName
            	WHERE ts > $ts AND tf = 1
            	GROUP BY data
            	HAVING COUNT(*) > 1
            ) ORDER BY id";
        $data = $sql->getAssocArray($q);
        $dublicates = [];
        
        foreach($data as $i => $line){
            if( !isset($dublicates [$line['ts']]) ){
                $dublicates [$line['ts']] = [];
            }else{
                $dublicates [$line['ts']][] = $line['id'];
            }
        }
        
        $ids = [];
        foreach($dublicates as $v){
            foreach($v as $id){
                $ids [] = $id;
            }
        }
        
        $in = implode(', ', $ids);
        $q = "DELETE FROM $tableName WHERE id IN ($in)";
        $sql->query($q);
        
    // }

?>