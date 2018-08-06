<?php
namespace Core\Classes\Apps;
use Core\Classes\System\RSqlCredentials;
use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;
use Core\Classes\Apps\FileManager;


class Backup{
    
    private static $config = "/Core/apps/Backup/Points/points.json";
    private static $folder = "/Core/apps/Backup/Points/";
    private static $htaccessContents = "Order Allow, Deny\nDeny from all";
    
    const TYPE_BACKUP = "backup";
    const TYPE_PROJECT = "project";
    
    public static function sqlDump($dest){
        
        $dest = $_SERVER['DOCUMENT_ROOT'].$dest;
        touch($dest);
        
        $hostname = RSqlCredentials::DB_HOSTNAME;
        $username = RSqlCredentials::DB_USERNAME;
        $password = RSqlCredentials::DB_PASSWORD;
        $db = RSqlCredentials::DB_DATABASE;
        
        $cmd= "mysqldump -u $username -p$password -h $hostname $db > '$dest'";
        $out = "";
        exec($cmd, $out);
        if(count($out)>1){
            var_dump($out);
        }
        
    }
    
    public static function sqlPhpDump($dest){
        
        $sql = new RSql();
        $raw = $sql->getArray("SHOW TABLES");
        $tables = [];
        foreach($raw as $r){
            $tables[$r[0]]=[];
        }
        
        $dump = "";
        $RsqlResource = $sql->resource();
        foreach($tables as $t=>$v){
            $create = $sql->getArray("SHOW CREATE TABLE $t");
            $tables[$t]['create'] = $create[0][1].";";
            $tables[$t]['drop']="DROP TABLE IF EXISTS $t;";
            
            $tables[$t]['data']=$sql->getAssocArray("SELECT * FROM $t");
            $tables[$t]['insert']="";
            $insert = "";
            if(count($tables[$t]['data'])){
                $insert = "INSERT INTO $t VALUES ";
                foreach($tables[$t]['data'] as $i=>$v){
                    foreach($v as $k=>$vv){
                        $v[$k]="'".mysqli_real_escape_string( $RsqlResource, $vv)."'";
                    }
                    $tables[$t]['data'][$i]=$insert." (".implode(",",$v).");";
                }
                $insert=implode("\n",$tables[$t]['data']);
                $tables[$t]['insert']=$insert."";
            }
            $tables[$t]=$tables[$t]['drop']."\n".$tables[$t]['create']."\n".$tables[$t]['insert'];
            $dump.=$tables[$t]."\n\n";
        }
        file_put_contents($_SERVER['DOCUMENT_ROOT'].$dest, $dump);
    }
    
    public static function extractSqlDump($path){
        system("mysql -h {RSqlCredentials::DB_HOSTNAME} -u {RSqlCredentials::DB_USERNAME} -p{RSqlCredentials::DB_PASSWORD} {RSqlCredentials::DB_DATABASE} < $path");
    }
    
    public static function extractSqlPHPDump($path){

        $dump = file_get_contents($path);
        $sql = new RSql; 
        $queries = explode(";",$dump);
        foreach($queries as $q){
            $sql->query($q);
            if($sql->getLastError()){
                RLogger::error("Backup","Ошибка извлечения SQL-дампа встроенным PHP-методом: ".$sql->getLastError());
                return FALSE;
            }
        }
    }
    
    public static function createBackup($title, $comment, $include_files=false, $include_mysql=false){
        $ts = date("Y-m-d H:i:s");
        $folder = date("Y-m-d_H-i-s");
        $root = $_SERVER['DOCUMENT_ROOT'];
        if(!$title){
            $title="Точка восстановления от $ts";
        }
        
        $data = [];
        $data['title']=$title;
        $data['created']=$ts;
        $data['files']=self::$folder.$folder."/files.zip";
        $data['sql']=self::$folder.$folder."/db.sql";
        $data['comment']=addslashes($comment);
        $data['type']='backup';
        $data['size']=0;
        $data['includes'] = ($include_files ? "1" : "0").($include_mysql ? "1" : "0");
        
        $json = file_get_contents($root.self::$config);
        $json = json_decode($json,true);
        
        mkdir($root.self::$folder.$folder,0777,true);
        
        $size = 0;
        if($include_files){
            FileManager::archivate("./",$data['files'],$list);
            $size += filesize($root.$data['files']);
            
        }
        
        if($include_mysql){
            Backup::sqlDump($data['sql']);
            if(filesize($root.$data['sql'])==0){
                RLogger::warn("Backup::createBackup","Не удалось корректно создать бэкап БД!");
                Backup::sqlPhpDump($data['sql']);
            }
            $size += filesize($root.$data['sql']);
        }
        
        $data['size']=$size;
        array_unshift($json, $data);
        file_put_contents($root.self::$config,json_encode($json,JSON_UNESCAPED_UNICODE));
        
        # Preventing downloading backups directly
        file_put_contents($root.self::$folder.$folder."/.htaccess",self::$htaccessContents);
    }
    
    
    public static function createProject($title, $comment, $include_files=false, $include_mysql=false){
        $ts = date("Y-m-d H:i:s");
        $root = $_SERVER['DOCUMENT_ROOT'];
        $folder = date("Y-m-d_H-i-s");
        if(!$title){
            $title="Проект развертывания от $ts";
        }
        
        $data = [];
        $data['title']=$title;
        $data['created']=$ts;
        $data['files']=self::$folder.$folder."/files.zip";
        $data['sql']=self::$folder.$folder."/db.sql";
        $data['comment']=addslashes($comment);
        $data['type']='project';
        $data['size']=0;
        $data['includes'] = ($include_files ? "1" : "0").($include_mysql ? "1" : "0");
        
        $json = file_get_contents($root.self::$config);
        $json = json_decode($json,true);
        
        mkdir($root.self::$folder.$folder,0777,true);
        
        $size = 0;
        if($include_files){
            FileManager::archivate("./",$data['files'],$list);
            $size += filesize($root.$data['files']);
            
        }
        
        if($include_mysql){
            Backup::sqlDump($data['sql']);
            if(filesize($root.$data['sql'])==0){
                RLogger::warn("Backup","Не удалось корректно создать бэкап БД!");
                Backup::sqlPhpDump($data['sql']);
            }
            $size += filesize($root.$data['sql']);
        }
        
        $config = ["host"=>RSqlCredentials::DB_HOSTNAME, "username"=>RSqlCredentials::DB_USERNAME, "password"=>RSqlCredentials::DB_PASSWORD, "db"=>RSqlCredentials::DB_DATABASE];
        $config = json_encode($config, JSON_UNESCAPED_UNICODE);
        $config = preg_replace("/\,/",",\n\t",$config);
        $config = preg_replace("/\{/","{\n\t",$config);
        $config = preg_replace("/\}/","\n}",$config);
        
      
        $data['config']=self::$folder.$folder."/config.json";
        file_put_contents($root.self::$folder.$folder."/config.json",$config);
        $size+=filesize($root.self::$folder.$folder."/config.json");
        $data['installer']=self::$folder.$folder."/index.txt";
        $installer = file_get_contents($root.self::$folder."installer.txt");
        
        file_put_contents($root.self::$folder.$folder."/index.txt",$installer);
        $size+=filesize($root.self::$folder.$folder."/index.txt");
        $data['size']=$size;
        array_unshift($json, $data);
        file_put_contents($root.self::$config,json_encode($json,JSON_UNESCAPED_UNICODE));
        
        file_put_contents($root.self::$folder.$folder."/.htaccess",self::$htaccessContents);
    }
    
    
    public static function deletePoint($ts){
        $d = $ts;
        $ts = date("Y-m-d_H-i-s",strtotime($ts));
        $json = json_decode(file_get_contents($_SERVER['DOCUMENT_ROOT'].self::$config),true);

        foreach($json as $i=>$v){
            if($v['created']==$d){
                unset($json[$i]);
            }
        }
        
        #if(is_dir(self::$folder.$ts)){
            FileManager::deleteFolder(self::$folder.$ts);
        #}
        
        $json = json_encode($json, JSON_UNESCAPED_UNICODE);
        file_put_contents($_SERVER['DOCUMENT_ROOT'].self::$config, $json);
    }
    
    public static function getPoint($ts){
        
        $json = json_decode(file_get_contents($_SERVER['DOCUMENT_ROOT'].self::$config),true);
        $r = null;
        foreach($json as $i=>$v){
            if($ts==$v['created']){
                $r = $v;
            }
        }
        return $r;
    }
    
    public static function contains($mask){
        
        return [
            "files"=>$mask[0]*1==true
            ,"sql"=>$mask[1]*1==true
            ];
    }
    
    public static function extractBackup($ts){
        $point = self::getPoint($ts);
        if($point==null){
            return FALSE;
        }
        if($point['type']==Backup::TYPE_BACKUP){
    
            $contains = Backup::contains($point['includes']);
            if($contains['files']){
                # Extracting files
                Backup::extractFiles($point['files']);
                
            }
            if($contains['sql']){
                # Extracting database
                Backup::extractDB($point['sql']);
            }
            
            $ts = date("Y-m-d_H-i-s",strtotime($ts));
            Backup::deletePoint($ts);
            #FileManager::deleteFolder(self::$folder.$ts);
        }
    
    }
    
    public static function extractFiles($path){
        $root = $_SERVER['DOCUMENT_ROOT'];
        $path = $root.$path;
        $zip = new \ZipArchive();
        $zip->open($path);
        $zip->extractTo($root."/");
        $zip->close();
    }
    
    public static function extractDB($path){
        $root = $_SERVER['DOCUMENT_ROOT'];
        $path = $root.$path;
        
        #self::extractSqlPHPDump($path);
        self::extractSqlDump($path);
    }
}