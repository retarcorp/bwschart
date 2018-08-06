<?php
namespace Core\Classes\Apps;
use Core\Classes\System\RCatalog;
use Core\Classes\System\RLogger;

class Imager{
    
    static $catalog = "cata_imager";
    static $loc = "/img/Imager/";
    
    public static function getFolders(){
        $catalog = new RCatalog(self::$catalog);
        return $catalog->getItemsAt(0);
    }
    
    public static function createFolder($name){
        $catalog = new RCatalog(self::$catalog);
        $id = $catalog->addItem(array($name));
        return $id;
    }
    
    public static function renameFolder($id, $name){
        $catalog = new RCatalog(self::$catalog);
        $catalog->editValuesOf($id, 0, array("title"=>$name));
        return;
    }
    
    public static function removeFolder($id){
        $catalog = new RCatalog(self::$catalog);
        $catalog->removeItemAt($id, 0);
    }
    
    public static function addImageTo($id, $nm, $location){
        
        $content = file_get_contents($location);
        $mime= mime_content_type($location);
        switch($mime){
            case "image/png":
            case "image/jpeg":
            case "image/gif":
            case "image/bmp":
                break;
            default:
                RLogger::safetyWarn("Imager","Попытка загрузить в хранилище изображений файл с MIME-типом $mime!");
                return FALSE;
        }
        $root = $_SERVER['DOCUMENT_ROOT'];
        $folder = $root.self::$loc;
        $ext = explode(".",$nm);
        $ext = $ext[count($ext)-1];
        do{
            
            $name = md5($nm.(mt_rand(0,100000000)/mt_rand(0,100000000))).".".$ext;
        }while(is_file($folder.$name));
        
        if(!is_dir($folder)){
            mkdir($folder,0777,true);
        }
        #echo $folder.$name;
        copy($location, $folder.$name);
        
        $catalog = new RCatalog(self::$catalog);
        $catalog->addItem(array(self::$loc.$name,$nm,"",filesize($location)),$id,0);
        
        $id = $catalog->getAllByQuery(1, " url='".self::$loc.$name."' ");
        $id = $id[0]['id'];
        
        return $id;
    }
    
    public static function getImagesAt($id){
        $catalog = new RCatalog(self::$catalog);
        return $catalog->getChildrenOf($id*1,0);
    }
    
    public static function getProperties($id){
        $catalog = new RCatalog(self::$catalog);
        return $catalog->getItemAt($id,1);
    }
    
    public static function deleteImage($id){
        $catalog = new RCatalog(self::$catalog);
        $img = $catalog->getItemAt($id,1);
        unlink($_SERVER['DOCUMENT_ROOT'].$img['url']);
        return $catalog->removeItemAt($id,1);
    }
}