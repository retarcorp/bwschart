<?php
require "../../config";
use Core\Classes\Content\Templates\Theme;
use Core\Classes\Content\Templates\Template;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::ADMIN);


Template::create($_POST['parent']*1,$_POST['name']);
echo json_encode(["status"=>"OK"]);