<?php

require "config";

use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

use Core\Classes\Apps\Backup;
$point = Backup::getPoint($_GET['ts']);

#echo $_GET['ts'];

if(!$point){
   die("Точка восстановления была удалена или задана некорректно!");
}

if($point['type']==Backup::TYPE_BACKUP){
    
    Backup::extractBackup($_GET['ts']);
    echo "<p>Откат завершен. Перенаправление...</p>
    <script>setTimeout(function(){window.history.back();},3000)</script>";
}else{
    die("Точку разворачивания проекта нельзя использовать для восстановления! Чтобы развернуть проект, запустите процесс вручную.");
}