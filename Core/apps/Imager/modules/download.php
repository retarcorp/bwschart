<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::GUEST);
    
    use Core\Classes\Apps\Imager;
    
    $id = $_GET['id']*1;
    $image= Imager::getProperties($id);
    $path = $image['url'];
    
    $content = file_get_contents($_SERVER["DOCUMENT_ROOT"].$path);
	$filename = ($image['title']);
	
	header("Content-Disposition: attachment; filename=$filename");
	header("Content-type: application/octet-stream");
	header("Content-length: ".filesize($_SERVER["DOCUMENT_ROOT"].$path));
	
	echo $content;