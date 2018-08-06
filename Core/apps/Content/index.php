<?php
    require "config";
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
?>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> Содержимое сайта </title>
    
    	<link rel="stylesheet" href="css/main.css">
    	<link rel="stylesheet" href="/Core/css/main.css"/>
    		
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	<script src="js/controller.js"> </script>
    	<script src='js/templates.js'></script>
    	<script src='js/pages.js'></script>
    </head>
    
    <body>
        <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>
        <main>
            <header>
                <nav>
                    <ul>
                        <li><a href='#pages'>Редактор страниц</a></li>
                        <li><a href='#templates'>Редактор шаблонов</a></li>
                    </ul>
                </nav>
            </header>
            
            <section id='content'>
                <article id='templates'>
                    <div class='templates Scrollable'>
                        
                        <ul>
                            <template id='templateFolder'>
                                <li data-id='{{id}}'>
                                    <span>{{title}}</span>
                                    <div class='list'>
                                        <ol class='templates'>
                                            
                                        </ol>
                                        <p class='buttons'>
                                            <input type='button' value='+' class='createTemplate' data-id='{{id}}'/>
                                        </p>
                                    </div>
                                    
                                </li>
                            </template>
                            
                            <template id='templateItem'>
                                <li data-id='{{id}}'>
                                    <span>{{title}}</span>
                                </li>
                            </template>
                        </ul>
                        <p class='buttons'>
                            <input type='button' value='Создать тему' id='createFolder' />
                        </p>
                    </div>
                    
                    <div class='form Scrollable'>
                        <form id='editForm'>
                            <fieldset class='head'>
                                <div class='title'>
                                    <label>
                                        <input type='text' id='title' value='{{title}}' />
                                    </label>
                                    <input type='button' value='HEAD' id='toHead'/>
                                    <input type='button' value='BODY' id='toBody'/>
                                </div>
                                <div class='buttons'>
                                    <input type='button' id='save' value='Сохранить'/>
                                </div>
                            </fieldset>
                            
                            <fieldset class='content'>
                                <div class='head'>
                                    
                                    <textarea id='head'></textarea>
                                </div>
                                
                                <div class='body'>
                                    <textarea id='body'></textarea>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </article>
                
                <article id='pageSection'>
                    <div class='pages Scrollable active' id='pages' >
                        <ul data-id='0'>
                            <template id='Page'>
                                <li data-id='{{id}}'>
                                    <span>{{name}}</span>
                                    <div>
                                        <ul data-id='{{id}}'></ul>
                                        <p class='buttons'>
                                            <input type='button' class='addPage' value='+' data-parent='{{id}}'/>
                                        </p>
                                    </div>
                                </li>
                            </template>
                        </ul>
                        <div>
                            <p>
                                <input type='button' class='addPage' value='+' data-parent='0'/>
                            </p>
                        </div>
                        
                    </div>
                    
                    <div class='form Scrollable'>
                        <form id='editPage'>
                            <fieldset class='head'>
                                <h3 id='PageName'></h3>
                                <input type='button' id='openPageLink' value='Открыть страницу'>
                                <input type='button' id='openPagen' value='Визуальный редактор'/>
                                <input type='button' id='savePage' value='Опубликовать'/>
                            </fieldset>
                            
                            <fieldset class='title'>
                                <label>
                                    <span>Заголовок страницы</span>
                                    <input type='text' id='pageTitle' />
                                </label>
                                <label>
                                    <span>Шаблон URL</span>
                                    <input type='text' id='url_pattern'/>
                                </label>
                            </fieldset>
                            <fieldset class='theme'>
                                <label>
                                    <span>Тема </span>
                                    <select id='theme'>
                                        <template id="ThemeOption">
                                            <option value='{{id}}'>{{title}}</option>
                                        </template>
                                    </select>
                                </label>
                                
                                <label>
                                    <span>Шаблон страницы</span>
                                    <select id='template'>
                                        <template id="TemplateOption">
                                            <option value='{{id}}'>{{title}}</option>
                                        </template>
                                    </select>
                                </label>
                            </fieldset>
                            
                            <fieldset class='metadata'>
                                <label>
                                    <span>Метаключи страницы</span>
                                    <textarea id='metakeys'></textarea>
                                </label>
                                <label>
                                    <span>Метаописание страницы</span>
                                    <textarea id='metadescription'></textarea>
                                </label>
                            </fieldset>
                            
                            <fieldset class='includes'>
                                <div class='label'>
                                    <span>Включение body_before</span>
                                    <textarea id='include_body_before'></textarea>
                                </div>
                                <div class='label'>
                                    <span>Включение body_after</span>
                                    <textarea id='include_body_after'></textarea>
                                </div>
                                <div class='label'>
                                    <span>Включение head_before</span>
                                    <textarea id='include_head_before'></textarea>
                                </div>
                                <div class='label'>
                                    <span>Включение head_after</span>
                                    <textarea id='include_head_after'></textarea>
                                </div>
                                <div class='label'>
                                    <span>Включение page_before</span>
                                    <textarea id='include_page_before'></textarea>
                                </div>
                                <div class='label'>
                                    <span>Включение page_after</span>
                                    <textarea id='include_page_after'></textarea>
                                </div>
                            </fieldset>
                            
                            
                        </form>
                    </div>
                </article>
                
            </section>
        </main>
    </body>
</html>