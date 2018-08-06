<?php
require "../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::GUEST);

$themes = Theme::getAll();
$res = [];
foreach($themes as $theme){
    $r = $theme->toArray();
    $r['templates']=[];
    foreach($theme->getTemplates() as $tpl){
        $r['templates'][] = $tpl->overviewArray();
    }
    $res[] = $r;
}
echo json_encode($res);