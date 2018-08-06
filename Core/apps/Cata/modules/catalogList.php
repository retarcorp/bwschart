<?php
	require_once "../config.inc";
	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use_rights(CoreUsers::GUEST);
	
	$sql = new RSql;
	 
	$data = $sql->getArray("SELECT * FROM cata_catalogs order by id desc");
	echo json_encode($data);
	
	$tpl = "";
	
	#echo $data;
	
?>