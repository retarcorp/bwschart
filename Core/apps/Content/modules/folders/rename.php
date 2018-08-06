<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::MODERATOR);

$theme = new Theme($_POST['id']);
$theme->rename($_POST['name']);

echo json_encode(["status"=>"OK"]);