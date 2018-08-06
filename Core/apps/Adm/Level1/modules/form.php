<?php

require "config";
use Core\Classes\System\CoreUsers;
use Core\Classes\System\RCatalog;
use Core\Classes\System\RImages;

use_rights(CoreUsers::MODERATOR);

$catalog = new RCatalog($_Config['catalog']);

$id = $_GET['id'];
$level = $_GET['level'];
$editable = $_Config['levels'][$level]['editable'];

$item = $catalog->getItemAt($id, $level);
$data= [];

foreach($editable as $v){
    $skin = $catalog->getSkinFor($v, $level);
    $data[]=[
        "name"=>$v
        ,"value"=>$item[$v]
        ,"title"=>$skin['title']
        ,"type"=>$skin['type']
    ];
    
}

foreach($data as $i=>$field){
    echo getField($field);
}


function getField($field){
    
        
    switch($field['type']){
        case "TEXTLINE":
        case "LINK":
        case "VARCHAR(100)":
        case "VARCHAR":
        case "CHAR":
        case "VARCHAR(50)":
            $input="<input type='text' value='{$field['value']}' id='field-{$field['name']}'/>";
            $type="string";
            break;
        
        case "INT":
        case "NUMBER":
        case "TINYINT":
        case "SMALLINT":
        case "BINT":
        case "MEDIUMINT":
        case "BIGINT":
            $input="<input type='number' step='1' value='{$field['value']}' id='field-{$field['name']}'/>";
            $type="int";
            break;
            
        case "BOOL":
        case "CBOOL":
            $input_pre="<input type='checkbox' ".($field['value']*1?"checked='checked'":"")." id='field-{$field['name']}'/>";
            $type="bool";
            break;
            
        case "FLOAT":
        case "CFLOAT":
        case "DOUBLE":
        case "DECIMAL":
            $input="<input type='number' step='0.001' value='{$field['value']}' id='field-{$field['name']}'/>";
            $type="float";
            break;
        
        case "VARCHAR(1000)":
        case "VARCHAR(3000)":
        case "VARCHAR(10000)":
        case "TINYTEXT":
        case "TEXT":
        case "PTEXT":
            $input="<xmp data-id='field-{$field['name']}'>{$field['value']}</xmp><textarea id='field-{$field['name']}'></textarea>";
            $type="text";
            break;
            
        case "FTEXT":
        case "CTEXT":
        case "MEDIUMTEXT":
            $input="<xmp data-id='field-{$field['name']}'>{$field['value']}</xmp><div class='ckeditor' id='field-{$field['name']}'></div>";
            $type="ctext";
            break;
            
        case "IMAGE":
            $input="<input type='button' value='{$field['value']}' id='field-{$field['name']}'/>";
            $type="image";
            break;
            
        default:
            $input="<input type='text' id='field-{$field['name']}' value='{$field['value']}'/>";
            $type="unknown";
    }
    
    $str = "<label data-name='{$field['name']}' data-type='$type'>
        $input_pre
        <span>{$field['title']}</span>
        $input
    </label>";
    return $str;
}