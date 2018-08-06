<?php
require_once "../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;

switch($_GET['role']){
    case "file": {
        
        $path = $_GET['path'];
        $name = $_GET['name'];
        $target = $_GET['target'];
        $root = $_SERVER['DOCUMENT_ROOT'];
        
        if(is_file($root.$target."/".$name)){
            $rname = "";
            $i=0;
            do{
                $rname = explode(".",$name);
                if(count($name)>1){
                    $rname[count($rname)-2].="($i)";
                }else $rname[0].="($i)";
                $i++;
                $rname = implode(".",$rname);
                
                $targetName = $root.$target."/".$rname;
            }while(is_file($targetName));
            $name = $rname;
        }
        
        FileManager::copyFile($path, $target."/".$name);
        echo json_encode(["status"=>"OK"]);
        break;
    }
    case "folder": {
        
        $path = $_GET['path'];
        $name = $_GET['name'];
        $target = $_GET['target'];
        $root = $_SERVER['DOCUMENT_ROOT'];
        
        if(is_dir($root.$target."/".$name)){
            $rname = "";
            $i=0;
            do{
                $rname = $name."($i)";
                $targetName = $root.$target."/".$rname;
            }while(is_dir($targetName));
            $name = $rname;
        }
        
        FileManager::copyFolder($path, $target."/".$name);
        echo json_encode(["status"=>"OK"]);
        break;
    }
}
