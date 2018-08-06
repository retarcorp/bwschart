<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;


switch(strtolower($_SERVER['REQUEST_METHOD'])){
    case "get":{
        use_rights(CoreUsers::GUEST);
        
        $page = new Page($_GET['id']);
        die(json_encode($page->toArray()));
        break;
    }
    
    case "post":{
        use_rights(CoreUsers::MODERATOR);
        
        $page = new Page($_POST['id']);
        
        $page->url_pattern = $_POST['url'];
        $page->title = $_POST['title'];
        $page->metakeys = $_POST['metakeys'];
        $page->metadesc = $_POST['metadesc'];
        
        $page->resetTemplate(new Template($_POST['template']*1));
        
        $page->setInclusion("body_before",$_POST['bodyBefore']);
        $page->setInclusion("body_after",$_POST['bodyAfter']);
        $page->setInclusion("head_after",$_POST['headAfter']);
        $page->setInclusion("head_before",$_POST['headBefore']);
        $page->setInclusion("page_after",$_POST['pageAfter']);
        $page->setInclusion("page_before",$_POST['pageBefore']);
        
        $page->update();
        echo json_encode(["status"=>"OK"]);
        
        
        
        break;
    }
}