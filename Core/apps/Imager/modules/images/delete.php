<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::ADMIN);
    
    use Core\Classes\Apps\Imager;
    
    $id = $_POST['id']*1;
    echo json_encode(Imager::deleteImage($id));