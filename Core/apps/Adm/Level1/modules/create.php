<?php

    # Универсальный модуль создания, должен работать и для более высоких порядков
    
    require "config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    
    use_rights(CoreUsers::MODERATOR);
    
    $default = ($_Config['levels'][$_POST['level']*1]['default']);
    if(!$default){
        die("Уровень не найден!");
    }
    
    $level = $_POST['level']*1;
    $catalog = new RCatalog($_Config['catalog']);
    $id = $_POST['id'];
    
    foreach($default as $i=>$v){
        if($v[0]=='$'){
            $v = substr($v,1);
            $default[$i]=eval("return ".$v.";");
        }
    }
   
    
    if($level==0){
        $catalog->addItem($default);
        
    }else{
        $catalog->addItem($default,$id, $level);
    }
    echo "[]";