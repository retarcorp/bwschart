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

	foreach(Instrument::$Instruments as $k=>$inst){
		$cl = ("\Classes\Instruments\_".$inst);
		$instrument = new $cl;
		$instrument->clearDayTicks();
	}
	

	$e = time();
	RLogger::info("TicksDeleter D1 ","Deleting finished for ".($e - $s)."s.");
	echo "TicksDeleter D1 ","Deleting finished for ".($e - $s)."s.";