<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

if(isset($_GET['id'])){
    $tpl = new Template($_GET['id']*1);
    echo json_encode($tpl->toArray());
    die();
}

if(isset($_POST['id'])){
    $tpl = new Template($_POST['id']*1);
    $tpl->edit($_POST['title'],$_POST['head'],$_POST['body']);
    echo json_encode(["status"=>"OK"]);
    die();
}