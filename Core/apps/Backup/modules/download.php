<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::MODERATOR);
    
    use Core\Classes\Apps\Backup;
    use Core\Classes\System\RSqlCredentials;
    
    $point = Backup::getPoint($_GET['ts']);
    
    if(!$point){
        die();
    }
    
    $zip = new \ZipArchive;
    $ts = date("Y-m-d_H-i-s",strtotime($point['created']));
    $zipName = "$ts.zip";
    touch($zipName);
    $zip->open($zipName, ZipArchive::CREATE);
    $root = $_SERVER['DOCUMENT_ROOT'];
            
    switch($point['type']){
        case Backup::TYPE_BACKUP:
            
            if(is_file($root.$point['files']))
                $zip->addFromString("files.zip",file_get_contents($root.$point['files']));
            if(is_file($root.$point['sql']))
                $zip->addFromString("db.sql",file_get_contents($root.$point['sql']));
            $zip->close();
            break;
            
        case Backup::TYPE_PROJECT:
            if(is_file($root.$point['files'])){
                $zip->addFromString("files.zip",file_get_contents($root.$point['files']));
            }
            if(is_file($root.$point['sql'])){
                $zip->addFromString("db.sql",file_get_contents($root.$point['sql']));
            }
            if(is_file($root.$point['config'])){
                $zip->addFromString("config.json",file_get_contents($root.$point['config']));
            }
            if(is_file($root.$point['installer'])){
                $zip->addFromString("index.php",file_get_contents($root.$point['installer']));
            }
            
            $cred = file_get_contents($root."/Core/Classes/System/RSqlCredentials.php");
            $cred = str_replace(RSqlCredentials::DB_HOSTNAME, "%HOSTNAME%",$cred);
            $cred = str_replace(RSqlCredentials::DB_USERNAME, "%USERNAME%",$cred);
            $cred = str_replace(RSqlCredentials::DB_PASSWORD, "%PASSWORD%",$cred);
            $cred = str_replace(RSqlCredentials::DB_DATABASE, "%DATABASE%",$cred);
            
            $zip->addFromString("RSqlCred.txt",$cred);
            $zip->close();
            break;
    }
    
    header("Content-Type: application/zip");
    header("Content-Disposition: attachment; filename=$zipName");
    header("Content-Length: ".filesize($zipName));
    readfile($zipName);
    unlink($zipName);