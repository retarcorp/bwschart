<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::GUEST);

$data = Theme::getAll();
$res = [];
foreach($data as $thm){
    $res[]=$thm->toArray();
}
echo json_encode($res);