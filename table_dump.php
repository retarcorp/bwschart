<?php

    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    use Core\Classes\System\RSql;
// 	header("Content-Type: text/plain");

	$TYPE_BUY = 1;
	$TYPE_SELL = 2;
	$TYPE_BUY_SELL = 3;
	$TABLE_NAME = 'ticks_test';
	$DB_NAME = 'BWSChart';

// 	$link = mysqli_connect('localhost', 'root', '', 'BWSChart');
    $sql = new RSql;

	$data = file_get_contents('EU6U7 - копия.csv');
	$sub_res = explode("\r\n", $data);

	foreach($sub_res as $i => $line){
		$res = explode(",", $line);

		if(!($res[0])){
			exit;
		}

		$pattern = "/(.*)\.([0-9]{3})\$/";
		$timeInfo = [];
		preg_match_all($pattern, $res[0], $timeInfo);

		$time = $timeInfo[1][0];
		$microtime = $timeInfo[2][0];
		$bid = $res[1];
		$ask = $res[2];
		$last = $res[3];
		$volume = $res[4];

		if($res[5] == 'Buy'){
			$type = $TYPE_BUY;
		}elseif($res[5] == 'Sell'){
			$type = $TYPE_SELL;
		}elseif($res[5] == 'Buy/Sell'){
			$type = $TYPE_BUY_SELL;
		}

		// var_dump($time);
		// print_r($res);
		// exit;

		$q = "INSERT INTO $TABLE_NAME (`time`, microtime, bid, ask, `last`, volume, type) VALUES('$time', $microtime, $bid, $ask, $last, $volume, $type)";
// 		mysqli_query($link, $q);
        $sql->query($q);

		if($sql->getLastError()){
			print_r($sql->getLastError()." on the line $i in csv file");
			exit;
		}
	}

// 	print_r($sub_res);

?>
