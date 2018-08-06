<?php

    # Универсальный модуль сохранения, по идее должен работать и для более высоких порядков
    
    require "config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    
    use_rights(CoreUsers::MODERATOR);
    
    $catalog = new RCatalog($_Config['catalog']);
    $level = $_POST['level'];
    $id = $_POST['id'];
    
    unset($_POST['id']);
    unset($_POST['level']);
    
    $catalog->editValuesOf($id, $level, $_POST);
    echo "[]";