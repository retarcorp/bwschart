<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::ADMIN);
    
    use Core\Classes\Apps\Imager;
    
    Imager::removeFolder($_POST['id']*1);
    echo "[]";