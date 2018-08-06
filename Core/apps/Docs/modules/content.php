<?php
	require "../config";
	use Core\Classes\System\CoreUsers;
	use_rights(CoreUsers::GUEST);
	
	use Core\Classes\Apps\Docs;
	
    
    switch(strtoupper($_SERVER['REQUEST_METHOD'])){
        case "GET":{
            $id = $_GET['id'];
            echo Docs::getContent($id);
            break;
        }
        case "POST":{
            
            $id = $_POST['id'];
            $content = $_POST['content'];
            Docs::putContent($id, $content);
            echo "[]";
            break;
        }
    }
    
    