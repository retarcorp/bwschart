<?php
    
    require "../config";
    $app = $_GET['app'];
    header("Content-Type: text/plain");
    
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::MODERATOR);
    
    use Core\Classes\Apps\AppManager\Manager;
    use Core\Classes\Apps\AppManager\InstallResult;
    $res = Manager::installRemoteApp($app);
    
    
    if($res->status == InstallResult::STATUS_ERROR){
        die($res->getMessage());
    }
    
    header("Location: ".$res->getMessage());
    
    