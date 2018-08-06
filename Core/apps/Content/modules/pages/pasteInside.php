<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\System\CoreUsers;

use_rights(CoreUsers::MODERATOR);

$subject = new Page($_POST['id']);
$to = new Page($_POST['to']);
$action = $_POST['action'];




switch($action){
    case "copy":{
        $subject->cloneTo($to);
        break;
    }
    case "cut":{
        $exp = $subject->isChildOf($to);
        if($exp){
            die(json_encode(["status"=>"ERROR","message"=>"Нельзя переместить страницу в дочернюю для нее!"]));
        }
        $subject->cloneTo($to);
        $subject->remove();
        break;
    }
}
echo json_encode(['status'=>"OK"]);