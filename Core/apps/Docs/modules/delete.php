<?php
	require "../config";
	use Core\Classes\System\CoreUsers;
	use_rights(CoreUsers::MODERATOR);
	
	use Core\Classes\Apps\Docs;
	
    $id =  $_GET['id'];
    Docs::remove($id);
    echo json_encode([]);