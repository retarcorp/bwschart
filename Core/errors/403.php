<!doctype html>
<html>
    <head>
        <meta charset='utf-8'/>
        <title>Ошибка 403 - доступ запрещен.</title>
        <link rel='stylesheet' href='/Core/css/main.css'/>
        <link rel='stylesheet' href='/Core/errors/main.css'/>
    </head>

    <body>
        <div class='wrapper'>
            <div class='hgroup'>
                <h1>403</h1>
                <h2>Доступ запрещен</h2>    
            </div>
            
            <div class='description'>
                <p>Доступ к документу <i><?=$_SERVER['REQUEST_URI'];?></i> запрещен. Возможно, Вы ошиблись при вводе адреса. Если Вы уверены, что по данному адресу должен находиться доступный документ, обратитесь, пожалуйста, к администратору сайта.</p>
            </div>
        </div>
    </body>
</html>