<?php
	require "../config";
	use Core\Classes\System\CoreUsers;
	use_rights(CoreUsers::GUEST);
	
	use Core\Classes\Apps\Docs;
	
    $id = $_GET['parent'];
    
    $docs = Docs::getDocsIn($id);
    
    usort($docs, function($a, $b){
       return strcmp($a['title'], $b['title']); 
    });
    
    usort($docs, function($a, $b){
        return - $a['type'] + $b['type'];
    });
    
    
    
    echo json_encode($docs);