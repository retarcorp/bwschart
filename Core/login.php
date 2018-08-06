<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    use Core\Classes\System\CoreUsers; 
    
    if(isset($_POST['login'])){
        
        $success = CoreUsers::login($_POST['login'],$_POST['password']);
        if(!$success){
            echo json_encode(["status"=>"ERROR","message"=>"Неверно введено имя пользователя или пароль!"]);
        }else{
            echo json_encode(['status'=>"OK"]);
        }
        die();
    }
    
    if($_Rights>CoreUsers::UNAUTHORIZED){
        header("Location: /Core/");
    }
?>

<!doctype html>
<html>
    <head>
        <title>RCore 1.20</title>
        <meta charset='utf-8' />
        
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/css/auth.css' />
        
        <script src='/Core/js/retarcore.js'></script>
        <script src='/Core/js/System.js'></script>
        <script src='/Core/js/auth.js'></script>
        <?php
            if($_GET['redirect']){
                echo "<script>Auth.redirect='{$_GET['redirect']}'</script>";
            }
        ?>
    </head>
    
    <body>
        <?php include_view("/Core/views/templates.php");?>
        <main>
            <div class='wrapper'>
                <div class='form'>
                    <div class='logo'>
                        <p class='version'>1.20</p>
                        <h3>Вход в систему</h3>
                    </div>
                    <form id='login'>
                        <label>
                            <span>Имя пользователя</span>
                            <input type='text' value='' id='username'/>
                        </label>
                        
                        <label>
                            <span>Пароль</span>
                            <input type='password' value='' id='password'/>
                        </label>
                        
                        <label class='no-margin'>
                            <input type='submit' value='Войти' id='go'/>
                        </label>
                        
                        <p><a href='#'>Забыли пароль?</a></p>
                    </form>
                </div>
            </div>
        </main>
        
    </body>
</html>