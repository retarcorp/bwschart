<?php

namespace Classes\Utils;
use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;

class DuplicatesRemover{
    
    private $sql = null;
    private $graph = null;
    private $tabe = '';
    
    public const INSTRUMENTS = [
        '6A','6B','6C','6E','6J','6N','6S','CL','GC'
    ];
    
    private const CACHE_FP = 'cache_fp_';
    private const CACHE_DELTA = 'cache_delta_';
    
    public const TABLE_NAME_FP = 'duplicates_stack_fp';
    # id INT,
    # ts INT,
    # tf INT,
    # tablename VARCHAR
    
    public const TABLE_NAME_DELTA = 'duplicates_stack_delta';
    # id INT,
    # ts INT,
    # tse INT,
    # delta INT
    # tablename VARCHAR
    
    public const FP = 1;
    public const DELTA = 2;
    
    public const LOG_FILE = "C:\inetpub\wwwroot\Duplicates\duplicates.log";
    
    public function __construct(int $graph){
        if( $graph != self::FP && $graph != self::DELTA ){
            throw new \Exception("Choose right graph");
        }
        
        $this->sql = new RSql();
        $this->graph = $graph;
        
        switch($this->graph){
            case self::FP:
                $this->table = self::TABLE_NAME_FP;
                break;
            
            case self::DELTA:
                $this->table = self::TABLE_NAME_DELTA;
                break;
        }
    }

    public function log(string $data){
        file_put_contents(self::LOG_FILE, $data, FILE_APPEND);
    }
    
    public function getFPCacheTableName(string $instrument): string{
        return self::CACHE_FP . $instrument;
    }
    
    public function getDeltaCacheTableName(string $instrument): string{
        return self::CACHE_DELTA . $instrument;
    }
    
    public function getDublicatesInfo(string $tableName): array{
        $q = $this->getDuplicatesFindingQuery($tableName);
        
        $data = $this->sql->getAssocArray($q);
        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
        
        return $data;
    }
    
    private function getDuplicatesFindingQuery(string $tableName): string{
        switch($this->graph){
            
            case self::FP:
                return "SELECT tf, ts FROM $tableName
                    GROUP BY ts, tf
                    HAVING COUNT(*) > 1";
            
            case self::DELTA:
                return "SELECT delta, ts, tse FROM $tableName
                    GROUP BY delta, ts, tse
                    HAVING COUNT(*) >1";
        }
    }
    
    public function add(array $duplicates, string $tableName){
        $values = [];
        
        if( !empty($duplicates) ){
            foreach($duplicates as $duplicate){
                $temp = $this->getValidatedDuplicate($duplicate, $tableName);
                
                if( !($this->isAlreadyExists($temp)) ){
                    $values [] = '(' . implode(', ', $temp) . ')';
                }
            }
            
            $fields = implode(', ', $this->getTableFields());
            
            $q = "INSERT INTO {$this->table}
                ($fields)
                VALUES " . implode(', ', $values);
            $this->sql->query($q);
            
            if( $e = $this->sql->getLastError() ){
                RLogger::error(__METHOD__, $e);
            }
        }
        
        $data = "$tableName, added " . count($values) . " row(s)\n";
        print_r($data);
        $this->log($data);
    }
    
    private function getTableFields(): array{
        switch($this->graph){
            case self::FP:
                return ['ts', 'tf', 'tablename'];
            case self::DELTA:
                return ['ts', 'tse', 'delta', 'tablename'];
        }
    }
    
    private function getValidatedDuplicate(array $duplicate, string $tableName): array{
        switch($this->graph){
            
            case self::FP:
                return [
                    $duplicate['ts'],
                    $duplicate['tf'],
                    "'" . $tableName . "'"
                ];
            
            case self::DELTA:
                return [
                    $duplicate['ts'],
                    $duplicate['tse'],
                    $duplicate['delta'],
                    "'" . $tableName . "'"
                ];
        }
    }
    
    public function isAlreadyExists(array $info): bool{
        $q = $this->getExistenceCheckingQuery($info);
        
        $data = $this->sql->getAssocArray($q);
        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
        
        return boolval($data[0]['amount']);
    }
    
    private function getExistenceCheckingQuery(array $info): string{
        switch($this->graph){
            
            case self::FP:
                return "SELECT COUNT(*) amount FROM {$this->table}
                    WHERE ts = " . $info[0] . "
                    AND tf = " . $info[1] . "
                    AND tablename = " . $info[2];
            
            case self::DELTA:
                return "SELECT COUNT(*) amount FROM {$this->table}
                    WHERE ts = " . $info[0] . "
                    AND tse = " . $info[1] . "
                    AND delta = " . $info[2] . "
                    AND tablename = " . $info[3];
        }
    }
    
    public function addDuplicatesFromTable(string $tableName){
        $duplicates = $this->getDublicatesInfo($tableName);
        $this->add($duplicates, $tableName);
    }
    
    public function getLast(): array{
        $q = "SELECT * FROM {$this->table}
            ORDER BY id DESC
            LIMIT 1";
        
        $data = $this->sql->getAssocArray($q);
        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
        
        return $data[0];
    }
    
    public function findExactDuplicatesIds(array $duplicate): array{
        $q = $this->getFindingDuplicateIdsQuery($duplicate);
        
        $data = $this->sql->getAssocArray($q);
        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
        
        array_pop($data);
        return array_map(function($e){
            return intval($e['id']);
        }, $data);
    }
    
    private function getFindingDuplicateIdsQuery(array $duplicate): string{
        switch($this->graph){
            
            case self::FP:
                return "SELECT id FROM " . $duplicate['tablename'] . "
                    WHERE ts = " . $duplicate['ts'] . "
                    AND tf = " . $duplicate['tf'] . "
                    ORDER BY id DESC";
            
            case self::DELTA:
                return "SELECT id FROM " . $duplicate['tablename'] . "
                    WHERE ts = " . $duplicate['ts'] . "
                    AND tse = " . $duplicate['tse'] . "
                    AND delta = " . $duplicate['delta'] . "
                    ORDER BY id DESC";
        }
    }
    
    public function deleteDuplicates(array $ids, string $tableName){
        $q = "DELETE FROM $tableName WHERE id IN (" . implode(', ', $ids) . ")";
        $this->sql->query($q);
        
        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
        
        $data = "$tableName, " . mysqli_affected_rows($this->sql->resource())
            . " row(s) has/have been removed\n";
        print_r($data);
        $this->log($data);
    }
    
    public function pop(){
        $q = "DELETE FROM {$this->table}
            ORDER BY id DESC
            LIMIT 1";
        $this->sql->query($q);
        
        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
    }
    
    public function getDuplicatesAmountInStack(): int{
        $q = "SELECT COUNT(*) amount FROM {$this->table}";
        $data = $this->sql->getAssocArray($q);

        if( $e = $this->sql->getLastError() ){
            RLogger::error(__METHOD__, $e);
        }
        
        return intval($data[0]['amount']);
    }
    
    public function clearDuplicates(){
        while( $this->getDuplicatesAmountInStack() ){
            $last = $this->getLast();
            $ids = $this->findExactDuplicatesIds($last);
            $this->deleteDuplicates($ids, $last['tablename']);
            $this->pop();
        }
        
        $data = "Current amount of duplicates in {$this->table} is "
            . $this->getDuplicatesAmountInStack() . "; " . date("d.m.Y H:i:s") . "\n";
        $this->log($data);
        
        print_r($data);
    }
    
    public function fillDuplicatesTable(){
        foreach(self::INSTRUMENTS as $instrument){
            $tableName = $this->getInstrumentTableName($instrument);
            $this->addDuplicatesFromTable($tableName);
        }
        
        $data = "Total amount of duplicates in {$this->table} is "
            . $this->getDuplicatesAmountInStack() . "; " . date("d.m.Y H:i:s") . "\n";
        $this->log($data);
        
        print_r($data);
    }
    
    private function getInstrumentTableName(string $instrument): string{
        switch($this->graph){
            case self::FP:
                return $this->getFPCacheTableName($instrument);
            case self::DELTA:
                return $this->getDeltaCacheTableName($instrument);
        }
    }
    
}