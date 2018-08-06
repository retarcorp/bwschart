<?php
namespace Core\Classes\Apps\AppManager;
use Core\Classes\System\CoreUsers;
use Core\Classes\System\RLogger;
use Core\Classes\System\RCatalog;
use Core\Classes\Apps\FileManager;
use Core\Classes\Apps\AppManager\CoreApp;
use Core\Classes\Apps\AppManager\InstallResult;



class Manager{
    
    const SHOP_URL = "http://app.retarcorp.com/apps/";
    const SHOP_APP_URL = "http://app.retarcorp.com/apps/app/";
    const SYSTEM_VERSION = "1.20";
    
    public static function getShopList(){
        $res =  json_decode(file_get_contents(self::SHOP_URL."?version=".self::SYSTEM_VERSION), true);

        foreach($res as $i=>$cat){
            foreach($cat['apps'] as $j=>$app){
                $res[$i]['apps'][$j]['installed']=0;
                if(self::isAppInstalled($app['name'])){
                    $res[$i]['apps'][$j]['installed']=1;
                }
            }
        }
        return $res;
    }
    
    public static function getAppData($appId){
        return json_decode(file_get_contents(self::SHOP_APP_URL."?version=".self::SYSTEM_VERSION."&app=".$appId), true);
    }
    
    public static function isAppInstalled($appName){
        $catalog = new RCatalog("cata_apps");
        $items = $catalog->getAllByQuery(1, " name='$appName'");
        return (count($items)>=1);
    }
    
    public static function getCoreApp($name){
        if(!self::isAppInstalled($name)){
            return NULL;
        }
        return new CoreApp($name);
    }
    
    public static function getAppURLById($id){
        $catalog=new RCatalog("cata_apps");
        $i = $catalog->getItemAt($id, 1);
        return $i['link'];
    }
    
    public static function getAppURLByName($name){
        $catalog=new RCatalog("cata_apps");
        $i = $catalog->getAllByQuery(1, "name='$name'");
        return $i[0]['link'];
    }
    
    const CATEGORY_GENERAL = 1;
    const CATEGORY_DEVTOOLS = 2;
    const CATEGORY_ADMINISTRATION = 3;
    
    const ERROR_INSTALL_NOT_FOUND = "KJXie9";
    public static function installRemoteApp($appId){
        $list = self::getAppData($appId);
        $result = new InstallResult();
        if(!$list){
            $result->error("Приложение удалено из магазина или не найдено!");
            return $result;  
        }
        $list = $list[0];
        
        $catalog = new RCatalog("cata_apps");
        
        
        $zip = $list['version']['path'];
        $img = $list['image_url'];
        $rights = $list['use_rights'];
        $desc = $list['description'];
        $name = $list['name'];
        $title = $list['title'];
        $category = $list['category'];
        $version = $list['version']['code'];
        
        switch($rights){
            case "ADMIN":{
                use_rights(CoreUsers::ADMIN);
                break;
            }
            case "MODERATOR":{
                use_rights(CoreUsers::MODERATOR);
                break;
            }
        }
        
        # If app is already installed - cancel!
        if(Manager::isAppInstalled($name)){
            return $result->error("Приложение уже установлено в систему!");
        }
        
        
        # Extracting App Zip and icon
        FileManager::createFolder("/Core/apps/$name");
        $zip = file_get_contents($zip);
        if(strlen($zip)<100){
            return $result->error("Архив установки не найден!");
        }
        file_put_contents($_SERVER['DOCUMENT_ROOT']."/Core/apps/$name/install.zip",$zip);
        
        FileManager::extractTo("/Core/apps/$name/install.zip","/Core/apps/$name/");
        FileManager::deleteFile("/Core/apps/$name/install.zip");
        
        file_put_contents($_SERVER['DOCUMENT_ROOT']."/Core/img/apps/$name.png",file_get_contents($img));
        
        # Installing App to App Catalog
        $appArr = [
                $name
                ,$title
                ,"/Core/img/apps/$name.png"
                ,"/Core/apps/$name"
                ,$version
                ,$desc
                ,2
            ];
        $catalog->addItem($appArr,$category*1, 0);
        
        
        # Redirecting to installer
        return $result->success("/Core/apps/$name/install");
    }
}