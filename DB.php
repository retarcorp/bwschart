<?php

    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
    use Classes\Instruments\Instrument;
    use Core\Classes\System\RSql;
    use Core\Classes\System\RLogger;
    
    header("Content-Type: text/plain");

    $instruments = ['6A','6B','6C','6E','6J','6N','6S','CL','GC'];
    $sql = new RSql;
    
    foreach($instruments as $instrument){

        $instrumentName = "\\Classes\\Instruments\\_".$instrument;
        $obj = new $instrumentName;
        $obj->clearWeekTicks();
        print_r($sql->getLastError());
    }