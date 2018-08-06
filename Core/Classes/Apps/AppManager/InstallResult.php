<?php
namespace Core\Classes\Apps\AppManager;

class InstallResult{
    
    private $message, $log;
    public $status;
    public function __construct($status=self::STATUS_PENDING, $message="", $log=""){
        $this->status = $status;
        $this->message = $message;
        $this->log = $log;
    }
    
    const STATUS_PENDING = -1;
    const STATUS_ERROR = 1;
    const STATUS_SUCCESS = 3;
    public function setMessage($msg){
        $this->message = $msg;
    }
    
    public function getMessage(){
        return $this->message;
    }
    
    public function error($msg){
        $this->message = $msg;
        $this->status = self::STATUS_ERROR;
        return $this;
    }
    
    public function success($msg){
        $this->message = $msg;
        $this->status = self::STATUS_SUCCESS;
        return $this;
    }
}