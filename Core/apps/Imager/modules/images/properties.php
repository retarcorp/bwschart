<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::GUEST);
    
    use Core\Classes\Apps\Imager;
    
    $id = $_GET['id']*1;
    echo json_encode(Imager::getProperties($id));