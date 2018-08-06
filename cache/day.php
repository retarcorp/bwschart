<?php
	$_SERVER['DOCUMENT_ROOT'] = "C:\inetpub\wwwroot";
	require_once "C:\inetpub\wwwroot\Core\Global.php";
	use Core\Classes\System\RSql;
	use Core\Classes\System\RLogger;

	use Classes\App;
	use Classes\FootprintCache;
	use Classes\Utils\Timestamp;
	use Classes\Instruments\Instrument;

	$s = time();
	#file_put_contents("log","!",FILE_APPEND);

	# For each instrument, 
	$time = time();
	$delay = 60*90; // 90 mins
	$start = $time - $delay;

	$startTS = new Timestamp($start);
	$endTS = new Timestamp($time);
	$timeframes = [App::TF_H1, App::TF_H4, App::TF_D1];

	foreach(Instrument::$Instruments as $k=>$inst){
		$cl = ("\Classes\Instruments\_".$inst);
		$instrument = new $cl;
		foreach($timeframes as $i=>$timeframe){
			FootprintCache::cache($instrument, $timeframe, $startTS, $endTS);
		}
	}
	

	$e = time();
	RLogger::info("FootprintCache Sheduler 1D","Caching finished for ".($e - $s)."s.");
	echo "FootprintCache Sheduler 1H","Caching finished for ".($e - $s)."s.";