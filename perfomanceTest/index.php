<?php

require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
use Core\Classes\System\RSql;

header("Content-Type: text/plain; Charset=utf-8");

$sql = new RSql();

$Tests = [
	// "Get 6E data request" => function(){
	// 	global $sql;
	// 	$sql->query("SELECT secs, usecs, direction, volume, price, order_id 
 //                    FROM ticks_6E 
 //                    WHERE secs <= 1527156606
 //                    AND secs >= 1527154806
 //                    ORDER BY secs DESC, usecs DESC");
	// 	return 1;
	// },

	"Get 6E Indexed table request" => function(){
		global $sql;
		$sql->query("SELECT secs, usecs, direction, volume, price, order_id 
                    FROM ticks_6E_indexed 
                    WHERE secs <= 1527156606
                    AND secs >= 1527154806
                    ORDER BY secs DESC, usecs DESC");
		return 1;
	}
];


foreach($Tests as $i => $test){
	$start = microtime(true);
	$test();
	$end = microtime(true);

	$d = $end - $start;
	echo $i.": ".$d."s\n";
}