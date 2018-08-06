<?php
    require $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::GUEST);
    
    use Core\Classes\Apps\AppManager\Manager;
    
    echo json_encode(Manager::getShopList());