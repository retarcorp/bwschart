<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::MODERATOR);
    
    use Core\Classes\Apps\Imager;
    
    $id = $_POST['id'];

    foreach($_FILES as $file){
        $res = Imager::addImageTo($id,$file['name'], $file['tmp_name']);
        
    }
    echo "[]";