<?php
	require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
	require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
	
?>
<!doctype html>
<html>
	<head>
		<meta charset='utf-8'/>
		<title> Справка системы | RetarCore 1.20</title>
	
		<link rel='stylesheet' href='/Core/css/main.css'/>
		<link rel='stylesheet' href='css/main.css'/>
		
		<script src='/Core/js/retarcore.js'></script>
		<script src='/Core/js/System.js'></script>
		<script src='js/controller.js'> </script>
	</head>
	
	<body>
		<?php include_view("/Core/views/menu.php");?>
		<main>
    		<aside class='items Scrollable'>
    		    <div class='contents'>
    			<ul class='articles' data-parent='0'>
    			    <template id='Item'>
    			        <li class='{{type}}' data-id='{{id}}' data-type='{{type}}' data-parent='{{parent}}' data-active='0'>
            				<div class='clickable'>
            					<h4 title='{{title}}'> {{title}}</h4>
            				</div>
            				
            				<div class='contents'>
            				    <ul data-parent='{{id}}'>
            				
                				</ul>
                				<div class='buttons'>
                				    <input type='button' class='addFolder' data-parent='{{id}}'/>
                            		<input type='button' class='addFile' data-parent='{{id}}'/>
                				</div>
            				</div>
            				
            			</li>
    			    </template>
    				
    			</ul>
    			<div class='buttons'>
    			    <input type='button' class='addFolder' data-parent='0'/>
            		<input type='button' class='addFile' data-parent='0'/>
    			</div>
    			</div>
    		</aside>
    		
    		<section id='doc'>
    		    <article id='content'>
    		        <h2 id='title'></h2>
    		        <div id='container'>
    		            
    		        </div>
    		    </article>
    		    <form id='editor'>
    		        <div class='toolbar'>
    		            <!--<input type='button' class='button' id='insertCode' value='Вставить код'/>-->
    		            <input type='button' class='button' id='save' value='Сохранить'/>
    		        </div>
    		        <div class='editor'>
    		            <div id='ckeditor'></div>
    		        </div>
    		    </form>
    		    <div class='popup' id='codePopup'>
    		        
    		        <div class='wrap'>
    		            <div class='title'>
    		                <h3>Вставка кода</h3>
    		                <select id='codeLang'>
    		                    <option value='html'>HTML</option>
    		                    <option value='css'>CSS</option>
    		                    <option value='javascript'>JavaScript</option>
    		                    <option value='php'>PHP</option>
    		                    <option value='json'>JSON</option>
    		                    <option value='sql'>SQL</option>
    		                </select>
    		            </div>
    		            <div class='editWrap'><textarea id='CodeEditor'></textarea></div>
    		            <p class='buttons'>
        		            <input type='button' class='button' id='applyCode' value='Вставить'/>
    		                <input type='button' class='button' id='cancelCode' value='Отменить'/>
    		                
    		            </p>
    		        </div>
    		    </div>
    		</section>
		</main>
	</body>
</html>