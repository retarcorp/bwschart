<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;


$res = FileManager::renameFile($_POST['path'],$_POST['newName']);
if($res == FileManager::RENAME_FILE_OK){
    echo json_encode(["status"=>"OK"]);    
}else{
    switch ($res){
        case FileManager::ERROR_FILE_EXISTS:{
            echo json_encode(["status"=>"ERROR","message"=>"Это имя уже занято!"]);
            break;
        }
        case FileManager::ERROR_ILLEGAL_NAME:{
            echo json_encode(["status"=>"ERROR","message"=>"Недопустимое имя файла."]);
            break;
        }
        default:{
            echo json_encode(["status"=>"ERROR","message"=>"При переименовании возникла ошибка!"]);
        }
    }
}
