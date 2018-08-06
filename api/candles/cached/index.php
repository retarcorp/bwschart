<?php
	
require $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
use Classes\FootprintCache;
use Core\Classes\System\RSql;

$tf = $_GET['timeframe'];
$instrument = $_GET['instrument'];

 $instrumentName = "\\Classes\\Instruments\\_".$instrument;
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }
$table = FootprintCache::getTableName($instrument);
$tf = FootprintCache::getTableTimeframeFor($tf);
$sql = new RSql;
$q = "SELECT id, ts FROM $table WHERE tf=$tf";
$data = $sql->getArray($q);
$r = [];
foreach($data as $i=>$d){
	$r[] = [$d[0],$d[1]];
}
usort($r,function($a, $b){
	return $a[1] - $b[1];
});
header("Content-Type: text/plain");
echo "id,ts\n";
foreach($r as $line){
	echo $line[0].",".$line[1]."\n";
}