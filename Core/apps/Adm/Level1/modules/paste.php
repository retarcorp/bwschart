<?php

    # Универсальный модуль перестановки, должен работать и для более высоких порядков
    
    require "config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    
    use_rights(CoreUsers::MODERATOR);
    
    $level = $_POST['level']*1;
    $catalog = new RCatalog($_Config['catalog']);
    $id = $_POST['id'];
    
    if($_POST['before']){
        //Paste BEFORE
        $before = $_POST['before']*1;
       
        $catalog->cloneBefore($id,$before,$level,($_POST['action']=="cut"));
    }
    if($_POST['after']){
        //Paste AFTER
        $after = $_POST['after']*1;
        $catalog->cloneAfter($id,$after,$level,($_POST['action']=="cut"));
    }
    
    echo "[]";