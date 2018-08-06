<?php 
	
	$APP_NAME = "Хранилище изображений";
	
	require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
	require_once $_SERVER['DOCUMENT_ROOT']."/Core/apps/Imager/config";
    use Core\Classes\System\RCatalog;
	
	if (file_exists(".uninstalled")){
		header("Location: install/");
		die();
	}


		
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<title> Изображения для сайта </title>

	<link rel='stylesheet' href='/Core/css/main.css'/>
	<link rel='stylesheet' href='css/main.css'/>


	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
	<script type="text/javascript" src="/Core/js/System.js"></script>
	
	<script src="js/controller.js"> </script>

</head>
<body>

	<?php
		include_view("/Core/views/menu.php");
	?>
	
	<aside class='folderList'>
		<ul class='folders'>
		    <template id='Folder'>
		        <li data-id='{{id}}' data-title='{{title}}'> <h3><i>[{{id}}]</i><span>{{title}}</span></h3> </li>
		    </template>
			
		</ul>
		<input type='button' value='Добавить папку' id='addFolder'/>
	</aside>
	
	<section class='imageList'>
		<div class='controls'> 
			<form enctype='multipart/form-data'>
			<label>
				<span> Добавить изображение </span>
				<input type='file' name='image' id='image'/>
			</label>
			</form>
		</div>
		<ul class='images' id='imagesUL'>
		    <template id='Image'>
		        <li data-id='{{id}}'>
		            <figure title='{{title}}'>
		                <div>
    		                <img src='/Core/apps/Imager/get/{{id}}'/>
		                </div>
		                <figcaption>
		                    <span>[{{id}}]</span>
		                </figcaption>
		            </figure>
		        </li>
		    </template>
		</ul>
	</section>
	
</body>
</html>