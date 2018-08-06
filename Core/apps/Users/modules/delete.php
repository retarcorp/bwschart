<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System as System;
    use_rights(CoreUsers::MODERATOR);
    
    $id = $_POST['id'];
    if(isset($_POST['password'])){
        $password = $_POST['password'];
        
    }
    
    try{
        CoreUsers::remove($id, $password);
    }catch(System\PasswordRequiredException $e){
        die(json_encode(["status"=>"PASSWORD_REQUIRED","message"=>"Для выполнения действия необходим пароль."]));
    }catch(System\InvalidUserCredentialsException $e){
        die(json_encode(["status"=>"ERROR","message"=>"Неправильный пароль пользователя!"]));
    }catch(System\NotEnoughRightsException $e){
        die(json_encode(["status"=>"ERROR","message"=>"Нельзя удалить пользователя с правами большими, чем у Вас!"]));
    }catch(System\LastAdminDeletingException $e){
        die(json_encode(["status"=>"ERROR","message"=>"Нельзя удалить последнего администратора системы!"]));
    }
    die(json_encode(["status"=>"OK","message"=>"Успешно удален!"]));