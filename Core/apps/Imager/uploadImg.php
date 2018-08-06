<?php
	
	#Module for Pagen
	
	require_once $_SERVER['DOCUMENT_ROOT']."/Core/apps/Imager/config";
    use Core\Classes\System\RCatalog;
    use Core\Classes\System\RImages;
    use Core\Classes\Apps\Imager;
	
	$file = $_FILES["file"];
	$img = Imager::addImageTo(-1,$file['name'], $file['tmp_name']);
	echo "$img";
?>