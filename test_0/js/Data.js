// класс отвечающий за работу с данными
var Data = {
    
    // текущий таймфрейм
    CurrentTimeframe: null,
    
    // текущая дельта
    CurrentDeltaValue: null,
    
    // последняя свеча
    LastCandle: null,
    
    // последняя дельта свеча
    LastDelta: null,
    
    // последняя футпринт свеча
    LastFootprint: null,
    
    // последний тик ленты ордеров
    LastABI: null,
    
    // массив XHR запросов
    xhr: [],
    
    // константные значения типов графика
    FootprintGraph: 'FOOTPRINT',
    DeltaGraph: 'DELTA',
    OrderGraph: 'ORDER TAPE',
    
    // флаг состояния изменения параметров для пределов запрашиваемых тиков ленты ордеров
    FlagForOrderChange: false,
    
    // ?? нигде не используется, необходимо найти зачем оно
    ChangeGraph: false,
    
    // последняя цена и ее метка времени
    LastValue: null,
    
    // крайняя правая дельта свеча
    RightDeltaCandle: {
        ts: null,
        index: null,
        pos: null
    },
    
    // крайняя левая дельта свеча
    LeftDeltaCandle: {
        ts: null,
        index: null
    },
    
    // крайняя правая свеча ленты ордеров
    RightOrderCandle: {
        secs: null,
        id: null,
        pos: null
    },
    
    // крайняя левая свеча ленты ордеров
    LeftOrderCandle: {
        secs: null,
        id: null
    },
    
    // предпоследняя правая свеча ленты ордеров
    PrelastOrderCandle: {
        secs: null,
        id: null,
        pos: null
    },
    
    // крайняя правая футпринт свеча
    RightFootprintCandle: {
        ts: null,
        index: null,
        pos: null
    },
    
    // крайняя левая футпринт свеча
    LeftFootprintCandle: {
        ts: null,
        index: null
    },
    
    // крайняя левая метка времени футпринт свечи
    LeftFootprintTs: 0,
    
    // крайняя левая метка времени свеч ленты ордеров
    LeftOrderTs: 0,
    
    // запрос на последнюю метку времени и цену тика
    getStartValue: function(instrument, f, startFlag){
        Data.Request.get('/api/tick/?instrument=' + instrument, f, undefined, undefined, startFlag);
    },
    
    // выбирает на какой тп свеч делать запрос
    getCandlesForInterval: function(obj){
        App.LoadGif.classList.remove('hide_modal');
        if(App.CurrentGraph.type === Data.FootprintGraph){
            this.getCandlesForFootprintGraph(obj);
        }else if(App.CurrentGraph.type === Data.DeltaGraph){
            this.getCandlesForDeltaGraph(obj);
        }else if(App.CurrentGraph.type === Data.OrderGraph){
            this.getCandlesForOrderGraph(obj);
        }
    },
    
    // запрашивает свечи для ленты ордеров
    getCandlesForOrderGraph: function(obj) {
        var id = obj.id,
            amount = 200,
            f = obj.f,
            instrument = obj.instrument,
            till = Math.ceil(Date.now()/1000);
            
        if(App.CurrentGraph.FlagForStartPrice){
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
            var num = Math.ceil(gs.WIDTH/gs.FIXED_TIME_STEP*5 * App.CurrentGraph.GraphSettings.OX_SCALE);
            
            if(id <= Data.LeftOrderCandle.id){
                till = Data.LeftOrderTs;
                
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
            else if(id + num >= Data.RightOrderCandle.id){
                till = Math.ceil((Data.RightOrderCandle.secs + 60))
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
                Graph.RequestInProcess = false;
                App.LoadGif.classList.add('hide_modal');
                
            }
        }
        
    },
    
    // запрос на удаление профиля рынка
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
    
    // запрос на публикацию профиля рынка
    postMarketProfile: function(list) {
        _.postJSON('/api/user/market/', {data: JSON.stringify(list)}, () => {
            App.CurrentGraph.loadMarketProfile();
        });
        
    },
    
    // запрос на получение профиль рынка для дельта графика
    getMarketProfileForDeltaGraph: function() {
        var delta = App.CurrentGraph.DELTA,
            instr = App.CurrentGraph.INSTRUMENT;
        
        if (instr == 0) instr = "6E";
        
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
    
    // запрос на получения профиля рынка для футпринт графика
    getMarketProfileForFootprintGraph: function() {
        var tmfr = App.CurrentGraph.GraphSettings.TIMEFRAME,
            instr = App.CurrentGraph.INSTRUMENT;
            
        if (instr == 0) instr = "6E";
        
         var xhr = new XMLHttpRequest();
         
         xhr.open('GET', `/api/user/markets/?instrument=${instr}&timeframe=${tmfr}`);
         xhr.send();
         
         xhr.onreadystatechange = () => {
             if (xhr.status !== 200) {
                //  console.log('status != 200')
             } else {
                 App.CurrentGraph.loadMarketProfile(true, xhr.responseText);
                //  console.log(xhr.responseText)
            }
         }
    },
    
    // запрос на футпринт свечи
    getCandlesForFootprintGraph: function(obj){
        var timeframe = obj.timeframe,
            instrument = obj.instrument,
            gs = App.CurrentGraph.GraphSettings,
            amount = 5,
            index = obj.candle_index,
            start = 0,
            f = obj.f;
        this.CurrentTimeframe = timeframe;
        if(App.CurrentGraph.FlagForStartPriceF){
            if(timeframe.ts <= App.Timeframe.M30.ts){
                amount = 20;
            }
            start = Math.ceil(Data.LastValue.date/1000);
            Data.Request.get(
                '/api/candles/amount/?instrument=' + instrument + 
                '&timeframe=' + timeframe.val + 
                '&start=' + start +
                '&n=' + amount, f, false
            );
        }
        else{
            var num = Math.ceil(gs.WIDTH/gs.TIME_STEP * (1.5 * gs.OX_SCALE));
            if(index <= Data.LeftFootprintCandle.index){
                start = Math.ceil(Data.LeftFootprintTs/1000);
                if(timeframe.ts <= App.Timeframe.M30.ts){
                    amount = 20;
                }
                Data.Request.get(
                    '/api/candles/amount/?instrument=' + instrument + 
                    '&timeframe=' + timeframe.val + 
                    '&start=' + start +
                    '&n=' + amount, f, false
                );
            }
            else if(index + num >= Data.RightFootprintCandle.index){
                var start = Math.ceil((Data.RightFootprintCandle.ts)/1000);
                var chD = Math.ceil(Date.now()/1000);
                var res = (chD - start) / timeframe.ts * 1000;
                if(res < 2) {
                    Data.Request.get(
                        '/api/candles/uncached/?timeframe=' + timeframe.val + 
                        '&instrument=' + instrument, f, true
                    );
                }
                else {
                    amount = Math.floor(res);
                    start = Math.ceil((Date.now() - timeframe.ts)/ 1000);// += Math.ceil(amount * timeframe.ts / 1000);
                    Data.Request.get(
                        '/api/candles/amount/?instrument=' + instrument + 
                        '&timeframe=' + timeframe.val + 
                        '&start=' + start +
                        '&n=' + amount, f, false
                     );
                }
            } 
            else {
                Graph.RequestInProcess = false;
                App.LoadGif.classList.add('hide_modal');
            }
        }
    },
    
    // запрос на дельта свечи
    getCandlesForDeltaGraph: function(obj){
        var delta = obj.delta,
            instrument = obj.instrument,
            gs = App.CurrentGraph.GraphSettings,
            amount = 40,//obj.amount,
            last_start = 0,//obj.last_start/1000, //- необязательный 
            index = obj.candle_index,
            f = obj.f;
            switch(delta){
                case 100: amount = 40; break;
                case 300: amount = 30; break;
                case 500: amount = 15; break;
                case 1000: amount = 10; break;
            }
        this.CurrentDeltaValue = delta;
        if(App.CurrentGraph.FlagForStartPrice){
            Data.Request.get(
                '/api/candles/delta/?instrument=' + instrument + 
                '&delta=' + delta + 
                '&amount=' + amount, f, false
            );
        }
        else{
            var num = Math.ceil(gs.WIDTH/gs.TIME_STEP * (1.5 * gs.OX_SCALE));
            if(index <= Data.LeftDeltaCandle.index/*Data.Cache.Candles[pos - 1] === undefined && (Data.Cache.Candles[pos] !== undefined)*/){
                last_start = Data.LeftDeltaCandle.ts/1000;
                Data.Request.get(
                    '/api/candles/delta/?instrument=' + instrument + 
                    '&delta=' + delta + 
                    '&amount=' + amount + '&last_start=' + last_start, f, false
                );
            }
            else if(index + num >= Data.RightDeltaCandle.index){
                Data.Request.get(
                    '/api/candles/delta/two-last/?instrument=' + instrument + 
                    '&delta=' + delta, f, true
                );
            
            } 
            else {
                Graph.RequestInProcess = false;
                App.LoadGif.classList.add('hide_modal');
                
            }
        }

    },
    
    // пространство имен для работы с запросами к серверу
    Request: {
        
        // обрывает все XHR запросы
        onXHRChanged: function(){
            Data.xhr.forEach(function(elem){
                elem.abort();
            });
            Data.xhr.splice(0, Data.xhr.length);
            Data.Cache.Candles = [];
            Data.LastCandle = null;
            Data.ChangeGraph = true;
            Graph.RequestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
        },
        
        // запрос по переданному url
        get: function(url, f, isForLastCandleFlag, orderFlag, startFlag){
            var pos = 0;
            for(; pos < Data.xhr.length; pos++){
                if(Data.xhr[pos].status !== 200){
                    pos--;
                    break;
                }   
            }
            Data.xhr.splice(0, pos);
            var xhr = new XMLHttpRequest();
            xhr.open('GET', url);
            Data.xhr.push(xhr);
            xhr.send();
            xhr.onload = function () {
                if (xhr.status === 200) {
                    
                    if(isForLastCandleFlag === undefined){
                        Data.Request.parseData(xhr.response, f, undefined, undefined, startFlag);
                    }
                    else if(orderFlag === undefined) {
                        Data.Request.parseData(xhr.response, f, isForLastCandleFlag);
                    }
                    else {
                        Data.Request.parseData(xhr.response, f, isForLastCandleFlag, orderFlag);
                    }
                } else {
                    alert( xhr.status + ': ' + xhr.statusText );
                }
            };
            xhr.onerror = function () {
                alert( xhr.status + ': ' + xhr.statusText );
            };
        },
        
        // выбор типа для парсинга полученных данных
        parseData: function(response, f, isForLastCandleFlag, orderFlag, startFlag){
            if(isForLastCandleFlag === undefined){
                this.parseLastValue(response, f, startFlag);
            }
            else if(App.CurrentGraph.type === Data.FootprintGraph){
                this.parseCandlesForFootprintGraph(response, f, isForLastCandleFlag);
            }
            else if(App.CurrentGraph.type === Data.OrderGraph){
                this.parseCandlesForOrderTapeGraph(response, f, isForLastCandleFlag, orderFlag);
            }
            else{
                this.parseCandlesForDeltaGraph(response, f, isForLastCandleFlag);
            }
        },
        
        // парсинг футпринт свечей
        parseCandlesForFootprintGraph: function(resp, f, isForLastCandleFlag){
            var candles=[];
            var gs = App.CurrentGraph.GraphSettings;
            var fl = '';
            if(isForLastCandleFlag){
                try{
                    fl = 'lastC';
                    var cndl = JSON.parse(resp).data;
                    if (cndl.length > 1) {
                        cndl.sort(function(a, b){
                            return a.startTS - b.startTS;
                        })
                        cndl.forEach(function(elem){
                            var from = new Date(elem.startTS).getTime() * 1000;
                            var finished = (elem.finished === "true")? true : false;
                            var candle = new FootprintCandle(elem.start_price, elem.last_price, from, Data.CurrentTimeframe.val, finished, 
                                elem.volume, elem.deltaShadow);
                            var tick_max_price = cndl.tick_max_price;
                            if(elem.start_price === null || elem.start_price === 0){
                                    candles.push(candle);
                            }
                            else{
                                if (elem.ticks.length > 1) {
                                    var fT = elem.ticks[0][2],
                                        sT = elem.ticks[1][2],
                                        step = gs.PRICE_TICK_STEP,
                                        l = elem.ticks.length;
                                    elem.ticks.forEach(function(tick, i){
                                        fT = tick[2]; 
                                        if(1*(fT - sT).toFixed(gs.ROUNDING) > step){
                                            for(var c = fT - step; c > sT; c -= step){
                                                candle.addTick(0, 0, c);
                                            }
                                        }                            
                                        candle.addTick(tick[0], tick[1], tick[2]);
            
                                        if(i < l-2) {
                                            sT = elem.ticks[i+2][2];
                                        }
                                    });
                                }
                                else {
                                    elem.ticks.forEach(function(tick){
                                        candle.addTick(tick[0], tick[1], tick[2]);
                                    });
                                }
                                
                                App.CurrentGraph.currentPrice.y = candle.last_price;
                                App.CurrentGraph.currentPriceLine.y = candle.last_price;
                                
                                if(Data.LastCandle === null || Data.LastCandle.from !== candle.from){
                                    Data.LastCandle = candle;
                                    App.CurrentGraph.flagForNewCandle = true;
                                }
                                candles.push(candle);
                            }
                        }) 
                    } 
                    else {
                        cndl = cndl[0];
                        var from = new Date(cndl.startTS).getTime() * 1000;
                        var finished = false;
                        var candle = new FootprintCandle(cndl.start_price, cndl.last_price, from, Data.CurrentTimeframe.val, finished, 
                            cndl.volume, cndl.deltaShadow);
                        var tick_max_price = cndl.tick_max_price;
                        if(cndl.start_price === null || cndl.start_price === 0){
                                candles.push(candle);
                        }
                        else{
                            if (cndl.ticks.length > 1) {
                                var fT = cndl.ticks[0][2],
                                    sT = cndl.ticks[1][2],
                                    step = gs.PRICE_TICK_STEP,
                                    l = cndl.ticks.length;
                                cndl.ticks.forEach(function(tick, i){
                                    fT = tick[2]; 
                                    if(1*(fT - sT).toFixed(gs.ROUNDING) > step){
                                        for(var c = fT - step; c > sT; c -= step){
                                            candle.addTick(0, 0, c);
                                        }
                                    }                            
                                    candle.addTick(tick[0], tick[1], tick[2]);
        
                                    if(i < l-2) {
                                        sT = cndl.ticks[i+2][2];
                                    }
                                });
                            }
                            else {
                                cndl.ticks.forEach(function(tick){
                                    candle.addTick(tick[0], tick[1], tick[2]);
                                });
                            }
                            
                            App.CurrentGraph.currentPrice.y = candle.last_price;
                            App.CurrentGraph.currentPriceLine.y = candle.last_price;
                            
                            if(Data.LastCandle === null || Data.LastCandle.from !== candle.from){
                                Data.LastCandle = candle;
                                App.CurrentGraph.flagForNewCandle = true;
                            }
                            candles.push(candle);
                        }
                    }
                }catch(e){
                }
            
            }else{
                fl = 'nolastC';
                JSON.parse(resp).data.candles.forEach(function(cndl){
                    if(cndl.volume !== 0 && cndl.start_price !== 0 && cndl.last_price !== 0 && cndl.deltaShadow !== 0){
                        var from = new Date(cndl.startTS).getTime() * 1000;
                        var finished = (cndl.finished === "true")? true : false;
                        var candle = new FootprintCandle(cndl.start_price, cndl.last_price, from, Data.CurrentTimeframe.val, finished, 
                        cndl.volume, cndl.deltaShadow);
                        
                        if (cndl.ticks.length > 1) {
                            var fT = cndl.ticks[0][2],
                                sT = cndl.ticks[1][2],
                                step = gs.PRICE_TICK_STEP,
                                l = cndl.ticks.length;
                            cndl.ticks.forEach(function(tick, i){
                                fT = tick[2]; 
                                if(1*(fT - sT).toFixed(gs.ROUNDING) > step){
                                    for(var c = fT - step; c > sT; c -= step){
                                        candle.addTick(0, 0, c);
                                    }
                                }                            
                                candle.addTick(tick[0], tick[1], tick[2]);
    
                                if(i < l-2) {
                                    sT = cndl.ticks[i+2][2];
                                }
                            });
                        }
                        else {
                            cndl.ticks.forEach(function(tick){
                                candle.addTick(tick[0], tick[1], tick[2]);
                            });
                        }
                        candles.push(candle);
                    }
                    else {
                        var from = new Date(cndl.startTS).getTime() * 1000;
                        if(from < Data.LeftFootprintTs){
                            Data.LeftFootprintTs = from;
                        }
                    }
                })
            }
            Data.Cache.save(candles, fl);
            Graph.RequestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
            if(typeof f == "function"){
                f(true);
            }
        },
        
        // парсинг дельта свечей
        parseCandlesForDeltaGraph: function(resp, f, isForLastCandleFlag){
            var candles=[];
            var gs = App.CurrentGraph.GraphSettings;
            var fl = '';
            if(isForLastCandleFlag){
                try{
                    fl = 'lastC';
                    
                    var LastCandle = null;
                    var st = 0;
                    
                    JSON.parse(resp).data.forEach( (elem) => {
                        if (elem.startTS >= st) LastCandle = elem;
                        
                        st = LastCandle.startTS;
                    });
                    
                    App.CurrentGraph.currentPriceLine.y = LastCandle.last_price;
                    App.CurrentGraph.currentPrice.y = LastCandle.last_price;
                    
                    if (App.CurrentGraph.LastDeltaCandle === null || App.CurrentGraph.LastDeltaCandle.startTS !== LastCandle.startTS) {
                        App.CurrentGraph.LastDeltaCandle = LastCandle;
                            
                        App.CurrentGraph.flagForNewCandle = true;
                    }
                    
                    JSON.parse(resp).data.forEach(function(candle){
                        var startTS = new Date(candle.startTS).getTime() * 1000;
                        var endTS = new Date(candle.endTS).getTime() * 1000;
                        var finished = (candle.finished === "true")? true : false;
                        var last = 'last';
                        var cndl = new DeltaCandle(candle.start_price, candle.last_price, candle.volume, candle.realDelta, startTS, endTS, finished, candle.deltaShadow, last);
                        var tick_max_price = candle.tick_max_price;
                        
                        if (candle.ticks.length > 1) {
                            var fT = candle.ticks[0][2],
                                sT = candle.ticks[1][2],
                                step = gs.PRICE_TICK_STEP,
                                l = candle.ticks.length;
                            candle.ticks.forEach(function(tick, i){
                                fT = tick[2]; 
                                if(1*(fT - sT).toFixed(gs.ROUNDING) > step && st != 0 && fT != 0){
                                    for(var c = fT - step; c > sT; c -= step){
                                        cndl.addTick(0, 0, c);
                                    }
                                }                            
                                cndl.addTick(tick[0], tick[1], tick[2]);
    
                                if(i < l-2) {
                                    sT = candle.ticks[i+2][2];
                                }
                            });
                        }
                        else {
                            candle.ticks.forEach(function(tick){
                                cndl.addTick(tick[0], tick[1], tick[2]);
                            });
                        }
                        
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
                        var finished = (candle.finished === "true")? true : false;
                        var cndl = new DeltaCandle(candle.start_price, candle.last_price, candle.volume, candle.realDelta, startTS, endTS, finished, candle.deltaShadow);
                        
                        if (candle.ticks.length > 1) {
                            var fT = candle.ticks[0][2],
                                sT = candle.ticks[1][2],
                                step = gs.PRICE_TICK_STEP,
                                l = candle.ticks.length;
                            candle.ticks.forEach(function(tick, i){
                                fT = tick[2]; 
                                if(1*(fT - sT).toFixed(gs.ROUNDING) > step && sT !== 0 && fT !== 0){//sT и fT - проверка на нулевой тик [0,0,0]
                                    for(var c = fT - step; c > sT; c -= step){
                                        cndl.addTick(0, 0, c);
                                    }
                                }                            
                                cndl.addTick(tick[0], tick[1], tick[2]);
        
                                if(i < l-2) {
                                    sT = candle.ticks[i+2][2];
                                }
                            });
                        }
                        else {
                            candle.ticks.forEach(function(tick){
                                cndl.addTick(tick[0], tick[1], tick[2]);
                            });
                        }
                            candles.push(cndl);
                    });
                }catch(e){
                    console.log(e); 
                }
            }
            Data.Cache.saveDelta(candles, fl);
            Graph.RequestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
            if(typeof f == "function"){
                f(true);
            }
        },
        
        // парсинг свечей ленты ордеров
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
                    var from = new Date(secs).getTime() * 1000;
                    if(from < Data.LeftOrderTs){
                        Data.LeftOrderTs = from;
                    }
                });
            }catch(e){
                console.log(e); 
            }
            Data.Cache.saveOrder(candles, fl, orderFlag);
            Graph.RequestInProcess = false;
            App.LoadGif.classList.add('hide_modal');
            if(typeof f == "function"){
                f(true);
            }
        },
        
        // парсинг последних данных(метки времени и цены тика)
        parseLastValue: function(response, f, startFlag){
            try{
                var obj = JSON.parse(response).data;
                Data.LastValue = {
                    price: 1 * obj.price,
                    date: 1 * obj.date// - App.TimezoneOffset
                }
                var dy = Data.LastValue.price - App.CurrentGraph.currentPrice.y;
                App.CurrentGraph.currentPriceLine.y = Data.LastValue.price;
                App.CurrentGraph.currentPrice.y = Data.LastValue.price;
                if(startFlag){
                    Graph.RequestInProcess = false;
                    App.CurrentGraph.FlagForStartPrice = true;
                }
                if(typeof f == "function"){
                    f(true);
                }
            }
            catch(e){
                console.error(e);
            }
        }
    },
    
    // пространство имен для кэша свеч
    Cache:{
        // проверяет содержит ли пробелы участой кэша (необходимо либо изменить либо удалить)
        containEmptySegment: function(start_ts, duration){
            /*
            var end = start_ts + duration;
            var segment = Data.Cache.get(start_ts, duration);
            var timeframe_ts = Data.CurrentTimeframe.ts;
            var len = segment.length;
            
            for(var i = 0; i < len - 1; i++){
                if((segment[i+1].from - segment[i].from) > timeframe_ts){
                    return true;
                }
            }
            
            var cacheBorder = (Data.Cache.Candles.length !== 0)? Data.Cache.Candles[Data.Cache.Candles.length - 1].from : 0;
            
            if(end - cacheBorder > 0 && Date.now() > end){
                return true;
            }
            return false;*/
            return true;
        },
        
        // проверяет не пуст ли интервал кэша (либо изменить либо удалить)
        containsInterval: function(start_ts, duration){
            // var end = start_ts + duration;
            // if(Data.Cache.Candles.length !== 0 
            // && start_ts >= Data.Cache.Candles[0].from 
            // && (end <= (Data.Cache.Candles[Data.Cache.Candles.length - 1].from + Data.CurrentTimeframe.ts) || Date.now() < end)
            // && !Data.Cache.containEmptySegment(start_ts, duration)){
            //     return true;
            // }else{
            //     return false;
            // }
            return true;
        },
        
        // возвращает массив свеч по заданному промежутку (изменить!)
        get: function(start_ts, duration){
            // var response=[];
            // var end = start_ts + duration;
            // Data.Cache.Candles.forEach(function(elem){
            //     response.push(elem);
            // });
            // return response;
            return Data.Cache.Candles;
        },
        
        // сохраняет футпринт свечи в кэш
        save: function(_candles, fl){
            var length = Data.Cache.Candles.length;
            var flag = true;
            _candles = this.unique(_candles);
            if(fl === 'nolastC'){
                _candles = _candles.filter(function(elem){
                    flag = true;
                    for(var i = 0; i < length; i++){
                        if (elem.from === Data.Cache.Candles[i].from &&
                            elem.finished === Data.Cache.Candles[i].finished &&
                            elem.last_price === Data.Cache.Candles[i].last_price &&
                            elem.timeframe === Data.Cache.Candles[i].timeframe &&
                            elem.start_price === Data.Cache.Candles[i].start_price &&
                            elem.tick_max_price === Data.Cache.Candles[i].tick_max_price
                            ){
                                flag = false;
                                break;
                        }
                        else if(elem.from === Data.Cache.Candles[i].from &&
                                elem.timeframe === Data.Cache.Candles[i].timeframe &&
                                elem.volume !== Data.Cache.Candles[i].volume
                        ){
                            elem.index = Data.Cache.Candles[i].index;
                            delete Data.Cache.Candles[i];
                            Data.Cache.Candles[i] = elem;
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
                    return a.from - b.from;
                });
                length = Data.Cache.Candles.length;
                
                
                
                if(App.CurrentGraph.FlagForStartPriceF){
                    App.CurrentGraph.FlagForStartPriceF = false;
                    var j = -(length - 1);
                    for(var i = 0; i < length ; i++){
                        Data.Cache.Candles[i].index = j;
                        j++;
                    }
                    Data.LeftFootprintTs = Data.Cache.Candles[0].from;
                }
                else{
                    if(Data.Cache.Candles[0].index === undefined){
                        var index = Data.LeftFootprintCandle.index;
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
                        var p = Data.RightFootprintCandle.pos,
                            index = Data.RightFootprintCandle.index,
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
                Data.RightFootprintCandle = {
                    ts: Data.Cache.Candles[length-1].from,
                    index: Data.Cache.Candles[length-1].index,
                    pos: length-1
                }
                Data.LeftFootprintCandle = {
                    ts: Data.Cache.Candles[0].from,
                    index: Data.Cache.Candles[0].index
                }
            }
            else if(fl === 'lastC'){
                if(_candles.length === 1){
                    var len = Data.Cache.Candles.length;
                        var ins = 0;
                    if(Data.Cache.Candles[len - 1].from === _candles[0].from){
                        ind = Data.Cache.Candles[len-1].index;
                        Data.Cache.Candles[len-1] = _candles[0];
                        Data.Cache.Candles[len-1].index = ind;
                    }
                    else {
                        _candles[0].index = Data.RightFootprintCandle.index + 1;
                        Data.Cache.Candles.push(_candles[0]);
                    }
                }
                else if(_candles.length === 2){
                    var from1 = _candles[0].from;
                    var pos = 0;
                    for(var i = Data.Cache.Candles.length - 1; i >= 0; i--) {
                        if(Data.Cache.Candles[i].from === from1){
                            pos = i;
                        }
                    }
                    var ind = Data.Cache.Candles[pos].index;
                    _candles[0].index = ind;
                    _candles[1].index = ind + 1;
                    
                    Data.Cache.Candles.splice(pos);
                    _candles.forEach(function(elem){
                        Data.Cache.Candles.push(elem);
                    });
                }
                
                length = Data.Cache.Candles.length;
                Data.RightFootprintCandle = {
                    ts: Data.Cache.Candles[length-1].from,
                    index: Data.Cache.Candles[length-1].index,
                    pos: length-1
                }
                Data.LeftFootprintCandle = {
                    ts: Data.Cache.Candles[0].from,
                    index: Data.Cache.Candles[0].index
                }
            }
            
            if(Data.LeftFootprintTs > Data.LeftFootprintCandle.ts){
                Data.LeftFootprintTs = Data.LeftFootprintCandle.ts;
            }  
            
            if(Data.Cache.Candles[Data.Cache.Candles.length - 2] !== undefined && Data.Cache.Candles[Data.Cache.Candles.length - 2].finished !== true){
                Data.Cache.Candles[Data.Cache.Candles.length - 2].finished = true;
            }
            
            if (!Data.LastFootprint) Data.LastFootprint = Data.Cache.Candles[ Data.Cache.Candles.length-1];
                
            if (Data.LastFootprint && Data.Cache.Candles[Data.Cache.Candles.length-1].index != Data.LastFootprint.index) {
                var newDelta = null;
                
                for(var i = Data.Cache.Candles.length - 1; i >=0; i--){
                    if(Data.Cache.Candles[i].last_price !== 0){
                        newDelta = Data.Cache.Candles[i];
                        break;
                    }
                }
                var deltaX = 0, deltaY = 0,
                    gs = App.CurrentGraph.GraphSettings,
                    px = gs.PERFECT_PX,
                    fixed_time_step = gs.FIXED_TIME_STEP,
                    _width = Math.ceil(gs.TIME_STEP / 5) - 6 * px,
                    
                    _x_l = gs.getXCordForPx(Data.LastFootprint.index * fixed_time_step )*gs.OX_SCALE,
                    _x_n = gs.getXCordForPx(newDelta.index * fixed_time_step )*gs.OX_SCALE,
                    
                    _y_l = (Data.LastFootprint.last_price === 0) ? Data.Cache.Candles[Data.Cache.Candles.length-1].last_price : Data.LastFootprint.last_price,
                    _y_n = (newDelta.last_price === 0) ? _y_l : newDelta.last_price;
                deltaX = _x_n - _x_l;
                deltaY = 1*(_y_n - _y_l).toFixed(gs.ROUNDING);
                if (App.Supervisor) App.CurrentGraph.onDragged(deltaX, deltaY, true);
                Data.LastFootprint = newDelta;
            }
            
        },
        
        // сохраняет свечи ленты ордеров в кэш
        saveOrder: function(_candles, fl, orderFlag) {
            var l = Data.Cache.Candles.length;
            var flag = true;
            // _candles = this.unique(_candles);
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
            
            if(_candles.length === 0){
                Data.LeftOrderTs -= 50;
            }
            
            _candles.forEach(function(e){
                e.id = e.secs*1000000 + e.usecs;
                Data.Cache.Candles.push(e);
            }); 
            
            Data.Cache.Candles.sort(function(a,b){
                return a.id - b.id;
            });
            
            if(App.CurrentGraph.FlagForStartPrice){
                Data.LeftOrderTs = Data.Cache.Candles[0].secs;
            }
            
            App.CurrentGraph.currentPrice.y = Data.Cache.Candles[Data.Cache.Candles.length - 1].maxPrice;
            App.CurrentGraph.currentPriceLine.y = Data.Cache.Candles[Data.Cache.Candles.length - 1].maxPrice;
            
            if (!Data.LastABI) Data.LastABI = Data.Cache.Candles[Data.Cache.Candles.length-1];
            
            if (!Data.PrelastOrderCandle) Data.PrelastOrderCandle = Data.Cache.Candles[Data.Cache.Candles.length-2];
            
            if (Data.Cache.Candles[Data.Cache.Candles.length-1] && Data.LastABI && Data.Cache.Candles[Data.Cache.Candles.length-1].id != Data.LastABI.id) {
                var newABI = Data.Cache.Candles[Data.Cache.Candles.length-1],
                    deltaX = 0, deltaY = 0,
                    gs = App.CurrentGraph.GraphSettings,
                    px = gs.PERFECT_PX,
                    fixed_time_step = gs.FIXED_TIME_STEP,
                    _width = Math.ceil(gs.TIME_STEP / 5) - 6 * px,
                    
                    _x_l = gs.getXCordForPx((newABI.id - _candles.length)* fixed_time_step / 5)*gs.OX_SCALE,
                    _x_n = gs.getXCordForPx(newABI.id * fixed_time_step / 5)*gs.OX_SCALE,
                    
                    _y_l = Data.LastABI.price,
                    _y_n = newABI.price;
                
                deltaX = _x_n - _x_l;
                deltaY = _y_n - _y_l;
                
                if (App.Supervisor) App.CurrentGraph.onDragged(deltaX, deltaY, true);
                
                Data.LastABI = newABI;

            };
            Data.FlagForOrderChange = false;
                
            var length = Data.Cache.Candles.length;
            var id = Data.RightOrderCandle.id;
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
            Data.RightOrderCandle = {
                secs: Data.Cache.Candles[length-1].secs,
                id: Data.Cache.Candles[length-1].id,
                pos: length-1
            }
            Data.LeftOrderCandle = {
                secs: Data.Cache.Candles[0].secs,
                id: Data.Cache.Candles[0].id
            }
            Data.PrelastOrderCandle = {
                secs: Data.Cache.Candles[length-2].secs,
                id: Data.Cache.Candles[length-2].id,
                pos: length-2 
            }
            
            if(Data.LeftOrderTs > Data.LeftOrderCandle.secs){
                Data.LeftOrderTs = Data.LeftOrderCandle.secs;
            }
            
        },
        
        // сохраняет дельта свечи в кэш
        saveDelta: function(_candles, fl){
            var length = Data.Cache.Candles.length;
            var flag = true;
            _candles = this.unique(_candles);
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
                length = Data.Cache.Candles.length;
                for(var i = 0; i < length-1; i++){
                    if(Data.Cache.Candles[i].startTS === Data.Cache.Candles[i+1].startTS){
                        var temp =  Data.Cache.Candles[i];
                        if(temp.endTS > Data.Cache.Candles[i+1].endTS) {
                            Data.Cache.Candles[i] = Data.Cache.Candles[i + 1];
                            Data.Cache.Candles[i+1] = temp;
                        }
                    }
                }
                
                length = Data.Cache.Candles.length;
                
                if(App.CurrentGraph.FlagForStartPrice){
                    var j = -(length - 1);
                    for(var i = 0; i < length ; i++){
                        Data.Cache.Candles[i].index = j;
                        j++;
                    }
                }
                else{
                    if(Data.Cache.Candles[0].index === undefined){
                        var index = Data.LeftDeltaCandle.index;
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
                        var p = Data.RightDeltaCandle.pos,
                            index = Data.RightDeltaCandle.index,
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
                Data.RightDeltaCandle = {
                    ts: Data.Cache.Candles[length-1].startTS,
                    index: Data.Cache.Candles[length-1].index,
                    pos: length-1
                }
                Data.LeftDeltaCandle = {
                    ts: Data.Cache.Candles[0].startTS,
                    index: Data.Cache.Candles[0].index
                }
            }
            else if(fl === 'lastC'){
                var l = Data.Cache.Candles.length;
                
                _candles.sort(function(a,b){
                    return a.startTS - b.startTS;
                });
                if(         _candles[0].startTS === _candles[1].startTS && 
                            _candles[0].endTS === _candles[1].endTS){
                    _candles.sort(function(a,b){
                        return a.realDelta - b.realDelta;
                    });
                    _candles[1].index = Data.RightDeltaCandle.index;
                    Data.Cache.Candles[Data.Cache.Candles.length - 1] = _candles[1];
                }else {
                    if(Data.Cache.Candles[Data.Cache.Candles.length - 1] && Data.Cache.Candles[Data.Cache.Candles.length - 1].startTS === _candles[0].startTS ) {
                        _candles[0].index = Data.RightDeltaCandle.index;
                        _candles[0].last = 'nolast';
                        _candles[1].index = Data.RightDeltaCandle.index + 1;
                        Data.Cache.Candles[Data.Cache.Candles.length - 1] = _candles[0];
                        Data.Cache.Candles.push(_candles[1]);
                    }
                    else {  
                        _candles[1].index = Data.RightDeltaCandle.index;
                        Data.Cache.Candles[Data.Cache.Candles.length - 1] = _candles[1];
                    }
                    
                    if (Data.Cache.Candles[Data.Cache.Candles.length - 1]) {
                       l = Data.Cache.Candles.length;
                        Data.RightDeltaCandle = {
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
            
            if (!Data.LastDelta) Data.LastDelta = Data.Cache.Candles[ Data.Cache.Candles.length-1];
                
            if (Data.LastDelta && Data.Cache.Candles[Data.Cache.Candles.length-1].index != Data.LastDelta.index) {
                var newDelta = null;
                
                for(var i = Data.Cache.Candles.length - 1; i >=0; i--){
                    if(Data.Cache.Candles[i].last_price !== 0){
                        newDelta = Data.Cache.Candles[i];
                        break;
                    }
                }
                var deltaX = 0, deltaY = 0,
                    gs = App.CurrentGraph.GraphSettings,
                    px = gs.PERFECT_PX,
                    fixed_time_step = gs.FIXED_TIME_STEP,
                    _width = Math.ceil(gs.TIME_STEP / 5) - 6 * px,
                    
                    _x_l = gs.getXCordForPx(Data.LastDelta.index * fixed_time_step )*gs.OX_SCALE,
                    _x_n = gs.getXCordForPx(newDelta.index * fixed_time_step )*gs.OX_SCALE,
                    
                    _y_l = (Data.LastDelta.last_price === 0) ? Data.Cache.Candles[Data.Cache.Candles.length-1].last_price : Data.LastDelta.last_price,
                    _y_n = (newDelta.last_price === 0) ? _y_l : newDelta.last_price;
                
                deltaX = _x_n - _x_l;
                deltaY = _y_n - _y_l;
                
                if (App.Supervisor) App.CurrentGraph.onDragged(deltaX, deltaY, true);
                
                Data.LastDelta = newDelta;

            };
            
        },
        
        // удаляет дубликаты свеч
        unique: function(arr) {
            var result = [];

            if(App.CurrentGraph.CurType === 'footprint'){
                nextInput:
                for (var i = 0; i < arr.length; i++) {
                    var elem = arr[i]; // для каждого элемента
                    for (var j = 0; j < result.length; j++) { // ищем, был ли он уже?
                        if (result[j].from == elem.from) continue nextInput; // если да, то следующий
                    }
                    result.push(elem);
                }
            }
            else {
                nextInput:
                for (var i = 0; i < arr.length; i++) {
                    var elem = arr[i]; // для каждого элемента
                    for (var j = 0; j < result.length; j++) { // ищем, был ли он уже?
                        if (result[j].startTS == elem.startTS) continue nextInput; // если да, то следующий
                    }
                    result.push(elem);
                }
            }
            
            return result;
        },
        
        //массив свеч в кэше
        Candles : []
    },
    
    // пространство имен для локального хранилища
    LocalStorage: {
        // сохраняет в локальное хранилище
        save: function(_case, obj){
            var sObj = JSON.stringify(obj);
            localStorage.setItem(_case, sObj);
        },
        
        // получает из локального хранилища
        get: function(_case){
            return JSON.parse(localStorage.getItem(_case));
        },
        
        // удаляет из локального хранилища
        remove: function(_case){
            localStorage.removeItem(_case);
        }
    }
}

// объект свечи
var Candle = function(){};

Candle.prototype = {
    constructor: Candle,
    
    // добавляет тики к свече
    addTick: function (bid, ask, price) {
        if(price !== 0)  {
            this.ticks.push(new Tick(ask, bid, price));
        }
    },
    
    // возвращает объем свечи
    getVolume: function () {
        return this.volume;
    },
    
    // возвращает массив тиков
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

// объект тиков
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