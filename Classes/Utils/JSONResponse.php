<?php

namespace Classes\Utils;

class JSONResponse{
    public static function ok($data){
        header("Content-Type: application/json; Charset=UTF-8");
        die(json_encode(["status"=>"OK","data"=>$data],JSON_UNESCAPED_UNICODE ));
    }
    
    public static function error($data){
        header("Content-Type: application/json; Charset=UTF-8");
        die(json_encode(["status"=>"ERROR","message"=>$data],JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
    }
}