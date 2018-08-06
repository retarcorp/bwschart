<pre>
<?php
	require_once "../config.inc";
	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use_rights(CoreUsers::ADMIN);
	

	$sql = new RSql;
	
	$_POST[d]=stripslashes($_POST[d]);
	$cata=$_POST['name'];
	$data = json_decode($_POST[d],true);
	$json = array();
	
	require_once "types.php";
	$abstracts = array_keys($types);
	
	
	foreach($data as $k => $v){
		
		$fields = array();
		foreach($v as $i => $el){
			$type = $data[$k][$i]['type'];
			if (in_array($type,$abstracts)){
				#echo $type."=> ".$types[$type]."\n";
				$type=$types[$type];
			}
			
			$index = $i;
			$fields[$index]=$type;
		}
		$json[$k]=$fields;
	}
   
	$tables = $json;
	$json = json_encode($json);

	$skin = $_POST[d];
	
	
	$i=0;
	foreach($tables as $table=>$d){
		if($i) $parent=", parent INT";
		$fields="";
		foreach($d as $name=>$type ){
			$fields.=", `$name` $type";
		}
		$Q = "CREATE TABLE $table (id INT NOT NULL AUTO_INCREMENT, c_order_id INT NOT NULL $parent  $fields ,PRIMARY KEY(id))";
		
		$exist = $sql->getArray("SHOW TABLES LIKE '$table'");
		if(count($exist)){
			#DEFAULT ACTION IF TABLE EXISTS
			
			$sql->query("DROP TABLE $table");
			if($sql->getLastError())echo "<p class='warn'>".$sql->getLastError()."</p>";
			echo "<p class='warn'>Таблица $table уже существовала и была удалена. </p>";
		}
		
		$sql->query($Q);
		if ($sql->getLastError()) echo "<p class='warn'>".$sql->getLastError()."</p>";
		else echo "<p class='ok'>Таблица $table успешно созданa.</p>";

		
		$i++;
		#echo $Q."\n";
	}
	#echo $i;
	$Q  = "INSERT INTO cata_catalogs (type, name, tables, skin) VALUES ($i, '$cata', '$json', '$skin')";
	#echo $Q;
	
	$exists = $sql->getArray("SELECT * FROM cata_catalogs WHERE name ='$cata'");
	if(count($exists)){
		echo  "<p class='warn'>Каталог $cata существовал и был удален.</p>";
		$sql->query("DELETE FROM cata_catalogs WHERE name='$cata'");
		if($sql->getLastError())echo "<p class='warn'>".$sql->getLastError()."</p>";
	}
	
	$sql->query($Q);
	if($sql->getLastError())echo "<p class='warn'>".$sql->getLastError()."</p>";
	else echo "<p class='ok'>Каталог $cata успешно создан!</p>";
?>
</pre>