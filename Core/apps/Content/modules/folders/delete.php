<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);

$theme = new Theme($_GET['id']);
$theme->remove();

echo json_encode(["status"=>"OK"]);