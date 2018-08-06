<?php
namespace Core\Classes\Content\Templates;
use Core\Classes\System\RSql;
use Core\Classes\System\RCatalog;
use Core\Classes\Content\Templates\Theme;

class Template{
    
    private $catalog;
    
    private $id;
    private $title;
    private $body;
    private $head;
    
    public function __construct($id){
        $this->catalog = new RCatalog("cata_content");
        $raw = $this->catalog->getItemAt($id,1);
        $this->id = $raw['id'];
        $this->title = $raw['title'];
        $this->body = $raw['body'];
        $this->head = $raw['head'];
    }
    
    public function toArray(){
        return ["id"=>$this->id, "title"=>$this->title, "body"=>$this->body, "head"=>$this->head];
    }
    
    public function overviewArray(){
        return  ["id"=>$this->id, "title"=>$this->title];
    }
    
    public function rename($name){
        $this->catalog->editValuesOf($this->id, 1, array("title"=>$name));    
    }
    
    public function remove(){
        $this->catalog->removeItemAt($this->id,1);
    }
    
    public function edit($title, $head, $body){
        $this->catalog->editValuesOf($this->id, 1, array("title"=>addslashes($title), "head"=>addslashes($head), "body"=>addslashes($body)));
    }
    
    public function _id(){
        return $this->id;
    }
    
    public function _head(){
        return $this->head;
    }
    
    public function _body(){
        return $this->body;
    }
    
    public static function create($parent, $name){
        $catalog = new RCatalog("cata_content");
        $catalog->addItem(array("","",$name,""),$parent,0);
    }
}