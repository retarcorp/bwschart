<?php

    # Универсальный модуль обмена, должен работать и для более высоких порядков
    
    require "config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    
    use_rights(CoreUsers::MODERATOR);
    
    $level = $_POST['level']*1;
    $catalog = new RCatalog($_Config['catalog']);
    $id = $_POST['id'];
    $target = $_POST['target'];
    
    $catalog->swap($id, $target, $level);
    echo "[]";