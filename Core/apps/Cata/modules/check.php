<?php
	#Checks if catalog exists.
    
	require_once "../config.inc";
	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use_rights(CoreUsers::GUEST);
	
	$sql = new RSql;
	$name= $_GET['name'];
	$data=$sql->getArray("select * from cata_catalogs where name='$name'");
	if(!count($data)) echo "";
	else{
		echo "<p class='warn'> Каталог уже существует! </p>";
	}
?>