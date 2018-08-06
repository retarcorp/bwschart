<?php

use Classes\Instruments\Instrument;
use Classes\App;
use Classes\Candle;
use Classes\Utils\Timestamp;
use Classes\Utils\JSONResponse;
use Classes\Ticks\Tick;
use Classes\Ticks\TickFactory;
use Classes\Markets\Market;
use Classes\Markets\MarketFactory;
use Classes\Users\Auth;
use Classes\Users\User;
use Classes\FootprintCache;
use Core\Classes\System\RSql;
use Core\Classes\System\RLogger;

class Handler{
    
    # @http GET /tick/
    public function getLastTick(){
        $instrument = $_GET['instrument'];
        $instrumentName = "\\Classes\\Instruments\\_".$instrument;
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        usleep(300000);
        
        $table = $instrument->getTableName(Instrument::WEEK);
        $sql = new RSql;
        
        $query = "SELECT price FROM $table ORDER BY id DESC LIMIT 1";
        $d =$sql->getArray($query);
        JSONResponse::ok($d[0][0]);
        
    }
    
    # @http GET /candles/
    public function getCandles(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        usleep(300000);
        
        $timeframe = $_GET['timeframe'];
        
        $startTS = new Timestamp(intval($_GET['start']));
        if($startTS->getTimestamp() > time()){
            JSONResponse::ok([]);
        }
        
        $end = intval($_GET['end']);
        $end = $end - $end % (App::$Timeframe[$timeframe]*60);
        if($end > time()){
            $end = time();
            $end = $end - $end%(App::$Timeframe[$timeframe]*60);
        }
        
        $endTS = new Timestamp($end);
        
        $candles = $instrument->getCandles($timeframe, $startTS, $endTS);
        $candlesInArray = [];
        
        foreach($candles as $candle){
            $candlesInArray [] = $candle->toArray();
        }
        
        $from = $startTS->getTimestamp();
        $res = ['from' => $from, "to"=>$end, 'candles' => $candlesInArray];
        RSql::destroy();
        return JSONResponse::ok($res);
    }
    
    # @http GET /candles/amount/
    public function getNCandles(){
        //$startCalcTime = microtime(true);
        
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        usleep(300000);
        
        $timeframe = $_GET['timeframe'];
        
        $startTS = new Timestamp(intval($_GET['start']));
        if($startTS->getTimestamp() > time()){
            JSONResponse::ok([]);
        }
        
        $n = intval($_GET['n']);
        
        //$endCalcTime = microtime(true);
        //$duration = $endCalcTime - $startCalcTime;
        //RLogger::warn('Estimated time from request to model', $duration);
        
        $candles = $instrument->getNCandles($timeframe, $startTS, $n);
        
        //$newstartCalcTime = microtime(true);
        
        $candles = array_map(function($candle){
            return $candle->toArray();
        }, $candles);
        
        $from = $startTS->getTimestamp();
        $res = ['from' => $from, 'n' => count($candles), 'candles' => $candles];
        
        //$newendCalcTime = microtime(true);
        //$newduration = $newendCalcTime - $newstartCalcTime;
        //RLogger::warn('Estimated time from model to response', $newduration);
        
        RSql::destroy();
        
        return JSONResponse::ok($res);
    }
    
    # @http GET /candles/test/
    public function test(){
        
        header('Content-Type: text/plain');
        
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        usleep(300000);
        
        $timeframe = $_GET['timeframe'];
        
        $startTS = new Timestamp(intval($_GET['start']));
        if($startTS->getTimestamp() > time()){
            JSONResponse::ok([]);
        }
        
        $n = intval($_GET['n']);
        $candles = $instrument->test($timeframe, $startTS, $n);
        
        $candles = array_map(function($candle){
            return $candle->toArray();
        }, $candles);
        
        $from = $startTS->getTimestamp();
        $res = ['from' => $from, 'n' => count($candles), 'candles' => $candles];
        RSql::destroy();
        return JSONResponse::ok($res);
    }
    
    # @http GET /candles/uncached/
    public function getUnCachedCandles(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $timeframe = $_GET['timeframe'];
        usleep(300000);
        
        $candles = $instrument->getUnCachedCandles($timeframe);
        $results = array_map(function($candle){
            return $candle->toArray();
        }, $candles);
        
        RSql::destroy();
        return JSONResponse::ok($results);
    }
    
    # @http GET /candle/last/
    public function getLastCandle(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $timeframe = $_GET['timeframe'];
        
        usleep(300000);
        
        $candle = $instrument->getLastCandle($timeframe);
        $result = $candle ? $candle->toArray() : [];
        
        RSql::destroy();
        return JSONResponse::ok($result);
    }
    
    # @http GET /candles/last/two/
    public function getTwoLastCandles(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $timeframe = $_GET['timeframe'];
        usleep(300000);
        
        $candles = $instrument->getTwoLastCandles($timeframe);
        
        $results = array_map(function($candle){
            return $candle->toArray();
        }, $candles);
        
        RSql::destroy();
        return JSONResponse::ok($results);
    }
    
    # @http GET /candles/delta/
    public function getDeltaCandles(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $delta = intval($_GET['delta']);
        $amount = intval($_GET['amount']);
        
        if(isset($_GET['last_start'])){
            $until = new Timestamp(intval($_GET['last_start']));
        }else{
            $until = new Timestamp(time());
        }
        
        usleep(300000);
        
        $candles = $instrument->getDeltaCandles($delta, $amount, $until);
        
        $result = [];
        foreach($candles as $candle){
            $result [] = $candle->toArray();
        }
        
        RSql::destroy();
        // return JSONResponse::ok(['amount' => count($result), 'result' => $result]);
        return JSONResponse::ok($result);
    }
    
    # @http GET /candles/delta/interval/
    public function getDeltaCandlesInInterval(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $delta = intval($_GET['delta']);
        
        $ts = intval($_GET['from']);
        $from = new Timestamp($ts);
        
        $ts = isset($_GET['to']) ? intval($_GET['to']) : time();
        $to = new Timestamp($ts);
        
        usleep(300000);
        
        $candles = $instrument->getDeltaCandles($delta, $from, $to);
        
        $candles = array_map(function($candle){
            return $candle->toArray();
        });
        
        $res = [
            'from' => $from->getTimestamp(),
            'to' => $to->getTimestamp(),
            'candles' => $candles
        ];
        
        JSONResponse::ok($res);
    }
    
    # @http GET /candles/delta/after/
    public function getReverseDeltaCandles(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $delta = intval($_GET['delta']);
        $amount = intval($_GET['amount']);
        
        if(isset($_GET['last_start'])){
            $start = intval($_GET['start']);
            $until = new Timestamp($start);
        }else{
            $until = new Timestamp(time());
        }
        
        usleep(300000);
        
        $candles = $instrument->getDeltaCandles($delta, $amount, $until, true);
        
        $result = [];
        foreach($candles as $candle){
            $result [] = $candle->toArray();
        }
        
        RSql::destroy();
        return JSONResponse::ok($result);
    }
    
    # @http GET /candles/delta/last/
    public function getLastDeltaCandle(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $delta = intval($_GET['delta']);

        usleep(300000);
        
        $candle = $instrument->getLastDeltaCandle($delta);
        RSql::destroy();
        return JSONResponse::ok($candle->toArray());
    }
    
    # @http GET /candles/delta/two-last/
    public function getTwoLastDeltaCandle(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $delta = intval($_GET['delta']);

        usleep(300000);
        
        $candles = $instrument->getTwoLastDeltaCandles($delta);
        $results = [];
        foreach($candles as $candle){
            $results [] = $candle->toArray();
        }
        RSql::destroy();
        return JSONResponse::ok($results);
    }
    
    # @http GET /ticks/
    public function getTicksInRange(){
        $instrumentName = "\\Classes\\Instruments\\_".$_GET['instrument'];
        
        if(class_exists($instrumentName)){
            $instrument = new $instrumentName;
        }else {
            JSONResponse::error('Invalid class name');
        }
        
        $min = isset($_GET['min']) ? intval($_GET['min']) : 0;
        $max = isset($_GET['max']) ? intval($_GET['max']) : 0;
        $amount = intval($_GET['amount']);
        $endTS = new Timestamp( intval($_GET['till']) );
        
        $tf = new TickFactory;
        $ticks = $tf->getTicksInRange($instrument, $endTS, $min, $max, $amount);
        return array_map(function($tick){
            return $tick->toArray();
        }, $ticks);
    }
    
    # @http GET /user/markets/
    public function getUserMarkets(){
        $user = (new Auth)->getCurrentUser();
        if( is_null($user) ){
            return JSONRespone::error("Пользователь не авторизован");
        }
        
        $mf = new MarketFactory;
        
        if( isset($_GET['delta']) ){
            $tfOrDelta = intval($_GET['delta']);
            $graph = Market::GRAPH_DELTA;
        }elseif( isset($_GET['timeframe']) ){
            $tfOrDelta = FootprintCache::getTableTimeframeFor($_GET['timeframe']);
            $graph = Market::GRAPH_FOOTPRINT;
        }
        
        $markets = $mf->getMarkets($user, $graph, $_GET['instrument'], $tfOrDelta);
        return array_map(function($e){
            return $e->toArray();
        }, $markets);
    }
    
    # @http POST /user/market/
    public function rebuidMarkets(){
        $user = (new Auth)->getCurrentUser();
        if( is_null($user) ){
            return JSONRespone::error("Пользователь не авторизован");
        }
        
        $mf = new MarketFactory;
        $data = json_decode($_POST['data'], true);
        $ids = [];
        
        foreach($data as $i => $marketInfo){
            $startTS = new Timestamp( intval($marketInfo['startTS']) );
            $endTS = new Timestamp( intval($marketInfo['endTS']) );
            $startPrice = floatval($marketInfo['startPrice']);
            $endPrice = floatval($marketInfo['endPrice']);
            
            if( isset($marketInfo['delta']) ){
                $tfOrDelta = intval($marketInfo['delta']);
                $graph = Market::GRAPH_DELTA;
            }elseif( isset($marketInfo['timeframe']) ){
                $tfOrDelta = FootprintCache::getTableTimeframeFor($marketInfo['timeframe']);
                $marketInfo['timeframe'] = $tfOrDelta;
                $graph = Market::GRAPH_FOOTPRINT;
            }
            
            $market = $mf->getMarketById( intval($marketInfo['id']) );
            if( is_null($market) ){
                $market = $mf->createMarket($user, $graph, $marketInfo['instrument'], $startTS, $endTS, $startPrice, $endPrice, $tfOrDelta);
                $ids [] = $market->getId();
            }else{
                if( !($mf->isOwn($user, $market)) ){
                    continue;
                }
                
                if( !($mf->isMarketDataEqual($market, $marketInfo)) ){
                    $marketInfo['graph'] = $graph;
                    $market->editSelf($marketInfo);
                }
            }
        }
        
        return JSONResponse::ok($ids);
    }
    
    # @http DELETE /user/market/
    public function deleteMarket(){
        $user = (new Auth)->getCurrentUser();
        if( is_null($user) ){
            return JSONRespone::error("Пользователь не авторизован");
        }
        
        $mf = new MarketFactory;
        $market = $mf->getMarketById( intval($_GET['id']) );
        if( is_null($market) ){
            return JSONResponse::error("Такого профиля рынка не существует");
        }
        
        if( $mf->isOwn($user, $market) ){
            $market->remove();
        }
        
        return JSONResponse::ok('');
    }
    
    # @http DELETE /user/markets/
    public function deleteMarkets(){
        $user = (new Auth)->getCurrentUser();
        if( is_null($user) ){
            return JSONRespone::error("Пользователь не авторизован");
        }
        
        $mf = new MarketFactory;
        $ids = $_GET['ids'];
        $markets = array_map(function($id){
            return new Market( intval($id) );
        }, $ids);
        
        $mf->removeMarkets($user, $markets);
        return JSONResponse::ok('');
    }
    
}