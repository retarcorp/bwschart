<?php

namespace Core\Classes\System;
use Core\Classes\System\RCatalog;
use Core\Classes\System\RLogger;

class RImages{
    
    private static  $catalog = "cata_imager";
    public static function output($id){
        $catalog = new RCatalog(self::$catalog);
        $image = $catalog->getItemAt($id,1);
        if(!$image['id']){
            $image['id']=0;
            $image['url']="/Core/apps/Imager/img/empty.jpg";
        }
        
        $image['ext'] = explode(".",$image['url']);
        $image['ext'] = $image['ext'][count($image['ext'])-1];
        
        $mime = "image/";
        switch(strtolower($image['ext'])){
            case "jpg":
            case "jpeg":
                $mime.="jpeg";
                break;
            case "png":
                $mime.="png";
                break;
            case "gif":
                $mime.="gif";
                break;
            case "bmp":
                $mime.="bmp";
                break;
            default:
                $mime="text/plain";
                RLogger::error("RImages","Не удалось отдать картинку {$image['id']} по URL {$image['url']}");
                die("An error occured while opening an image");
                return;
                break;
        }
        $loc = $_SERVER['DOCUMENT_ROOT'].$image['url'];
        
        header("Content-Type: $mime");
        header("Content-Length: ".filesize($loc));
        die(file_get_contents($loc));
    }
    
    public static function getImages($folder){
        $catalog = new RCatalog("cata_imager");
        return $catalog->getChildrenOf($folder);
    }
    
    public static function getURL($id){
        $catalog = new RCatalog(self::$catalog);
        $image = $catalog->getItemAt($id,1);
        return $image['url'];
    }
    
    public static function getImage($id, $attrs=[], $w=NULL, $h=NULL){
        $catalog = new RCatalog(self::$catalog);
        $image = $catalog->getItemAt($id,1);
        if($image==NULL){
            $src="/Core/apps/Imager/img/empty.jpg";
        }else{
            $src= $image['url'];
        }
        
        $a = [];
        foreach($attrs as $attr=>$val){
            $a[]="$attr='$val'";
        }
        $attr=implode(" ",$a);
        
        return "<img src='$src' $attr/>";
    }
    
}