<?php

namespace Classes\Users;

use Core\Classes\System\RCatalog;
use Classes\Users\Auth;
use Classes\Utils\Sms;
use Classes\Markets\Market;
use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;

class User{
    
    private $catalog;
    public $id, $login,$password, $expire, $demo_login,$demo_password, $phone, $ssid, $last_ip;
    private $arr;
    
    public function __construct($id){
        $this->catalog = new RCatalog(Auth::CATALOG_NAME);
        $item = $this->catalog->getItemAt($id, 0);
        
        $this->id = $id;
        $this->login = $item['login'];
        $this->password = $item['password'];
        $this->expire = $item['expire'];
        $this->demo_login = $item['demo_login'];
        $this->demo_password = $item['demo_password'];
        $this->phone = $item['phone'];
        $this->ssid = $item['data'];
        $this->last_ip = $item['last_ip'];
        
        $this->arr = $item;
    }
    
    public function authByLogin(){
        $hash = Auth::getHash();
        setcookie(Auth::COOKIE_NAME, $hash, time()+86400*30, "/");
        $_COOKIE[Auth::COOKIE_NAME] = $hash;
        
        #RLogger::info("",$hash);
    
        #$sms = Auth::getSms();
        #Sms::send($this->phone, "BWSChart login code: ".$sms);
        $ip = $_SERVER['REMOTE_ADDR'];
        $this->catalog->editValuesOf($this->id*1, 0, ["data"=>$hash,"auth_status"=>Auth::AUTH_SMS_PENDING,"sms_code"=>$sms, "last_ip" => '']);
        $this->finalAuth();
    }
    
    public function finalAuth(){
        $ip = $_SERVER['REMOTE_ADDR'];
        $this->catalog->editValuesOf($this->id*1, 0, ["auth_status"=>Auth::AUTH_OK,"sms_code"=>0, 'last_ip' => '']);
    }
    
    public function refreshAuth(){
        $hash = Auth::getHash();
        setcookie(Auth::COOKIE_NAME, $hash, time()+86400*30, "/");
        $_COOKIE[Auth::COOKIE_NAME] = $hash;
        $ip = $_SERVER['REMOTE_ADDR'];
        $this->catalog->editValuesOf($this->id*1, 0, ["data"=>$hash, "last_ip" => '']);
    }
    
    
    public function getId(): int{
        return $this->id;
    }
    
    public function getArray(){
        return $this->arr;
    }
    
}