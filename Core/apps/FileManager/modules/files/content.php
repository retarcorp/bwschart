<?php
require_once "../../config";

use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;
use Core\Classes\System\RLogger;

$root = $_SERVER['DOCUMENT_ROOT'];

switch($_SERVER['REQUEST_METHOD']){
    case "GET":{
        $path = $root.$_GET['path'];
        if(!is_file($path)){
            echo "Файл не найден!";
        }
        
        echo json_encode(["data"=>(file_get_contents($path))]);
        if(json_last_error()){
            echo "Содержимое файла не может быть прочитано текстовым редактором.";
        }
        break;
    }
    
    case "POST":{
        $path = $root.$_POST['path'];
        #ini_set("allow_url_fopen",1);
        file_put_contents($path,$_POST['content']);
        echo json_encode(["status"=>"OK"]);
        RLogger::info("Файловый менеджер","Перезаписан файл $path.");
    }
}