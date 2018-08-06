<?php

    # Универсальный геттер, должен работать и для более высоких порядков
    
    require "config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    
    use_rights(CoreUsers::GUEST);
    $catalog = new RCatalog($_Config['catalog']);
    $level = $_GET['level'];
    $id = $_GET['id'];
    
    if($id == NULL){
        echo json_encode($catalog->getItemsAt(0));
    }else{
        echo json_encode($catalog->getChildrenOf($id, $level));
    }