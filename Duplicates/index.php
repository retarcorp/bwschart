<?php

$_SERVER['DOCUMENT_ROOT'] = "C:\inetpub\wwwroot";
require_once "C:\inetpub\wwwroot\Core\Global.php";
use Classes\Utils\DuplicatesRemover as DR;

header("Content-Type: text/plain");

const ACTION_FILL = 1;
const ACTION_REMOVE = 2;

$fp = new DR(DR::FP);
$delta = new DR(DR::DELTA);

$action = $argv[1];

if( isset($_GET['fill']) || $action == ACTION_FILL ){
    $fp->fillDuplicatesTable();
    $delta->fillDuplicatesTable();
    die();
}

if( isset($_GET['remove']) || $action == ACTION_REMOVE ){
    $fp->clearDuplicates();
    $delta->clearDuplicates();
    die();
}