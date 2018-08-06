<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;

$path = $_GET['path'];
$name = $_GET['name'];
$target="";

if($_GET['createFolder']){
    $target = explode(".",$name);
    unset($target[count($target)-1]);
    $target = implode(".",$target);
    
}
if($_GET['target']){
    $target = $_GET['target'];
}
$to = dirname($path)."/".$target;
FileManager::extractTo($path, $to);
echo json_encode(["status"=>"OK"]);