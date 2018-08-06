<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::GUEST);

use Core\Classes\Apps\FileManager;
    
    $method = $_SERVER['REQUEST_METHOD'];
    switch($method){
        case "GET":{
            
            $items = FileManager::getItemsAtDir($_GET['path']);
            echo json_encode($items);
        }
    }
