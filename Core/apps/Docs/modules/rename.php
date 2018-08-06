<?php
	require "../config";
	use Core\Classes\System\CoreUsers;
	use_rights(CoreUsers::MODERATOR);
	
	use Core\Classes\Apps\Docs;
	
    $id =  $_POST['id'];
    $title = addslashes($_POST['name']);
    
    Docs::rename($id, $title);
    
    echo json_encode([]);