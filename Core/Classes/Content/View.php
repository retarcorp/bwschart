<?php
namespace Core\Classes\Content;
use Core\Classes\System\RSql;
use Core\Classes\Content\Teleport;

class View{
    
    const TABLE_NAME  = "core_pages";
    public $page;
    private $html, $title, $metakeys, $metadesc;
    
    
    public function __construct($url){
        
        if(gettype($url)=="string"){
            $sql = new RSql;
            $raw = $sql->getArray("SELECT * FROM core_pages");
            
            foreach($raw as $page){
                
                $match = $this->matchPattern($url, $page['url']);
                
                if ($match){
                    
                    $this->real_url = $url;
                    $this->page = new Page($page['id']*1);
                    $this->title = $this->page->title;
                    $this->metadesc = $this->page->metadesc;
                    $this->metakeys = $this->page->metakeys;
                    break;
                }
            }
            if($this->page == NULL){
                #$this->error404();
            }
        }
        if(gettype($url)=="integer"){
            $this->page = new Page($url);
            $this->title = $this->page->title;
            $this->metadesc = $this->page->metadesc;
            $this->metakeys = $this->page->metakeys;
            $this->real_url = $this->page->url_pattern;
        }
    }

    
    private $dataTransfer = [];
    public function getDataTransfer(){
        return $this->dataTransfer;
    }
    
    private function matchPattern($url, $pattern){
        $reg = "#\{([a-zA-Z0-9\_]+)\}#";
        preg_match_all($reg, $pattern, $matches);
        $pattern = str_replace($matches[0],"([a-zA-Z0-9\%\-\_\+]+)",$pattern);
        $match =  preg_match("#^".$pattern."$#", $url, $items);
        
        if($match){
            $this->dataTransfer=[];
            $fields = $matches[1];
            $items;
            foreach($fields as $i=>$f){
                $this->dataTransfer[$f]=$items[$i+1];
            }
        }
        return $match;
    }
    
    public function build(){
        
        if($this->page == NULL){
            return $this;
        }
        
        $b_page = Teleport::proceed($this->page->getInclusion("page_before"),$this);
        $b_head = Teleport::proceed($this->page->getInclusion("head_before"),$this);
        $head   = Teleport::proceed($this->page->head,$this);
        $a_head = Teleport::proceed($this->page->getInclusion("head_after"),$this);
        $b_body = Teleport::proceed($this->page->getInclusion("body_before"),$this);
        $body   = Teleport::proceed($this->page->body,$this);
        $a_body = Teleport::proceed($this->page->getInclusion("body_after"),$this);
        $a_page = Teleport::proceed($this->page->getInclusion("page_after"),$this);
        
      $html = "$b_page".
        "<!doctype html>".
            "<html>".
                "<head>".
                    "<title>{$this->title}</title>"
                    ."<meta name='keywords' content='{$this->metakeys}'/>"
                    ."<meta name='description' content='{$this->metadesc}'/>";
        $html.= $b_head;
        $html.= $head;
        
        foreach(array_keys($this->meta) as $meta){
            $html.=$this->getMetaHTML($meta);
        }
        
        foreach(array_keys($this->stylesheets) as $stylesheet){
            $html.=$this->getStylesheetHTML($stylesheet);
        }
        
        foreach(array_keys($this->scripts) as $script){
            $html.=$this->getScriptHTML($script);
        }
        $html.= $a_head;
        $html.= "</head>";
        
        $html.="<body>";
        $html.=$b_body;
        $html.=$body;
        $html.=$a_body;
        $html.="</body>";
        
        $html.="</html>$b_page";
        $this->html = $html;

        return $this;
    }
    
    
    public function debug(){
        if($this->page==NULL){
            return $this;
        }
        
        $head = Teleport::clear($this->page->head);
        $body = $this->page->body;
        $html="
        <!doctype html>
        <html>
            <head>
                $head
            </head>
            
            <body>
                $body
            </body>
        </html>
        ";
        $this->html = $html;
        return $this;
    }
    
    public function content(){
        return $this->html;
    }
    
    
    public function redirect($location){
        header("Location: $location");
    }
    
    public function error404(){
        $this->html = "";
        http_response_code(404);
        require_once $_SERVER['DOCUMENT_ROOT']."/Core/errors/404.php";
    }
    
    public function error403(){
        $this->html = "";
        http_response_code(403);
        require_once $_SERVER['DOCUMENT_ROOT']."/Core/errors/403.php";
    }
    
     public function error401(){
        $this->html = "";
        http_response_code(401);
        require_once $_SERVER['DOCUMENT_ROOT']."/Core/errors/401.php";
    }
    
    public function error500(){
        $this->html = "";
        http_response_code(500);
        require_once $_SERVER['DOCUMENT_ROOT']."/Core/errors/500.php";
    }
    
    public function error503(){
        $this->html = "";
        http_response_code(503);
        require_once $_SERVER['DOCUMENT_ROOT']."/Core/errors/500.php";
    }
    
    private $scripts=[];
    private $stylesheets=[];
    private $meta = [];
    
    public function appendScript($src){
        $this->scripts[$src]=1;    
    }
    
    private function getScriptHTML($src){
        return "<script src='$src'></script>";
    }
    
    public function appendStylesheet($href){
        $this->stylesheets[$href]=1;
    }
    
    public function getStylesheetHTML($href){
        return "<link rel='stylesheet' href='$href'/>";
    }
    
    public function appendMeta($name, $value){
        $this->meta[$name]=$value;
    }
    
    public function getMetaHTML($name){
        return "<meta name='$name' content='{$this->meta[$name]}'/>";
    }
    
    public function setTitle($title){
        $this->title = $title;
    }
    
    public function setMetadesc($desc){
        $this->metadesc= $desc;
    }
    
    public function setMetakeys($keys){
        $this->metakeys = $keys;
    }
    
}