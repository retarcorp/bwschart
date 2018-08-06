<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    
    use Classes\Users\Auth;
    Auth::logout();
    header("Location: ".Auth::AUTH_FORM_URL);