<?php
namespace Core\Classes\Content\Templates;
use Core\Classes\System\RSql;
use Core\Classes\System\RCatalog;

class Theme{
    
    private $id;
    private $title;
    
    public function __construct($id){
        $sql = new RSql;
        $raw = $sql->getArray("SELECT * FROM cata_content_folders WHERE id=$id");
        $this->id = $id;
        $this->title = $raw[0]['title'];
    }
    
    public function toArray(){
        return ["id"=>$this->id, "title"=>$this->title];
    }
    
    public static function getAll(){
        $sql = new RSql;
        $raw = $sql->getArray("SELECT id FROM cata_content_folders");
        $res = [];
        foreach($raw as $l){
            $res[]=new self($l['id']);
        }
        return $res;
    }
    
    public function rename($name){
        $catalog = new RCatalog("cata_content");
        $catalog->editValuesOf($this->id, 0, array("title"=>$name));
    }
    
    public function remove(){
        $catalog = new RCatalog("cata_content");
        $catalog->removeItemAt($this->id, 0);
    }
    
    public function getTemplates(){
        $catalog = new RCatalog("cata_content");
        $items= $catalog->getChildrenOf($this->id, 0);
        $res = [];
        foreach($items as $l){
            $res[] = new Template($l['id']);
        }
        return $res;
    }
    
    public static function create($name){
        $catalog = new RCatalog("cata_content");
        $catalog->addItem(array($name,''));
    }
    
    
    
}