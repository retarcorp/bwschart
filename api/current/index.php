<?php

    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    header("Content-Type: application/json");
    
    use Classes\Users\Auth;
    use Classes\Users\User;
    use Classes\Utils\JSONResponse as json;
    
    $auth = new Auth;
    $current = $auth->getCurrentUser();
    $method = $_SERVER['REQUEST_METHOD'];
    
    switch($method){
        case "GET":
            if( is_null($current) ){
                return json::error("Пользователь не авторизован");
            }else{
                return json::ok("Пользователь авторизован, все в порядке");
            }
    }
    