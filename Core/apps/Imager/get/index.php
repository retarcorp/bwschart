<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/Core/Global.php";

    use Core\Classes\System\CoreUsers;
    use Core\Classes\Apps\Imager;
    use Core\Classes\System\RImages;
    
    RImages::output($_GET['id']);