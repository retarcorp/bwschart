<?php
namespace Core\Classes\Content;
use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;
use Core\Classes\Content\Templates\Template;

class Page{
    
    private $id;
    private $order_id;
    public $name;
    public $url_pattern;
    public $head;
    public $body;
    public $title;
    public $metakeys;
    public $metadesc;
    public $template;
    private $parentPage;
    private $includes;
    private $created;
    private $modified;
    private $data;
    
    public function __construct($id, $r=null){
        
        if($r==NULL){
            $sql = new RSql;
            $id*=1;
            $raw = $sql->getArray("SELECT * FROM core_pages WHERE id=$id");
            $r = $raw[0];
        }
        
        $this->id = $r['id'];
        $this->order_id = $r['c_order_id'];
        $this->name = $r['name'];
        $this->url_pattern = $r['url'];
        $this->head = $r['head'];
        $this->body = $r['body'];
        $this->title = $r['title'];
        $this->parentPage = $r['parent'];
        $this->template = $r['template'];
        $this->metakeys = $r['metakeys'];
        $this->metadesc = $r['metadescription'];
        $this->includes = json_decode($r['includes'],true);
        $this->rawIncludes = $r['includes'];
        
    }
    
    public function update(){
        $sql = new RSql;
        $sql->execPrepared("UPDATE core_pages SET name='?', url='?', head='?', body='?', title='?', metakeys='?', metadescription='?', template=?, includes='?', modified=NOW() WHERE id=?",[$this->name, $this->url_pattern, $this->head, $this->body, $this->title, $this->metakeys, $this->metadesc,$this->template, json_encode($this->includes), $this->id]);
    }
    
    public function toArray(){
        return [
            "id"=>$this->id
            ,"name"=>$this->name
            ,"url"=>$this->url_pattern
            ,"head"=>$this->head
            ,"body"=>$this->body
            ,"title"=>$this->title
            ,"parent"=>$this->parentPage
            ,"template"=>$this->template
            ,"metakeys"=>$this->metakeys
            ,"metadescription"=>$this->metadesc
            ,"includes"=>$this->rawIncludes
        ];
    }
    
    public function overviewArray(){
        return [
            "id"=>$this->id
            ,"url"=>$this->url_pattern
            ,"name"=>$this->name
            ,"title"=>$this->title
            ,"parent"=>$this->parentPage
            ,"template"=>$this->template
        ];
    }
    
    
    public function remove(){
        $sql = new RSql;
        $sql->query("DELETE FROM core_pages WHERE id={$this->id}");
    }
    
    public function _id(){return $this->id;}
    public function _oid(){return $this->order_id;}
    public function _parent(){return $this->parentPage;}
    
    public function isChildOf($page){
        
        $id = $this->id;
        function xcheck($pg, $id){

            if($id == $pg->_id()){
                return true;
            }
            
            foreach($pg->childPages() as $p){
                if(xcheck($p, $id)){
                    return true;
                }
            }
            return false;
        }
        return xcheck($page, $id);
    }
    
    public function getParentPage(){
        return new Page($this->parentPage);
    }
    
    public function getSiblings(){
        return self::children($this->parentPage);
    }
    
    public function cloneTo($target){
        $children = $target->childPages();
        $oids = array_map(function($e){
            return $e->_oid();
        },$children);
        $min = 300;
        foreach($oids as $oid){
            if($oid<$min){
                $min = $oid;
            }
        }
        $min-=1;
        
        $this->execClone($min, $target->_id());
    }
    
    public function execClone($oid, $parent){
        
        $sql = new RSql;
        $sql->execPrepared("INSERT INTO core_pages(id, c_order_id, name, url, head, body, title,metakeys, metadescription, includes,parent,is_static,template,created,modified,data) VALUES(?,?,'?','?','?','?','?','?','?','?',?,?,?,'?','?','?')",[
                'DEFAULT'
                ,$oid
                ,$this->name
                ,$this->url_pattern
                ,$this->head
                ,$this->body
                ,$this->title
                ,$this->metakeys
                ,$this->metadescription
                ,json_encode($this->includes)
                ,$parent
                ,0
                ,$this->template
                ,date("Y-m-d H:i:s")
                ,date("Y-m-d H:i:s")
                ,''
            ]);
        if($sql->getLastError()){
            RLogger::error("Page::cloneTo",$sql->getLastError());
        }
    }
    
    public function insertBefore($target){
        $children= $target->getSiblings();
        
        foreach($children as $i=>$c){
            if($c->_id() == $target->_id()){
                $before = ($i>0) ? $children[$i-1] : NULL;
                break;
            }
        }
        if($before){
            $oid = ($target->_oid()+$before->_oid())/2;
        }else{
            $oid = $target->_oid()+1;
        }
        $this->execClone($oid, $target->_parent());
        
    }
    
    public function insertAfter($target){
        $children= $target->getSiblings();
        
        foreach($children as $i=>$c){
            
            if($c->_id() == $target->_id()){
                $after = $children[$i+1];
                break;
            }
        }
        if($after){
            $oid = ($target->_oid()+$after->_oid())/2;
        }else{
            $oid = $target->_oid()-1;
        }
        $this->execClone($oid, $target->_parent());
        
    }
    
    public function childPages(){
        return self::children($this->id);    
    }
    
    
    public function setInclusion($key, $val){
        $this->includes[$key]=$val; 
    }
    
    public function resetTemplate($tpl){
        
        if($this->template!= $tpl->_id()){
            $this->body = $tpl->_body();
            $this->head = $tpl->_head();
            $this->template = $tpl->_id();
        }
        
    }
    
    
    public function getInclusion($key){
        return $this->includes[$key] ? $this->includes[$key] : "";
    }
    
    
    public static function children($id){
        $sql = new RSql;
        $id*=1;
        $raw = $sql->getArray("SELECT * FROM core_pages WHERE parent=$id ORDER BY c_order_id DESC");
        $res=[];
        foreach($raw as $r){
            $res[] = new Page($r['id'],$r);
        }
        return $res;
    }
    
    public static function create($name, $parent){
        $sql = new RSql;
        $parent*=1;
        
        $raw = $sql->getArray("SELECT c_order_id FROM core_pages WHERE parent=$parent ORDER BY c_order_id ASC LIMIT 1");
        $raw = $raw[0];
        if(!$raw){
            $oid = 300;
        }else{
            $oid = $raw['c_order_id']*1-1;
        }
        
        $sql->execPrepared("INSERT INTO core_pages(id,c_order_id, name,created,includes,parent) VALUES (DEFAULT, $oid, '?',NOW(),'{}', $parent)",[$name]);
        $r = $sql->getArray("SELECT * FROM  core_pages WHERE parent=$parent ORDER BY id DESC LIMIT 1");
        return new Page($r[0]['id'],$r[0]);
    }
    
    
    
    
}