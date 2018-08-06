<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::MODERATOR);


$tpl = new Template($_POST['id']);
$tpl->rename($_POST['name']);
echo json_encode(["status"=>"OK"]);