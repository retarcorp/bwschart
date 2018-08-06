<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
	$APP_TITLE = "Менеджер файлов ";
	
	if (file_exists(".uninstalled")){
		header("Location: ./install/");
	}
	require "config";
?>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> Файловый менеджер </title>
    
    	<link rel="stylesheet" href="css/main.css">
    	<link rel="stylesheet" href="/Core/css/main.css"/>
    		
    	<link rel="shortcut icon" href="http://app.retarcorp.com/core/favicon.ICO" type="image/x-icon">
    
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	
    	<script src="js/ace.js" type="text/javascript" charset="utf-8"></script>
    	<script src="js/controller.js"> </script>
    	<script src="js/editor.js"> </script>

    </head>
    <body>

    <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>

	<main>
	    <aside id='fileTree' class='Scrollable'>
	        <ul id='tree' data-path=''>
	            <li data-path='/Core' data-role='folder' >
	                <span class='itemName' > Core</span>
	            </li>
	            <template id='asideItem'>
	                <li data-path='{{path}}' data-role='{{role}}'>
	                   <span class='itemName' data-ext='{{ext}}'>{{name}}</span> 
	                   <ul data-path='{{path}}'>
	                       
	                   </ul>
	                </li>
	            </template>
	        </ul>
	    </aside>
	    
	    <section id='content'>
	        <article id='toolbar'>
	             <div class='buttons'>
	                <input type='button' id='goBack' title='Назад'/>
	                <input type='button' id='goUp' title='Вверх'/>
	            </div>
	            
	            <div id='path'>
	                <ul>
	                    <li data-path=''>Корень</li>
	                    <template id='pathItem'>
	                        <li data-path='{{path}}'>{{name}}</li>
	                    </template>
	                </ul>
	            </div>
	            
	            <div class='buttons'>
	                <input type='button' id='newFile' title='Создать файл'/>
	                <input type='button' id='newFolder' title='Создать папку'/>
	                <input type='button' id='openEditor' title='Открыть редактор'/>
	            </div>
	            <div id='spinner'><div class='ring'></div></div>
	        </article>
	        
	        <article id='elements' class='Scrollable'>
	            <ul id='items' data-path=''>
	                <template id='contentItem'>
	                    <li data-path='{{path}}' data-role='{{role}}' data-ext='{{ext}}'>
	                        <span class='itemName' data-ext='{{ext}}'>{{name}}</span>
	                    </li>
	                </template>
	            </ul>
	        </article>
	    
	    
    	    <div id='editor'>
    	        <div id='editor-tabs'>
    	           <ul>
    	               <template id='EditorTab'>
    	                   <li data-path='{{path}}' title='{{path}}' data-ext='{{ext}}'><span>{{name}}</span><input type='button' class='closeTab'/></li>
    	               </template>
    	           </ul>
    	        </div>
    	        
    	        <div id='editor-elements'>
    	            <ul>
    	                <template id='EditorElement'>
    	                    <li data-path='{{path}}'>
    	                        <div class='header'></div>
    	                        <div class='content'>
    	                            <div class='ace'>{{content}}</div>
    	                        </div>
    	                    </li>
    	                </template>
    	            </ul>
    	        </div>
    	    </div>
	    </section>
	    <div id='itemContextMenu' class='context'>
	        <ul>
	            <li class='edit'>Редактировать</li>
	            <li class='rename'>Переименовать</li>
	        </ul>
	        <ul>
	            <li class='copy'>Копировать</li>
	            <li class='cut'>Вырезать</li>
	            <li class='delete'>Удалить</li>
	        </ul>
	        <ul class='folder'>
	            <li class='archivate'>Архивировать</li>
	            <li class='extract-here'>Извлечь сюда</li>
	            <li class='extract-to-folder'>Извлечь в <span></span></li>
	            <li class='extract-to'>Извлечь в ...</li>
	        </ul>
	        <ul>
	            <li class='download'>Скачать</li>
	            <li class='properties'>Свойства</li>
	        </ul>
	    </div>
	    
	    <div id='generalContextMenu' class='context'>
	        <ul>
	            <li class=' list'>
	                <span>Вид</span>
	                <ol>
	                    <li class='view-Signs'>Значки</li>
	                    <li class='view-List'>Список</li>
	                    <li class='view-Table'>Таблица</li>
	                </ol>
	            </li>
	        </ul>
	        <ul>
	            <li class='createFile'>Создать файл</li>
	            <li class='createFolder'>Создать папку</li>
	        </ul>
	        <ul>
	            <li class='paste'>Вставить</li>
	        </ul>
	        <ul>
	            <li class='properties'>Свойства папки</li>
	        </ul>
	    </div>
	    
	    <template id='folderProperties'>
	        <div class='folderProperties properties'>
	            <table>
	                <tbody>
	                    <tr>
	                        <td>Путь к папке</td>
	                        <td><input type='text' readonly value='{{name}}'/></td>
	                    </tr>
	                    <tr>
	                        <td>Размер папки</td>
	                        <td>{{size}}</td>
	                    </tr>
	                    <tr>
	                        <td>Папок:</td>
	                        <td>{{folders}}</td>
	                    </tr>
	                    <tr>
	                        <td>Файлов:</td>
	                        <td>{{files}}</td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	    </template>
	    
	    <template id='fileProperties'>
	        <div class='fileProperties properties'>
	            <table>
	                <tbody>
	                    <tr>
	                        <td>Путь к файлу</td>
	                        <td><input type='text' readonly value='{{path}}'/></td>
	                    </tr>
	                    <tr>
	                        <td>Размер файла</td>
	                        <td>{{size}}</td>
	                    </tr>
	                    <tr>
	                        <td>Последний доступ</td>
	                        <td>{{accessed}}</td>
	                    </tr>
	                    <tr>
	                        <td>Последнее изменение</td>
	                        <td>{{modified}}</td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	    </template>
	</main>	
	
</body>
</html>