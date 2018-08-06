<?php

	require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
	use Core\Classes\Apps\Imager;
	use Core\Classes\System\RImages;
	
	$file = $_FILES["file"];
	$name = $file["name"];
	$addr = $file["tmp_name"];
	
	$folder = $_POST['folder'];

	$r = Imager::addImageTo($folder, $file['name'], $file['tmp_name']);
	
	
	
	if ($r) echo "<li data-src='".RImages::getURL($r)."' data-id='$r'> <img src='/Core/apps/Imager/get/$r'/> </li>";