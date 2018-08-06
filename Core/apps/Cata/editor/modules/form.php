<?php

	require_once "../../config.inc";
	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use Core\Classes\System\RCatalog;
	use_rights(CoreUsers::ADMIN);
	
	$name = $_GET['name'];
	$id = $_GET[id];
	$nest = $_GET[nest];
	
	$sql = new RSql;
	
	$check = $sql->getArray("SELECT * from cata_catalogs WHERE name='$name'");
	if(!count($check)) die("<h2> Каталога $name не существует!</h2>");
	
	$catalog = new RCatalog($name);
	$item =$catalog->getItemAt($id, $nest);

	$j = $catalog->getSchemaJSON();
	$j = json_decode($j,true);
	$j=$j[$nest];
	
	foreach($item as $k => $v){
		if($k=="id") continue;
		if($k=="parent") continue;
		if($k=="c_order_id") continue;

		
		if(($j[$k]=='TEXT')||($j[$k]=='MEDIUMTEXT')||($j[$k]=='LONGTEXT')){
			$kk = $catalog->getSkinTitleFor($k,$nest);
			echo "<tr class='editable big'><td data-name='$k'>$kk</td> <td><textarea data-name='$k'>$v</textarea></td> </tr>";}
		else if(strpos($j[$k],'VARCHAR')!==false){
			$kk = $catalog->getSkinTitleFor($k,$nest);
			echo "<tr class='editable medium'><td data-name='$k'>$kk</td> <td><textarea data-name='$k'>$v</textarea></td> </tr>";
		}			
		else{
			$kk = $catalog->getSkinTitleFor($k,$nest);
			echo "<tr class='editable small'><td data-name='$k'>$kk</td> <td><textarea data-name='$k'>$v</textarea></td> </tr>";
		} 
			
	}