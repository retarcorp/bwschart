<?php
    require_once "Global.php";
    require_once "Auth.php";
?>
<!doctype html>
<html>
    <head>
        <meta charset='utf-8'/>
        <title>RCore 1.20</title>
        
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/css/index.css'/>
        
        
        <script src='/Core/js/retarcore.js'></script>
        <script src='/Core/js/index.js'></script>
    </head>
    
    <body>
        
    <?php include_view("/Core/views/menu.php"); ?>      
        
        <main>
            <div class='content'>
                <div class='widgets'>
                    <div class='widget' id='hello'>
                        <h3 class='title'>Приветствие системы</h3>
                        <div class='content'>
                            <p>Добро пожаловать в CMF RCore! Версия Вашей системы - 1.20.1 (выпуск 26.05.2017). Приятной разработки!</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class='logo'>
                <p>v1.20</p>
            </div>
        </main>
        
        
    </body>
</html>