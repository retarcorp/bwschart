<?php
	require_once $_SERVER["DOCUMENT_ROOT"]."/Core/Auth.php";

	$APP_TITLE = "Каталоги RetarCata";
	
?>


<!doctype html>
<html>
	<head>
	
		<meta charset='utf-8'/>
		<title><?=$APP_TITLE?> | Retar Core v 1.17</title>
		
		<script src='/Core/js/retarcore.js'></script>
		<script src='/Core/js/System.js'></script>
		<script src='js/controller.js'> </script>
		<script src='js/generator.js'> </script>
		
		
		<link rel='stylesheet' href='/Core/css/main.css'/>
		<link rel='stylesheet' href='css/main.css'/>
		<link rel='stylesheet' href='css/generator.css'/>
		
	</head>
	
	<body>
	
		<?php include_view("/Core/views/menu.php");  ?>


	    <main>
    		<div class='wrapper'>
    			<aside class='folder_list'>
    				<input type='button' value='+' id='addCatalog'/>
    				<ul class='list'>
    				    <template id='catalog'>
    				        <li data-id='{{id}}' data-name='{{name}}'> 
    				            <h4>{{name}}</h4> 
    				            <div class='buttons'> 
    				                <!--input type='button' value='' class='generateCS' data-id='{{id}}' data-name='{{name}}'/--> 
    				                <!--input type='button' value='' class='editCatalog' data-id='{{id}}' data-name='{{name}}'/--> 
    				            </div> 
    				        </li>
    				    </template>
    					
    				</ul>
    				
    			</aside>
    			
    			<section class='content'>
    				<form class='edit Scrollable'>
    				
    				</form>
    			</section>
    		</div>
    	</main>
		
	</body>

</html>