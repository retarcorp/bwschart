<?php
    require "config";
    use Core\Classes\System\RLogger;
    use Core\Classes\System\RSql;
    
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::GUEST);
    
    $sql = new RSql;
    
    if(isset($_GET['from'])){
        if($_GET['from']*1){
            $query = "SELECT * FROM cata_logger_journal WHERE id<{$_GET['from']}  ORDER BY `id` DESC LIMIT {$_GET['amo']}";
        }else{
            $query = "SELECT * FROM cata_logger_journal ORDER BY `id` DESC LIMIT {$_GET['amo']}"; 
        }
        
    }
    

    echo json_encode($sql->getAssocArray($query));
    