<?php
namespace Core\Classes\Apps;
use Core\Classes\System\RLogger;

class FileManager{

	#private static $root = $_SERVER['DOCUMENT_ROOT'];
	
	public static function getItemsAtDir($dir){
	    $adir = $_SERVER['DOCUMENT_ROOT'].$dir;
	    
	    $items = scandir($adir);
	    $res=[];
	    $folders=[];
	    $files=[];
	    
	    foreach($items as $i=>$f){
	        if($f==".") continue;
	        if($f=="..") continue;
	        
	        $item = ["name"=>$f,"path"=>$dir."/".$f];
	        if(is_file($adir."/".$f)){
	            $item["role"]="file";
	            $item["ext"]=strtolower(pathinfo($adir."/".$f)['extension']);
	            $item['size']=filesize($adir."/".$f);
	            $files[]=$item;
	        }
	        if(is_dir($adir."/".$f)){
	            $item["role"]="folder";
	            $folders[]=$item;
	        }
	    }
	    
	    usort($folders,function($a, $b){
	       return strcmp($a['name'], $b['name']); 
	    });
	    usort($files,function($a, $b){
	       return strcmp($a['name'], $b['name']); 
	    });
	    
	    return array_merge($folders,$files);
	}
	
	public static function addFile($dir, $file){
		global $APP_NAME;
		$dirName=$dir;
		
		chdir($_SERVER["DOCUMENT_ROOT"].$dir);
		$dir = opendir($_SERVER["DOCUMENT_ROOT"].$dir);
		
		while($handle = readdir($dir)){
			if (!is_dir($handle)){
				if($handle==$file) {
					RLogger::warn("$APP_NAME > FileManager.php","Не удалось создать файл $name в папке $dirName! Файл уже существует.");
					return FALSE;
				}
			}
		}
		
		if(@touch($file)){
			RLogger::info("FileManager.php","$APP_NAME > Создан файл $name в папке $dirName");
			return true;
		}else{
			RLogger::warn("FileManager.php","$APP_NAME > Не удалось создать файл $name в папке $dirName! Ошибка функции touch.");
		}
		return false;		
	}
	
	public static function removeFile($dir, $file){
		global $APP_NAME;
		
		chdir($_SERVER["DOCUMENT_ROOT"].$dir);
		if(!is_file($file)){
			RLogger::warn("$APP_NAME > FileManager.php","Не удалось удалить файл $file из папки $dir. Файл не существует!");
			return false;
		}
	
		if(@unlink($file)){
			RLogger::info("FileManager.php","$APP_NAME > Удален файл {$file} из папки $dir");
			return true;
		}else{
			RLogger::warn("FileManager.php","$APP_NAME > Не удалось удалить файл $file из папки $dir. Ошибка функции unlink.");
			return false;
		}
	}
	
	const ERROR_FOLDER_EXISTS = 20;
	const RENAME_FOLDER_OK =39;
	const ERROR_ILLEGAL_NAME = -31;
	public static function renameFolder($dir, $name){
	    
	    if(strpos($name,"/")!==FALSE){
	        return self::ERROR_ILLEGAL_NAME;
	    }
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $adir = $root.$dir;
	    $absdir = explode("/",$adir);
	    $absdir[count($absdir)-1]=$name;
	    $newdir = implode("/",$absdir);
	    
	    if(is_file($newdir)){
	        return self::ERROR_FOLDER_EXISTS;
	    }
	    if(is_dir($newdir)){
	        return self::ERROR_FOLDER_EXISTS;
	    }
	    if(rename($adir, $newdir)){
	        return self::RENAME_FOLDER_OK;
	    }
	    return false;
	}
	
	const ERROR_FILE_EXISTS= 392;
	const RENAME_FILE_OK = 49;
	public static function renameFile($dir, $name){
	    
	    if(strpos($name,"/")!==FALSE){
	        return self::ERROR_ILLEGAL_NAME;
	    }
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $adir = $root.$dir;
	    $absdir = explode("/",$adir);
	    $absdir[count($absdir)-1]=$name;
	    $newdir = implode("/",$absdir);
	    
	    if(is_file($newdir)){
	        return self::ERROR_FILE_EXISTS;
	    }
	    if(is_dir($newdir)){
	        return self::ERROR_FILE_EXISTS;
	    }
	    if(rename($adir, $newdir)){
	        return self::RENAME_FILE_OK;
	    }
	    return false;
	}
	
	
	public static function archivate($dir, $dest,$ignoreList = []){
	    
	    $root = $_SERVER['DOCUMENT_ROOT'];
    	$zipLocation = $root."/".$dest;
    	
    	$zip = new \ZipArchive;
    	$zip->open($zipLocation, \ZipArchive::CREATE);
    	
    	function contentOf($folder, $zip, $dir){
            # echo $folder." \n";
            $root = $_SERVER['DOCUMENT_ROOT'];
             
    		$result = array();
    		$c = scandir($folder);
    		
    		foreach($c as $item){
    			if($item==".") continue;
    			if($item=="..") continue;
    			if($item=="/") continue;
    			
    			$name = $folder."/".$item;
    			$archName = str_replace($root.$dir."/", "", $name);
    			
    			if (is_file($name)) {
    				$zip->addFile($name, $archName);
    			}
    			if (is_dir($name)) {
    				$zip->addEmptyDir($archName);
    				contentOf($name, $zip, $dir);
    			}
    		}
    		
    		return $result;
    	}
    
    	$content = contentOf($root.$dir,$zip, $dir);
    	$zip->close();
	}
	
	public function extractTo($from, $to){
	    $zip = new \ZipArchive;
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    
	    $zip->open($root.$from);
	    $zip->extractTo($root.$to);
	}
	
	public static function deleteFile($path){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    RLogger::info("File Manager","Удален файл $path.");
	    return unlink($root.$path);
	}
	
	public static function deleteFolder($path){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $abs = $root.$path;
	    if(!is_dir($abs)){
	        RLogger::error("File Manager","Не удалось удалить папку $path! Папка не существует.");
	        return FALSE;
	    }
	    
	    $items = scandir($abs);
	    foreach($items as $i => $v){
	        if($v==".") continue;
	        if($v=="..") continue;
	        
	        if(is_dir($abs."/".$v)){
	            self::deleteFolder($path."/".$v);
	        }
	        if(is_file($abs."/".$v)){
	            unlink($abs."/".$v);
	        }
	    }
	    rmdir($abs);
	    RLogger::info("File Manager","Удалена папка $path со всем содержимым.");
	}
	
	const CREATE_FILE_OK = 1;
	public static function createFile($path){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $file =  $path;
	    $path = $root."/".$path;
	    if(is_dir($path)){
	        return self::ERROR_FILE_EXISTS;
	    }
	    if(is_file($path)){
	        return self::ERROR_FOLDER_EXISTS;
	    }
	    if(strpos("/",$file)){
	        return self::ERROR_ILLEGAL_NAME;
	    }
	    touch($path);
	    RLogger::info("File Manager","Создан файл $path.");
	    return self::CREATE_FILE_OK;
	    
	}
	
	const CREATE_FOLDER_OK=3;
	public static function createFolder($path){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $file =  $path;
	    $path = $root."/".$path;
	    if(is_dir($path)){
	        return self::ERROR_FILE_EXISTS;
	    }
	    if(is_file($path)){
	        return self::ERROR_FOLDER_EXISTS;
	    }
	    if(strpos("/",$file)){
	        return self::ERROR_ILLEGAL_NAME;
	    }
	    mkdir($path);
	    RLogger::info("File Manager","Создана папка $path.");
	    return self::CREATE_FOLDER_OK;
	    
	}
	
	
	public static function getFileProperties($path){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $dir =$path; 
	    $path=$root.$path;
	    
	    if(!is_file($path)){
	        return [];
	    }
	    
	    return [
	            "accessed"=>fileatime($path)
	            ,"modified"=>filemtime($path)
	            ,"size"=>filesize($path)
	            ,"extension"=>pathinfo($path)['extension']
	            ,"name"=>pathinfo($path)['basename']
	            ,"path"=>$dir
	        ];
	}
	
	public static function getFolderProperties($path){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    $dir = $path;
	    $path=$root.$path;
	    if(!is_dir($path)){
	        return [];
	    }
	    
	    $size = 0;
	    function countSize($dir){
	        $items = scandir($dir);
	        $sum=0;
	        foreach($items as $i=>$v){
	            if($v=="." || $v==".."){
	                continue;
	            }
	            if(is_dir("$dir/$v")){
	               $sum+=countSize($dir."/$v"); 
	            }
	            if(is_file("$dir/$v")){
	                $sum+=filesize($dir."/$v");
	            }
	        }
	        return $sum;
	    }
	    
	    function countElements($dir){
	        $items = scandir($dir);
	        $sum=["files"=>0,"folders"=>0];
	        foreach($items as $i=>$v){
	            if($v=="." || $v==".."){
	                continue;
	            }
	            if(is_dir("$dir/$v")){
	               $sum["folders"]++;
	               $r = countElements($dir."/$v"); 
	               $sum["files"]+=$r["files"];
	               $sum["folders"]+=$r["folders"];
	            }
	            if(is_file("$dir/$v")){
	                $sum["files"]+=1;
	            }
	        }
	        return $sum;
	    }
	    
	    $size = countSize($path);
	    $elements = countElements($path);
	    
	    return [
	            "name"=>$dir
	            ,"size"=>$size
	            ,"files"=>$elements["files"]
	            ,"folders"=>$elements["folders"]
	        ];
	}
	
	public static function copyFile($from, $to){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    return copy($root.$from, $root.$to);
	}
	
	public static function copyFolder($from, $to){
	    $root = $_SERVER['DOCUMENT_ROOT'];
	    
	    mkdir($root.$to);
	    function xcopy($from, $to){
	        foreach(scandir($from) as $item){
	            if($item=="." || $item=="..") continue;
	            if(is_file($from."/".$item)){
	                copy($from."/".$item,$to."/".$item);
	            }
	            if(is_dir($from."/".$item)){
	                mkdir($to."/".$item);
	                xcopy($from."/$item",$to."/$item");
	            }
	        }
	    }
	    xcopy($root.$from, $root.$to);
	    
	}

}