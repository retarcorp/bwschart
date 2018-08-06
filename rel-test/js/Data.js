var testT = 0;

var Data = {
    
    currentTimeframe: null,
    
    currentDeltaValue: null,
    
    lastCandle: null,
    
    cycleObject: null,
    
    lastDelta: null,
    
    lastABI: null,
    
    xhr: null,
    
    footprintGraph: 'FOOTPRINT',
    
    deltaGraph: 'DELTA',
    
    orderGraph: 'ORDER TAPE',
    
    FlagForOrderChange: false,
    
    changeGraph: false,
    
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
    
    rightOrderCandle: {
        secs: null,
        id: null,
        pos: null
    },
    
    leftOrderCandle: {
        secs: null,
        id: null
    },
    
    prelastOrderCandle: {
        secs: null,
        id: null,
        pos: null
    },
    
    getStartValue: function(instrument, f){
        Data.Request.get('/api/tick/?instrument=' + instrument, f);
    },
    
    getCandlesForInterval: function(obj){
        
        App.LoadGif.classList.remove('hide_modal');
        if(App.CurrentGraph.type === Data.footprintGraph){
            this.getCandlesForFootprintGraph(obj);
        }else if(App.CurrentGraph.type === Data.deltaGraph){
            this.getCandlesForDeltaGraph(obj);
        }else if(App.CurrentGraph.type === Data.orderGraph){
            this.getCandlesForOrderGraph(obj);
        }
    },
    
    getCandlesForOrderGraph: function(obj) {
        var id = obj.id,
            amount = 200,
            f = obj.f,
            instrument = obj.instrument,
            till = Math.ceil(Date.now()/1000);
            
            
        if(App.CurrentGraph.flagForStartPrice){
            if(Ui.FormFlag === 0){
                Data.Request.get(
                    '/api/ticks/?instrument=' + instrument + 
                    '&till=' + till + 
                    '&amount=' + 300, f, false, false
                );
            }
            else if(Ui.FormFlag === 1){
                var min = Ui.FormVal.Min;
                Data.Request.get(
                    '/api/ticks/?instrument=' + instrument +
                    '&till=' + till + 
                    '&amount=' + amount + '&min=' + min, f, false, true
                );
                
            } 
            else if(Ui.FormFlag === 2){
                var min = Ui.FormVal.Min;
                    max = Ui.FormVal.Max;
                Data.Request.get(
                    '/api/ticks/?instrument=' + instrument +
                    '&till=' + till + 
                    '&amount=' + amount + '&min=' + min + '&max=' + max, f, false, true
                );
            }
            else if(Ui.FormFlag === 3){
                var max = Ui.FormVal.Max;
                Data.Request.get(
                    '/api/ticks/?instrument=' + instrument +
                    '&till=' + till + 
                    '&amount=' + amount + '&max=' + max, f, false, true
                );
            }
        }
        else{
            var gs = App.CurrentGraph.GraphSettings;
            var num = Math.ceil(gs.WIDTH/gs.FIXED_TIME_STEP*5);
            if(App.CurrentGraph.IsZoomBorderCrossing){
                num*=4;
            }
            if(gs.IS_TIME_ZOOM_BORDER){
                num*=4;
            }
            
            if(id <= Data.leftOrderCandle.id){
                till = Data.leftOrderCandle.secs;
                if(Ui.FormFlag === 0){
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount, f, false, false
                    );
                }
                else if(Ui.FormFlag === 1){
                    var min = Ui.FormVal.Min;
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount + '&min=' + min, f, false, true
                    );
                }
                else if(Ui.FormFlag === 2){
                    var min = Ui.FormVal.Min;
                        max = Ui.FormVal.Max;
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount + '&min=' + min + '&max=' + max, f, false, true
                    );
                }
                else if(Ui.FormFlag === 3){
                    var max = Ui.FormVal.Max;
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount + '&max=' + max, f, false, true
                    );
                }
            }
            else if(id + num >= Data.rightOrderCandle.id){
                till = Math.ceil((Data.rightOrderCandle.secs + 60))
                // till = Math.ceil(Date.now()/1000);
                amount = 10;
                if(Ui.FormFlag === 0){
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount, f, false, false
                    );
                }
                else if(Ui.FormFlag === 1){
                    var min = Ui.FormVal.Min;
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount + '&min=' + min, f, false, true
                    );
                }
                else if(Ui.FormFlag === 2){
                    var min = Ui.FormVal.Min;
                        max = Ui.FormVal.Max;
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount + '&min=' + min + '&max=' + max, f, false, true
                    );
                }
                else if(Ui.FormFlag === 3){
                    var max = Ui.FormVal.Max;
                    Data.Request.get(
                        '/api/ticks/?instrument=' + instrument +
                        '&till=' + till + 
                        '&amount=' + amount + '&max=' + max, f, false, true
                    );
                }
            
            } 
            else {
                Graph.requestInProcess = false;
                App.LoadGif.classList.add('hide_modal');
                
            }
        }
        
    },
    
    deleteMarketProfile: function(id, abort) {
        //_.postJSON('/api/user/market/', {data: JSON.stringify({id: id})}, function(d){console.log(d)});
        
        var xhr = new XMLHttpRequest();
        
        xhr.open('DELETE', `/api/user/market/?id=${id}`, true);
        xhr.send();
         
        xhr.onreadystatechange = () => {
            if (xhr.status !== 200 && xhr.readyState != 4) {
                console.log('error');
            } else {
                if (!abort) App.CurrentGraph.loadMarketProfile();
            }
        }
        
    },
    
    postMarketProfile: function(list) {
        
        _.postJSON('/api/user/market/', {data: JSON.stringify(list)}, (data) => {
            console.log(data)
            App.CurrentGraph.loadMarketProfile();
        });
        
    },
    
    getMarketProfileForDeltaGraph: function() {
        var delta = App.CurrentGraph.DELTA,
            instr = App.CurrentGraph.INSTRUMENT;
        
        if (instr == 0) instr = "6E";
        
         //this.postMarketProfileForFootprint();
         var xhr = new XMLHttpRequest();
         
         xhr.open('GET', `/api/user/markets/?instrument=${instr}&delta=${delta}`);
         xhr.send();
         
         xhr.onreadystatechange = () => {
             if (xhr.status !== 200 && xhr.readyState != 4) {
             } else {
                 App.CurrentGraph.loadMarketProfile(true, xhr.responseText);
            }
         }
    },
    
    getMarketProfileForFootprintGraph: function() {
        var tmfr = App.CurrentGraph.GraphSettings.TIMEFRAME,
            instr = App.CurrentGraph.INSTRUMENT;
        
        if (instr == 0) instr = "6E";
        
         //this.postMarketProfileForFootprint();
         var xhr = new XMLHttpRequest();
         
         xhr.open('GET', `/api/user/markets/?instrument=${instr}&timeframe=${tmfr}`);
         xhr.send();
         
         xhr.onreadystatechange = () => {
             if (xhr.status !== 200) {
                 console.log('error');
             } else {
                 App.CurrentGraph.loadMarketProfile(true, xhr.responseText);
            }
         }
             //Data.Request.get(`/api/user/markets?instrument=${instr}&timeframe=${tmfr}`, false, false);
        
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
            f = obj.f;
            
        this.cycleObject = obj;
        // для запроса на сервер
        var start = Math.floor((start_ts - timeframe.ts)/1000);
        var end = Math.floor((start_ts + duration)/1000); 
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
            
            // let from = (new Date().getTime() - 2 * timeframe.ts)/1000;
            // let to = (new Date().getTime() + 2*timeframe.ts)/1000;
            
            App.LoadGif.classList.add('hide_modal');
            
            // Data.Request.get(
            //     '/api/candles/' + '?start=' + from + 
            //     '&end=' + to + 
            //     '&timeframe=' + timeframe.val + 
            //     '&instrument=' + instrument
            //     , f, false);
            
            Data.Request.get(
                '/api/candles/uncached/?timeframe=' + timeframe.val + 
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
            amount = 40,//obj.amount,
            last_start = 0,//obj.last_start/1000, //- необязательный 
            index = obj.candle_index,
            // pos = obj.position,
            f = obj.f;
            switch(delta){
                case 100: amount = 40; break;
                case 300: amount = 30; break;
                case 500: amount = 15; break;
                case 1000: amount = 10; break;
            }
        this.currentDeltaValue = delta;
        if(App.CurrentGraph.flagForStartPrice){
            // console.log('FIRST')
            Data.Request.get(
                '/api/candles/delta/?instrument=' + instrument + 
                '&delta=' + delta + 
                '&amount=' + amount, f, false
            );
            
            
            
        }
        else{
            var num = Math.ceil(App.CurrentGraph.GraphSettings.WIDTH/App.CurrentGraph.GraphSettings.TIME_STEP);
            if(index <= Data.leftDeltaCandle.index/*Data.Cache.Candles[pos - 1] === undefined && (Data.Cache.Candles[pos] !== undefined)*/){
                // console.log('THIRD')
                last_start = Data.leftDeltaCandle.ts/1000;
                Data.Request.get(
                    '/api/candles/delta/?instrument=' + instrument + 
                    '&delta=' + delta + 
                    '&amount=' + amount + '&last_start=' + last_start, f, false
                );
            }
            else if(index + num >= Data.rightDeltaCandle.index){
                Data.Request.get(
                    '/api/candles/delta/two-last/?instrument=' + instrument + 
                    '&delta=' + delta, f, true
                );
            
            } 
            else {
                Graph.requestInProcess = false;
                App.LoadGif.classList.add('hide_modal');
                
            }
        }
        
        // Data.Request.get(
        //     '/api/candles/delta/two-last/?instrument=' + instrument + 
        //     '&delta=' + delta, f, true
        // );

    },
    
    // пространство имен для работы с запросами к серверу
    Request: {
        
        onXHRChanged: function(){
            if(Data.xhr !== null){
                Data.xhr.abort();
            }
            Data.Cache.Candles = [];
            Data.lastCandle = null;
            Data.changeGraph = true;
            Graph.requestInProcess = false;
            App.LoadGif.classList.add('hide_modal');

        },
        
        get: function(url, f, isForLastCandleFlag, orderFlag){
            Data.xhr = new XMLHttpRequest();
            
            GlobalTime = new Date();
            
//            console.log(url);
            
            var xhr = Data.xhr;
            xhr.open('GET', url, true);
            xhr.send();
            
            //console.log('Запрос на сервер сделан. Время: ', new Date(), '\n Задержка: ', GlobalTime.getTime() - new Date().getTime(), '\n');
            
            xhr.onload = function () {
                if (xhr.status === 200) {
                    if(orderFlag === undefined) {
                        Data.Request.parseData(xhr.response, f, isForLastCandleFlag);
                    }
                    else {
                        Data.Request.parseData(xhr.response, f, isForLastCandleFlag, orderFlag);
                    }
                    
                    //console.log('Сервер дал ответ. Время: ', new Date(), '\n Задержка: ', GlobalTime.getTime() - new Date().getTime(), '\n');
                } else {
                    alert( xhr.status + ': ' + xhr.statusText );
                }
            };
            xhr.onerror = function () {
                alert( xhr.status + ': ' + xhr.statusText );
            };
        },
        
        parseData: function(response, f, isForLastCandleFlag, orderFlag){

            if(isForLastCandleFlag === undefined){
                this.parseLastValue(response, f);
            }
            else if(App.CurrentGraph.type === Data.footprintGraph){
                this.parseCandlesForFootprintGraph(response, f, isForLastCandleFlag);
            }
            else if(App.CurrentGraph.type === Data.orderGraph){
                this.parseCandlesForOrderTapeGraph(response, f, isForLastCandleFlag, orderFlag);
            }
            else{
                this.parseCandlesForDeltaGraph(response, f, isForLastCandleFlag);
            }
        },
        
        parseCandlesForFootprintGraph: function(resp, f, isForLastCandleFlag){
            var candles=[],
                gs = App.CurrentGraph.GraphSettings;
            if(isForLastCandleFlag){
                try{
                    var cndl = JSON.parse(resp).data,
                        first = null,
                        last = null,
                        fFrom = 0,
                        lFrom = 0;
                    
                    if (cndl.length > 1) {
                        first = (cndl[0].startTS < cndl[1].startTS) ? cndl[0] : cndl[1];
                        last = (cndl[0].startTS > cndl[1].startTS) ? cndl[0] : cndl[1];
                        
                        fFrom = new Date(first.startTS).getTime() * 1000;
                        lFrom = new Date(last.startTS).getTime() * 1000;
                        
                    } else {
                        first = cndl[0];
                        
                        fFrom = new Date(first.startTS).getTime() * 1000;
                    }
                    
                    // var from = new Date(cndl.startTS).getTime() * 1000;
                    
                    var finished = false;
                    
                    var fCandle = new FootprintCandle(first.start_price, first.last_price, fFrom, Data.currentTimeframe.val, finished, 
                        first.volume, first.deltaShadow);
                        
                    if (last) {
                        
                        var lCandle = new FootprintCandle(last.start_price, last.last_price, lFrom, Data.currentTimeframe.val, finished, last.volume, last.deltaShadow);
                        
                        // var sP = last.ticks[0][2],
                        //     lP = last.ticks[0][2];
                        
                        last.ticks.forEach(function(tick, i){
                            lCandle.addTick(tick[0], tick[1], tick[2]);
                            
                            // if (sP > tick[2]) sP = tick[2];
                            // if (lp < tick[2]) lP = tick[2];
                        });
                        
                        // for (sP; sP < lP; sP += gs.PRICE_TICK_STEP) {
                        //     if (!last.ticks.find ( (tick) => tick[2] == sP )) {
                        //         lCandle.addTick(0, 0, sP);
                                
                        //         console.log(lCandle.ticks);
                        //     }
                        // }
                        
                        //console.log('FIRST: ',  firtst, gs.tsToTime(fCandle.from), '\n LAST: ', last, gs.tsToTime(lCandle.from));
                        
                        candles.push(lCandle);
                        
                    }
            
                    var sP = (fCandle.start_price < fCandle.last_price) ? fCandle.start_price : fCandle.last_price,
                        lP = (fCandle.start_price > fCandle.last_price) ? fCandle.start_price : fCandle.last_price;
                    
                    first.ticks.forEach(function(tick, i){
                        fCandle.addTick(tick[0], tick[1], tick[2]);
                        
                        // if (sP > tick[2]) sP = tick[2];
                        // if (lp < tick[2]) lP = tick[2];
                    });
                    
                    for (var r = sP; r < lP; r += gs.PRICE_TICK_STEP) {
                        if (!first.ticks.find ( (tick) => tick[2] == parseFloat(r.toFixed(8)) )) {
                            fCandle.addTick(0, 0, r);
                        }
                    }
                    
                    if (!last) {
                        
                        if (fCandle.last_price != 0) {
                            App.CurrentGraph.currentPrice.y = fCandle.last_price;
                            App.CurrentGraph.currentPriceLine.y = fCandle.last_price;
                            
                            if(Data.lastCandle === null || Data.lastCandle.from !== fCandle.from){
                                
                                Data.lastCandle = fCandle;
                                
                                App.CurrentGraph.flagForNewCandle = true;
                            } 
                        }
                        
                    }
                    
                    candles.push(fCandle);
                    
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
                    
                    cndl.ticks.sort( (tickA, tickB) => tickB[2] - tickA[2]);
        
                    if (cndl.ticks.length) {
                        var lP = cndl.ticks[0][2],
                            sP = cndl.ticks[cndl.ticks.length-1][2];
                        
                        cndl.ticks.forEach(function(tick, i){
                            candle.addTick(tick[0], tick[1], tick[2]);
                        });
                        
                        for (var r = sP; r < lP; r += gs.PRICE_TICK_STEP) {
                            if (!candle.ticks.find ( (tick) =>  tick.price == parseFloat(r.toFixed(8)))) {
                                candle.addTick(0, 0, r);
                                
//                                console.log(gs.tsToTime(candle.from));
                            }
                        }
                        
                        // if (cndl.volume == 0) {
                        //     setTimeout( () => {
                        //         Data.getCandlesForFootprintGraph(Data.cycleObject);
                        //         console.log('cycle');
                        //     }, 2000);
                        // }
                        
                        candles.push(candle); 
                    }
                    
                })
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
                    
                    var lastCandle = null;
                    var st = 0;
                    
                    JSON.parse(resp).data.forEach( (elem) => {
                        if (elem.startTS >= st) lastCandle = elem;
                        
                        st = lastCandle.startTS;
                    });
                    
                    App.CurrentGraph.currentPriceLine.y = lastCandle.last_price;
                    App.CurrentGraph.currentPrice.y = lastCandle.last_price;
                    
                    if (App.CurrentGraph.lastDeltaCandle === null || App.CurrentGraph.lastDeltaCandle.startTS !== lastCandle.startTS) {
                        App.CurrentGraph.lastDeltaCandle = lastCandle;
                            
                        App.CurrentGraph.flagForNewCandle = true;
                    }
                    
                    JSON.parse(resp).data.forEach(function(candle){
                        var startTS = new Date(candle.startTS).getTime() * 1000;
                        var endTS = new Date(candle.endTS).getTime() * 1000;
                        var finished = false;
                        var last = 'last';
                        // var start_price = (candle.start_price === 0) ? candle.last_price : candle.start_price;
                        var cndl = new DeltaCandle(candle.start_price, candle.last_price, candle.volume, candle.realDelta, startTS, endTS, finished, candle.deltaShadow, last/*, index*/);
                        var tick_max_price = candle.tick_max_price;
                            // index--;
                        candle.ticks.forEach(function(tick, i){
                            cndl.addTick(tick[0], tick[1], tick[2]);
                        });
                        
                        //App.CurrentGraph.currentPrice.y = cndl.last_price;
                        
                        candles.push(cndl);
                    });
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
                        // var start_price = (candle.start_price === 0) ? candle.last_price : candle.start_price;
                        var cndl = new DeltaCandle(candle.start_price, candle.last_price, candle.volume, candle.realDelta, startTS, endTS, finished, candle.deltaShadow/*, index*/);
                        var tick_max_price = candle.tick_max_price;
                            // index--;
                            candle.ticks.forEach(function(tick, i){
                                // if(tick[0] !== 0 && tick[1] !== 0 && tick[2] !== 0)  {
                                    cndl.addTick(tick[0], tick[1], tick[2]);
                                // }
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
        
        parseCandlesForOrderTapeGraph: function(resp, f, isForLastCandleFlag, orderFlag) {
            var candles=[];
            var fl = '';
                try{
                    fl = 'nolastC';
                    JSON.parse(resp).forEach(function(tick){
                        var secs = tick.secs;
                        var usecs = tick.usecs;
                        var dir = tick.direction;
                        var volume = tick.volume;
                        var maxPrice = tick.maxPrice;
                        var minPrice = tick.minPrice;
                        var cndl = new OrderCandle(secs, usecs, dir, volume, maxPrice, minPrice);
                        candles.push(cndl);
                    });
                }catch(e){
                    console.log(e); 
                }
            // }
            Data.Cache.saveOrder(candles, fl, orderFlag);
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
                        if(Data.Cache.Candles[i].finished === false || elem.finished == false){
                            if (testT == elem.from)
                                console.log(elem.ticks);
                            
                            Data.Cache.Candles[i] = elem;
                            // console.log(elem);
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
        
        saveOrder: function(_candles, fl, orderFlag) {

        var l = Data.Cache.Candles.length;
        // if(!orderFlag) {
            var flag = true;
            
            //console.log('Столбики отпарсены. Время: ', new Date(), '\n Задержка: ', GlobalTime.getTime() - new Date().getTime(), '\n', 'Число столбиков: ', _candles.length, '\n');
            
            _candles = _candles.filter(function(elem){
                flag = true;
                for(var i = 0; i < l; i++){
                    if (elem.secs === Data.Cache.Candles[i].secs && 
                        elem.usecs === Data.Cache.Candles[i].usecs &&
                        elem.volume === Data.Cache.Candles[i].volume &&
                        elem.maxPrice === Data.Cache.Candles[i].maxPrice &&
                        elem.minPrice === Data.Cache.Candles[i].minPrice &&
                        elem.direction === Data.Cache.Candles[i].direction){
                            flag = false;
                            break;
                    }
                }
                return flag;
            });
            
            _candles.forEach(function(e){
                e.id = e.secs*1000000 + e.usecs;
                Data.Cache.Candles.push(e);
            }); 
            
            Data.Cache.Candles.sort(function(a,b){
                return a.id - b.id;
            });
            
            if (!Data.lastABI) Data.lastABI = Data.Cache.Candles[Data.Cache.Candles.length-1];
            
            if (!Data.prelastOrderCandle) Data.prelastOrderCandle = Data.Cache.Candles[Data.Cache.Candles.length-2];
            
            if (Data.Cache.Candles[Data.Cache.Candles.length-1] && Data.lastABI && Data.Cache.Candles[Data.Cache.Candles.length-1].id != Data.lastABI.id) {
                var newABI = Data.Cache.Candles[Data.Cache.Candles.length-1],
                    deltaX = 0, deltaY = 0,
                    gs = App.CurrentGraph.GraphSettings,
                    px = gs.PERFECT_PX,
                    fixed_time_step = gs.FIXED_TIME_STEP,
                    _width = Math.ceil(gs.TIME_STEP / 5) - 6 * px,
                    
                    _x_l = gs.getXCordForPx((newABI.id - _candles.length)* fixed_time_step / 5)*gs.OX_SCALE,
                    _x_n = gs.getXCordForPx(newABI.id * fixed_time_step / 5)*gs.OX_SCALE,
                    
                    _y_l = Data.lastABI.maxPrice,
                    _y_n = newABI.maxPrice;
                
                deltaX = _x_n - _x_l;
                deltaY = _y_n - _y_l;
                
                
                if (App.supervisor) App.CurrentGraph.onDragged(deltaX, deltaY, true);
                
                Data.lastABI = newABI;

            };
            Data.FlagForOrderChange = false;
                
            var length = Data.Cache.Candles.length;
            var id = Data.rightOrderCandle.id;
            var pos = 0;
            for(var i = 0; i < length; i++){
                if(Data.Cache.Candles[i].id - App.CurrentGraph.FirstIdOrder === 0){
                    pos = i;
                    break;
                }
            }
            
            for(var i = pos - 1; i >= 0; i--){
                if(Data.Cache.Candles[i+1].id - Data.Cache.Candles[i].id > 1){
                    Data.Cache.Candles[i].id = Data.Cache.Candles[i+1].id - 1
                }
            }
            for(var i = pos + 1 ; i < length; i++){
                if(Data.Cache.Candles[i].id - Data.Cache.Candles[i-1].id > 1){
                    Data.Cache.Candles[i].id = Data.Cache.Candles[i-1].id + 1
                }
            }
            
            var length = Data.Cache.Candles.length;
            Data.rightOrderCandle = {
                secs: Data.Cache.Candles[length-1].secs,
                id: Data.Cache.Candles[length-1].id,
                pos: length-1
            }
            Data.leftOrderCandle = {
                secs: Data.Cache.Candles[0].secs,
                id: Data.Cache.Candles[0].id
            }
            Data.prelastOrderCandle = {
                secs: Data.Cache.Candles[length-2].secs,
                id: Data.Cache.Candles[length-2].id,
                pos: length-2 
            }
            
            //console.log('Столбики сохранены, отсортированы. Время: ', new Date(), '\n Задержка: ', GlobalTime.getTime() - new Date().getTime(), '\n');
            
        },
        
        saveDelta: function(_candles, fl){
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
                
                console.log('Delta');
                
                _candles.forEach(function(e){
                    Data.Cache.Candles.push(e);
                }); 
                
                Data.Cache.Candles.sort(function(a,b){
                    return a.startTS - b.startTS;
                });
                // console.log(Data.Cache.Candles)
                length = Data.Cache.Candles.length;
                
                console.log( Data.Cache.Candles[ Data.Cache.Candles.length-1].start_price);
                
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
            }
            else if(fl === 'lastC'){
                var l = Data.Cache.Candles.length;
                
                _candles.sort(function(a,b){
                    return a.startTS - b.startTS;
                });
                
                    // console.log(2,_candles)
                if(         _candles[0].startTS === _candles[1].startTS && 
                            _candles[0].endTS === _candles[1].endTS){
                    _candles.sort(function(a,b){
                        return a.realDelta - b.realDelta;
                    });
                    _candles[1].index = Data.rightDeltaCandle.index;
                    Data.Cache.Candles[Data.Cache.Candles.length - 1] = _candles[1];
                }else {
                    // console.log(Data.Cache.Candles[Data.Cache.Candles.length - 1],_candles[0])
                    if(Data.Cache.Candles[Data.Cache.Candles.length - 1] && Data.Cache.Candles[Data.Cache.Candles.length - 1].startTS === _candles[0].startTS ) {
                        // console.log('один')
                        _candles[0].index = Data.rightDeltaCandle.index;
                        _candles[0].last = 'nolast';
                        _candles[1].index = Data.rightDeltaCandle.index + 1;
                        // Data.Cache.Candles.push(_candles[0]);
                        Data.Cache.Candles[Data.Cache.Candles.length - 1] = _candles[0];
                        Data.Cache.Candles.push(_candles[1]);
                    }
                    else {  
                        // console.log('два')
                        _candles[1].index = Data.rightDeltaCandle.index;
                        Data.Cache.Candles[Data.Cache.Candles.length - 1] = _candles[1];
                    }
                    
                    if (Data.Cache.Candles[Data.Cache.Candles.length - 1]) {
                       l = Data.Cache.Candles.length;
                        Data.rightDeltaCandle = {
                            ts: Data.Cache.Candles[l-1].startTS,
                            index: Data.Cache.Candles[l-1].index,
                            pos: l-1
                        } 
                    }
                    
                }
            }
            // проверка на завершение свечки
            if(Data.Cache.Candles[Data.Cache.Candles.length - 2] !== undefined && Data.Cache.Candles[Data.Cache.Candles.length - 2].finished !== true){
                Data.Cache.Candles[Data.Cache.Candles.length - 2].finished = true;
            }
            
            if (!Data.lastDelta) Data.lastDelta = Data.Cache.Candles[ Data.Cache.Candles.length-1].start_price;
                
                if (Data.lastDelta && Data.Cache.Candles[Data.Cache.Candles.length-1].index != Data.lastDelta.index) {
                    var newDelta = Data.Cache.Candles[Data.Cache.Candles.length-1],
                        deltaX = 0, deltaY = 0,
                        gs = App.CurrentGraph.GraphSettings,
                        px = gs.PERFECT_PX,
                        fixed_time_step = gs.FIXED_TIME_STEP,
                        _width = Math.ceil(gs.TIME_STEP / 5) - 6 * px,
                        
                        _x_l = gs.getXCordForPx(Data.lastDelta.index * fixed_time_step )*gs.OX_SCALE,
                        _x_n = gs.getXCordForPx(newDelta.index * fixed_time_step )*gs.OX_SCALE,
                        
                        _y_l = Data.lastDelta.last_price,
                        _y_n = newDelta.last_price;
                        
                    //console.log(_x_l, _x_n);
                    
                    deltaX = _x_n - _x_l;
                    deltaY = _y_n - _y_l;
                    
                    if (App.supervisor) App.CurrentGraph.onDragged(deltaX, deltaY, true);
                    
                    Data.lastDelta = newDelta;

                };
            
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
        if(price !== 0)  {
            this.ticks.push(new Tick(ask, bid, price));
        }
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

var OrderCandle = function(secs, usecs, dir, vol, maxPrice, minPrice){
    // this.id = ;
    this.secs = secs;
    this.usecs = usecs;
    this.direction = dir;
    this.volume = vol;
    this.maxPrice = maxPrice;
    this.minPrice = minPrice;
}

// OrderCandle.prototype = Object.create(Candle.prototype);
OrderCandle.prototype.constructor = OrderCandle;

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