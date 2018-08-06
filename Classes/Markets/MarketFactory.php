<?php

    namespace Classes\Markets;
    use Core\Classes\System\RSql;
    use Core\Classes\System\RLogger;
    use Classes\Markets\Market;
    use Classes\Users\User;
    use Classes\Users\Auth;
    use Classes\Utils\Timestamp;
    use Classes\FootprintCache;
    
    class MarketFactory{
        
        public function getInstanceFromArray(array $data): Market{
            $market = new Market( intval($data['id']) );
            $startTS = new Timestamp( intval($data['start_ts']) );
            $endTS = new Timestamp( intval($data['end_ts']) );
            $market->setUserId( intval($data['uid']) )
                ->setGraph( intval($data['graph']) )
                ->setInstrument( $data['instrument'] )
                ->setStartTS( $startTS )
                ->setEndTS( $endTS )
                ->setStartPrice( floatval($data['start_price']) )
                ->setEndPrice( floatval($data['end_price']) )
                ->setTimeframe( intval($data['timeframe']) )
                ->setDelta( intval($data['delta']) );
            return $market;
        }
        
        public function getMarkets(User $user, int $graph, string $instrument, int $tfOrDelta): array{
            $sql = new RSql;
            switch($graph){
                case Market::GRAPH_FOOTPRINT:
                    $column = "timeframe";
                    break;
                case Market::GRAPH_DELTA:
                    $column = "delta";
                    break;
            }
            
            $q = "SELECT * FROM ".Market::TABLE_NAME." 
                WHERE uid = {$user->getId()}
                AND graph = $graph
                AND instrument = '$instrument'
                AND $column = $tfOrDelta";
                
            $data = $sql->getAssocArray($q);
            if( $e = $sql->getLastError() ){
                RLogger::error("MarketFactory\$getMarkets", $e);
            }
            
            return array_map(function($e){
                return $this->getInstanceFromArray($e);
            }, $data);
        }
        
        public function createMarket(User $user, int $graph, string $instrument, Timestamp $startTS, Timestamp $endTS, float $startPrice, float $endPrice, int $tfOrDelta): Market{
            switch($graph){
                case Market::GRAPH_FOOTPRINT:
                    $timeframe = $tfOrDelta;
                    $delta = 0;
                    break;
                case Market::GRAPH_DELTA:
                    $delta = $tfOrDelta;
                    $timeframe = 0;
                    break;
            }
            
            $sql = new RSql;
            $q = "INSERT INTO ".Market::TABLE_NAME." VALUES(
                default,
                {$user->getId()},
                $graph,
                '$instrument',
                {$startTS->getTimestamp()},
                {$endTS->getTimestamp()},
                $startPrice,
                $endPrice,
                $timeframe,
                $delta
            )";
            $sql->query($q);
            if( $e = $sql->getLastError() ){
                RLogger::error("MarketFactory\$createMarket", $e);
            }
            
            $q = "SELECT * FROM ".Market::TABLE_NAME." 
                WHERE uid = {$user->getId()}
                ORDER BY id DESC
                LIMIT 1";
            $data = $sql->getAssocArray($q);
            
            if( $e = $sql->getLastError() ){
                RLogger::error("MarketFactory\$createMarket", $e);
            }
            return $this->getInstanceFromArray($data[0]);
        }
        
        public function getMarketById(int $id): ?Market{
            $sql = new RSql;
            $q = "SELECT * FROM ".Market::TABLE_NAME." WHERE id = $id";
            $data = $sql->getAssocArray($q);
            if( !empty($data) ){
                return $this->getInstanceFromArray($data[0]);
            }
            return null;
        }
        
        public function isMarketDataEqual(Market $market, array $data): bool{
            $arr = $market->toArray();
            foreach($arr as $p => $v){
                if( $arr[$p] != $data[$p] ){
                    return false;
                }
            }
            return true;
        }
        
        public function isOwn(User $user, Market $market): bool{
            $sql = new RSql;
            $q = "SELECT id FROM ".Market::TABLE_NAME." 
                WHERE uid = {$user->id} 
                AND id = {$market->getId()}";
            $data = $sql->getAssocArray($q);
            if( $e = $sql->getLastError() ){
                RLogger::error("MarketFactory\$isOwn", $e);
            }
            
            return empty($data) ? false : true;
        }
        
        public function removeMarkets(User $user, array $markets): void{
            $ids = array_map(function($market){
                return $market->getId();
            }, $markets);
            $sql = new RSql;
            $q = "DELETE FROM ".Market::TABLE_NAME."
                WHERE uid = {$user->getId()} AND id IN (".implode(', ', $ids).")";
            $sql->query($q);
            if($e = $sql->getLastError()){
                RLogger::error("MarketFactory\$removeMarkets", $e);
            }
        }
        
    }
    
    
?>