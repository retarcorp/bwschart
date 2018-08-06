<?php

	require_once "../../config.inc";

	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use Core\Classes\System\RCatalog;
	use_rights(CoreUsers::GUEST);
	
	$name = $_GET['name'];
	
	$id = $_GET[id];
	$nest = $_GET[nest];
	
	$catalog = new RCatalog($name);
	
	echo $catalog->getParentOf($id, $nest);
	
	