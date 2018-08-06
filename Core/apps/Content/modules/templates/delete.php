<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::MODERATOR);


$tpl = new Template($_GET['id']);
$tpl->remove();
echo json_encode(["status"=>"OK"]);