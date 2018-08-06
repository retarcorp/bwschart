<?php

	require_once $_SERVER["DOCUMENT_ROOT"]."/Core/Global.php";
	use Core\Classes\System\RImages;
	use Core\Classes\System\RCatalog;
	use Core\Classes\System\CoreUsers;
	
	use_rights(CoreUsers::GUEST);
	
	$folder = $_GET['folder'];
	
	$imgs = RImages::getImages($folder);
	foreach($imgs as $img){
		echo "<li data-id='".$img["id"]."' data-src='".RImages::getURL($img['id'])."' >".RImages::getImage($img['id'],["data-folder"=>"$folder","data-id"=>"{$img['id']}"],NULL,150)."</li>";
	}