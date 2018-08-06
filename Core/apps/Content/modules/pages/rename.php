<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\System\CoreUsers;

use_rights(CoreUsers::MODERATOR);

$page = new Page($_POST['id']*1);
$page->name= $_POST['name'];
$page->update();

echo json_encode(["status"=>"OK"]);