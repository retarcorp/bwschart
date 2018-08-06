<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    use Classes\Users\Auth;
    $a = new Auth();
    if($a->getCurrentUser()){
        header("Location: ./");
    }
?>


<!DOCTYPE html>
<html lang="ru-RU">
  <head>
    <meta charset="utf-8">
    <title>Главная страница</title><!--[if IE]>
    <meta http-equiv="X-UA-Compatible" content="IE = edge"><![endif]-->
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="keywords" content="">
    <link rel="stylesheet" type="text/css" href="login.css"><!--[if lt IE 9]>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.2/html5shiv.min.js"></script><![endif]-->
  </head>
  <body class="index-page">
    <div class="flex-container">
        <div class="flex-center">
            <form action="" method="post" class="login">
                
                <fieldset class='creds'>
                    <div class="name">
                        <label for="login">Логин:</label>
                        <input type="text" name="login" id="login"/>
                    </div>
                    
                    <div class="password">
                        <label for="password">Пароль:</label>
                        <input type="password" name="password" id="password"/>
                    </div>
                    
                    <div class="submit_btn">
                        <input type="submit" value="Отправить" />
                    </div>
                    
                    <div class="error_message">
                        
                    </div>
                </fieldset>
                
                <fieldset class='sms'>
                    
                    <p class='status'>На номер <b>375******655</b> была отправлена смс для входа в систему.</p>
                    <div class='sms-code'>
                        <label for=''>Код из смс: </label>
                        <input type='text' name='sms-code' id='sms-code'/>
                    </div>
                    
                    <div class="submit_btn">
                        <input type="submit" value="Войти" id='final' />
                    </div>
                    
                    <div class="error_message">
                        
                    </div>
                    
                </fieldset>
                
            </form>
        </div>
    </div>
    <script src="/Core/js/retarcore.js"></script>
    
    <script src="submit_handler.js"></script>
  </body>
</html>