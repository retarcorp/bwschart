<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;

#echo json_encode($_GET);
FileManager::deleteFolder($_GET['path']);
echo json_encode(["status"=>"OK"]);