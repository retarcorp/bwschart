<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);


Theme::create($_POST['name']);
echo json_encode(["status"=>"OK"]);