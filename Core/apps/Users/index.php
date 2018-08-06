<?php
	require_once $_SERVER["DOCUMENT_ROOT"]."/Core/Global.php";
	require_once $_SERVER["DOCUMENT_ROOT"]."/Core/Auth.php";
	$APP_TITLE = "Пользователи";
	
?>


<!doctype html>
<html>
	<head>
	
		<meta charset='utf-8'/>
		<title>Пользователи | Retar Core v1.20</title>
		
		<script src='/Core/js/retarcore.js'></script>
		<script src='/Core/js/System.js'></script>
		<script src='js/controller.js'> </script>
	
		
		<link rel='stylesheet' href='/Core/css/main.css'/>
		<link rel='stylesheet' href='css/main.css'/>
		
	</head>
	
	<body>
	    <?php include_view("/Core/views/menu.php");?>
		<main>
	
    		<div class='wrapper'>
    			<section class='users Scrollable'>
    				<ul id='users'>
    				    <template id='User'>
    				        <li data-id='{{id}}' data-role='{{role}}' class='{{c_role}}'> 
                    			<h4>{{login}}</h4>
                    			<h6>{{role_title}}</h6>
                    			<p>{{info}} </p>
                    		</li>
    				    </template>
    				</ul>
    				<input type='button' id='add' value='Добавить'/>
    			</section>
    			
    			<section class='actions Scrollable'>
    				
    				<form id='addUser'>
    				    <h2>Создание пользователя</h2>
    				    <div class='col-2'>
        				    <fieldset>
        				         <label>
            				        <span>Логин пользователя</span>
            				        <input type='text' id='add-login' />
            				    </label>
            				    
            				    <label>
            				        <span>Пароль пользователя</span>
            				        <input type='password' id='add-password' />
            				    </label>
        				    </fieldset>
        				    
        				    <fieldset>
        				        <label>
        				            <span>Права пользователя</span>
        				            <select id='add-role'>
        				                <option value='1'>Гость</option>
        				                <option value='2'>Модератор</option>
        				                <option value='3'>Администратор</option>
        				            </select>
        				        </label>
        				   
            				    <label>
            				        <span>Описание пользователя</span>
            				        <textarea id='add-description'></textarea>
            				    </label>
        				    </fieldset>
    				    </div>
    				    
    				    <input type='submit' class='button' value='Создать пользователя'/>
    				</form>
    							
    				<form class='editor' id='editor'>
    					<label>
    						<span>Логин пользователя</span>
    						<input type='text' id='user-login'/>
    					</label>
    					
    					<label>
    						<span>Старый пароль (необходим для изменения своего или паролей других пользователей таких же прав, для изменения пароля пользователей с более слабыми правами вводить не нужно)</span>
    						<input type='password' value='' id='user-old-password'/>
    					</label>
    					
    					<label>
    						<span>Новый пароль</span>
    						<input type='text' value='' id='user-new-password'/>
    					</label> 
    					
    					<input type='hidden' id='user-id' value='0'/>
    					<label>
    						<span>Роль пользователя</span>
    						<select id='user-role'>
    							<option value='3'>Администратор</option>
    							<option value='2'>Модератор</option>
    							<option value='1'>Гость</option>
    						</select>
    					</label>
    					
    					<label>
    						<span>Информация о пользователе</span>
    						<textarea id='user-info'></textarea>
    					</label>
    					
    					<input type='button' value='Сохранить' id='user-save'/>
    				</form>
    			</section>
    		</div>
    	</main>
	
	</body>

</html>