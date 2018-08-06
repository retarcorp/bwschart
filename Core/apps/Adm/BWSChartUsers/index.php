<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
	$APP_TITLE = "Менеджер файлов ";
	
	$_Config = json_decode(file_get_contents("config.json"),true);
	
?>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> <?=$_Config['title']?> </title>
    
    	
    	<link rel="stylesheet" href="/Core/css/main.css"/>
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/custom.css">
        
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	<script type="text/javascript" src="/Core/modules/cImager/api.js"></script>
    	
    	<script src="js/controller.js"> </script>
    	<script>App.Data.ImagerFolder = <?=$_Config['imager_folder']*1;?>;</script>
        <script src="js/custom.js"> </script>
        
    </head>
    <body>

    <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>

	<main>
	    <aside class='Scrollable'>
	        <input type='button' id='createItem' value='Добавить элемент'/>
	        <div id='licensesCount'>0(0)</div>
	        <!--Всего: 0. Активных: 0.-->
            <ul class='level-1' id='lvl1'>
    	        <template id="Level1">
    	            <li data-id='{{id}}'>
    	                <div class='content'><?=file_get_contents($_Config['levels'][0]['display'])?></div>
    	            </li>
    	        </template> 
    	    </ul> 
	    </aside>
	    
	    <section class='edit Scrollable'>
	        
	        <form id='editForm'>
	            <div class='tools'>
    	            <input type='button' id='save' value='Сохранить'/>
    	        </div>
    	        
    	        <fieldset id='fields'>
    	            
    	        </fieldset>
	        </form>
	    </section>
	    
	</main>	
	
</body>
</html>