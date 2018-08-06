<?php
namespace Core\Classes\Content;
use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;
use Core\Classes\Content\Portal;
use Core\Classes\Content\View;

class Portal{
    
    private $args;
    private $name;
    private $method;
    private $view;
    
    private static $table= "cata_portals_items";
    
    public function __construct($view, $name, $args){
        $sql = new RSql;
        $raw = $sql->getArray("SELECT * FROM ".self::$table." WHERE portal='$name'");
       
        
        if(!count($raw)){
            RLogger::error("Pagen Portals","Попытка доступа к несуществующему порталу '$name'.");
            throw new \Exception("No such portal!");
        }
        $this->args = $args;
        $this->name = $name;
        $this->view = $view;
        $this->method = $raw[0]['method'];
    }
    
    public function teleport(){
        
        $m = $this->method;
        $m = explode("$",$m);
        $class= $m[0];
        $method = $m[1];
        
        try{
            if(class_exists($class)){
                $instance = new $class();
                if(method_exists($instance, $method)){
                    return $instance->$method($this->args, $this->view);
                }else{
                    RLogger::error("Pagen Portals","Не найден метод-портал  $class::$method() в классе.");
                    return NULL;
                }
            }
        }catch(\Exception $e){
            
            RLogger::error("Pagen Portals","Не найден класс-телепорт $class.");
            return NULL;
        }
        
    }

}