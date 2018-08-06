<?php
    require "../../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::GUEST);
    
    use Core\Classes\Apps\Imager;
    echo json_encode(Imager::getFolders());