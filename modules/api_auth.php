<?php
require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
use Classes\Users\Auth;
use Classes\Users\User;

$auth = new Auth();
if(!$auth->getCurrentUser()){
    
    die(json_encode(["status"=>"ERROR","message"=>"Authorization required"]));
}