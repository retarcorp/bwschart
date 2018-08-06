<?php
    require "config";
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
?>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> Система отчетов </title>
    
    	<link rel="stylesheet" href="css/main.css">
    	<link rel="stylesheet" href="/Core/css/main.css"/>
    		
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	<script src="js/controller.js"> </script>
    </head>
    
    <body class='Scrollable'>
        <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>
        <main >
            <section id='content'>
                <div id='toolbar'>
                    <label>
                       
                        <input type='button' value='Фильтровать по субъектам' id='logApps'/>
                    </label>
                    <label>
                        <span>Уровень лога: </span>
                        <select id='logLevel'>
                            <option value="all"> Все </option>
                            <option value="warn"> Предупреждения </option>
                            <option value="safety_warn"> Проблемы безопасности </option>
                            <option value="error"> Ошибки системы </option>
                        </select>
                    </label>
                </div>
                
                <table>
                    <thead>
                        <td class='status'></td>
                        <td class='date'>Дата</td>
                        <td class='user'>Пользователь</td>
                        <td class='reason'>Субъект</td>
                        <td class='content'>Отчет</td>
                    </thead>
                    
                    <tbody id='list'>
                        <template id='log'>
                            <tr data-id='{{id}}' class='s-{{status}}'>
                                <td class='status'><i class='status-{{status}}'></i></td>
                                <td class='date'>{{date}}</td>
                                <td class='user'>{{user}}</td>
                                <td class='reason'>{{app}}</td>
                                <td class='content'><xmp>{{content}}</xmp></td>
                            </tr>
                        </template>
                    </tbody>
                </table>
                <div id='spinner'><i></i></div>
            </section>
        </main>
    </body>
</html>