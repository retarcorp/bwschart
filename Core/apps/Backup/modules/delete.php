<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::ADMIN);
    
    use Core\Classes\Apps\Backup;
    
    $ts = $_GET['ts'];
    Backup::deletePoint($ts);
    
    echo '[]';