<?php


spl_autoload_register(function ($class) {
    $root = $_SERVER['DOCUMENT_ROOT'];
    
    $class= str_replace("\\","/",$class);
    $path = "$root/$class.php";
    if(is_file($path)){
        require_once($path);    
    }else{
        throw new Exception("Unable to load class $class! File /$class.php not found.");
    }
});

function include_view($module){
    include $_SERVER['DOCUMENT_ROOT'].$module;
}

function use_rights($rights, $callback=NULL){
    global $_Rights;
    if($rights>$_Rights){
        
        if(is_callable($callback)){
            $callback();
        }else{
            die("Недостаточно прав для совершения операции.");
        }
    }
}

# Используется для определения и сохранения текущего пользователя системы и его прав для использования в дальнейшем приложениями.
use Core\Classes\System\CoreUsers; 
$ssid = $_COOKIE['ssid'];
$user = CoreUsers::getCurrent();

if($user===NULL){
    $_Rights = CoreUsers::UNAUTHORIZED;
    $_User=NULL;
}else{
    $_User = $user;
    $_Rights = $user['role'];
}