<?php
	require_once "../config";
	use Core\Classes\Content\Page;
	
	$id = $_POST[id];
	$body = $_POST[gen];
	
	$title = addslashes($_POST['title']);
	$keywords = addslashes($_POST[keywords]);
	$description = addslashes($_POST['description']);
	
	$page = new Page($id);
	
    $page->metakeys = $keywords;
    $page->title = $title;
    $page->description = $description;
    $page->body = $body;
    
    $page->update();