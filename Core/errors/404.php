<!doctype html>
<html>
    <head>
        <meta charset='utf-8'/>
        <title>Ошибка 404 - файл не найден</title>
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/errors/main.css'/>
    </head>

    <body>
        <div class='wrapper'>
            <div class='hgroup'>
                <h1>404</h1>
                <h2>Файл не найден</h2>    
            </div>
            
            <div class='description'>
                <p>По адресу <i><?=$_SERVER['REQUEST_URI'];?></i> нет документа, доступного для просмотра. Проверьте правильность написания адреса в адресной строке браузера. Если Вы уверены, что здесь должно что-то быть, свяжитесь с администратором сайта.</p>
            </div>
        </div>
    </body>
</html>