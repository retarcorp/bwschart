<!doctype html>
<html>
    <head>
        <meta charset='utf-8'/>
        <title>Ошибка 503 - Сервер временно недоступен</title>
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/errors/main.css'/>
    </head>

    <body>
        <div class='wrapper'>
            <div class='hgroup'>
                <h1>503</h1>
                <h2>Сервер временно недоступен</h2>    
            </div>
            
            <div class='description'>
                <p>К сожалению, серверу не хватило ресурсов для отображения документа <i><?=$_SERVER['REQUEST_URI'];?></i>. Попробуйте вернуться позже или написать о проблеме администратору сайта.</p>
            </div>
        </div>
    </body>
</html>