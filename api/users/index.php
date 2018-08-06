<?php

require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
header("Content-Type: application/json");

use Classes\Users\Auth;
use Classes\Users\User;
use Classes\Utils\JSONResponse;

if($_SERVER['REQUEST_METHOD'] == "POST"){
    # Login
    $login = $_POST['login'];
    $password = $_POST['password'];

    $auth = new Auth();
    $res = $auth->auth($login, $password);
    if($res){
        $arr = $res->getArray();
        $r = [];
        $r['redirect'] = Auth::REDIRECT_URL;
        $r['phone']=$arr['phone'];
        
        JSONResponse::ok($r);
    }else{
        JSONResponse::error("Логин и/или пароль неверны или истек их срок действия.");
    }
}

if($_SERVER['REQUEST_METHOD'] == "GET"){
    # Get data of current user
    
    $auth = new Auth();
    $current = $auth->getCurrentUser();
    
    JSONResponse::ok($current->getArray());
}