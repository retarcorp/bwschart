<?php
require_once "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\FileManager;

$target = $_SERVER["DOCUMENT_ROOT"].$_POST["path"];

foreach($_FILES as $descr => $file){

	$name = $file["name"];
	$fileName = $name;
	$i=0;
	while(file_exists($fileName)) $fileName=$name."(".($i++).")";
	file_put_contents($target.$fileName,file_get_contents($file["tmp_name"]));
}

echo json_encode(["status"=>"OK"]);
