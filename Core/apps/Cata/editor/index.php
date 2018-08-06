<?php
	require_once "../config.inc";
	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use Core\Classes\System\RCatalog;
	use_rights(CoreUsers::GUEST);
	
	
	$CATA_NAME = $_SERVER['QUERY_STRING'];
	$APP_TITLE = "Каталог $CATA_NAME";
	
	$catalog = new RCatalog($CATA_NAME);
	$nest = $catalog->getNest();
	
?>


<!doctype html>
<html>
	<head>
	
		<meta charset='utf-8'/>
		<title><?=$APP_TITLE?> | Retar Core v 1.17</title>
		
		<script src='/Core/js/retarcore.js'></script>
		<script src='/Core/js/System.js'> </script>
		
		<script> _.c = '<?=$CATA_NAME?>'; _.l = <?=$nest?>;</script>
		<script src='js/controller.js'> </script>
		
		<link rel='stylesheet' href='/Core/css/main.css'/>
		<link rel='stylesheet' href='css/main.css'/>
		
	</head>
	
	<body>
	
		<?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php"; ?>
        
        <main>
            <div class='wrapper'>
    			<aside class='folder_list'>
    				<h3> Текущий уровень: <span id='t_level'> 0 </span>. ID родителя: <span id='t_id'> -1 </span>.
    					<div class='buttons'>
    						<input type='button' value='↑' id='back' title='На уровень выше'/>
    						<input type='button' value='+' id='add' title='Добавить элемент'/>
    						
    					</div>
    				</h3>
    			</aside>
    			
    			<ul class='list Scrollable'></ul>
    				
    			
    			<section class='content'>
    				<form class='edit'>
    				
    				</form>
    			</section>
    		</div>
        </main>
		
		
	</body>

</html>