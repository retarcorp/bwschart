<?php

require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
header("Content-Type: application/json");

use Classes\Users\Auth;
use Classes\Users\User;
use Classes\Utils\JSONResponse;

if($_SERVER['REQUEST_METHOD'] == "POST"){
    # Login by sms
    $sms = $_POST['sms'];
    
    
    $auth = new Auth();
    $res = $auth->authBySms($sms);
    
    if($res){
       
        $r = [];
        $r['redirect'] = Auth::REDIRECT_URL;
        JSONResponse::ok($r);
    }else{
        JSONResponse::error("Неверный СМС-код или истекла сессия!");
    }
}
