<!doctype html>
<html>
    <head>
        <meta charset='utf-8'/>
        <title>Ошибка 401 - требуется авторизация.</title>
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/errors/main.css'/>
    </head>

    <body>
        <div class='wrapper'>
            <div class='hgroup'>
                <h1>401</h1>
                <h2>Требуется авторизация</h2>    
            </div>
            
            <div class='description'>
                <p>По адресу <i><?=$_SERVER['REQUEST_URI'];?></i> находится документ, доступ к которому защищен. Для получения доступа к документу обратитесь, пожалуйста, к администратору сайта.</p>
            </div>
        </div>
    </body>
</html>