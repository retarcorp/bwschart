<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::MODERATOR);
    
    use Core\Classes\Apps\Imager;
    
    Imager::renameFolder($_POST['id']*1,$_POST['title']);
    echo "[]";