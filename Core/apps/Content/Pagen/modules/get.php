<?php
    require "../config";
    use Core\Classes\Content\View;
    
    
    $id = $_GET['page'];
    
    $view = new View($id*1);
    echo $view->debug()->content();
    
?>

