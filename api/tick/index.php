<?php
require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
header("Content-Type: application/json");

require $_SERVER['DOCUMENT_ROOT']."/modules/api_auth.php";

use Classes\Instruments\Instrument;
use Classes\App;
use Classes\Candle;
use Classes\Utils\Timestamp;
use Classes\Utils\JSONResponse;
use Core\Classes\System\RSql;


$instrument = $_GET['instrument'];
$instrumentName = "\\Classes\\Instruments\\_".$instrument;

if(class_exists($instrumentName)){
    $instrument = new $instrumentName;
}else {
    JSONResponse::error('Invalid class name');
}

$table = $instrument->getTableName(Instrument::WEEK);
$sql = new RSql;

$query = "SELECT price, secs FROM $table ORDER BY id DESC LIMIT 1";
$d =$sql->getArray($query);
JSONResponse::ok(["price"=>$d[0][0],"date"=>$d[0][1]."000"]);