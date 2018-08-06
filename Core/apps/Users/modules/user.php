<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System as System;
    
    use_rights(CoreUsers::MODERATOR, function(){
        die(json_encode(["status"=>"ERROR","message"=>"У Вас недостаточно прав, чтобы изменять информацию о пользователях!"]));
    });
    
    switch($_SERVER['REQUEST_METHOD']){
        case "GET":{
            
            $id=$_GET['id'];
            $user = CoreUsers::getUser($id);
            if(!$user){
                die(json_encode(["status"=>"ERROR","message"=>"Пользователь был удален или не найден!"]));
            }
            unset($user['password']);
            unset($user['ssid']);
            die(json_encode(["status"=>"OK","data"=>$user]));
            break;
        }
        case "POST":{
            
            try{
                $data = $_POST;
                unset($data['id']);
                CoreUsers::edit($_POST['id']*1,$data);
            }catch(System\NotEnoughRightsException $e){
                die(json_encode(["status"=>"ERROR","message"=>$e->getMessage()]));
            }catch(System\InvalidUserCredentialsException $e){
                die(json_encode(["status"=>"ERROR","message"=>"Неверный пароль пользователя!"]));
            }
            die(json_encode(["status"=>"OK","data"=>""]));
        }
    }