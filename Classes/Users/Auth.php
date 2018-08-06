<?php

namespace Classes\Users;

use Core\Classes\System\RCatalog;
use Classes\Users\User;

class Auth{
    
    const CATALOG_NAME = "bwschart_users";
    const COOKIE_NAME = "bws_ssid";
    const AUTH_FORM_URL = "/login.php";
    const REDIRECT_URL = "/";
    
    const AUTH_NONE = 0;
    const AUTH_SMS_PENDING = 1;
    const AUTH_OK = 2;
    
    public function __construct(){
        $this->catalog = new RCatalog(self::CATALOG_NAME);
        
    }
    
    public function auth($login, $password){
        if(!trim($login)){
            return false;
        }
        if(!trim($password)){
            return false;
        }
        
        $r = $this->catalog->getAllByQuery(0,"login='$login' AND password='$password' AND expire >= NOW() ");
        if(count($r)){
            $user = new User($r[0]['id']*1);
            $user->authByLogin();
            return $user;
        }
        return false;
    }
    
    public function getIPfor($login, $password){
        $data = $this->catalog->getAllByQuery(0,"login='$login' AND password='$password' AND expire >= NOW()");
        return $data[0]['last_ip'];
    }
    
    public function authBySms($sms){
        $ssid = $_COOKIE[self::COOKIE_NAME];
        $r = $this->catalog->getAllByQuery(0,"data='$ssid' AND auth_status=".self::AUTH_SMS_PENDING);
        if(!count($r)){
            return false;
            
        }
        if($r[0]['sms_code'] == $sms){
            $user = new User($r[0]['id']*1);
            $user->finalAuth();
            return true;
        }
        return false;
    }
    
    public static function getHash(){
        return md5(rand(0,999999)*time());
    }
    
    public static function getSms(){
        return rand(10000,99999);
    }
    
    public function getCurrentUser(){
        $ssid = $_COOKIE[self::COOKIE_NAME];
        
        # Костыль для отмены механизма обязательной авторизации по СМС
        # return new User(2);
        
        if(!trim($ssid)){
            return null;
        }
        $r = $this->catalog->getAllByQuery(0,"data='$ssid' AND auth_status=".self::AUTH_OK);
        if(!count($r)){
            return null;
        }
        return new User($r[0]['id']*1);
    }
    
    public function logout(){
        $user = $this->getCurrentUser();
        setcookie(self::COOKIE_NAME,"",time()+1,"/");
        unset($_COOKIE[self::COOKIE_NAME]);
        $ip = $_SERVER['REMOTE_ADDR'];
        $this->catalog->editValuesOf($user->id*1, 0, ["last_ip" => $ip]);
    }
    
}