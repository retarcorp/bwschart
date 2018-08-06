<?php

namespace Classes\Utils;

use Core\Classes\System\RLogger;

class Sms{
    
    const USERNAME = "192577589";
    const PASSWORD = "59Z8Aw5g";
    
    public static function send($phone, $message) {
		$curl = curl_init();
	
		curl_setopt($curl, CURLOPT_URL, 'http://api.rocketsms.by/json/send');	
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_POSTFIELDS, "username=".self::USERNAME."&password=".self::PASSWORD."&phone=" . $phone . "&text=" . $message);
		
		$result = @json_decode(curl_exec($curl), true);
		RLogger::info("Sms",$phone." -> ".$message);
		
		if ($result && isset($result['id'])) {
			return true;
		} elseif ($result && isset($result['error'])) {
			return false;
		} else {
			return false;
		}
	}
}