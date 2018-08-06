<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::GUEST);

$parent = $_GET['id']*1;
$res = [];
foreach(Page::children($parent) as $p){
    $res[]=$p->overviewArray();
}
echo json_encode($res);