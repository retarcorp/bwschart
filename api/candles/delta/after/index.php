<?php
require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
require $_SERVER['DOCUMENT_ROOT']."/api/Handler.php";
header("Content-Type: application/json");

require $_SERVER['DOCUMENT_ROOT']."/modules/api_auth.php";

$str = explode('?',$_SERVER['REQUEST_URI']);
parse_str($str[1], $res);
$_GET = array_merge($_GET,$res);

$method = ($_SERVER['REQUEST_METHOD']);
$uri = "/".$_GET['api_uri']."/";


$class = file_get_contents("../../../Handler.php");
$lines = [];
preg_match_all("/@http ([\/a-zA-Z\-\_\s0-9]+)\n[a-z\s]* function ([a-zA-Z0-9\_\-]+)/",$class,$lines);

$handlers = [];
foreach($lines[1] as $i=>$m){
    $handlers[trim($m)] = "Handler$".trim($lines[2][$i]);
}

if($method=="PUT"){
    parse_str(file_get_contents("php://input"),$_PUT);
}


$handler = new Handler();
echo json_encode($handler->getReverseDeltaCandles());
usleep(400000);
