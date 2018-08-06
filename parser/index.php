<?php
require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
use Classes\Ticks\Tick;

$sql = mysqli_connect('localhost', 'root', '', 'BWSChart');

# Parsing and inserting data
$data = file_get_contents("php://input");
// file_put_contents('data.txt', $data, FILE_APPEND);
$lines = explode("\r\n", $data);

foreach ($lines as $i => $line) {
    $line = trim($line);

    if(!$line){
        unset($lines[$i]);
        continue;
    }

    $tick_info = explode(" ", $line);
    $time_info = explode(".", $tick_info[0]);
    $secs = trim($time_info[0]);
    $msecs = trim($time_info[1]);
    $table = trim(substr($tick_info[2], 0, 2));
    $direction = $tick_info[3] == "ask" ? Tick::ASK : Tick::BID;
    $volume = trim($tick_info[4]);
    $price = str_replace(",", ".", $tick_info[5]) * 1;

    $surrogate_oid = $secs.$msecs;

    $order_id = intval($tick_info[6]) ? intval($tick_info[6]) : $surrogate_oid;

    $tables = [$table, $table."_day", $table."_week"];

    foreach($tables as $tableName){
        $Q = "INSERT INTO ticks_$tableName (secs, usecs, direction, volume, price, order_id) VALUES($secs, $msecs, $direction, $volume, $price, $order_id)";

        if( $tableName == '6E_day' ){
            file_put_contents('log', date("Y-m-d H:i:s", $secs).". $msecs, $direction, $volume, $price, $order_id"."\n", FILE_APPEND);
        }
        
        mysqli_query($sql, $Q);
        if(mysqli_error($sql)){
            file_put_contents('Error_log', mysqli_error($sql).' '.date("Y-m-d H:i:s", time())."\n", FILE_APPEND);
        }

        // $value = rand(0, 100);

        // if($value < 10){
        //     if($tableName == $table."_day"){
        //         $timeToRemove = time() - 60 * 60 * 24;
        //         #$remove = "DELETE FROM ticks_$tableName WHERE secs < $timeToRemove";

        //         // mysqli_query($sql, $remove);
        //         // if(mysqli_error($sql)){
        //         //     file_put_contents('Error_log', mysqli_error($sql).' '.date("Y-m-d H:i:s", time())."\n", FILE_APPEND);
        //         // }
        //     }elseif($tableName == $table."_week"){
        //         $timeToRemove = time() - 60 * 60 * 24 * 7;
        //         #$remove = "DELETE FROM ticks_$tableName WHERE secs < $timeToRemove";

        //         // mysqli_query($sql, $remove);
        //         // if(mysqli_error($sql)){
        //         //     file_put_contents('Error_log', mysqli_error($sql).' '.date("Y-m-d H:i:s", time())."\n", FILE_APPEND);
        //         // }
        //     }
            
        // }
    }
}
mysqli_close($sql);