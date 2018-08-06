<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;

$res = FileManager::createFile($_POST['path']);

switch($res){
    case FileManager::ERROR_FILE_EXISTS:
    case FileManager::ERROR_FOLDER_EXISTS:
        echo json_encode(["status"=>"ERROR","message"=>"В файловой системе уже существует объект с таким именем!"]);
        break;
    case FileManager::ERROR_ILLEGAL_NAME:
        echo json_encode(["status"=>"error","message"=>"Некорректное имя файла!"]);
        break;
    case FileManager::CREATE_FILE_OK:
        echo json_encode(["status"=>"ok"]);
        break;
    default:
        echo json_encode(["status"=>"ERROR","message"=>"Ошибка создания файла!"]);
}