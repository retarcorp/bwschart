<?php
    require "config";
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Auth.php";
?>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<meta charset="utf-8">
    	<title> SQL-консоль </title>
    
    	<link rel="stylesheet" href="css/main.css">
    	<link rel="stylesheet" href="/Core/css/main.css"/>
    		
    	<script type="text/javascript" src="/Core/js/retarcore.js"></script>
    	<script type="text/javascript" src="/Core/js/System.js"></script>
    	<script src="js/controller.js"> </script>
    </head>
    
    <body>
        <?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/menu.php";?>
        <main>
            <section id='queries'>
                <article id='terminal'>
                    <div class='form'>
                        <label>
                            <textarea id='query' placeholder='Your query here'></textarea>
                        </label>
                        <label>
                            <input type='button' id='sendQuery' value='Отправить'/>
                        </label>    
                    </div>
                </article>
                
                <article id='list'>
                    <ul class='Scrollable'>
                        <template id='queryTpl'>
                            <li title='{{date}}'>{{query}}</li>
                        </template>
                    </ul>
                </article>
            </section>
            <section id='result'>
                <div class='status'><div id='status'></div></div>
                <table id='result_table'>
                    <thead>
                        
                    </thead>
                    
                    <tbody id='queryResult'>
                        
                    </tbody>
                    
                </table>
            </section>
        </main>
    </body>
</html>