<?php
namespace Core\Classes\Content;
use Core\Classes\Content\View;

class RContent{
    
    public static function route(string $url){
        $view = new View($url);
        return $view->build()->content();
    }
}