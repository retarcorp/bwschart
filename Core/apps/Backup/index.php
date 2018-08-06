<?php 
	
	$APP_NAME = "Точки восстановления системы";
	
	require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
    use Core\Classes\System\RCatalog;


		
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<title> Точки восстановления системы </title>

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
	
	<main>
	    <aside class='points Scrollable'>
	        <ul id='points'>
	            <template id='Point'>
	                <li data-created='{{ts}}'>
	                    <h3>{{title}}</h3>
	                    <h5>{{created}}</h5>
	                    
	                    <div class='comment'>
	                        {{comment}}
	                    </div>
	                    
	                    <div class='desc'>
	                        <p>Тип точки: {{type}}</p>
	                        <p>Содержит: {{contains}}</p>
	                        <p>Размер: {{size}}</p>
	                    </div>
	                    
	                    <div class='buttons'>
	                        <input type='button' value='' class='backup' title='Откатить до этой точки'/>
	                        <input type='button' value='' class='download' title='Скачать точку'/>
	                        
	                        <input type='button' value='' class='delete' title='Удалить точку'/>
	                    </div>
	                </li>
	            </template>
	        </ul>
	    </aside>
	    
	    <section class='Scrollable'>
	        <form id='createPoint'>
	            <fieldset>
	                <label>
    	                <span>Название точки</span>
    	                <input type='text' value='' id='title'/>
	                </label>
	                
	                <label>
	                    <span>Комментарий к созданию точки</span>
	                    <textarea id='comment'></textarea>
	                </label>
	            </fieldset>
	            
	            <fieldset class='no-m'>
	                <h3>Тип точки</h3>
	                <label><input type='radio' checked value='backup' name='type' id='type-backup'/> <span>Точка восстановления</span></label>
	                <label><input type='radio'  value='project' name='type' id='type-project'/> <span>Архив для развертывания проекта</span></label>
	            </fieldset>
	            
	            <fieldset class='no-m'>
	                <h3>Включить в точку</h3>
	                <label><input type='checkbox' checked value='' id='include-files'/><span>Файлы сайта, начиная с корня</span></label>
	                <label><input type='checkbox' checked value='' id='include-mysql'/><span>Дамп базы данных</span></label>
	            </fieldset>
	            
	            <input type='submit' value='Создать точку'/>
	        </form>
	    </section>
	</main>
	
</body>
</html>