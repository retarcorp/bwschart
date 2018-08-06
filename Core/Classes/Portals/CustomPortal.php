<?php

namespace Core\Classes\Portals;
use Core\Classes\Content\Teleport;

class CustomPortal{
    public function content($args,$view){
        $view->appendScript("/js/abs.js");
        $view->appendStylesheet("/style.css");
        $view->appendMeta("viewport","initial-scale=1, user-scalable=no");
        
        $view->setTitle("Главная страница");
        $view->setMetakeys("ключевые, слова, приложения");
        $view->setMetadesc("Ключевые слова приложения и описание страницы из контроллера");
        
        
        $str = "<hr/>Hello, user #{$args['id']}! You have successfully teleported from a portal!<hr/>";
        $str.=Teleport::proceed('[[custom_portal text="1231243"]]',$view);
        return $str;
    }
    
    public function custom($args, $view){
        return print_r($args);
    }
}