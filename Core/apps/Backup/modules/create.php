<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::MODERATOR);
    
    use Core\Classes\Apps\Backup;
    
   
    $title = $_POST['title'] ;
    $comment = $_POST['comment'];
    $i_f = $_POST['include-files']*1 ==1;
    $i_m = $_POST['include-mysql']*1==1;
    
    switch($_POST['type']){
        case "project":
            Backup::createProject($title, $comment, $i_f, $i_m);
            break;
        
        case "backup":
            Backup::createBackup($title, $comment, $i_f, $i_m);
            break;
    }
    
    echo "[]";