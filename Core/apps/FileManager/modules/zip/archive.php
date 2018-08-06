<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::MODERATOR);

use Core\Classes\Apps\FileManager;

#echo json_encode($_POST);
$path = $_POST['path'];
$name = $_POST['name'];

$root = $_SERVER['DOCUMENT_ROOT'];

if(is_file($root."/".$name.".zip")){
    $rname = $name;
    for($i=0;;$i++){
        if(!is_file("$root/$name($i).zip")){
            $rname="$name($i).zip";
            break;
        }
    }
    $name= $rname;
}else{
    $name = $name.".zip";
}
$parent = explode("/",$path);
$parent[count($parent)-1]="";
$parent = implode("/",$parent);

#echo $parent.$name;

FileManager::archivate($path, $parent.$name);
echo json_encode(["status"=>"OK"]);