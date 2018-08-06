<?php
require "../../config";
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::MODERATOR);

	$content = file_get_contents($_SERVER["DOCUMENT_ROOT"].$_GET["path"]);
	$filename = basename($_GET["path"]);
	header("Content-Disposition: attachment; filename=$filename");
	header("Content-type: application/octet-stream");
	header("Content-length: ".filesize($_SERVER["DOCUMENT_ROOT"].$_GET["path"]));
	
	echo $content;
