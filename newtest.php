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
    
    // foreach($instruments as $instrument){
    //     $tableName = "ticks_$instrument";
    //     $tables = [$tableName, $tableName . '_day', $tableName . '_week'];
        
    //     foreach($tables as $table){
    //         $q = "SELECT id FROM $table WHERE order_id IS NULL OR order_id = 0";
    //         // print_r($q."\n");
    //         $d = $sql->getAssocArray($q);
            
    //         if( !empty($d) ){
    //             print_r("$table.\n");
    //             // print_r($d);
                
    //             $ids = array_map(function($e){
    //                 return $e['id']*1;
    //             }, $d);
    //             print_r($ids);
    //             $upd = "UPDATE $table SET order_id = (secs * 1000000 + usecs) WHERE id IN (" . implode(", ", $ids) . ")";
    //             $sql->query($upd);
    //         }
    //     }
        
    // }
    
    $class = "\\Classes\\Instruments\\_6E";
    $instrument = new $class;
    $timeframe = "M1";
    $startTS = new Timestamp(1528882380);
    $endTS = new Timestamp(1528882980);
    $candles = $instrument->getComputedCandles($timeframe, $startTS, $endTS);
    
    foreach($candles as $candle){
        if( !(FootprintCache::compareData($instrument, $timeframe, $candle)) ){
	        FootprintCache::updateCandle($instrument, $timeframe, $candle);
	    }
    }

?>