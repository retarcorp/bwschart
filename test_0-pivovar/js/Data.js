var test = true,
    test2 = true;

var Data = {
    
    currentTimeframe: null,
    
    currentDeltaValue: null,
    
    lastCandle: null,
    
    xhr: null,
    
    footprintGraph: 'FOOTPRINT',
    
    deltaGraph: 'DELTA',
    
    LastValue: null,
    
    rightDeltaCandle: {
        ts: null,
        index: null,
        pos: null
    },
    
    leftDeltaCandle: {
        ts: null,
        index: null
    },
    
    Nflag: false,
    
    getStartValue: function(instrument, f){
        Data.Request.get('/api/tick/?instrument=' + instrument, f);
    },
    
    getCandlesForInterval: function(obj){
        
        App.LoadGif.classList.remove('hide_modal');
        
        if(App.CurrentGraph.type === Data.footprintGraph){
            this.getCandlesForFootprintGraph(obj);
        }else{
            this.getCandlesForDeltaGraph(obj);
        }
    },
    
    deleteMarketProfile: function(id, abort) {
        //_.postJSON('/api/user/market/', {data: JSON.stringify({id: id})}, function(d){console.log(d)});
        
        var xhr = new XMLHttpRequest();
        
        xhr.open('DELETE', `/api/user/market/?id=${id}`, true);
        xhr.send();
        
        console.log("DELETE");
        
        xhr.onreadystatechange = () => {
            if (xhr.status !== 200 && xhr.readyState != 4) {
                console.log('error');
            } else {
                console.log(xhr.responseText);
                if (!abort) App.CurrentGraph.loadMarketProfile();
            }
        }
        
    },
    
    postMarketProfile: function(list) {
        
        _.postJSON('/api/user/market/', {data: JSON.stringify(list)}, () => {
            App.CurrentGraph.loadMarketProfile();
        });
        
    },
    
    getMarketProfileForDeltaGraph: function() {
        var delta = App.CurrentGraph.DELTA,
            instr = App.CurrentGraph.INSTRUMENT;
        
        console.log(delta);
        
        if (instr == 0) instr = "6E";
        
        if (test) {
             //this.postMarketProfileForFootprint();
             var xhr = new XMLHttpRequest();
             
             xhr.open('GET', `/api/user/markets/?instrument=${instr}&delta=${delta}`);
             xhr.send();
             
             xhr.onreadystatechange = () => {
                 if (xhr.status !== 200 && xhr.readyState != 4) {
                     console.log('error');
                 } else {
                     console.log(xhr.responseText);
                     App.CurrentGraph.loadMarketProfile(true, xhr.responseText);
                }
             }
             //Data.Request.get(`/api/user/markets?instrument=${instr}&timeframe=${tmfr}`, false, false);
        }
        
        //_.postJSON('/api/user/market/', {data: JSON.stringify(data)}, function(d){console.log(d)});
        
        //var data = Data.Request.get(`/api/user/markets?instrument=${instr}&timeframe=${tmfr}`, false, false);
        
        //console.log(data);
    },
    
    getMarketProfileForFootprintGraph: function() {
        var tmfr = App.CurrentGraph.GraphSettings.TIMEFRAME,
            instr = App.CurrentGraph.INSTRUMENT;
        
        if (instr == 0) instr = "6E";
        
        if (test) {
             //this.postMarketProfileForFootprint();
             var xhr = new XMLHttpRequest();
             
             xhr.open('GET', `/api/user/markets/?instrument=${instr}&timeframe=${tmfr}`);
             xhr.send();
             
             console.log(`/api/user/markets/?instrument=${instr}&timeframe=${tmfr}`);
             
             xhr.onreadystatechange = () => {
                 if (xhr.status !== 200) {
                     console.log('error');
                 } else {
                     App.CurrentGraph.loadMarketProfile(true, xhr.responseText);
                }
             }
             //Data.Request.get(`/api/user/markets?instrument=${instr}&timeframe=${tmfr}`, false, false);
        }
        
        //_.postJSON('/api/user/market/', {data: JSON.stringify(data)}, function(d){console.log(d)});
        
        //var data = Data.Request.get(`/api/user/markets?instrument=${instr}&timeframe=${tmfr}`, false, false);
        
        //console.log(data);
    },
    
    getCandlesForFootprintGraph: function(obj){
        var start_ts = obj.start_ts,
            duration = obj.duration,
            timeframe = obj.timeframe,
            instrument = obj.instrument,
            price_tick_step = obj.price_tick_step,
            lastCandleVisible = obj.lastCandleVisible,
            f = obj.f,
            holidays = obj.holidays,
            isHolidaysCome = obj.isHolidaysCome;
        // для запроса на сервер
        
        var start = Math.floor((start_ts - timeframe.ts)/1000);
        var end = Math.floor((start_ts + duration)/1000);
        
        console.log(holidays);
        
        if (isHolidaysCome) {
            start -= (holidays)/1000;
        }
        // console.log(start*1000, end*1000, new Date(start*1000), new Date(end*1000))
        
        this.currentTimeframe = timeframe;
        this.currentPriceTickStep = price_tick_step;
        
        var flagForInterval = Data.Cache.containsInterval(start_ts, duration);
        
        if((!lastCandleVisible && !flagForInterval) || (lastCandleVisible && !flagForInterval)){
            //загрузка всего отрезка
            // console.warn('загружаем отрезок');
            Data.Request.get(
                '/api/candles/' + '?start=' + start + 
                '&end=' + end + 
                '&timeframe=' + timeframe.val + 
                '&instrument=' + instrument
                , f, false);
        }else if(lastCandleVisible && flagForInterval){
            //загрузка только последней свечи
            // console.warn('загружаем последнюю свечу');
            App.LoadGif.classList.add('hide_modal');
            Data.Request.get(
                '/api/candle/last/?timeframe=' + timeframe.val + 
                '&instrument=' + instrument
                , f, true);
        }else {
            // console.error('ниделаем ничего')
            Graph.requestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
            setTimeout(function(){
               f(true);
            }, 300);
        }
    },
    
    getCandlesForDeltaGraph: function(obj){
        var delta = obj.delta,
            instrument = obj.instrument,
            amount = 10,//obj.amount,
            last_start = 0,//obj.last_start/1000, //- необязательный 
            index = obj.candle_index,
            // pos = obj.position,
            f = obj.f;
        this.currentDeltaValue = delta;
        if(App.CurrentGraph.flagForStartPrice){
            // console.log('FIRST')
            amount = 10;
            Data.Request.get(
                '/api/candles/delta/?instrument=' + instrument + 
                '&delta=' + delta + 
                '&amount=' + amount, f, false
            );
            
        }
        else{
            var num = Math.ceil(App.CurrentGraph.GraphSettings.HEIGHT/App.CurrentGraph.GraphSettings.TIME_STEP);
            if(index <= Data.leftDeltaCandle.index/*Data.Cache.Candles[pos - 1] === undefined && (Data.Cache.Candles[pos] !== undefined)*/){
                // console.log('THIRD')
                amount = 40;
                last_start = Data.leftDeltaCandle.ts/1000;
                Data.Request.get(
                    '/api/candles/delta/?instrument=' + instrument + 
                    '&delta=' + delta + 
                    '&amount=' + amount + '&last_start=' + last_start, f, false
                );
            }
            else if(index + num >= Data.rightDeltaCandle.index){
                // console.log('SECOND')
                // /api/candles/delta/last/?instrument=&delta=
                if(Data.Nflag) {
                    // console.log(1,Data.Nflag)
                    amount = 5;
                    Data.Request.get(
                        '/api/candles/delta/?instrument=' + instrument + 
                        '&delta=' + delta + 
                        '&amount=' + amount, f, false
                    );
                    Data.Nflag = false;
                }else {
                    // console.log(2,Data.Nflag)
                    Data.Request.get(
                        '/api/candles/delta/last/?instrument=' + instrument + 
                        '&delta=' + delta, f, true
                    );
                }
            } 
            else {
                Graph.requestInProcess = false;
                App.LoadGif.classList.add('hide_modal');
                
            }
        }
    },
    
    // пространство имен для работы с запросами к серверу
    Request: {
        
        onXHRChanged: function(){
            if(Data.xhr !== null){
                Data.xhr.abort();
            }
            Data.Cache.Candles = [];
            Data.lastCandle = null;
            Graph.requestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
        },
        
        get: function(url, f, isForLastCandleFlag){
            Data.xhr = new XMLHttpRequest();
            var xhr = Data.xhr;
            xhr.open('GET', url);
            xhr.send();
            xhr.onload = function () {
                if (xhr.status === 200) {
                    Data.Request.parseData(xhr.response, f, isForLastCandleFlag);
                    
                } else {
                    alert( xhr.status + ': ' + xhr.statusText );
                }
            };
            xhr.onerror = function () {
                alert( xhr.status + ': ' + xhr.statusText );
            };
        },
        
        parseData: function(response, f, isForLastCandleFlag){
            if(isForLastCandleFlag === undefined){
                this.parseLastValue(response, f);
            }
            else if(App.CurrentGraph.type === Data.footprintGraph){
                this.parseCandlesForFootprintGraph(response, f, isForLastCandleFlag);
            }else{
                this.parseCandlesForDeltaGraph(response, f, isForLastCandleFlag);
            }
        },
        
        parseCandlesForFootprintGraph: function(resp, f, isForLastCandleFlag){
            var candles=[];
            if(isForLastCandleFlag){
                try{
                    var cndl = JSON.parse(resp).data;
                    var from = new Date(cndl.startTS).getTime() * 1000;
                    var finished = false;
                    var candle = new FootprintCandle(cndl.start_price, cndl.last_price, from, Data.currentTimeframe.val, finished, 
                        cndl.volume, cndl.deltaShadow);
                    var tick_max_price = cndl.tick_max_price;
                    if(cndl.start_price === null || cndl.start_price === 0){}
                    else{
                        cndl.ticks.forEach(function(tick, i){
                            candle.addTick(tick[0], tick[1], tick[2]);
                        });
                        
                        App.CurrentGraph.currentPrice.y = candle.last_price;
                        
                        if(Data.lastCandle === null || Data.lastCandle.from !== candle.from){
                            Data.lastCandle = candle;
                            
                            App.CurrentGraph.flagForNewCandle = true;
                        }
                        candles.push(candle);
                    }
                }catch(e){
                    // console.log('пустая свеча');
                }
            }else{
                JSON.parse(resp).data.candles.forEach(function(cndl){
                    // console.log(new Date(cndl.startTS))
                    var from = new Date(cndl.startTS).getTime() * 1000;
                    var finished = (cndl.finished === "true")? true : false;
                    var candle = new FootprintCandle(cndl.start_price, cndl.last_price, from, Data.currentTimeframe.val, finished, 
                    cndl.volume, cndl.deltaShadow);
                    var tick_max_price = cndl.tick_max_price;
                    cndl.ticks.forEach(function(tick, i){
                        candle.addTick(tick[0], tick[1], tick[2]);
                    });
                    
                    if (new Date(candle.from).getDay() == 0) {
                        App.CurrentGraph.isHolidaysCome = true;
                        console.log('bomsss');
                    }
                
                console.log(new Date(candle.from).getDay());
                
                    candles.push(candle);
                })
                
                if (App.CurrentGraph.isHolidaysCome)
                    console.log(JSON.parse(resp).data.candles);
            }
            Data.Cache.save(candles);
            Graph.requestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
            if(typeof f == "function"){
                f(true);
            }
        },
        
        parseCandlesForDeltaGraph: function(resp, f, isForLastCandleFlag){
            
            var candles=[];
            var fl = '';
            if(isForLastCandleFlag){
                try{
                    fl = 'lastC';
                    var candle = JSON.parse(resp).data;
                    var startTS = new Date(candle.startTS).getTime() * 1000;
                    var endTS = new Date(candle.endTS).getTime() * 1000;
                    var finished = false;
                    var last = 'last';
                    var cndl = new DeltaCandle(candle.start_price, candle.last_price, candle.volume, candle.realDelta, startTS, endTS, finished, candle.deltaShadow, last/*, index*/);
                    var tick_max_price = candle.tick_max_price;
                        // index--;
                    candle.ticks.forEach(function(tick, i){
                        cndl.addTick(tick[0], tick[1], tick[2]);
                    });
                    
                    App.CurrentGraph.currentPrice.y = cndl.last_price;
                    
                    if (App.CurrentGraph.lastDeltaCandle === null || App.CurrentGraph.lastDeltaCandle.startTS !== cndl.startTS) {
                        App.CurrentGraph.lastDeltaCandle = cndl;
                        
                        console.log(cndl);
                            
                        App.CurrentGraph.flagForNewCandle = true;
                    }
                    
                    candles.push(cndl);
                }catch(e){
                    console.log(e); 
                }
            }else{
                try{
                    fl = 'nolastC';
                    JSON.parse(resp).data.forEach(function(candle){
                        var startTS = new Date(candle.startTS).getTime() * 1000;
                        var endTS = new Date(candle.endTS).getTime() * 1000;
                        var finished = candle.finished === "true";
                            var cndl = new DeltaCandle(candle.start_price, candle.last_price, candle.volume, candle.realDelta, startTS, endTS, finished, candle.deltaShadow/*, index*/);
                            var tick_max_price = candle.tick_max_price;
                            // index--;
                            candle.ticks.forEach(function(tick, i){
                                cndl.addTick(tick[0], tick[1], tick[2]);
                            });
                            candles.push(cndl);
                        // }
                    });
                }catch(e){
                    console.log(e); 
                }
            }
            Data.Cache.saveDelta(candles, fl);
            Graph.requestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
            if(typeof f == "function"){
                f(true);
            }
        },
        
        parseLastValue: function(response, f){
            try{
                var obj = JSON.parse(response).data;
                Data.LastValue = {
                    price: 1 * obj.price,
                    date: 1 * obj.date// - App.TimezoneOffset
                }
                // Data.LastValue = JSON.parse(response).data;
                Graph.requestInProcess = false;
                App.CurrentGraph.flagForStartPrice = true;
                App.LoadGif.classList.add('hide_modal');
                if(typeof f == "function"){
                    f(true);
                }
            }
            catch(e){
                console.error(e);
            }
        }
    },
    
     Cache:{
        //проверяет на наличие пробелов в кеше на заданном промежутке
        //true - содержит пробелы  / false - не содержит
        containEmptySegment: function(start_ts, duration){
            var end = start_ts + duration;
            var segment = Data.Cache.get(start_ts, duration);
            var timeframe_ts = Data.currentTimeframe.ts;
            var len = segment.length;
            
            for(var i = 0; i < len - 1; i++){
                if((segment[i+1].from - segment[i].from) > timeframe_ts){
                    //console.log(segment[i+1].from - segment[i].from, timeframe_ts);
                    return true;
                }
            }
            
            var cacheBorder = (Data.Cache.Candles.length !== 0)? Data.Cache.Candles[Data.Cache.Candles.length - 1].from : 0;
            
            if(end - cacheBorder > 0 && Date.now() > end){
                return true;
            }
            return false;
        },
        
        //проверяет, есть ли участок в кеше полностью и без пробелов
        containsInterval: function(start_ts, duration){
            //console.log('containsInterval: ', start_ts, duration);
            var end = start_ts + duration;
            // 1 - если кеш не пустой
            // 2 - крайняя левая свеча(первая в кеше) меньше\равна старту
            // 3 - крайняя правая лежит либо после(по времени) правой границы, либо до, но все равно должна быть отрисована
            //так как часть ее находится после правой границы, а начало до || если еще не может быть свечек в том промежутке
            // 4 - если нет пробелов в таком интервале
            if(Data.Cache.Candles.length !== 0 
            && start_ts >= Data.Cache.Candles[0].from 
            && (end <= (Data.Cache.Candles[Data.Cache.Candles.length - 1].from + Data.currentTimeframe.ts) || Date.now() < end)
            && !Data.Cache.containEmptySegment(start_ts, duration)){
                return true;
            }else{
                return false;
            }
        },
        
        get: function(start_ts, duration){
            //console.log('getfromCache');
            var response=[];
            var end = start_ts + duration;
            Data.Cache.Candles.forEach(function(elem){
                // if(elem.from >= start_ts - Data.currentTimeframe.ts && elem.from <= end){
                    response.push(elem);
                // }
            });
            return response;
        },
        
        //Сохраняет без повторов, и последняя свеча обновляется. Если пришла уже завершенная, то в кеше это отмечается
        save: function(_candles){
            var l = Data.Cache.Candles.length;
            var flag = true;
            _candles = _candles.filter(function(elem){
                flag = true;
                for(var i = 0; i < l; i++){
                    if (elem.from === Data.Cache.Candles[i].from){
                        if(Data.Cache.Candles[i].finished === false){
                            Data.Cache.Candles[i] = elem;
                        }
                        flag = false;
                        break;
                    }
                }
                return flag;
            });
            _candles.forEach(function(e){
                Data.Cache.Candles.push(e);
            }); 
            Data.Cache.Candles.sort(function(a,b){
                return a.from-b.from;
            });
            // проверка на завершение свечки
            if(Data.Cache.Candles[Data.Cache.Candles.length - 2] !== undefined && Data.Cache.Candles[Data.Cache.Candles.length - 2].finished !== true){
                Data.Cache.Candles[Data.Cache.Candles.length - 2].finished = true;
            }
        },
        
        saveDelta: function(_candles, fl){
            var gs = App.CurrentGraph.GraphSettings;
            var length = Data.Cache.Candles.length;
            var flag = true;
            if(fl === 'nolastC'){
                _candles = _candles.filter(function(elem){
                    flag = true;
                    for(var i = 0; i < length; i++){
                        if (elem.startTS === Data.Cache.Candles[i].startTS &&
                            elem.endTS === Data.Cache.Candles[i].endTS &&
                            elem.finished === Data.Cache.Candles[i].finished &&
                            elem.last_price === Data.Cache.Candles[i].last_price &&
                            elem.realDelta === Data.Cache.Candles[i].realDelta &&
                            elem.start_price === Data.Cache.Candles[i].start_price &&
                            elem.tick_max_price === Data.Cache.Candles[i].tick_max_price
                            ){
                                // if(Data.Cache.Candles[i].finished === false && elem.finished === true){
                                //     Data.Cache.Candles[i] = elem;
                                // }
                                // if(Data.Cache.Candles[i].finished === false){
                                //     Data.Cache.Candles[i] = elem;
                                // }
                                flag = false;
                                break;
                        }
                    }
                    return flag;
                });
                
                _candles.forEach(function(e){
                    Data.Cache.Candles.push(e);
                }); 
                
                Data.Cache.Candles.sort(function(a,b){
                    return a.startTS - b.startTS;
                });
                // console.log(Data.Cache.Candles)
                length = Data.Cache.Candles.length;
                
                if(App.CurrentGraph.flagForStartPrice){
                    var j = -(length - 1);
                    for(var i = 0; i < length ; i++){
                        Data.Cache.Candles[i].index = j;
                        j++;
                    }
                }
                else{
                    if(Data.Cache.Candles[0].index === undefined){
                        var index = Data.leftDeltaCandle.index;
                        var pos = 0;
                        for(var i = 0; i < length; i++){
                            if(Data.Cache.Candles[i].index !== undefined){
                                pos = i - 1;
                                break;
                            }
                        }
                        for(var i = pos; i >=0; i--){
                            Data.Cache.Candles[i].index = --index;
                        }
                    }
                    if(Data.Cache.Candles[length - 1].index === undefined){
                        var p = Data.rightDeltaCandle.pos,
                            index = Data.rightDeltaCandle.index,
                            length = Data.Cache.Candles.length;
                        var pos = 0;
                        for(var i = p; i < length; i++){
                            if(Data.Cache.Candles[i].index === undefined){
                                pos = i;
                                break;
                            }
                        }
                        for(var i = pos; i < length; i++){
                            Data.Cache.Candles[i].index = ++index;
                        }
                    }
                }
                
            // console.log(Data.Cache.Candles)
                length = Data.Cache.Candles.length;
                Data.rightDeltaCandle = {
                    ts: Data.Cache.Candles[length-1].startTS,
                    index: Data.Cache.Candles[length-1].index,
                    pos: length-1
                }
                Data.leftDeltaCandle = {
                    ts: Data.Cache.Candles[0].startTS,
                    index: Data.Cache.Candles[0].index
                }
                
                console.log(gs.tsToTime(Data.Cache.Candles[length-1].startTS));
            }
            else if(fl === 'lastC'){
                var l = Data.Cache.Candles.length;
                
                if(_candles[0].startTS !== Data.Cache.Candles[l-1].startTS){
                    console.log(_candles[0].startTS, Data.Cache.Candles[l-1].startTS)
                    _candles[0].index = Data.Cache.Candles[l-1].index+1;
                    Data.Cache.Candles[l] = _candles[0];
                } else {
                    
                    Data.Cache.Candles[l-1] = _candles[0];
      
                }

            }
            // console.warn(Data.rightDeltaCandle, Data.leftDeltaCandle, Data.Cache.Candles)
                
            // проверка на завершение свечки
            if(Data.Cache.Candles[Data.Cache.Candles.length - 2] !== undefined && Data.Cache.Candles[Data.Cache.Candles.length - 2].finished !== true){
                Data.Cache.Candles[Data.Cache.Candles.length - 2].finished = true;
            }
            
        },
        
        //объект данных кеша
        Candles : []
    },
    
    LocalStorage: {
        save: function(_case, obj){
            var sObj = JSON.stringify(obj);
            localStorage.setItem(_case, sObj);
        },
        
        get: function(_case){
            return JSON.parse(localStorage.getItem(_case));
        },
        
        remove: function(_case){
            localStorage.removeItem(_case);
        }
    }
}

var Candle = function(){};

Candle.prototype = {
    constructor: Candle,
    
    addTick: function (bid, ask, price) {
        this.ticks.push(new Tick(ask, bid, price));
    },

    getVolume: function () {
        return this.volume;
    },
    
    getTicks: function () {
        var t = this;
        if(t.ticks.length !== 0){
            var max = this.ticks[0].getVolume();
            t.ticks.forEach(function (e) {
                var tmp = e.getVolume();
                max = (tmp > max) ? tmp : max;
            });
            return t.ticks.map(function (e) {
                e.length = e.getVolume() / max;
                if (e.length === 1) {
                    e.isMain = true;
                }
                return e;
            });
        }
    }
};

var DeltaCandle = function(start_price, last_price, volume, realDelta, startTS, endTS, finished, deltaShadow, last/*, index*/){
    this.start_price = start_price;
    this.last_price = last_price;
    this.volume = volume;
    this.realDelta = realDelta;
    this.startTS = startTS;
    this.endTS = endTS;
    this.finished = finished;
    this.deltaShadow = deltaShadow;
    this.last = (last !== undefined) ? last : 'nolast';
    this.ticks = [];
    // this.index = index;
}

DeltaCandle.prototype = Object.create(Candle.prototype);
DeltaCandle.prototype.constructor = DeltaCandle;

var FootprintCandle = function (start_price, last_price, from, timeframe, finished, volume, deltaShadow) {
    this.start_price = start_price;
    this.last_price = last_price;
    this.from = from;
    this.timeframe = timeframe;
    this.finished = finished;
    this.volume = volume;
    this.deltaShadow = deltaShadow;
    this.ticks = [];
};

FootprintCandle.prototype = Object.create(Candle.prototype);
FootprintCandle.prototype.constructor = FootprintCandle;

var Tick = function (ask, bid, price) {
    this.ask = ask;
    this.bid = bid;
    this.price = price;
    this.isMain = false;
    this.dir = (this.ask > this.bid) ? Tick.Dir.DIR_MINUS : Tick.Dir.DIR_PLUS;
    this.length = 0;
};

Tick.Dir = {
    DIR_PLUS: 1
    , DIR_MINUS: 2
};

Tick.prototype = {
    constructor: Tick
    , getVolume: function () {
        return this.ask + this.bid;
    }
};