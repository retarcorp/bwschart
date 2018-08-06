<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    
    use Classes\Users\Auth;
    (new Auth)->logout();
    header("Location: ".Auth::AUTH_FORM_URL);