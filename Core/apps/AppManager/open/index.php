<?php
    
    require "../config";
    $app = $_GET['app'];
    header("Content-Type: text/plain");
    
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::MODERATOR);
    
    use Core\Classes\Apps\AppManager\Manager;
    use Core\Classes\Apps\AppManager\InstallResult;
    
    $res = Manager::getAppURLByName($app);
    
    header("Location: $res");