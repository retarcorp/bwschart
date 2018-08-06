<?php
    
# Module needed to be included for all RCore PAGES in order to not to let unauthorized users view its contents.

require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";
use Core\Classes\System\CoreUsers;

if($_Rights == CoreUsers::UNAUTHORIZED){
    header("Location: /Core/login.php?redirect=".$_SERVER['REQUEST_URI']);
}