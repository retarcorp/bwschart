<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::GUEST);
    
    $users = CoreUsers::getAll();
    echo json_encode($users);