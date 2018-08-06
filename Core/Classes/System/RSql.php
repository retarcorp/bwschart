<?php

namespace Core\Classes\System;
use Core\Classes\System\RSqlCredentials;

class RSql{

	private  $hostname;
	private  $username;
	private  $password;
	private  $mainDB;
	private  $DBsource;
	
	private $lastQuery;
	private $lastError;
	
	private static $link;

	public function __construct(){
	
		if(self::$link == NULL){
		
			$this->hostname= RSqlCredentials::DB_HOSTNAME;
			$this->username= RSqlCredentials::DB_USERNAME;
			$this->password= RSqlCredentials::DB_PASSWORD;
			$this->mainDB = RSqlCredentials::DB_DATABASE;
			$this->DBSource = mysqli_connect($this->hostname, $this->username, $this->password,$this->mainDB);
			self::$link = $this->DBSource;
		}else{
		    $this->DBSource = self::$link;
		}
		
	}
	
	public function resource(){
		return $this->DBSource;
	}

    private $res = null;
    
	public function query($q){
	    if($this->res){
	        #mysqli_free_result($this->res);
	    }
	    $this->res = mysqli_query($this->resource(), $q);
	    
	    $this->lastQuery=$q;
	    $this->lastError = NULL;
	    if(mysqli_error($this->resource())){
	        $this->lastError = "Error executing query '$q': ".mysqli_error($this->resource());
	    }
	    
		return $this->res;
	}
	
	public function execPrepared($query, $params){
	    $query = explode("?",$query);
	    if(count($query)-count($params)!=1){
	        $this->lastError = "Amount of params is not equal to amount of placeholders.";
	        return FALSE;
	    }
	    $q = $query[0];
	    foreach($params as $i=>$p){
	        $p = mysqli_real_escape_string($this->DBSource, $p);
	        $q.=$p.$query[$i+1];
	    }
	    return $this->query($q);
	}
	
	public function getLastError(){
	    return $this->lastError;
	}


	public function getAssocArray($Q){
	    //global $LocalTime;
	    
		$res = $this->query($Q);
		
		//$LocalTime = microtime(true);
		
		$result = array();
		while($T = mysqli_fetch_assoc($res)) array_push($result, $T);
		mysqli_free_result($res);
		return $result;
	}
	
	
	public function getArray($Q){
		$res = $this->query($Q);
		$result = array();
		while($T = mysqli_fetch_array($res)) array_push($result, $T);
		return $result;
	}



	public static function destroy(){
		try{
			mysqli_close(self::$link);
		}catch(\Exception $e){
// 			print_r($e->getMessage());
		}
	}
}