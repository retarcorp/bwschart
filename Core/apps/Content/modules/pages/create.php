<?php
require "../../config";
use Core\Classes\Content\Page;
use Core\Classes\System\CoreUsers;
use_rights(CoreUsers::MODERATOR);

$id = $_POST['parent'];
$name = $_POST['name'];
$page = Page::create($name, $id);
echo json_encode($page->overviewArray());