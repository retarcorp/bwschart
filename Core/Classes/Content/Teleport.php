<?php
namespace Core\Classes\Content;
use Core\Classes\System\RSql;
use Core\Classes\Content\Portal;

class Teleport{
    
    
    public static function fromDataTransfer($text,$transfer){
        
        $reg = '#\{\{\$([a-zA-Z0-9\_]*)\}\}#';
        preg_match_all($reg, $text, $items);
        $replaces = $items[0];
        $names = $items[1];
        
        foreach($names as $i=>$name){
            if(isset($transfer[$name])){
                $replace = "#".addcslashes($replaces[$i],'{$}')."#";
                $text= preg_replace($replace,$transfer[$name],$text);
            }
        }
        return $text;
    }
    
    public static function getPortal($p, $view){
        $reg = "#^\[\[([^\[\]]+)\]\]$#";
        preg_match($reg,$p,$content);
        $raw = $content[1];
        if(!$raw){
            return NULL;
        }
        $raw = preg_replace("#\t#"," ",$raw);
        $raw = preg_replace("#\s\s+#"," ",$raw);
        $elements = explode(" ",$raw);
        $name = $elements[0];
        
        
        $res = preg_match("#^[a-zA-Z\-\_]+$#",$name);
        if(!$res){
            #echo "Invalid name!";
            return NULL;
        }
        
        $args= array_slice($elements, 1);
        $argvals = [];
        foreach($args as $i=>$a){
            
            $reg = '#^([a-zA-Z0-9\_\-]+)\=[\'\"]([^\'"\[\]]+)[\"\']$#';
            $res = preg_match($reg, $a,$m);
            if(count($m)!=3){
                # Not correct arguments;
                return NULL;
            }
            $arg = $m[1];
            $val = $m[2];
            $argvals[$arg]=$val;
        }
       
        
        try{
            $portal = new Portal($view, $name, $argvals);
            return $portal;
        }catch(\Exception $e){
            #echo "Portal doesn't exist!";
            return NULL;
        }
        
    }

    public static function fromPortals($text, $view){
        $reg = "#\[\[[^\[\]]+\]\]#";
        preg_match_all($reg,$text,$matches);
        $portals = $matches[0];
        
        foreach($portals as $i=>$p){
            $portal = self::getPortal($p, $view);
            if($portal!=NULL){
                $val = $portal->teleport();
                $text = preg_replace("#".addcslashes($p,"+[]{}$")."#",$val,$text);
            }
        }
        
        return $text;
    }
    
    public static function proceed($text, $view){
        
        # Data Transfer;
        $text = self::fromDataTransfer($text, $view->getDataTransfer());

        # Portals
        $text = self::fromPortals($text,$view);
        return $text;
    }
    
    public static function clear($text){
        $reg = "#^\[\[([^\[\]]+)\]\]$#";
        return preg_replace($reg,"",$text);
    }
}