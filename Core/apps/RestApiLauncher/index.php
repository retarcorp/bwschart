<?php

    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
?>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> REST API Launcher </title>
    
    	<link rel="stylesheet" href="css/main.css">
    	<link rel="stylesheet" href="/Core/css/main.css"/>
    		
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	<script src="js/controller.js"> </script>
    </head>
    
    <body>
        <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>
        <main>
            <h1>Привет! А вот и я, чудесное новое приложение, ничего не умеющее!</h1>
        </main>
    </body>
</html>