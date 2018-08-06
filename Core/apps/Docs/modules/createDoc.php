<?php
	require "../config";
	use Core\Classes\System\CoreUsers;
	use_rights(CoreUsers::MODERATOR);
	
	use Core\Classes\Apps\Docs;
	
    $parent =  $_POST['parent'];
    $title = addslashes($_POST['title']);
    
    Docs::createDocIn($parent, $title);
    
    echo json_encode([]);