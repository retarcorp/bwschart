<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\System\CoreUsers;

use_rights(CoreUsers::MODERATOR);

$page = new Page($_GET['id']*1);
$page->remove();
unset($page);

echo json_encode(["status"=>"OK"]);