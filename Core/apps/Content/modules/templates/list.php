<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::GUEST);

$theme = new Theme($_GET['id']);
$tpls = $theme->getTemplates();
$res = [];
foreach($tpls as $tpl){
    $res[]=$tpl->overviewArray();
}
echo json_encode($res);
