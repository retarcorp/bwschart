<?php
    require "../config";
    use Core\Classes\System\CoreUsers;
    use Core\Classes\System as System;
    use_rights(CoreUsers::MODERATOR);
    
    try{
        CoreUsers::add($_POST['login'], $_POST['password'], $_POST['role'], $_POST['description']);
    }catch(System\InvalidUserCredentialsException $e){
         die(json_encode(["status"=>"ERROR","message"=>"Некорректные логин или пароль пользователя! Логин должен состоять не менее чем из 4 латинских букв, цифр или знака нижнего подчеркивания, пароль - из 8 символов!"]));
    }catch(System\UserAlreadyExistsException $e){
        die(json_encode(["status"=>"ERROR","message"=>"Такой пользователь уже существует в системе!"]));
    }catch(System\NotEnoughRightsException $e){
        die(json_encode(["status"=>"ERROR","message"=>"Невозможно создать пользователя с правами большими, чем у Вас!"]));
    }
    echo json_encode(['status'=>"OK","data"=>"Пользователь успешно создан!"]);