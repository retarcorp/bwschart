<?php
require_once "../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::GUEST);

use Core\Classes\Apps\FileManager;



switch($_GET['role']){
    case "file": echo json_encode(FileManager::getFileProperties($_GET['path'])); break;
    case "folder": echo json_encode(FileManager::getFolderProperties($_GET['path'])); break;
}
