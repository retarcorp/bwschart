<?php
    require "config";
    use Core\Classes\System\RSql;
    
    use Core\Classes\System\CoreUsers;
    use_rights(CoreUsers::ADMIN);
    
    
    $sql = new RSql;
    $query = $_POST['query'];
    if(trim($query)){
        $raw = @$sql->getAssocArray($query);
        
        if($sql->getLastError()){
            $status="<span class='error'>{$sql->getLastError()}</span>";
        }else{
            $status="<span class='info'>Запрос был выполнен успешно. Ответ содержит ".count($raw)." строк.</span>";
            if(count($raw)){
                $keys = array_keys($raw[0]);
                $thead="";
                foreach($keys as $i=>$key){$thead.="<td>$key</td>";}
                
                $tbody="";
                foreach($raw as $i=>$row){
                    $tbody.="<tr>";
                    foreach($row as $j=>$val){
                        $tbody.="<td><xmp>$val</xmp></td>";
                    }
                    $tbody.="</tr>";
                }
            }
            
        }
        $queries = json_decode(file_get_contents("queries.json"),true);
        if($queries[0]['query']!=$query){
            array_unshift($queries, ["date"=>date("Y-m-d H:i:s"), "query"=>$query]);
            file_put_contents("queries.json", json_encode($queries, JSON_UNESCAPED_UNICODE));
        }
    }
    
    
    
?>
        
<div class='status'><div id='status'><?=$status?></div></div>
<table id='result_table'>
    <thead>
        <?=$thead?>
    </thead>
    
    <tbody id='queryResult'>
        <?=$tbody?>
    </tbody>
    
</table>