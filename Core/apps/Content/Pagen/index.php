<?php

    require_once $_SERVER["DOCUMENT_ROOT"]."/Core/Global.php";
	require_once $_SERVER["DOCUMENT_ROOT"]."/Core/Auth.php";
	use Core\Classes\Content\Page;
	
    $id = $_GET['id'];
    $page = new Page($id);
	$APP_TITLE = "Редактор содержимого";
?>


<!doctype html>
<html>
	<head>
	
		<meta charset='utf-8'/>
		<title>Управление содержимым | Retar Core v 1.20</title>
		
		<script src='/Core/js/retarcore.js'></script>
		<script src='/Core/js/System.js'></script>
		
		<script src='js/controller.js'> </script>
		<script>
		    A.Data.page = <?=$id?>;
		    A.Data.url = '<?=$page->url_pattern?>';
		    A.Data.metakeys = '<?=$page->metakeys;?>' ;
		    A.Data.metadesc = '<?=$page->metadesc?>';
		    A.Data.title = '<?=$page->title?>' 
		    
		</script>
		
		<script src="//cdn.ckeditor.com/4.5.6/standard/ckeditor.js"></script>
		<link rel='stylesheet' href='/Core/css/main.css'/>
		<link rel='stylesheet' href='css/main.css'/>
		
	</head>
	
	<body>
	
		<?php include_view("/Core/views/menu.php"); ?>

        <div class='header'>
		   <header class='w_form'>
            	<div class='general'>
            		<a href='<?=$page->url_pattern?>' class='button' id='link' target='_blank' title='Открыть на сайте'> </a>
            		<input type='button' value='settings' id='settings' title='Настройки страницы'/>
            		
            		<input type='text' id='title' value='<?=$page->title?>'>
            		
            		<input type='button' value='save' id='save' title='Сохранить изменения'/>
            	</div>
            	
            	<div class='side'>
            		<input type='button' value='close' id='close' title='Закрыть окно редактирования'/>
            	</div>
            	
            	<div id='mainContext'>
            		<label> <span>Ключевые слова </span>	<textarea id='keywords'><?=$page->metakeys?></textarea> </label>
            		<label> <span>Метаописание </span>	<textarea id='description'><?=$page->metadesc?></textarea> </label>
            		<input type='button' id='submit' value='Принять'/>
            	</div>
            </header>
		</div>
		
		<section class='content w_form'>
			
			<iframe src='modules/get.php?page=<?=$id?>' id='field'></iframe>
			<script>
			    var f = _.$("#field")[0];

			    var onbeforeloadframe = function(e){
			        this.removeEventListener("DOMContentLoaded",onbeforeloadframe);
			        var onload = f.contentWindow.onload;
			        f.contentWindow.onload = null; 
			        e.stopImmediatePropagation();
			        e.stopPropagation();
			        e.preventDefault()
			       
			        A.init();
			        f.contentWindow.onload = onload;
			        f.contentWindow.dispatchEvent(new Event("DOMContentLoaded"));
			    }
			    f.contentWindow.addEventListener("DOMContentLoaded", onbeforeloadframe)
			    
			    
			</script>
			<div id='layout'> <div class='miniLoader'> <p> </p> </div> </div>
		</section>
		
		<aside class='instruments'>
		
		</aside>
		
		<div id='listedContext'>
			
				<input type='button' value='C' id='copyListed'/>
				<input type='button' value='X' id='removeListed' />
		
		</div>
		
		<div id='atomicContext'>
			<div id='imgContext'>
				<label> <span> Описание картинки для поиска</span> <input type='text' value='' id='imgAlt'/></label>
				<label> <span> Загрузить другую картинку </span> <form enctype='multipart/form-data'><input type='file' id='imgSrc' name='imgSrc'/> </form></label>
				<input type='button' value='Сохранить' id='imgSave'/>
			</div>
			
			<div id='aContext'>
				<label> <span> Адрес ссылки </span> <input type='text' value='' id='aHref'/></label>
				<label> <span> Описание ссылки для поиска </span> <input type='text' value='' id='aTitle'/></label>
				<label> <input type='checkbox' value='' id='aNofollow'/> <span> Неиндексируемая ссылка </span> </label>
				<label> <input type='checkbox' value='' id='aTargetblank'/> <span> В новой вкладке </span> </label>
				
				<input type='button' value='Сохранить' id='aSave'/>
			</div>
			
			<div id='iContext'>
				<textarea id='iframe'></textarea>
				<input type='button' value='Сохранить' id='aSave'/>
			</div>
		</div>
		
		<div id='popupContext'>
			<div id='editorContext'>
				<div id='ckeditor'> </div>
				<input type='button' id='ckaccept' value='Принять'/>
			</div>
		</div>
	</body>

</html>