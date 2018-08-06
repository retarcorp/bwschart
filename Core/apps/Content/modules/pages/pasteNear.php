<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\System\CoreUsers;

use_rights(CoreUsers::MODERATOR);

$subject = new Page($_POST['id']);
$action = $_POST['action'];

if(isset($_POST['before'])){
    $before = new Page($_POST['before']*1);
    $parent = $before->getParentPage();
    
    switch($action){
        case "copy":{
            $subject->insertBefore($before);
            break;
        }
        case "cut":{
            $exp = $parent->isChildOf($subject);
            if($exp){
                die(json_encode(["status"=>"ERROR","message"=>"Нельзя переместить страницу в дочернюю для нее!"]));
            }
            $subject->insertBefore($before);
            $subject->remove();
            break;
        }
    }
}

if(isset($_POST['after'])){
    $after = new Page($_POST['after']*1);
    $parent = $after->getParentPage();
    
    switch($action){
        case "copy":{
            $subject->insertAfter($after);
            break;
        }
        case "cut":{
            $exp = $parent->isChildOf($subject);
            if($exp){
                die(json_encode(["status"=>"ERROR","message"=>"Нельзя переместить страницу в дочернюю для нее!"]));
            }
            $subject->insertAfter($after);
            $subject->remove();
            break;
        }
    }
}
echo json_encode(['status'=>"OK"]);