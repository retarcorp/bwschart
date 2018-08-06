<?php
    require "config";
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
?>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> Менеджер приложений </title>
    
    	<link rel="stylesheet" href="css/main.css">
    	<link rel="stylesheet" href="/Core/css/main.css"/>
    		
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	<script src="js/controller.js"> </script>
    </head>
    
    <body>
        <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>
        <main>
            <div id='tabs'>
                <nav>
                    <ul>
                        <li><a href='#shop'>Магазин приложений</a></li>
                        <!--<li><a href='#installed'>Установленные</a></li>-->
                        <!--<li><a href='#install'>Установить свое приложение</a></li>-->
                    </ul>
                </nav>
            </div>
            
            
            <section id='container'>
                
                <section id='shop' class='Scrollable'>
                    <?php require "shop-section.php"; ?>
                    
                </section>
                
                <section id='installed' class='Scrollable'>
                    2
                </section>
                 
                <section id='install' class='Scrollable'>
                    3
                </section>
            </section>
        </main>
    </body>
</html>