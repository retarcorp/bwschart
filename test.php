<?php

    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    
    date_default_timezone_set('GMT');
    
    foreach($_GET as $k => $arg){
        print_r("<p>$k - ".date('d.m.Y H:i:s', $arg)."</p>");
    }
    
    
    echo "Current time is ".date("d.m.Y H:i:s", time());