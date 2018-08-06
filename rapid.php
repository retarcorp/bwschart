<?php

	require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
	use Core\Classes\System\RSql;

	use Classes\App;
	use Classes\Instruments\Instrument;

	$instruments = array_keys(Instrument::$TYPE_ROUND_CORRESPONDENCE);

	$sql = new RSql;
	foreach($instruments as $i=>$v){
		$sql->query("CREATE TABLE `fp_candles_$v` (
			 `id` bigint(20) NOT NULL AUTO_INCREMENT,
			 `first_price` double NOT NULL,
			 `last_price` double NOT NULL,
			 `start_ts` bigint(20) unsigned NOT NULL,
			 `tick_max_price` double NOT NULL,
			 `volume` int(11) NOT NULL,
			 `timeframe` int(3) NOT NULL,
			 PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8");

		$sql->query("CREATE TABLE `fp_candles_{$v}_ticks` (
			 `c_id` bigint(20) NOT NULL,
			 `price` double NOT NULL,
			 `bid` int(11) NOT NULL,
			 `ask` int(11) NOT NULL
			) ENGINE=InnoDB DEFAULT CHARSET=utf8");

		if($sql->getLastError()){
			echo $sql->getLastError();
		}
	}
