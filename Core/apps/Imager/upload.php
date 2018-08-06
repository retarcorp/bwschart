
<style>
	body{
		margin: 0;
		font-size: 80%;
		font-family: monospace;
	}
	textarea{
		width: 100%;
		min-height: 80px;
		font-size: 100%;
	}
</style>

<textarea><?php

	#Module for CKEDITOR
	
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/apps/Imager/config";
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    use Core\Classes\Apps\Imager;
    
	
	$file = $_FILES["upload"];
	$id = -1; #Folder to upload to
	
	$img = Imager::addImageTo(-1,$file['name'], $file['tmp_name']);
	echo "$img";
	

?></textarea>