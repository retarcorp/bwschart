<!doctype html>
<html>
    <head>
        <meta charset='utf-8'/>
        <title>Ошибка 500 - Неполадки на сервере</title>
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/errors/main.css'/>
    </head>

    <body>
        <div class='wrapper'>
            <div class='hgroup'>
                <h1>500</h1>
                <h2>Внутренняя ошибка сервера</h2>    
            </div>
            
            <div class='description'>
                <p>К сожалению, при отображении документа <i><?=$_SERVER['REQUEST_URI'];?></i> возникли проблемы на сервере. Попробуйте вернуться позже или написать о проблеме администратору сайта.</p>
            </div>
        </div>
    </body>
</html>