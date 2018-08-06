<?php
namespace Core\Classes\Apps;
use Core\Classes\System\RLogger;
use Core\Classes\System\RSql;

class Docs{
    
    const TYPE_FOLDER = 1;
    const TYPE_DOC = 0;
    
    private static $table = "core_docs";
    public static function install(){
        $sql = new RSql;
        $sql->query("DROP TABLE IF EXISTS ".self::$table);
        $sql->query("CREATE TABLE `".self::$table."` ( `id` int(11) NOT NULL AUTO_INCREMENT, `parent` int(11) DEFAULT NULL, `type` int(11) DEFAULT 0, `title` varchar(1000) DEFAULT '', `content` mediumtext, `shorthand` text, `data` text, PRIMARY KEY (`id`) ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8");
        if($sql->getLastError()){
            
            return false;
        }
        return true;
        
    }
    
    public static function getDocsIn($id){
        $sql = new RSql;
        $id *=1;
        $res = $sql->getAssocArray("SELECT * FROM ".self::$table." WHERE parent=$id");
        return $res;
    }
    
    public static function createDocIn($id, $title){
        $sql = new RSql;
        $sql->query("INSERT INTO ".self::$table." (id, type, parent, title) VALUES (DEFAULT, ".self::TYPE_DOC.", $id, '$title') ");
        if($sql->getLastError()){
            RLogger::error("Docs","Не удалось создать справочную статью! Ошибка уровня SQL: ".$sql->getLastError());
        }
    }
    
    public static function createFolderIn($id, $title){
        $sql = new RSql;
        $sql->query("INSERT INTO ".self::$table." (id, type, parent, title) VALUES (DEFAULT, ".self::TYPE_FOLDER.", $id, '$title') ");
        if($sql->getLastError()){
            RLogger::error("Docs","Не удалось создать папку справки! Ошибка уровня SQL: ".$sql->getLastError());
        }
    }
    
    public static function rename($id, $title){
        $sql = new RSql;
        $sql->query("UPDATE ".self::$table." SET title='$title' WHERE id=$id ");
        if($sql->getLastError()){
            RLogger::error("Docs","Не удалось переименовать элемент справки! Ошибка уровня SQL: ".$sql->getLastError());
        }
    }
    
    public static function remove($id){
        $sql = new RSql;
        $sql->query("DELETE FROM ".self::$table." WHERE id=$id ");
        if($sql->getLastError()){
            RLogger::error("Docs","Не удалось удалить элемент справки! Ошибка уровня SQL: ".$sql->getLastError());
        }
    }
    
    public static function getContent($id){
    
        $sql = new RSql;
        $res = $sql->getArray("SELECT content FROM ".self::$table." WHERE id=$id ");
        if($sql->getLastError()){
            RLogger::error("Docs","Не удалось получить содержимое справочного документа! Ошибка уровня SQL: ".$sql->getLastError());
            return null;
        }
        return $res[0]['content'];
        
    }
    
    public static function putContent($id, $content){
        $sql = new RSql;
        $sql->execPrepared("UPDATE ".self::$table." SET content='?' WHERE id=?",[$content, $id]);
        if($sql->getLastError()){
            RLogger::error("Docs","Не удалось записать содержимое справочного документа! Ошибка уровня SQL: ".$sql->getLastError());
        }
    }
    
    
}