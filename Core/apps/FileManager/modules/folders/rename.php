<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;


$res = FileManager::renameFolder($_POST['path'],$_POST['newName']);
if($res == FileManager::RENAME_FOLDER_OK){
    echo json_encode(["status"=>"OK"]);    
}else{
    switch ($res){
        case FileManager::ERROR_FOLDER_EXISTS:{
            echo json_encode(["status"=>"ERROR","message"=>"Это имя уже занято!"]);
            break;
        }
        case FileManager::ERROR_ILLEGAL_NAME:{
            echo json_encode(["status"=>"ERROR","message"=>"Недопустимое имя папки."]);
            break;
        }
        default:{
            echo json_encode(["status"=>"ERROR","message"=>"При переименовании возникла ошибка!"]);
        }
    }
}
