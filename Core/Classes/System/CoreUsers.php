<?php

namespace Core\Classes\System;
use Core\Classes\System as System;

class CoreUsers{

	const ADMIN = 3;
	const MODERATOR = 2;
	const GUEST = 1;
	const UNAUTHORIZED=0;
	const LIFETIME = 86400;
	
	private static $table = "cata_users";
	
	# getCurrent: Array
	# Returns an array of current user or NULL if no user authotized.
	public static function getCurrent(){
	   
		$ssid = $_COOKIE['ssid'];
		if(!$ssid) return false;
		
		$sql = new System\RSql;
		
		$q = "SELECT * FROM ".self::$table." WHERE ssid='$ssid'";
		$users = $sql->getAssocArray($q);
		#var_dump($users);
		
		if(!count($users)) return NULL;
		return $users[0];
		
	}
	
	# getId (string, string) : int | bool
	# Returns an id of user with login and password sent, or NULL if there's no such user in database
	public static function getId($login, $password){
		$sql = new RSql;
		$password = md5($password);
		
		$q = "SELECT * FROM ".self::$table." WHERE login='$login' AND password='$password';";
		$users = $sql->getArray($q);
		
		if(count($users)){ return $users[0]['id'];}
		return NULL;
	}
	
	# getUser(int): Array
	# returns an array of user from database by id.	
	public static function getUser($id){
		$sql = new RSql;
		
		$q = "SELECT * FROM ".self::$table." WHERE id='$id';";
		$users = $sql->getAssocArray($q);
		
		if(count($users)){ return $users[0];}
		return NULL;
	}
	
	# isUserId (int, string) : bool
	# returns TRUE if user with given id has given password hash, FALSE otherwise
	public static function isUserId($id, $password){
		$sql = new RSql;
		
		$q = "SELECT * FROM ".self::$table." WHERE id=$id AND password='$password';";
		$users = $sql->getArray($q);
		
		if(count($users)){ return true;}
		return false;
	}
	
	# getSSID(string, string) : string
	# creates unique SSID for user with given login and password.
	public static function getSSID($login, $password){
		return md5(md5(microtime(true)).md5($login).md5($password));
	}
	
	# login (string, string) : bool
	# tries to login a user with given login and raw password. If successfull, sets a cookie SSID and returns true.
	public static function login($login, $passwordstr){
		
		$password = md5($passwordstr);
		// $password = $passwordstr;
		$sql = new RSql;
		
		$q = "SELECT * FROM ".self::$table." WHERE login='$login' AND password='$password';";
		$users = $sql->getArray($q);
		
		if(count($users)){
			$ssid = self::getSSID($login, $password);
			$id = $users[0]['id'];
			
			self::setSSID($ssid);
			
			$q = "UPDATE ".self::$table." SET ssid='$ssid' WHERE id='$id'";
			$sql->query($q);
			
			setcookie("ssid",$ssid,time()+self::LIFETIME,"/");
			
			RLogger::addReport("Core Users",RLogger::STATUS_INFO,"Авторизован пользователь $login. [{$_SERVER['REMOTE_ADDR']}]");
			return true;
		}
		RLogger::addReport("Core Users",RLogger::STATUS_SAFETY_WARNING,"Попытка войти в систему под некорректными данными, под логином $login, паролем $passwordstr! [{$_SERVER['REMOTE_ADDR']}]");
		return false;
	}
	
	# logout(): bool
	# unsets dynamic SSID for user and database.
	public static function logout(){
		$user = self::getCurrent();
		if($user){
			$sql = new RSql;
			$id = $user['id'];
			$Q = "UPDATE ".self::$table." SET ssid='' WHERE id='$id'";
			$sql->query($Q);
			
		}
		RLogger::addReport("Core Users",RLogger::STATUS_INFO,"Пользователь {$user['login']} вышел из системы. [{$_SERVER['REMOTE_ADDR']}]");
		setcookie("ssid","",time()-10,"/core");
		unset($_COOKIE['ssid']);
		return true;
		
	}
	
	
	# setSSID(string) : bool
	# tries to set cookie SSID. If successfull, returns TRUE.
	private static function setSSID($ssid){
		$_COOKIE['ssid'] = $ssid;
		if (setcookie("ssid", $ssid, time()+self::LIFETIME, "/core")) return true;
		return false;
	}
	
	# reauth() : bool
	# tries to reset SSID for user in terms of dynamic ssid authorization system.
	public static function reauth(){
		$ssid = $_COOKIE['ssid'];
		if(!$ssid) return false;
		
		$sql = new RSql;
		
		$q = "SELECT * FROM ".self::$table." WHERE ssid='$ssid'";
		$users = $sql->getAssocArray($q);
		
		if(count($users)){
			$ssid = self::getSSID($users[0]['login'], $users[0]['password']);
			$id = $users[0]['id'];
			
			self::setSSID($ssid);
			$q = "UPDATE ".self::$table." SET ssid='$ssid' WHERE id='$id'";
			$sql->query($q);
			
			RLogger::addReport("Core Users",RLogger::STATUS_INFO,"Изменен динамический SSID пользователя {$users[0]['login']}! [{$_SERVER['REMOTE_ADDR']}]");
			return true;
		}
		
		RLogger::addReport("Core Users",RLogger::STATUS_SAFETY_WARNING,"Неудачная попытка сменить динамический SSID пользователя {$users[0]['login']}! [{$_SERVER['REMOTE_ADDR']}]");
		return false;
	}
	
	# authorized() : bool
	# Returns TRUE if current user is authorized, and reauthorizates. If current user is not authorized, returns FALSE.
	public static function authorized(){
		$ssid = $_COOKIE['ssid'];
		if(!$ssid) return false;
		
		$sql = new RSql;
		
		$q = "SELECT * FROM ".self::$table." WHERE ssid='$ssid'";
		$users = $sql->getArray($q);
		
		if(count($users)){
			self::reauth();
			return true;
		}
		
		return false;
	}
	
	# add(string, string, string) : bool
	# Creates new user in database. If user already exists, throws UserAlreadyExistsException exception.
	public static function add($login, $rpassword, $role, $description){
		
		if(!preg_match("/^[a-zA-Z0-9\_]{4,}$/",$login)){
		    throw new InvalidUserCredentialsException();
		    return false;
		}
		if(!preg_match("/^[^\s\t\n]{8,}$/",$rpassword)){
		    throw new InvalidUserCredentialsException();
		    return false;
		}
		
		$current = self::getCurrent();
		if($current['role']<$role*1) {
		    
		    RLogger::safetyWarn("Core Users", "Попытка создать пользователя с правами большими, чем у текущего.");
		    throw new NotEnoughRightsException();
		    return false;
		}
		$password = md5($rpassword);
		$sql = new RSql;
		
		$Q ="SELECT * FROM ".self::$table." WHERE login='$login'";
		$users = $sql->getArray($Q);
		
		if(count($users)){
			throw new UserAlreadyExistsException();
			RLogger::addReport("Core Users",RLogger::STATUS_ERROR,"Попытка создать уже существующего пользователя под логином {$users[0]['login']}");
			return false;
			
		}else{
			$Q="INSERT INTO ".self::$table." VALUES (default, '?', '?', ?, '?', '')";
			$sql->execPrepared($Q, [$login, $password, $role, $description]);
			
			if ($sql->getLastError()) return false;
			
			RLogger::addReport("Core Users",RLogger::STATUS_INFO,"Создан новый пользователь под логином $login");
			return true;
		}
	}
	
	# edit (int, Array) : bool
	# Tries to edit user. Data array should look like the following template:
	# $data = array("login"=> , "password"=> , ...);
	public static function edit($id, $data){
		$sql=new RSql;
		if(!count($data)) return true;
		
		$current = CoreUsers::getCurrent();
		$edited = CoreUsers::getUser($id);
		
		if($edited['role']*1>$current['role']*1){
		    throw new NotEnoughRightsException("Нельзя изменить пользователя с правами большими, чем Ваши!");
		    return FALSE;
		}
		
		$passwordCheck=false;
		if($edited['role']*1 == $current['role']*1){
	        $passwordCheck = true;
		}
		
		if($passwordCheck){
		    if(md5($data['oldPassword'])!= $edited['password']){
		        throw new InvalidUserCredentialsException();
		        return FALSE;
		    }
		}
		unset($data['oldPassword']);
		$data['password'] = md5($data['password']);
		
		$Q = "UPDATE ".self::$table." SET id=$id ";
		foreach ($data as $k=>$d){
			$Q.=" ,$k='$d' ";
		}
		$Q.=" WHERE id=$id";
		$sql->query($Q);
		
		if ($sql->getLastError()){
		    RLogger::error("Core Users", "Не удалось изменить данные пользователя! Входной массив: ".print_r($data,true)." ".$sql->getLastError());
		    return false;
		} 
		
		return true;
		
	}
	
	# remove(int):bool
	# Removes user from database.
	public static function remove($id, $password = NULL){
		$current = self::getCurrent();
		$role = $current['role'];
		
		$user = self::getUser($id);
		
		
		
		if($role<$user['role']){
			throw new NotEnoughRightsException();
			return false;
		}
		if($user['role']==self::ADMIN){
		    $sql = new RSql;
		    $c = $sql->getAssocArray("SELECT * FROM ".self::$table." WHERE role=".self::ADMIN);
		    if(count($c)<=1){
		        throw new LastAdminDeletingException();
		    }
		}
		if($role==$user['role']){
		    if($password){
		        if(md5($password) != $user['password']){
		            throw new InvalidUserCredentialsException();
		        }
		    }else{
		        throw new PasswordRequiredException();
		        return false;
		    } 
		}
		
		$Q = "DELETE FROM ".self::$table." WHERE id='$id'";
		
		$sql = new RSql;
		$sql->query($Q);
		if(!$sql->getLastError()) {
		    return true;
		}else{
		    RLogger::error("Core Users","Не удалось удалить пользователя! Ошибка уровня SQL: ".$sql->getLastError());
		}
		return false;
	}
	
	public static function getAll(){
	    $current = self::getCurrent();
	    $sql = new RSql;
	    $role = $current['role']*1;
	    $query = "SELECT * FROM ".self::$table." WHERE role<=$role";
	    return $sql->getAssocArray($query);
	}
}

class NotEnoughRightsException extends \Exception{
	public function __construct($message="Недостаточно прав пользователя для осуществления операции!"){
		parent::__construct($message);
	}
}

class InvalidUserCredentialsException extends \Exception{
	public function __construct($message="Некорректные данные входа пользователя!"){
		parent::__construct($message);
	}
}

class PasswordRequiredException extends \Exception{
	public function __construct($message="Для осуществления этого действия необходим пароль пользователя!"){
		parent::__construct($message);
	}
}

class UserAlreadyExistsException extends \Exception{	
	public function __construct($message="Пользователь с таким логином уже существует!"){		
		parent::__construct($message);
	}
}

class LastAdminDeletingException extends \Exception{	
	public function __construct($message="Пользователь с таким логином уже существует!"){		
		parent::__construct($message);
	}
}