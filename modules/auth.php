<?php
require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
use Classes\Users\Auth;
use Classes\Users\User;

$auth = new Auth();
if(!$auth->getCurrentUser()){
    header("Location: ".Auth::AUTH_FORM_URL);
    die();
}