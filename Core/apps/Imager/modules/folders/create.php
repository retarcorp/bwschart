<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::ADMIN);
    
    use Core\Classes\Apps\Imager;
    echo Imager::createFolder($_POST['title']);