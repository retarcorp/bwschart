var Delta = function(type) {
    this.CurType = type;
};

Delta.prototype = {
    
    flag: true,

    constructor: Delta,
    
    supervisorEnable: false,
    
    graphType: 'delta',

    GraphSettings: null,
    
    lastDeltaCandle: null,
    
    lastOrderCandle: null,

    Canvas: null, // DOM Element Canvas

    tmpCanvas: null,

    Ctx: null, //Ctx

    tmpCtx: null,

    imgData: null,

    Type: null, //тип события для обработки перемещения графика
    
    mouseFlag: false,
    
    cursorPositionX: 0,
    
    cursorPositionY: 0,
    
    visualSettings: null,
    
    cursorPositionXforFirstTouch: 0,
    
    cursorPositionYforFirstTouch: 0,
    
    cursorPositionXforSecTouch: 0,
    
    cursorPosirionYforSecTouch: 0,   
    
    requestInProcess: false, //флаг состояния отправки запроса
    
    flagForStartPrice: true, //флаг состояния для коректировки начальной цены
    
    flagForStartTs: true,
    
    spritesEdditor: false, //флаг состояния едитора спрайтов
    
    appFirstStartedFlag: true,// флаг первого запуска
    
    xCordCursorLine: 0, //координата по иксу курсора мыши
    
    yCordCursorLine: 0, //координата по игреку курсора мыши
    
    xDashLineSprite: null,//координата по иксу для пунктирной вертикальной линии
    
    yDashLineSprite: null,//координата по игреку для пунктирной горизонтальной линии
    
    priceFootnoteSprite: null, //спрайт индикатора цены
    
    timeFootnoteSprite: null,//спрайт индикатора времени
    
    sprites: [], //массив спрайтов
    
    daySprites: [],
    
    MarketProfileSprites: [],
    
    IsStartValueNotReceiced: true,
    
    days: [],
    
    visibleCandles: [],
    
    MarketProfileRedact: false,
    
    touch: false,
    
    cordForRectangleSprite: {
        first_x: 0,
        second_x: 0,
        first_y: 0,
        second_y: 0
    }, //координаты для построения спрайта прямоугольника
    
    cordForHorizontalLine: 0, //координата для постоянеия спрайта горизонтальной линии
    
    cordForVerticalLine: 0, //координата для построения спрайта вертикальной линии
    
    currentSprite: '', //текущий спрайт, который выбрали, что бы построить
    
    rectangleEdditor: false, 
    
    rectangleEdditorMobile: false,
    
    IsZoomBorderCrossing: false,
    
    IsAxesZoom: false,
    
    PreCordX: 0,
    
    PreCordY: 0,
    
    Indicators: [],
    
    IsVolumeIndicatorCreate: false,
    
    IsDeltaIndicatorCreate: false,
    
    IsOrderIndicatorCreate: false,
    
    CandleSprite: null,
    
    Till: 0,
    
    flagForStartPriceF: true,
    
    FirstIdOrder: 0,
    
    timeoutCurrentTime: null,
    
    init: function(canvas, callback){
        this.GraphSettings = new DeltaGraphSettings(
            20,
            0.00002,
            5,
            60
        );
        if (this.CurType === "delta") {
            this.visualSettings = App.deltaVisualSettings;
        } else if (this.CurType === 'footprint') {
            this.visualSettings = App.footprintVisualSettings;
        } else {
            this.visualSettings = App.orderVisualSettings;
        }
        
        this.Canvas = canvas;
        this.Ctx = this.Canvas.getContext("2d");
        this.tmpCanvas = document.createElement('canvas');
        this.tmpCtx = this.tmpCanvas.getContext('2d');
        if(this.CurType === 'footprint'){
            this.GraphSettings.setTimeFrame();
        }
        this.getDimensions();
        if(this.appFirstStartedFlag){
            this.createMainSprite();
        }
        this.tmpCtx.save();
        // this.loadMarketProfile();
        this.recursiveRender();
        
        this.buildCurrentPrice(this.recursiveRender());
        Graph.timer;
        callback();
    },
    
    createIndicator: function(type){
        // console.log("Включаем индикаторы")
        var gs = this.GraphSettings,
            volume = 'Volume',
            delta = 'Delta',
            indicators = this.Indicators,
            ctx = this.tmpCtx,
            gs = this.GraphSettings;
            // console.log('5')
            
        if(type === volume && this.IsVolumeIndicatorCreate && App.currentPlatform !== 'PC') {
            // console.log('2')
            for(var i = 0; i < this.Indicators.length; i++){
                if(this.Indicators[i].IndicatorType === volume){
                    this.Indicators.splice(i, 1);
                }
            }
            for(var i = 0; i < this.Indicators.length; i++){
                this.Indicators[i].setIndex(i);
            }
            this.IsVolumeIndicatorCreate = false;
        }
        else if(type === volume && !this.IsVolumeIndicatorCreate){
            // console.log('1')
            this.IsVolumeIndicatorCreate = true;
            var newIndicator = new Indicator(volume, indicators.length);
            indicators.push(newIndicator);
            gs.setIndicatorsProper(indicators);
        }
        else if(type === delta && !this.IsDeltaIndicatorCreate){
            // console.log('3')
            this.IsDeltaIndicatorCreate = true;
            var newIndicator = new Indicator(delta, indicators.length);
            indicators.push(newIndicator);
            gs.setIndicatorsProper(indicators);
        } 
        this.render();
    },
    
    getDimensions: function() {
        var div = document.getElementsByClassName('graph')[0];
        var styles = getComputedStyle(div);
        var gs = this.GraphSettings;
        this.Canvas.height = parseInt(styles.height);
        this.Canvas.width = parseInt(styles.width);
        this.tmpCanvas.height = parseInt(styles.height);
        this.tmpCanvas.width = parseInt(styles.width);
        gs.HEIGHT = this.Canvas.height;
        gs.WIDTH = this.Canvas.width;
        gs.FIXED_WIDTH = this.Canvas.width;
        gs.FIXED_HEIGHT = this.Canvas.height;
        gs.zoomRecount();
    },
    
    render: function(f) { 
        var gs = this.GraphSettings;
        gs.recount();
        this.resetCanvas();
        gs.lastCandleVisible = true;
        
        if(!gs.lastCandleVisible && Data.Cache.containsInterval(gs.START_POINT_ON_NULL, gs.OX_MS)){
            this.buildData(f, Data.Cache.get(gs.START_POINT_ON_NULL, gs.OX_MS), true); 
        }else{
            this.buildData(f, Data.Cache.get(gs.START_POINT_ON_NULL, gs.OX_MS), false); 
        }
        if (App.supervisor && !this.supervisorEnable && (Data.lastABI || Data.lastDelta || Data.lastFootprint)) {
            
            this.supervisorEnable = true;
            
            if (this.CurType === "delta") {
                Data.lastDelta = Data.Cache.Candles[Data.Cache.Candles.length-1];
                this.supervisorEnable = true;
                console.log('зашли в дельту')
                this.transform({
                    new_start_ox: (Data.lastDelta.index * gs.FIXED_TIME_STEP + gs.FIXED_WIDTH/2) * gs.OX_SCALE,
                    new_start_price: this.currentPrice.y - gs.pxToPrice(gs.HEIGHT / 2),
                });
                
            } else if(this.CurType === 'footprint') {
                Data.lastFootprint = Data.Cache.Candles[Data.Cache.Candles.length-1];
                this.supervisorEnable = true;
                this.transform({
                    new_start_ox: (Data.lastFootprint.index * gs.FIXED_TIME_STEP + gs.FIXED_WIDTH/2) * gs.OX_SCALE,
                    new_start_price: this.currentPrice.y - gs.pxToPrice(gs.HEIGHT / 2),
                });
            } else if (this.CurType === "ordertape"){
                var id1 = gs.getCurrentId(Data.Cache.Candles[0].id),    
                    id2 = gs.getCurrentId(Data.Cache.Candles[Data.Cache.Candles.length-1].id),
                    
                    new_start_ox = gs.getXCordForPx(id2 * gs.FIXED_TIME_STEP / 5)*gs.OX_SCALE,
                    new_start_price =  Data.lastABI.price - gs.pxToPrice(gs.HEIGHT / 2);
                    
                App.CurrentGraph.onDragged(new_start_ox - gs.WIDTH/2*gs.OX_SCALE, 0, true);
            }
            
        }
        
        
        if (!App.supervisor && this.supervisorEnable) {
            this.supervisorEnable = false;
        }
        
        
    },
    
    //flag, чтобы если мы запросили свечи, которых не хватает, но последняя при этом не видна, чтобы они отрисовались
    recursiveRender: function(flag){
        var t = this;
        this.render(function(flag){
            if(flag || t.isLastCandleVisible()){
                t.recursiveRender();
            }
        });  
    },
    
    recountCord: function(e){
        var gs = this.GraphSettings;
        this.cursorPositionX = (e.touches[0].clientX - 40) / gs.TOTAL_ZOOM;
        this.cursorPositionY = gs.realY(e.touches[0].clientY / gs.TOTAL_ZOOM);
        this.onMoveForCursor(e);
    },
    
    createHorizontalLine: function(e) {
        var gs = this.GraphSettings;
        var newSprite = new HorizontalLineSprite();
        if(e.type === "mousedown"){
            newSprite.y = this.cordForHorizontalLine;
            this.sprites.push(newSprite);
            this.spritesEdditor = false;
            Ui.addHelpBar('', false);
        }
        else if(e.type === "touchstart"){
            if(this.touch === true){
                this.recountCord(e);
                newSprite.y = this.cordForHorizontalLine;
                this.sprites.push(newSprite);
                this.spritesEdditor = false;
                Ui.addHelpBar('', false);
                this.touch = false;
            }
        }
    },
    
    createVerticalLine: function(e) {
        var gs = this.GraphSettings;
        var newSprite = new VerticalLineSprite();
        if(e.type === "mousedown" && App.currentPlatform === 'PC'){
            if(this.CurType !== 'ordertape'){
                newSprite.x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.cordForVerticalLine : this.cordForVerticalLine + 0.5 * gs.FIXED_TIME_STEP;
            }
            else {
                newSprite.x = this.cordForVerticalLine;
            }
        }
        else if(e.type === "touchstart"){
            if(this.touch === true){
                this.recountCord(e);
                newSprite.x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.cordForVerticalLine : this.cordForVerticalLine + 0.5 * gs.FIXED_TIME_STEP;
                this.touch = false;
            }
        }
        this.sprites.push(newSprite);
        this.spritesEdditor = false;
        Ui.addHelpBar('', false);
    },
    
    getTotalValue: function(f_x, s_x, f_y, s_y) {
        // console.log(f_x, s_x, f_y, )
        if (this.CandleSprite) {
            var gs = this.GraphSettings,
                ret = {
                    val: 0,
                    ticks: []
                },
                nTicks = [],
                sprites = this.CandleSprite,
                maxValX = (f_x > s_x) ? f_x : s_x,
                minValX = (f_x > s_x) ? s_x : f_x,
                maxValY = (f_y > s_y) ? f_y : s_y,
                minValY = (f_y > s_y) ? s_y : f_y,
                length = sprites.length,
                fixed_time_step = gs.FIXED_TIME_STEP;
            if(sprites !== undefined){
                for(var count = 0; count < length; count++){
                    if(sprites[count].index * fixed_time_step >= minValX - 0.5 * fixed_time_step  && sprites[count].index * fixed_time_step <= maxValX){
                        // console.log(ticks)
                        var ticks = sprites[count].getTicks();
                        if(ticks !== undefined){
                            var len = ticks.length;
                            for(var i = 0; i < len; i++){
                                if(ticks[i].price >= minValY && ticks[i].price <= maxValY){
                                    ret.val += ticks[i].ask + ticks[i].bid;
                                    var n = ticks[i].bid + ticks[i].ask,
                                        pr = ticks[i].price;
                                    var obj = {};
                                    obj[pr] = n;
                                    
                                    nTicks.push(obj);
                                }
                            }
                        }
                    }
                }
            }
            // console.log(nTicks)
            var lnt = nTicks.length,
                coun = 0;
            
            nTicks.sort(function(a, b){
                return Object.keys(a)[0] - Object.keys(b)[0];
            });
            for(var i = 0; i < lnt; i++){
                for(var j = i+1; j < lnt; j++){
                    if(Object.keys(nTicks[i])[0] === Object.keys(nTicks[j])[0]){
                        nTicks[i][Object.keys(nTicks[i])[0]] += nTicks[j][Object.keys(nTicks[j])[0]];
                        // count++;
                        // nTicks.splice(j, 1);
                    }
                }
            }
            ret.ticks.push(nTicks[0]);
            for(var i = 1; i < lnt; i++){
                if(Object.keys(nTicks[i])[0] !== Object.keys(nTicks[i-1])[0])
                    ret.ticks.push(nTicks[i]);
            }
            ret.ticks.sort(function(a, b){
                return b[Object.keys(b)[0]] - a[Object.keys(a)[0]];
            });
            return ret;
        } else return { val: 0, ticks: []}
        
    },
    
    createRectangle: function() {
        var gs = this.GraphSettings;
        var newSprite = new RectangleSprite();
        
        if(this.CurType !== 'ordertape'){
            newSprite.f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.cordForRectangleSprite.first_x : this.cordForRectangleSprite.first_x + 0.5 * gs.FIXED_TIME_STEP;
            newSprite.s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.cordForRectangleSprite.second_x : this.cordForRectangleSprite.second_x + 0.5 * gs.FIXED_TIME_STEP;
        }
        else {
            newSprite.f_x = this.cordForRectangleSprite.first_x;
            newSprite.s_x = this.cordForRectangleSprite.second_x;
        }
        newSprite.f_y = this.cordForRectangleSprite.first_y;
        newSprite.s_y =this.cordForRectangleSprite.second_y;
        this.sprites.push(newSprite);
        Ui.addHelpBar('', false);
    },
    
    createMarketProfile: function() {
        // console.log('create mp')
        var gs = this.GraphSettings;
        var newSprite = new MarketSprite();
        
        var f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.cordForRectangleSprite.first_x : this.cordForRectangleSprite.first_x + gs.FIXED_TIME_STEP;
        var s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.cordForRectangleSprite.second_x : this.cordForRectangleSprite.second_x + gs.FIXED_TIME_STEP;
        newSprite.f_x = this.findCandleTsByCord(f_x)/1000;
        newSprite.f_y = this.cordForRectangleSprite.first_y;
        newSprite.s_x = this.findCandleTsByCord(s_x)/1000;
        newSprite.s_y = this.cordForRectangleSprite.second_y;
        
        Ui.addHelpBar('', false);
        
        var last = newSprite;
        
        if(this.CurType === 'delta'){
            last.send = {
                id: 0,
                instrument: App.CurrentGraph.INSTRUMENT,
                delta: App.CurrentGraph.DELTA,
                startTS: (newSprite.f_x < newSprite.s_x) ? newSprite.f_x : newSprite.s_x,
                endTS: (newSprite.f_x > newSprite.s_x) ? newSprite.f_x : newSprite.s_x,
                startPrice: (newSprite.f_y < newSprite.s_y) ? newSprite.f_y : newSprite.s_y,
                endPrice: (newSprite.f_y > newSprite.s_y) ? newSprite.f_y : newSprite.s_y
            }
        }
        else if(this.CurType === 'footprint'){
            last.send = {
                id: 0,
                instrument: App.CurrentGraph.INSTRUMENT,
                timeframe: gs.TIMEFRAME,
                startTS: (newSprite.f_x < newSprite.s_x) ? newSprite.f_x : newSprite.s_x,
                endTS: (newSprite.f_x > newSprite.s_x) ? newSprite.f_x : newSprite.s_x,
                startPrice: (newSprite.f_y < newSprite.s_y) ? newSprite.f_y : newSprite.s_y,
                endPrice: (newSprite.f_y > newSprite.s_y) ? newSprite.f_y : newSprite.s_y
            }
        }
        Data.postMarketProfile([last.send]);
    },
    
    findCandleTsByCord: function(cord) {
        if(this.CurType === 'delta'){
            return this.findDeltaCandleTsByCord(cord);
        }
        else if(this.CurType === 'footprint'){
            return this.findFootprintCandleTsByCord(cord);
        }
    },
    
    findDeltaCandleTsByCord: function(cord) {
        var candles = Data.Cache.Candles,
            len = candles.length,
            ret = 0,
            gs = this.GraphSettings,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            timestep = gs.FIXED_TIME_STEP,
            // findIndex = (cord - 0.5 * timestep) / timestep,
            findIndex = (!this.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? Math.ceil((cord - 0.5 * timestep) / timestep) : Math.floor((cord - 0.5 * timestep) / timestep),
            findFlag = false;
        candles.forEach(function(candle){
             if(candle.index === findIndex) {
                 findFlag = true;
                 ret = candle.startTS;
             }
        });
        if(!findFlag) {
            if(findIndex < candles[0].index){
                ret = candles[0].startTS;
            }
            else if(findIndex >candles[len - 1].index) {
                ret = candles[len - 1].startTS;
            }
        }
        return ret;
    },
    
    findFootprintCandleTsByCord: function(cord) {
        var candles = Data.Cache.Candles,
            len = candles.length,
            ret = 0,
            gs = this.GraphSettings,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            timestep = gs.FIXED_TIME_STEP,
            // findIndex = Math.floor((cord - 0.5 * timestep) / timestep),
            findIndex = (!this.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? Math.ceil((cord - 0.5 * timestep) / timestep) : Math.floor((cord - 0.5 * timestep) / timestep),
            findFlag = false;
        candles.forEach(function(candle){
             if(candle.index === findIndex) {
                 findFlag = true;
                 ret = candle.from;
             }
        });
        if(!findFlag) {
            if(findIndex < candles[0].index){
                ret = candles[0].from;
            }
            else if(findIndex >candles[len - 1].index) {
                ret = candles[len - 1].from;
            }
        }
        return ret;
    },
    
    findeCandleCordByTs: function(ts) {
        ts *= 1000;
        if(this.CurType === 'delta'){
            return this.findDeltaCandleCordByTs(ts);
        }
        else if(this.CurType === 'footprint'){
            return this.findFootprintCandleCordByTs(ts);
        }
    },
    
    findDeltaCandleCordByTs: function(ts) {
        var candles = Data.Cache.Candles,
            len = candles.length,
            ret = 0,
            gs = this.GraphSettings,
            timestep = gs.FIXED_TIME_STEP,
            findFlag = false;
        candles.forEach(function(candle){
             if(candle.startTS === ts) {
                 findFlag = true;
                 ret = candle.index * timestep;
             }
        });
        if(!findFlag) {
            if(ts < candles[0].startTS){
                ret = candles[0].index * timestep;
            }
            else if(ts >candles[len - 1].startTS) {
                ret = candles[len - 1].index * timestep;
            }
        }
        ret += 0.5 * timestep;
        return ret;
    },
    
    findFootprintCandleCordByTs: function(ts) {
        var candles = Data.Cache.Candles,
            len = candles.length,
            ret = 0,
            gs = this.GraphSettings,
            timestep = gs.FIXED_TIME_STEP,
            findFlag = false;
        candles.forEach(function(candle){
             if(candle.from === ts) {
                 findFlag = true;
                 ret = candle.index * timestep;
             }
        });
        if(!findFlag) {
            if(ts < candles[0].from){
                ret = candles[0].index * timestep;
            }
            else if(ts >candles[len - 1].from) {
                ret = candles[len - 1].index * timestep;
            }
        }
        ret += 0.5 * timestep;
        return ret;
    },
    
    loadMarketProfile: function(ins, ans) {
        // console.log('load mp')
        var gs = this.GraphSettings,
            timestep = gs.TIME_STEP / gs.GRADE;
        
        
        if (!ins) {
            if(this.CurType === 'delta'){
                Data.getMarketProfileForDeltaGraph();
            }
            else if(this.CurType === 'footprint'){
                // console.log('!ins type footprint')
                Data.getMarketProfileForFootprintGraph();
            }
        } else {
            if (ans.length) {
                // console.log('ins')
                let res = JSON.parse(ans),
                    MarketArr = [],
                    push = true;
                
                this.clearSprites({type: 'Market'});
                this.MarketProfileSprites = [];
                
                res.forEach( (elem) => {
                    this.MarketProfileSprites.forEach( (market) => {
                        if (market.send.id === elem.id) {
                            push = false;
                        }
                    });
                    
                    if (push) {
                        // console.log('push mp(load mp)')
                        MarketArr.push(new MarketSprite());
                    
                        MarketArr[MarketArr.length - 1].f_x = elem.startTS;
                        MarketArr[MarketArr.length - 1].s_x = elem.endTS;
                    
                        // MarketArr[MarketArr.length - 1].f_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? elem.startTS : elem.startTS + 0.5 * timestep;
                        // MarketArr[MarketArr.length - 1].s_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? elem.endTS : elem.endTS + 0.5 * timestep;
                        MarketArr[MarketArr.length - 1].f_y = elem.startPrice;
                        MarketArr[MarketArr.length - 1].s_y = elem.endPrice;
                        
                        // elem.startTS = MarketArr[MarketArr.length - 1].f_x;
                        // elem.endTS = MarketArr[MarketArr.length - 1].s_x;
                        
                        MarketArr[MarketArr.length - 1].send = elem;
                        
                        this.sprites.push(MarketArr[MarketArr.length - 1]); 
                        // console.log(this.sprites)
                    } 
                    else {
                        push = true;
                    }
                });
                
                MarketArr.forEach( (elem) => {
                     this.MarketProfileSprites.push(elem);
                });
                
            }
        }
        
    },
    
    updateMarketProfile: function(market) {
        if(this.CurType === 'delta'){
            market.send = {
                id: market.send.id,
                instrument: market.send.instrument,
                delta: market.send.delta,
                startTS: (market.f_x < market.s_x) ? market.f_x : market.s_x,
                endTS: (market.f_x > market.s_x) ? market.f_x : market.s_x,
                startPrice: (market.f_y < market.s_y) ? market.f_y : market.s_y,
                endPrice: (market.f_y > market.s_y) ? market.f_y : market.s_y
            }
        }
        else if(this.CurType === 'footprint'){
            // console.log('update mp type = footprint')
            market.send = {
                id: market.send.id,
                instrument: market.send.instrument,
                timeframe: market.send.timeframe,
                startTS: (market.f_x < market.s_x) ? market.f_x : market.s_x,
                endTS: (market.f_x > market.s_x) ? market.f_x : market.s_x,
                startPrice: (market.f_y < market.s_y) ? market.f_y : market.s_y,
                endPrice: (market.f_y > market.s_y) ? market.f_y : market.s_y
            }
            // console.log('startTS = ' + market.send.startTS, 'endTS = ' + market.send.endTS)
        }
    },
    
    createMainSprite: function() {
        var gs = this.GraphSettings;
        this.appFirstStartedFlag = false;
        this.xDashLineSprite = new XDashLineSprite();
        this.yDashLineSprite = new YDashLineSprite();
        this.priceFootnoteSprite = new PriceFootnoteSprite();
        this.currentPriceLine = new HorizontalLineSprite('CurrentPrice');
        this.currentPrice = new PriceFootnoteSprite();
        this.timeFootnoteSprite = new TimeFootnoteSprite();
        
        if(this.CurType === 'delta'){
            this.IsDeltaIndicatorCreate = true;
            var indicators = this.Indicators;
            
            if(indicators.length === 0){
                var newIndicator = new Indicator('Delta', indicators.length);
                indicators.push(newIndicator);
                gs.setIndicatorsProper(indicators);
            }
        }
        if(this.CurType === 'ordertape') {
            this.IsOrderIndicatorCreate = true;
            var indicators = this.Indicators;
            var newIndicator = new Indicator('Order', indicators.length);
            indicators.push(newIndicator);
            gs.setIndicatorsProper(indicators);
        }
        
        // var indicators = this.Indicators;
        // if(indicators.length === 0){
        //     var newIndicator = new Indicator('Delta', indicators.length);
        //     indicators.push(newIndicator);
        //     gs.setIndicatorsProper(indicators);
        // }
    },
    
    removeAllSprites: function() {
        this.spritesEdditor = false;
        
        this.MarketProfileSprites.forEach( (market) => {
            Data.deleteMarketProfile(market.send.id);
        });
        
        this.sprites.splice(0, this.sprites.length);
        this.MarketProfileSprites.splice(0, this.MarketProfileSprites.length);
    },
    
    createSprite: function(e){
        if(this.spritesEdditor){
            // console.log(this.currentSprite)
            switch(this.currentSprite){
                case 'horizontal-line': this.createHorizontalLine(e); break;
                case 'vertical-line': this.createVerticalLine(e); break;
                case 'rectangle': this.rectangleEdditor = true; this.rectangleEdditorMobile = true; break;
                case 'market-profile': this.rectangleEdditor = true; this.rectangleEdditorMobile = true; this.marketEdditor = true; break;
                // case 'move': console.log(this.currentSprite); break;
                case 'remove': this.findSprite(e); break;
            }
        }
    },
    
    clearSprites: function(clear) {
        if (typeof clear == "object") {
            var length = this.sprites.length;
            var buf = [];
            
            this.sprites.forEach( (sprite) =>  {
                if (sprite.type !== clear.type) {
                    buf.push(sprite);
                }
            });
             
            this.sprites = buf;
             
        }
        
        // console.log(this.sprites.length);
        // console.log(this.sprites);
    },
    
    findSprite: function(e) {
        if(this.sprites !== undefined){
            for(var i = this.sprites.length - 1; i >= 0; i--){
                
                 if(this.GraphSettings.findeSpriteCord(this.sprites[i], e))
                {
                    if (this.sprites[i].type == "Market") {
                        Data.deleteMarketProfile(this.sprites[i].send.id);
                    }
                    
                    this.sprites.splice(i, 1);
                    break;
                }
            }
        }
        this.spritesEdditor = false;
        Ui.addHelpBar('', false);
    },
    
    resetCanvas: function() {
        this.tmpCtx.fillStyle = this.visualSettings.DIR_BG;
        this.tmpCtx.fillRect(0, 0, this.GraphSettings.WIDTH, this.GraphSettings.HEIGHT);
        this.drawGrid();//отрисовка сетки 
    },
    
    buildCurrentPrice: function(f) {
        Graph.timer = setTimeout(this.buildCurrentPrice.bind(this), 5000, f);
        Graph.requestInProcessForCurrentPrice = true;
        Data.getStartValue(App.CurrentGraph.INSTRUMENT, f, false);
    },
    
    buildData: function(f, candles, isFullIntervalInCache) {
        var t = this;
        var gs = App.CurrentGraph.GraphSettings;
        
        this.currentPriceLine.renderIfVisible();  
        
        
        if(App.CurrentGraph.IsStartValueNotReceiced && this.CurType === 'footprint'){
            App.CurrentGraph.IsStartValueNotReceiced = false;
            Graph.requestInProcess = true;
            Data.getStartValue(App.CurrentGraph.INSTRUMENT, f, true);
        }
        else if(this.flagForStartPrice && !Graph.requestInProcess && !App.CurrentGraph.IsStartValueNotReceiced && this.CurType === 'footprint') {
            gs.MIDDLE_PRICE = Data.LastValue.price;
            gs.START_TS = 1 * Data.LastValue.date + 3 * gs.TIMEFRAME_TS;
            this.flagForStartPrice = false;
            gs.setStartPrice();
        }
        
        if(t.flagForStartPrice && candles.length !== 0 && this.CurType !== 'footprint'){
            App.CurrentGraph.IsStartValueNotReceiced = false;
            var middle_price = 0;
            for(var i = candles.length - 1; i >= 0; i--){
                
                if(t.CurType === 'ordertape') {
                    if(candles[i].maxPrice !== 0){
                        middle_price = candles[i].maxPrice;
                        break;
                    }
                      
                }
                else {
                    if(candles[i].start_price !== 0){
                        middle_price = candles[i].start_price;
                        break;
                    }
                }
            }
            
            gs.MIDDLE_PRICE = (middle_price === 0) ? Data.LocalStorage.get('start_price' + App.CurrentGraph.INSTRUMENT) : middle_price;
            
            this.FirstIdOrder = Data.rightOrderCandle.id;
            t.flagForStartPrice = false;
            gs.setStartPrice();
        } 
        if(isFullIntervalInCache){
            t.buildSprites(candles);
            this.drawMainGraph();
        }else{
            if(candles.length!==0){
                t.buildSprites(candles);
            }
            //  var ts = 0;
            var index = gs.getCandleIndex();
            if(this.CurType === 'delta'){
                App.CurrentGraph.getSprites(f, index);
            }
            else if(this.CurType === 'ordertape') {
                App.CurrentGraph.getSprites(f, index*5 + this.FirstIdOrder);
            }
            else if(this.CurType === 'footprint' && !this.flagForStartPrice) {
                App.CurrentGraph.getSprites(f, index);
            }
            // App.CurrentGraph.getSprites(f/*, ts*/, index/*, pos*/);
            this.drawMainGraph(candles);
        }
    },
    
    buildIndicators: function(candles) {
        var t = this,
            ctx = this.tmpCtx,
            gs = this.GraphSettings;
        
        for(var i = this.Indicators.length - 1; i >= 0; i--){
            this.Indicators[i].onGraphRender(candles, ctx, gs);
        }
    },

    //просто создание спрайтов и отрисовка
    
    buildSprites: function (candles) {
        // console.log('buildSprites');
        var t = this,
            ctx = this.tmpCtx,
            gs = this.GraphSettings;
        
        var sprites = candles.map(function(candle){
            if(t.CurType === 'ordertape') {
                return new CandleSpriteOrderTape(candle);
            }
            else if(t.CurType === 'footprint'){
                return new CandleSprite(candle);
            }
            else {
                return new CandleSpriteDelta(candle);
            }
        });
        
        if(this.sprites !== undefined){
            this.sprites.forEach(function(elem){
                sprites.push(elem);
            });
            this.daySprites.forEach(function(elem){
                sprites.push(elem);
            });
        }
        
       sprites.forEach(function(candle){
            candle.renderIfVisible();
       });
       
            
    },
    
    buildTimeSprites: function(candles) {
        var gs = this.GraphSettings,
            ctx = ctx = App.CurrentGraph.tmpCtx,
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            t = this,
            bufVis = [],
            vis = false;
        // if(this.CurType !== 'ordertape'){
            ctx.fillStyle = this.visualSettings.DIR_TIME_FILL;
        // }
        // else {
        //     ctx.fillStyle = this.visualSettings.DIR_TIME_FILL;
        // }
        ctx.fillRect(0, gs.HEIGHT - bottom_indent, gs.WIDTH - right_indent, bottom_indent);
        ctx.strokeStyle = "#000";
        ctx.beginPath();
        ctx.moveTo(0, gs.HEIGHT - bottom_indent);
        ctx.lineTo(gs.WIDTH - right_indent, gs.HEIGHT - bottom_indent);
        ctx.stroke();
        
        var sprites = candles.map(function(candle){
            if(t.CurType === 'ordertape') {
                return new CandleSpriteOrderTape(candle);
            }
            else if(t.CurType === 'footprint'){
                return new CandleSprite(candle);
            }
            else {
                return new CandleSpriteDelta(candle);
            }
        });
        sprites.forEach(function(candle){
            vis = candle.timeRenderIfVisible();
            if (candle.type == "Candle" && candle.Candle && candle.Candle.volume) {
                if (vis) bufVis.push(candle);
            }
        }); 
        
        this.visibleCandles = bufVis;
        
        this.drawEndLines("day");
        
        this.CandleSprite = candles;
        
    },
    
    drawMainGraph: function(candles) {
        this.fillRect();
        this.drawAxes();
        this.drawGridMarks();
        if(this.Indicators.length !== 0 && candles !== undefined){
            this.buildIndicators(candles);
        }
        this.yDashLineSprite.renderIfVisible();
        this.priceFootnoteSprite.renderIfVisible();
        this.currentPrice.renderIfVisible();
        this.buildTimeSprites(candles);
        this.xDashLineSprite.renderIfVisible();
        this.timeFootnoteSprite.renderIfVisible();
        
        
        this.transferImgData();
    },
    
    drawEndLines: function(type) {
        //console.log(this.candlesInTime);
        
        var gs = this.GraphSettings,
            gp = App.CurrentGraph,
            day = "",
            candleDay = "";
        // if(gs.TIMEFRAME != 'D1') {
        this.visibleCandles.forEach( (Candle, i, mas) => {
            if(this.CurType !== 'footprint'){
                var cy = new Date(Candle.Candle.startTS).getFullYear(),
                    cm = new Date(Candle.Candle.startTS).getMonth(),
                    cd = new Date(Candle.Candle.startTS).getDate(),
                    adderM ="",
                    adderD = "";
            }
            else {
                var cy = new Date(Candle.Candle.from).getFullYear(),
                    cm = new Date(Candle.Candle.from).getMonth(),
                    cd = new Date(Candle.Candle.from).getDate(),
                    adderM ="",
                    adderD = "";
            }
                
            if ( cm < 10 ) adderM = "0";
            if ( cd < 10 ) adderD = "0";
            
            candleDay = cy+"-"+adderM+cm+"-"+adderD+cd;
            
            var check = 0; 
            if(i < mas.length - 1) {
                if(gs.TIMEFRAME != 'D1') {
                    switch(this.CurType) {
                        default: check = new Date(mas[i+1].Candle.startTS).getHours() - new Date(Candle.Candle.startTS).getHours(); break;
                        // case 'delta': check = new Date(mas[i+1].Candle.startTS).getHours() - new Date(Candle.Candle.startTS).getHours(); break;
                        case 'footprint': check = new Date(mas[i+1].Candle.from).getHours() - new Date(Candle.Candle.from).getHours(); break;
                        // case 'ordertape': check = new Date(mas[i+1].Candle.startTS).getHours() - new Date(Candle.Candle.startTS).getHours(); break;
                    }
                }
                else {
                    check = new Date(Candle.Candle.from).getMonth() - new Date(mas[i+1].Candle.from).getMonth();
                }

                if (check < 0 && !this.days.find( function(elem){
                    if (elem == candleDay) {
                        return true;
                    }
                } )) {
                    gp.candleStartDay = Candle.Candle;
                }
            }
        });
        if ( ( gp.candleStartDay && !gp.candleStartDay.flag ) ) {
            let v = (gs.TIMEFRAME != 'D1') ? new VerticalLineSprite("day") : new VerticalLineSprite("month");
            v.x = (gp.candleStartDay.index + 0.5) * gs.FIXED_TIME_STEP;
            if(this.CurType !== 'footprint'){
                var y = new Date(gp.candleStartDay.startTS).getFullYear(),
                    m = new Date(gp.candleStartDay.startTS).getMonth(),
                    d = new Date(gp.candleStartDay.startTS).getDate();
            }
            else {
                var y = new Date(gp.candleStartDay.from).getFullYear(),
                    m = new Date(gp.candleStartDay.from).getMonth(),
                    d = new Date(gp.candleStartDay.from).getDate();
            }
            
            adderM = (m < 10) ? "0" : "";
            adderD = (d < 10) ? "0" : "";
            
            // if (m < 10) adderM = "0"; else adderM = "";
            
            // if (d < 10) adderD = "0"; else adderD = "";
            
            day = y+"-"+adderM+m+"-"+adderD+d;
            
            this.days.push(day);
            
            gp.candleStartDay.flag = true;
            
            gp.daySprites.push(v);
        }
        
        gp.candleStartDay = null;
        gp.candleEndDay = null;
        gp.candleEndMonth = null;
        
    },
    
    fillRect: function() {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        ctx.fillStyle = "#ffffff";
        ctx.fillRect(0, gs.HEIGHT - bottom_indent, gs.WIDTH, bottom_indent);//заливка нижнего пространства
        ctx.fillRect(gs.WIDTH - right_indent, 0, right_indent, gs.HEIGHT);//заливка правого пространства
    },
    
    drawAxes: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var px = gs.PERFECT_PX;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        var centerX = gs.WIDTH - right_indent;
        var centerY = Math.ceil(gs.HEIGHT - bottom_indent);

        ctx.strokeStyle = '#000000';
        ctx.lineWidth = gs.LINE_WIDTH;
        ctx.beginPath();
        ctx.moveTo(0, centerY + px); //левый нижний угол
        ctx.lineTo(centerX + px, centerY + px); //центр
        ctx.lineTo(centerX + px, px); //правый верхний угол 
        ctx.moveTo(0, gs.HEIGHT - delta_indent + px);
        ctx.lineTo(centerX + px, gs.HEIGHT - delta_indent + px);
        ctx.moveTo(0, Math.ceil(gs.HEIGHT - (delta_indent - bottom_indent)/2 - bottom_indent) + px);
        ctx.lineTo(centerX + px, Math.ceil(gs.HEIGHT - (delta_indent - bottom_indent)/2 - bottom_indent) + px);
        ctx.stroke();
    },
    
    transferImgData: function () {
        this.Ctx.putImageData(this.tmpCtx.getImageData(0, 0, this.GraphSettings.WIDTH, this.GraphSettings.HEIGHT), 0, 0);
    },

    //отрисовка сетки на графике
    drawGrid: function () {
        var ctx = this.tmpCtx;
        ctx.strokeStyle = this.visualSettings.DIR_GRID;
        ctx.lineWidth = App.CurrentGraph.GraphSettings.LINE_WIDTH;
        this.drawXGrid();
        this.drawYGrid();
    },

    //отрисовка вертикальных линий
    drawXGrid: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings,
            px = gs.PERFECT_PX,
            pixelsPerGridMark = gs.TIME_STEP,
            smallIntervalPixelsWidth = gs.calculateIndentOnX(),
            currentW = smallIntervalPixelsWidth,
            delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE,
            centerY = gs.HEIGHT - delta_indent;
        ctx.beginPath();
        while (currentW < gs.WIDTH) {
            var xCord = Math.ceil(currentW) + px;
            ctx.moveTo(xCord, centerY + px);
            ctx.lineTo(xCord, px);
            currentW += pixelsPerGridMark;
        }
        ctx.stroke();
    },

    //отрисовка горизонтальных линий
    drawYGrid: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        var px = gs.PERFECT_PX,
            pixelsPerGridMark = gs.PRICE_STEP, // Pixels in one vertical mark on Y grid
            smallIntervalPixelsHeight = gs.calculateIndentOnY(),
            currentH = delta_indent + smallIntervalPixelsHeight,
            centerX = gs.WIDTH - right_indent + px;
        ctx.beginPath();
        while (currentH < gs.HEIGHT) {
            var yCord = gs.HEIGHT - Math.floor(currentH) + px;
            ctx.moveTo(centerX, yCord);
            ctx.lineTo(px, yCord);
            currentH += pixelsPerGridMark;
        }
        ctx.stroke();
    },

    drawGridMarks: function () { 
        this.drawYGridMarks();
    },

    drawYGridMarks: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var px = gs.PERFECT_PX,
            pricePerPixel = gs.PRICE_PER_PX, // How many PRICE units in 1 PIXEL currently
            pixelsPerGridMark = gs.PRICE_STEP, // Pixels in one vertical mark on Y grid
            startPrice = gs.START_PRICE; // Price units on zero point in corner of graph

        // var priceUnitsInGridMark = pixelsPerGridMark * pricePerPixel;
        var priceUnitsInGridMark = gs.round(pixelsPerGridMark * pricePerPixel, gs.ROUNDING);

        var firstGridMarkPrice = (startPrice % priceUnitsInGridMark ) ?
            (startPrice + priceUnitsInGridMark - startPrice % priceUnitsInGridMark)
            : startPrice + priceUnitsInGridMark; // Price on first grid mark visible on axe

        if (startPrice < 0) {
            firstGridMarkPrice -= priceUnitsInGridMark;
        }
        var smallIntervalPixelsHeight = gs.calculateIndentOnY();
        
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var indent = (App.currentPlatform === 'PC') ? gs.RIGHT_TEXT_INDENT : gs.RIGHT_TEXT_INDENT_MOBILE;
        
        var currentH = delta_indent + smallIntervalPixelsHeight,
            currentGridMarkPrice = firstGridMarkPrice,
            centerX = gs.WIDTH - right_indent + px,
            cord_of_mark_X = gs.WIDTH - right_indent + gs.HATCH_LENGHT;
            
        ctx.fillStyle = this.visualSettings.DIR_PRICE_FILL;
        ctx.fillRect(gs.WIDTH - right_indent, 0, right_indent, gs.HEIGHT);
        ctx.beginPath();
        ctx.moveTo(gs.WIDTH - right_indent, 0);
        ctx.lineTo(gs.WIDTH - right_indent, gs.HEIGHT - bottom_indent);
        ctx.stroke();
        
        // console.log('gridMarks: ',smallIntervalPixelsHeight, gs.calculateIndentOnY());
        ctx.lineWidth = gs.LINE_WIDTH;
        ctx.fillStyle = this.visualSettings.DIR_PRICE_TEXT; 
        ctx.strokeStyle = '#000000';
        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        
        // ctx.strokeStyle = this.visualSettings.DIR_PRICE_TEXT; 
        ctx.beginPath();
        while (currentH < gs.HEIGHT) {
            // console.log(currentH, gs.HEIGHT)
            var xCord = gs.WIDTH - right_indent + indent;
            var yCord = gs.HEIGHT - Math.ceil(currentH) + px;
            ctx.moveTo(centerX, yCord);
            ctx.lineTo(cord_of_mark_X, yCord);
            ctx.fillText(currentGridMarkPrice.toFixed(gs.ROUNDING), xCord, yCord);
            currentH += pixelsPerGridMark;
            currentGridMarkPrice += priceUnitsInGridMark;
        }
        ctx.stroke();
    },

    dragByButtons: function (e) {
        var gs = this.GraphSettings;
        var left = 37,
            up = 38,
            right = 39,
            down = 40,
            speed = gs.SPEED_OF_MOVING_GRAPH,
            val = 0; //value of dragging
        switch (e.keyCode) {
            case left:
                val = -gs.TIME_STEP;//-gs.pxToTime(speed);
                this.onDragged(val, 'left');
                break;
            case up:
                val = gs.PRICE_STEP / gs.PRICE_POINTS;//gs.pxToPrice(speed);
                this.onDragged(val, 'up');
                break;
            case right:
                val = gs.TIME_STEP;//gs.pxToTime(speed);
                this.onDragged(val, 'right');
                break;
            case down:
                val = -gs.PRICE_STEP / gs.PRICE_POINTS;//-gs.pxToPrice(speed);
                this.onDragged(val, 'down');
                break;
        }
        this.onMoveForCursor();
    },
    
    //нажатие левой кнопки мыши
    onDown: function (e) {
        var gs = this.GraphSettings;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        var zoom = gs.TOTAL_ZOOM;
        if(e.type === 'mousedown' && App.currentPlatform === 'PC'){
            this.findIndicatorZoneClose(e, gs);
            var x = (e.clientX - 40) / zoom,
                y = e.clientY / zoom;
                
            var marketSprites = this.MarketProfileSprites;
            
            if (marketSprites.length) {
                marketSprites.forEach( (elem) => {
                   var maxValX = (elem.f_x > elem.s_x) ? elem.f_x : elem.s_x,
                       minValX = (elem.f_x > elem.s_x) ? elem.s_x : elem.f_x,
                       maxValY = (elem.f_y > elem.s_y) ? elem.f_y : elem.s_y,
                       minValY = (elem.f_y > elem.s_y) ? elem.s_y : elem.f_y;
                    
                   // console.log(this.cordForHorizontalLine);
                   if (App.CurrentGraph.IsZoomBorderCrossing) {
                       tfV = 0;
                   }
                    
                    var leftCheck = x - elem.f_x_px,
                        rightCheck = x - elem.s_x_px,
                        bottomCheck = y - elem.s_y_px,
                        topCheck = y - elem.f_y_px;
                    
                    if (leftCheck < 10 && leftCheck > -10 && y > elem.f_y_px && y < elem.s_y_px) {
                        elem.redact = true;
                        elem.r_type = 'left';
                        this.MarketProfileRedact = true;
                    } 
                    
                    if (rightCheck < 10 && rightCheck > -10 && y > elem.f_y_px && y < elem.s_y_px) {
                        elem.redact = true;
                        elem.r_type = 'right';
                        this.MarketProfileRedact = true;
                    }
                    
                    if (bottomCheck < 10 && bottomCheck > -10 && x > elem.f_x_px && x < elem.s_x_px) {
                        elem.redact = true;
                        elem.r_type = 'down';
                        this.MarketProfileRedact = true;
                    }
                    
                    if (topCheck < 10 && topCheck > -10 && x > elem.f_x_px && x < elem.s_x_px) {
                        elem.redact = true;
                        elem.r_type = 'up';
                        this.MarketProfileRedact = true;
                    }
                });
            }    
            
            if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - delta_indent)) {
                if(this.rectangleEdditor){
                    this.cordForRectangleSprite.first_x = this.xDashLineSprite.x;
                    this.cordForRectangleSprite.first_y = this.yDashLineSprite.y;
                } else if (!this.MarketProfileRedact) {
                    this.mouseFlag = true;
                    this.cursorPositionX = x;
                    this.cursorPositionY = gs.realY(y);
                    this.PreCordX = x;
                    this.PreCordY = gs.realY(y);
                    this.onMoveForCursor(e);
                }
            }
        }
        else if(e.type === 'touchstart'){
            var x = (e.touches[0].clientX - 40) / zoom,
                y = e.touches[0].clientY / zoom;
            if(e.touches.length === 1){
                if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent)) {
                    if(this.rectangleEdditor && this.rectangleEdditorMobile){
                        this.recountCord(e);
                        this.cordForRectangleSprite.first_x = this.xDashLineSprite.x;
                        this.cordForRectangleSprite.first_y = this.yDashLineSprite.y;
                        this.rectangleEdditorMobile = false;
                        App.clickForEvent = false;
                    }
                    else if(this.rectangleEdditor){
                        this.recountCord(e);
                        this.cordForRectangleSprite.second_x = this.xDashLineSprite.x;
                        this.cordForRectangleSprite.second_y = this.yDashLineSprite.y;
                        if(!this.marketEdditor) {
                            this.createRectangle();
                        }
                        else {
                            this.createMarketProfile();
                        }
                        this.rectangleEdditor = false;
                        this.spritesEdditor = false;
                    }
                    else {
                        this.mouseFlag = true;
                        this.recountCord(e);
                    }
                }
            }
            else if(e.touches.length === 2){
                var x1 = (e.touches[1].clientX - 40) / zoom,
                    y1 = e.touches[1].clientY / zoom;
                if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent) && (x1 <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent)) {
                    this.cursorPositionXforFirstTouch = x;
                    this.cursorPositionYforFirstTouch = gs.realY(y);
                    this.cursorPositionXforSecTouch = x1;
                    this.cursorPositionYforSecTouch = gs.realY(y1);
                }
            }
        }
    },
    
    findIndicatorZoneClose: function(e, gs) {
        if(this.Indicators.length !== 0){
            var t = this;
            this.Indicators.forEach(function(elem){
                var ind = elem.onMouseClick(e, gs);
                if(ind !== null && elem.IndicatorWorkspace.type !== 'Order'){
                    gs.INDICATORS_INDENT -= elem.IndicatorWorkspace.height / gs.TOTAL_ZOOM;
                    if(elem.IndicatorWorkspace.type === 'Volume') {
                        t.IsVolumeIndicatorCreate = false;
                    }
                    else if(elem.IndicatorWorkspace.type === 'Delta') {
                        t.IsDeltaIndicatorCreate = false;
                    }
                    t.Indicators.splice(--ind, 1);
                    for(var i = 0; i < t.Indicators.length; i++){
                        t.Indicators[i].setIndex(i);
                    }
                }
            });
        }
    },
    
    findIndicatorZone: function(e, gs){
        if(this.Indicators.length !== 0){
            this.Indicators.forEach(function(elem){
                elem.onGraphMouseMove(e, gs);
            });
        }
    },

    onMove: function (e) {
        var gs = this.GraphSettings;
        var zoom = gs.TOTAL_ZOOM;
        var X = (e.clientX - 40) / zoom,
            Y = e.clientY / zoom;
        this.cordX = X;
        this.cordY = gs.realY(Y);
        var x = 0, y = 0, xS = 0, yS = 0, deltaX = 0, deltaY = 0;
        if(e.type === 'mousemove' && App.currentPlatform === 'PC'){
            this.findIndicatorZone(e, gs);
            this.onMoveForCursor();
                x = X;
                y = gs.realY(Y);
                
            if (this.MarketProfileSprites.length) {
                var marketSprites = this.MarketProfileSprites;
                
                marketSprites.forEach( (elem) => {
                    
                    if (elem.redact) {
                        switch(elem.r_type) {
                            case 'left': 
                                if (elem.f_x < elem.s_x) {
                                    elem.f_x = this.findCandleTsByCord(this.cordForVerticalLine)/1000;
                                }
                                else {
                                    elem.s_x = this.findCandleTsByCord(this.cordForVerticalLine)/1000;
                                }
                                break;
                                
                            case 'right': 
                                if (elem.f_x > elem.s_x) {
                                    elem.f_x = this.findCandleTsByCord(this.cordForVerticalLine)/1000;
                                }
                                else {
                                    elem.s_x = this.findCandleTsByCord(this.cordForVerticalLine)/1000;
                                }
                                break;
                                
                            case 'down':
                                if (elem.f_y > elem.s_y) {
                                    elem.s_y = this.cordForHorizontalLine;
                                }
                                else {
                                    elem.f_y = this.cordForHorizontalLine;
                                }
                                break;
                                
                            case 'up':
                                if (elem.f_y < elem.s_y) {
                                    elem.s_y = this.cordForHorizontalLine;
                                }
                                else {
                                    elem.f_y = this.cordForHorizontalLine;
                                }
                                break;
                        }
                    }
                });
            }
            
            if (this.mouseFlag && !this.MarketProfileRedact) {
                deltaX += (this.cursorPositionX - x) * gs.OX_SCALE;
                deltaY += (this.cursorPositionY - y) * gs.PRICE_PER_PX;
                this.onDragged(deltaX, deltaY);
                this.cursorPositionX = x;
                this.cursorPositionY = y;
            }
            if(this.IsAxesZoom){
                this.onMoveForAxes(this.PreCordX - x, this.PreCordY - y);
                this.PreCordX = x;
                this.PreCordY = y;
            }
        }
        else if (e.type === 'touchmove') {
            var X = (e.touches[0].clientX - 40) / zoom,
                Y = e.touches[0].clientY / zoom;
            if(e.touches.length === 1){
                this.onMoveForCursor();
                if (this.mouseFlag) {
                    x = X;
                    y = gs.realY(Y);
                    this.cordX = x;
                    this.cordY = y;
                    deltaX += (this.cursorPositionX - x) * gs.OX_SCALE;
                    deltaY += (this.cursorPositionY - y) * gs.PRICE_PER_PX;
                    this.onDragged(deltaX, deltaY);
                    this.cursorPositionX = x;
                    this.cursorPositionY = y;
                }
            }
            else if (e.touches.length === 2){
                var X1 = (e.touches[1].clientX - 40) / zoom,
                    Y1 = e.touches[1].clientY / zoom;
                //console.log(e)
                var xft = this.cursorPositionXforFirstTouch,
                    xst = this.cursorPositionXforSecTouch,
                    yft = this.cursorPositionYforFirstTouch,
                    yst = this.cursorPositionYforSecTouch,
                    deltaFirst = 0,
                    deltaSecond = 0;
                x = X;
                y = gs.realY(Y);
                xS = X1;
                yS = gs.realY(Y1);
                deltaFirst = Math.round(Math.sqrt((x - xS)*(x - xS) + (y - yS)*(y - yS)));
                deltaSecond = Math.round(Math.sqrt((xft - xst)*(xft - xst) + (yft - yst)*(yft - yst)));
                var cord = (e === undefined) ? 0 : {
                    X: Math.abs(x - xS),
                    Y: Math.abs(y - yS)
                }
                if(deltaFirst > deltaSecond){
                    this.zoomIn(1, cord);
                }
                else {
                    this.zoomOut(1, cord);
                }
            }
        }
    },
    
    findAxes: function() {
        var gs = this.GraphSettings,
            width = gs.WIDTH - gs.RIGHT_INDENT,
            x = this.cordX,
            y = this.cordY,
            additive = 20;
        if(y < additive || x > (width - additive))
        {
            this.IsAxesZoom = true;
        }
    },
    
    onMoveForAxes: function(x, y) {
        var gs = this.GraphSettings,
            width = gs.WIDTH - gs.RIGHT_INDENT,
            X = Math.ceil(this.cordX),
            Y = Math.ceil(this.cordY);
            
        TransformQuery = {};
        this.IsXAxeZoom = true;
        if(X >= width){
            if(y >= 0) {
                if (gs.ZOOM_Y !== gs.MIN_Y_ZOOM) {
                    TransformQuery.zoom_y = (gs.ZOOM_Y > gs.MIN_Y_ZOOM) ? (gs.ZOOM_Y - 1) : gs.ZOOM_Y;
                    this.transform(TransformQuery);
                }
            }
            else {
                if (gs.ZOOM_Y !== gs.MAX_Y_ZOOM) {
                    TransformQuery.zoom_y = (gs.ZOOM_Y < gs.MAX_Y_ZOOM) ? (gs.ZOOM_Y + 1) : gs.ZOOM_Y;
                    this.transform(TransformQuery);
                }
            }
        }
        if(Y <= 0){
            if(x <= 0){
                if (gs.ZOOM_X !== gs.MIN_X_ZOOM) {
                    TransformQuery.zoom_x = (gs.ZOOM_X > gs.MIN_X_ZOOM) ? (gs.ZOOM_X - 1) : gs.ZOOM_X;
                    this.transform(TransformQuery);
                }
            }
            else{
                if (gs.ZOOM_X !== gs.MAX_X_ZOOM) {
                    TransformQuery.zoom_x = (gs.ZOOM_X < gs.MAX_X_ZOOM) ? (gs.ZOOM_X + 1) : gs.ZOOM_X;
                    this.transform(TransformQuery);
                }
            }
        }
    },
    
    onMoveForCursor: function(e){
        var gs = this.GraphSettings,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            px = gs.PERFECT_PX;
        if(e === undefined){
            var cordX = this.cordX,
                cordY = this.cordY;
        }
        else {
            var cordX = this.cursorPositionX,
                cordY = this.cursorPositionY;
        }
            
        if (cordY > 0 && cordX > 0) {
            var priceStep = Math.ceil(gs.PRICE_STEP / gs.PRICE_POINTS),
                smallIntervalOnY = gs.calculateIndentOnY() - 0.5 * priceStep;
            if(App.CurrentGraph.CurType !== 'ordertape'){
                var timeStep = gs.TIME_STEP / grade;
            }
            else {
                var timeStep = gs.TIME_STEP / grade / 5;
            }
            
            var tempS = timeStep;
            var smallIntervalOnX = gs.calculateIndentOnX();
            var tempInt = smallIntervalOnX;
            
            if(this.IsZoomBorderCrossing || (x_zoom_cur_grade > gs.X_ZOOM_GRADE.ZERO)){
                if(App.CurrentGraph.CurType !== 'ordertape'){
                    smallIntervalOnX = tempInt - 0.5 * timeStep;
                }
                else {
                    smallIntervalOnX = tempInt;
                }
            }
            
            var powX = Math.floor((cordX - smallIntervalOnX) / timeStep),
                minX = Math.ceil(powX * timeStep + smallIntervalOnX);

            var powY = Math.floor((cordY - smallIntervalOnY) / priceStep);
            var minY = Math.ceil(powY * priceStep + smallIntervalOnY),
                maxY = minY + priceStep;
                
            var pow = 100, adder = pow/2;
            var _x = Math.floor(gs.OX_SCALE * (minX + timeStep * 0.5) + gs.START_POINT_ON_NULL);
            
            if(!this.mouseFlag || e !== undefined){
                if(this.IsZoomBorderCrossing || (x_zoom_cur_grade > gs.X_ZOOM_GRADE.ZERO)) adder = 0;
                    if(App.CurrentGraph.CurType !== 'ordertape'){
                        this.xDashLineSprite.x = Math.round(_x/pow)*pow-adder;
                    }
                    else {
                        this.xDashLineSprite.x = _x;
                    }
                    this.timeFootnoteSprite.x = _x;
                    this.touch = true;
                    if(this.spritesEdditorr || this.touch){
                        this.cordForVerticalLine = _x;
                    }
                var _y = 1*((minY + 0.5 * priceStep) * gs.PRICE_PER_PX + gs.START_PRICE).toFixed(gs.ROUNDING);
                
                var k = 0,
                    g = _y,
                    roundCorrection = (gs.ROUNDING <= 4) ? 1 : 0;
                
                while (gs.ROUNDING - k + roundCorrection != 0) {
                    _y *= 10;
                    k++;
                }
                
                _y *= 2;
                _y = Math.round(_y/10)*10;
                _y = Math.round(_y/2);
                _y /= Math.pow(10, k);
                
                // if(cordY > minY && cordY < maxY + 0.5 * priceStep){
                this.yDashLineSprite.y = _y;
                this.priceFootnoteSprite.y = _y;
                this.touch = true;
                if(this.spritesEdditor || this.touch){
                    this.cordForHorizontalLine = _y;
                }
                // }
            }
            this.recursiveRender();
        }
    },

    onUp: function (e) {
        var gs = this.GraphSettings;
        this.IsAxesZoom = false;
        if(e.type === 'mouseup' && App.currentPlatform === 'PC'){
            
            var updateProfile = false,
                updateList = [];
            
            var marketSprites = this.MarketProfileSprites;
                
            marketSprites.forEach( (elem) => {
                if (elem.redact) {
                    elem.redact = false;
                    elem.r_type = '';
                    this.MarketProfileRedact = false;
                    this.updateMarketProfile(elem);
                    updateProfile = true;
                    if(this.CurType === 'footprint'){
                        elem.send.timeframe = gs.TIMEFRAME;
                        elem.send.startTS = Math.ceil(elem.send.startTS);
                        elem.send.endTS = Math.ceil(elem.send.endTS);
                    }
                    updateList.push(elem.send);
                }
            });
            
            if (updateProfile) {
                Data.postMarketProfile(updateList);
            }
            
            if(this.rectangleEdditor){
                this.cordForRectangleSprite.second_x = this.xDashLineSprite.x;
                this.cordForRectangleSprite.second_y = this.yDashLineSprite.y;
                if(!this.marketEdditor) {
                    this.createRectangle();
                }
                else {
                    this.createMarketProfile();
                    this.marketEdditor = false;
                }
                this.rectangleEdditor = false;
                this.spritesEdditor = false;
            } else if (!this.MarketProfileRedact) {
                this.mouseFlag = false;
                this.cursorPositionX = (e.clientX - 40) / gs.TOTAL_ZOOM;//gs.realX(e.clientX - 50);
                this.cursorPositionY = gs.realY(e.clientY / gs.TOTAL_ZOOM);
            }
        }
        else if (e.type === 'touchend') {
            this.mouseFlag = false;
        }
    },

    onDragged: function (x, y, supervisor) {
        if (!App.supervisor || supervisor ) {
            var TransformQuery = {};
            if (arguments.length === 2) {
                if (arguments[1] === 'left' || arguments[1] === 'right') {
                    TransformQuery.transform_TS = x;
                }
                else if (arguments[1] === 'up' || arguments[1] === 'down') {
                    TransformQuery.transform_Price = x*this.GraphSettings.PRICE_PER_PX;
                }
                else {
                    TransformQuery.transform_TS = x;
                    TransformQuery.transform_Price = y;
                    TransformQuery.zoom = false;
                }
            } else {
                TransformQuery.transform_TS = x;
                TransformQuery.transform_Price = y;
                TransformQuery.zoom = false;
            }
            this.transform(TransformQuery);
        }
    },
    
    onZoom: function (e) {
        var gs = this.GraphSettings;
        var plus = 107, //клавиша + на нумпаде
            plusS = 187, //клавиша =
            minus = 109, //клавиша - на нумпаде
            minusS = 189, //клавиша -
            key = (e.deltaY) ? e.type : e.keyCode;
            zoom = gs.TOTAL_ZOOM;
        key = (!key) ? e.type : key;

        var cord = (e === undefined) ? 0 : {
                X: (e.clientX - 40) / zoom,
                Y: e.clientY / zoom
            }
            
        switch (key) {
            // case plus :
            // case plusS :
            //     //console.log(e)
            //
            //     this.zoomIn(e, gs, power, PPP, stepPPP);
            //     break;
            // case minus :
            // case minusS :
            //     //console.log(e)
            //
            //     this.zoomOut(e, gs, power, PPP, stepPPP);
            //     break;
            case 'wheel' :
                if (e.deltaY < 0) {
                    this.zoomOnWheel('in', cord);
                }
                else if (e.deltaY > 0) {
                    this.zoomOnWheel('out', cord);
                }
                break;
        }
    },

    zoomOnWheel: function (flag, cord) {
        var gs = this.GraphSettings;
        if (flag === 'in') {
            this.zoomIn(1, cord);
        }
        else if (flag === 'out') {
            this.zoomOut(1, cord);
        }
    },

    zoomIn: function (power, cord) {
        var gs = this.GraphSettings;
        var max = 1,
            TransformQuery = {};
        if (gs.TOTAL_ZOOM !== max) {
            var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
            cord.W = gs.WIDTH - right_indent;
            cord.H = gs.HEIGHT - bottom_indent;
            TransformQuery.zoom = (gs.TOTAL_ZOOM < max) ? (1 * (gs.TOTAL_ZOOM + 0.01 * power).toFixed(2)) : gs.TOTAL_ZOOM;
            TransformQuery.cord = cord;
            this.transform(TransformQuery);
        }
    },

    zoomOut: function (power, cord) {
        var gs = this.GraphSettings;
        var min = 0.4,
            TransformQuery = {};
        if (gs.TOTAL_ZOOM !== min) {
            var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
            cord.W = gs.WIDTH - right_indent;
            cord.H = gs.HEIGHT - bottom_indent;
            TransformQuery.zoom = (gs.TOTAL_ZOOM > min) ? (1 * (gs.TOTAL_ZOOM - 0.01 * power).toFixed(2)) : gs.TOTAL_ZOOM;
            TransformQuery.cord = cord;
            this.transform(TransformQuery);
        }
    },
    
    transform: function (q) {
        var gs = this.GraphSettings;
        if (q.new_start_ox && q.new_start_price){
            gs.START_OX_POINT = q.new_start_ox;   
            gs.START_PRICE = q.new_start_price;
        }
        if (q.transform_TS) {
            gs.START_OX_POINT += /*Math.floor(*/q.transform_TS/*)*/;
            gs.setStartPointOnNull();
        }
        if (q.transform_Price) {
            gs.START_PRICE += q.transform_Price;
            this.yCordCursorLine += q.transform_Price;
        }
        if (typeof q.zoom === "number") {
            gs.TOTAL_ZOOM = q.zoom;
            if(gs.TOTAL_ZOOM > 1){
                gs.TOTAL_ZOOM = 1;
            }
            else if(gs.TOTAL_ZOOM < 0.4) {
                gs.TOTAL_ZOOM = 0.4;
            }
            App.CurrentGraph.IsZoomBorderCrossing = (gs.TOTAL_ZOOM < 0.8);
            gs.zoomRecount();
            
            gs.TOTAL_ZOOM = q.zoom;
            if(gs.TOTAL_ZOOM > 1){
                gs.TOTAL_ZOOM = 1;
            }
            else if(gs.TOTAL_ZOOM < 0.4) {
                gs.TOTAL_ZOOM = 0.4;
            }
            
            if (q.cord.X) {
                if (!!(App.CurrentGraph.IsZoomBorderCrossing = (gs.TOTAL_ZOOM < 0.8)) && !gs.IS_ZOOM_BORDER) {
                    gs.START_OX_POINT += Math.abs(gs.START_OX_POINT - this.cordForVerticalLine - gs.pxToScale((gs.WIDTH - q.cord.X - 100))*4);
                    gs.IS_ZOOM_BORDER = true;
                } 
                
                if (!(App.CurrentGraph.IsZoomBorderCrossing) && gs.IS_ZOOM_BORDER) {
                    gs.START_OX_POINT = this.cordForVerticalLine + gs.pxToScale((gs.WIDTH - q.cord.X - 100)/4);
                    gs.IS_ZOOM_BORDER = false;
                }
            } else {
                q.cord.X = gs.WIDTH / 2.0;
                
                if (!!(App.CurrentGraph.IsZoomBorderCrossing = (gs.TOTAL_ZOOM < 0.8)) && !gs.IS_ZOOM_BORDER) {
                    gs.START_OX_POINT += Math.abs(gs.START_OX_POINT - (gs.START_OX_POINT + gs.START_POINT_ON_NULL)/2.0 - gs.pxToScale((gs.WIDTH - q.cord.X))*4);
                    gs.IS_ZOOM_BORDER = true;
                } 
                
                if (!(App.CurrentGraph.IsZoomBorderCrossing) && gs.IS_ZOOM_BORDER) {
                    gs.setStartPointOnNull();
                    gs.START_OX_POINT -= Math.abs(gs.START_OX_POINT - (gs.START_OX_POINT + gs.START_POINT_ON_NULL)/2.0 - gs.pxToScale((gs.WIDTH - q.cord.X))/4);
                    gs.IS_ZOOM_BORDER = false;
                }
            }
            gs.zoomRecount();
        }
        if (typeof q.zoom_x === 'number'){
            gs.ZOOM_X = q.zoom_x;
            gs.OX_SCALE = Math.pow(gs.POWER_OF_GRAPH, q.zoom_x) * gs.FIXED_OX_SCALE;
            gs.setStartPointOnNull();
        }
        if (typeof q.zoom_y === 'number'){
            gs.ZOOM_Y = q.zoom_y;
            gs.PRICE_PER_PX = Math.pow(gs.POWER_OF_GRAPH_Y, q.zoom_y) * gs.FIXED_PRICE_PER_PX;
            gs.zoomYRecount();
        }
        if(q.cord) {
            var gs = this.GraphSettings,
                x = q.cord.X,
                y = q.cord.Y,
                bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
                fixedW = q.cord.W,//gs.FIXED_WIDTH,
                W = gs.WIDTH - right_indent,
                fixedH = q.cord.H,//gs.FIXED_HEIHT,
                H = gs.HEIGHT - bottom_indent,
                powX = (x === undefined) ? 0.5 : (fixedW - x) / fixedW,
                powY = (y === undefined) ? 0.5 : (fixedH - y) / fixedH;
            var xShift = gs.pxToScale(powX * (W - fixedW)),
                yShift = gs.pxToPrice(powY * (H - fixedH));
            gs.START_OX_POINT += xShift;
            gs.START_PRICE -= yShift;
            gs.setStartPointOnNull();
        }
        this.recursiveRender();
    },

    onResize: function () {
        this.getDimensions();
        this.recursiveRender(true);
    }
    
}

var DeltaGraph = function() {
    this.INSTRUMENT = null;
    this.DELTA = null;
}

DeltaGraph.prototype = new Delta('delta');
DeltaGraph.prototype.type = App.GraphType.DELTA;

DeltaGraph.prototype.setInstrument = function(instrument) {
    this.INSTRUMENT = instrument.name;
    this.PRICE_STEP = instrument.step;
    this.PRICE_PER_PX = instrument.pricePerPx;
    this.ROUNDING = instrument.rounding;
}
DeltaGraph.prototype.getSprites = function(f, index){
   var gs = this.GraphSettings;
    if(!Graph.requestInProcess){
            Graph.requestInProcess = true;
            Data.getCandlesForInterval({
                delta: App.CurrentGraph.DELTA, 
                instrument: App.CurrentGraph.INSTRUMENT, 
                candle_index: index,
                f: f
            });
    }
    if(this.XDashLineSprite !== undefined){
        this.XDashLineSprite.renderIfVisible();
        this.YDashLineSprite.renderIfVisible();
    }
}

DeltaGraph.prototype.setDelta = function(delta) {
    this.DELTA = delta;
}

var CandleSpriteDelta = function (Candle) {
    this.Candle = Candle; 
    this.positionOfFirstTick = 0;
    this.positionOfLastTick = 0; 
    this.type = "Candle";
};

CandleSpriteDelta.prototype = {
    constructor: CandleSpriteDelta
    , isVisible: function () {
        var gs = App.CurrentGraph.GraphSettings;
        var startPointOfCandle = gs.getXCordForPx(this.Candle.index * gs.FIXED_TIME_STEP),    
            arrayOfTicks = this.Candle.getTicks();
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        if(arrayOfTicks != undefined){
            var startTimePointOfGraph = gs.START_POINT_ON_NULL,
                startPricePointOfGraph = gs.START_PRICE, 
                pricePerPixel = gs.PRICE_PER_PX, 
                widthOfGraph = gs.WIDTH - right_indent,      
                grade = gs.GRADE,
                heightOfGraph = gs.HEIGHT - bottom_indent, 
                stepOfCandle = gs.TIME_STEP / grade,
                oy_ms = heightOfGraph * pricePerPixel,
                firstTickPrice = gs.getYCordForPrice(arrayOfTicks[0].price),
                lastTickPrice = gs.getYCordForPrice(arrayOfTicks[arrayOfTicks.length - 1].price), 
                x_visible  = (startPointOfCandle + stepOfCandle >= 0 && startPointOfCandle <= widthOfGraph); 
            var y_visible = (firstTickPrice <= gs.getYCordForPrice(startPricePointOfGraph) && lastTickPrice >= 0); 
            if(x_visible && y_visible) {
                for(var i = 1; i < arrayOfTicks.length; i++){
                    this.positionOfFirstTick = (arrayOfTicks[i].price <= startPricePointOfGraph + oy_ms && arrayOfTicks[i-1].price >= startPricePointOfGraph + oy_ms) ? i : this.positionOfFirstTick;
                    this.positionOfLastTick = (arrayOfTicks[i].price > startPricePointOfGraph) ? i : this.positionOfLastTick;
                  }
                if(!this.Candle.finished){
                    gs.lastCandleVisible = true;
                }
                else {
                    gs.lastCandleVisible = false; 
                }
            }
            return x_visible && y_visible;
        }
    }

    , render: function () {
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            vs = App.CurrentGraph.visualSettings;
            
        var candle_start_price = this.Candle.start_price,
            candle_last_price = this.Candle.last_price,
            rounding = gs.ROUNDING,
            green = vs.DIR_PLUS,             
            light_green = vs.DIR_PLUS_LIGHT ,        
            red = vs.DIR_MINUS,             
            light_red = vs.DIR_MINUS_LIGHT, 
            gray = vs.DIR_0,            
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            line_width = gs.LINE_WIDTH,
            px = gs.PERFECT_PX,           
            time_step = gs.TIME_STEP / grade,      
            fixed_time_step = gs.FIXED_TIME_STEP,
            price_tick_step = gs.PRICE_TICK_STEP,
            index = this.Candle.index,
            price_per_px = gs.PRICE_PER_PX, 
            y_cord_shift = 0.8 * gs.PRICE_STEP / gs.PRICE_POINTS / 2;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        
        var _x = gs.getXCordForPx(index * fixed_time_step) + px,
            _y = Math.ceil(gs.getYCordForPrice(candle_start_price) - y_cord_shift) + px,  
            _width = Math.ceil(time_step * 0.12), 
            _height = (candle_start_price - candle_last_price === 0) ? 0.8 * Math.ceil((price_tick_step) / price_per_px) : Math.ceil((candle_start_price - candle_last_price) / price_per_px);
            if (!(candle_start_price - candle_last_price === 0)) {
                if (_height < 0) {
                    _y += 0.8 * Math.ceil((price_tick_step) / price_per_px);
                    _height -= 0.8 * Math.ceil((price_tick_step) / price_per_px + px);
                }
                else {
                    _height += 0.8 * Math.ceil((price_tick_step) / price_per_px);
                }
            }
        if(!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)){  
            ctx.fillStyle = (candle_start_price <= candle_last_price) ? green : red;
            var prev = ctx.fillStyle;
            if (candle_start_price - candle_last_price === 0) {
                ctx.fillStyle = gray;
            }
            ctx.fillRect(_x, _y, _width, _height);
            ctx.lineWidth = gs.LINE_WIDTH;
            ctx.strokeStyle = vs.DIR_CANDLE_OUTLINE;
            ctx.strokeRect(_x, _y, _width, _height);
            var array_of_ticks = this.Candle.getTicks(),               
                width_of_ticks = Math.ceil(time_step - _width) - 11 * px, 
                height_of_ticks = 0.8 * Math.ceil((price_tick_step) / price_per_px); 
            if(array_of_ticks.length != 0){
                var firstPos = (this.positionOfFirstTick >= 1) ? this.positionOfFirstTick - 1 : 0;
                var lastPos = (this.positionOfLastTick <= array_of_ticks.length - 2) ? this.positionOfLastTick + 1 : this.positionOfLastTick;
                for(var i = firstPos; i <= lastPos; i++){
                    var _x_ticks_cord = Math.ceil(_x + _width + 1) + px, 
                        _y_ticks_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[i].price).toFixed(rounding))) - Math.floor(height_of_ticks / 2) + px,
                        _width_of_tick = Math.ceil(width_of_ticks * array_of_ticks[i].length),
                        _ticks_color = '',                       
                        _bid_x_cord = _x + time_step / 2 - 5, 
                        _ask_x_cord = _bid_x_cord + 10,       
                        _y_cord =  _y_ticks_cord + height_of_ticks / 2; 
                    if(array_of_ticks[i].isMain){
                        _ticks_color = (array_of_ticks[i].dir === 1) ? red : green;
                    }
                    else {
                         _ticks_color = (array_of_ticks[i].dir === 1) ? light_red : light_green;
                    }
                    
                    ctx.fillStyle = _ticks_color;
                    ctx.fillRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
                    ctx.lineWidth = gs.LINE_WIDTH;
                    ctx.strokeStyle = vs.DIR_CANDLE_OUTLINE;
                    ctx.strokeRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
                    
                    if (gs.ZOOM_Y > gs.MIN_Y_ZOOM * 0.6) {
                        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_TICK_FONT : gs.TEXT_TICK_FONT_MOBILE;
                        ctx.font = (array_of_ticks[i].isMain) ? 'bold ' + ctx.font : ctx.font; 
                        ctx.fillStyle = vs.DIR_TEXT;
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'middle';
                        ctx.textAlign = 'right';
                        ctx.fillText(array_of_ticks[i].bid, _bid_x_cord, _y_cord);
                        ctx.textAlign = 'left';
                        ctx.fillText(array_of_ticks[i].ask, _ask_x_cord, _y_cord);
                    }
                }
            }
        }
        else {
            if(x_zoom_cur_grade < gs.X_ZOOM_GRADE.THREE) _width *= 4;
            var array_of_ticks = this.Candle.getTicks(), 
                x_pos_collumn = Math.ceil(_x - _width / 2) + px, 
                x_pos = Math.floor(x_pos_collumn + _width / 2) + px, 
                max_y_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[0].price).toFixed(rounding))),
                min_y_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[array_of_ticks.length - 1].price).toFixed(rounding))),
                __h = -(delta_indent - bottom_indent - px);
            ctx.strokeStyle = vs.DIR_CANDLE_OUTLINE;
            ctx.lineWidth = gs.LINE_WIDTH;
            ctx.beginPath();
            ctx.moveTo(x_pos, max_y_cord);
            ctx.lineTo(x_pos, min_y_cord);
            ctx.stroke();
            ctx.lineWidth = gs.LINE_WIDTH;;
            ctx.fillStyle = (candle_start_price <= candle_last_price) ? green : red;
            if (candle_start_price - candle_last_price === 0) ctx.fillStyle = gray;
            ctx.strokeStyle = vs.DIR_CANDLE_OUTLINE;
            ctx.fillRect(x_pos_collumn, _y, _width, _height);
            if(x_zoom_cur_grade <= gs.X_ZOOM_GRADE.ONE)  ctx.strokeRect(x_pos_collumn, _y, _width, _height);
        }
    }
    
    , isTimeVisible: function() {
        var gs = App.CurrentGraph.GraphSettings;
        var startPointOfCandle = gs.getXCordForPx(this.Candle.index * gs.FIXED_TIME_STEP), 
            arrayOfTicks = this.Candle.getTicks(); 
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        if(arrayOfTicks != undefined){
            var startTimePointOfGraph = gs.START_POINT_ON_NULL, 
                startPricePointOfGraph = gs.START_PRICE, 
                widthOfGraph = gs.WIDTH - right_indent, 
                grade = gs.GRADE,
                heightOfGraph = gs.HEIGHT - bottom_indent, 
                stepOfCandle = gs.TIME_STEP / grade, 
                firstTickPrice = gs.getYCordForPrice(arrayOfTicks[0].price),
                lastTickPrice = gs.getYCordForPrice(arrayOfTicks[arrayOfTicks.length - 1].price), 
                x_visible  = (startPointOfCandle + stepOfCandle >= 0 && startPointOfCandle + stepOfCandle/2 <= widthOfGraph); 
            return x_visible;
        }
    }
    
    , timeRender: function(){
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            x_zoom_grade = gs.X_ZOOM_GRADE,
            line_width = gs.LINE_WIDTH,
            time_step = gs.TIME_STEP / grade,
            fixed_time_step = gs.FIXED_TIME_STEP,
            index = this.Candle.index,
            _x = Math.ceil(gs.getXCordForPx(index * fixed_time_step) + 0.5 * time_step) + px,
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE
            delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE,
            _y = gs.HEIGHT - 0.5 * bottom_indent + 2,
            centerY = gs.realY(0) + px + delta_indent - bottom_indent,
            cord_of_mark_Y = gs.realY(-gs.HATCH_LENGHT) + delta_indent - bottom_indent;
        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;              
        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_PRICE_TEXT; 
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        var text = gs.tsToTime(this.Candle.startTS);
                
        if(!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === x_zoom_grade.ZERO)){   
            ctx.fillText(text, _x, _y, 0.75 * time_step);
            ctx.lineWidth = line_width;
            ctx.fillStyle = '#000000';
            
            ctx.beginPath();
            ctx.moveTo(_x, centerY);
            ctx.lineTo(_x, cord_of_mark_Y);
            ctx.stroke();
        }
        else {
            var period = 1;
            switch(x_zoom_cur_grade) {
                case x_zoom_grade.ONE: period = 10; break;
                case x_zoom_grade.TWO: period = 50; break;
                case x_zoom_grade.THREE: period = 250; break;
                case x_zoom_grade.FOUR: period = 500; break;
            }
            if(App.CurrentGraph.IsZoomBorderCrossing) period *= 5;
            if(index % period === 0) {
                x_pos = Math.floor(_x - time_step / 2) + px
                ctx.fillText(text, x_pos, _y);
                ctx.lineWidth = line_width;
                ctx.fillStyle = '#000000';
                ctx.beginPath();
                ctx.moveTo(x_pos, centerY);
                ctx.lineTo(x_pos, cord_of_mark_Y);
                ctx.stroke();
            }
        }
    }
    
    , timeRenderIfVisible: function(){
        if(this.isTimeVisible()){
            this.timeRender();
            return true;
        }
    }
    
    , renderIfVisible: function () {
        if (this.isVisible()) {
            this.render();
            return true;
        }
    }
};

var DeltaGraphSettings = function (zoom, price_per_px, price_points, min_px_per_detailed_candle) { 
    this.TOTAL_ZOOM = 1;
    this.ZOOM_X = 9;
    this.ZOOM_Y = 0;
    this.WIDTH = 0; 
    this.HEIGHT = 0; 
    this.FIXED_WIDTH = 0; 
    this.FIXED_HEIGHT = 0; 
    
    this.IS_ZOOM_BORDER = false;
    this.IS_TIME_ZOOM_BORDER = false;
    this.X_ZOOM_GRADE = {
        ZERO: 0,
        ONE: 1,
        TWO: 2,
        THREE: 3,
        FOUR: 4
    };
    this.X_ZOOM_CURRENT_GRADE = 0;
    this.GRADE = 1;
    
    this.Y_ZOOM_GRADE = {
        ZERO: 1,
        ONE: 3,
        TWO: 5,
        THREE: 7,
        FOUR: 9
    };
    this.Y_ZOOM_CURRENT_GRADE = 1;
    
    this.MIN_X_ZOOM = -200;
    this.MIN_Y_ZOOM = -100;
    this.MAX_X_ZOOM = 9;
    this.MAX_Y_ZOOM = 0;
    
    this.START_TS = 0; 
    this.START_OX_POINT = 300;
    this.START_POINT_ON_NULL = 0;
    this.TIME_STEP = 0;
    this.FIXED_TIME_STEP = 100;
    this.FIXED_TIME_PER_PX = 0;
    this.OX_MS = 0;
    
    this.START_PRICE = 0;
    this.PRICE_PER_PX = price_per_px; 
        this.FIXED_PRICE_PER_PX = price_per_px; // цена в одном тике, которая не изменяется 
    this.PRICE_STEP = 0; 
    this.PRICE_POINTS = price_points; 
    this.FIXED_PRICE_POINTS = price_points; 
    this.PRICE_TICK_STEP = 0;
    this.MIDDLE_PRICE = 0;
    
    this.RIGHT_INDENT = 85; 
    this.FIXED_RIGHT_INDENT = 85;
    this.RIGHT_INDENT_MOBILE = 70;
    this.FIXED_RIGHT_INDENT_MOBILE = 70;
    
    this.BOTTOM_INDENT = 30;
    this.FIXED_BOTTOM_INDENT = 30;
    this.BOTTOM_INDENT_MOBILE = 25;
    this.FIXED_BOTTOM_INDENT_MOBILE = 25;
    
    this.TEXT_FONT = '14px Arial';
    this.TEXT_FONT_MOBILE = '12px Arial';
    this.TEXT_TICK_FONT = '11px Arial';
    this.TEXT_TICK_FONT_MOBILE = '9px Arial';
    this.TEXT_MARKET_FONT = 'bold 16px Arial';
    this.TEXT_MARKET_FONT_MOBILE = 'bold 13px Arial';
    this.TEXT_ORDER_FONT = '17px Arial';
    this.TEXT_ORDER_FONT_MOBILE = '15px Arial';
    
    this.PERFECT_PX = 0.5; //для резкоcти 
    this.INSTRUMENT = 0;
    
    this.POWER_OF_GRAPH = 1.03;
    this.POWER_OF_GRAPH_Y = 1.02;
    this.lastCandleVisible = true;
    this.ROUNDING = 0;
    this.LINE_WIDTH = 1;
    this.HATCH_LENGHT = 8.5;
    
    this.OX_SCALE = 1;
    this.FIXED_OX_SCALE = 1;
     
    this.ZOOM = zoom;

    this.DELTA_INDENT = 30;
    this.DELTA_INDENT_MOBILE = 25;
    this.FIXED_DELTA_INDENT = 30;
    this.FIXED_DELTA_INDENT_MOBILE = 25;
    
    this.DELTA = 0;
    
    this.RIGHT_TEXT_INDENT = 46.5;
    this.FIXED_RIGHT_TEXT_INDENT = 46.5;
    this.RIGHT_TEXT_INDENT_MOBILE = 40;
    this.FIXED_RIGHT_TEXT_INDENT_MOBILE = 40;
    
    this.BOTTOM_TEXT_INDENT = 17.5;
    this.FIXED_BOTTOM_TEXT_INDENT = 17.5;
    this.BOTTOM_TEXT_INDENT_MOBILE = 16;
    this.FIXED_BOTTOM_TEXT_INDENT_MOBILE = 16;
    
    this.INDICATORS_INDENT = 0;
    this.FIXED_INDICATORS_INDENT = 0;
     
    this.TIMEFRAME = 0; 
    this.TIMEFRAME_TS = 0; 
};

DeltaGraphSettings.prototype = {
    constructor: DeltaGraphSettings
    
    , countXZoomGrade: function() {
        var cur = this.ZOOM_X;
        var grade = {
            one: -20,
            two: -60,
            three: -120,
            four: -160
        }
        this.X_ZOOM_CURRENT_GRADE = this.X_ZOOM_GRADE.ZERO;
        if(cur < grade.four) {
            this.X_ZOOM_CURRENT_GRADE = this.X_ZOOM_GRADE.FOUR;
        }
        else if(cur < grade.three) {
            this.X_ZOOM_CURRENT_GRADE = this.X_ZOOM_GRADE.THREE;
        }
        else if(cur < grade.two) {
            this.X_ZOOM_CURRENT_GRADE = this.X_ZOOM_GRADE.TWO;
        }
        else if(cur < grade.one) {
            this.X_ZOOM_CURRENT_GRADE = this.X_ZOOM_GRADE.ONE;
        }
        this.GRADE = (App.CurrentGraph.IsZoomBorderCrossing) ? this.pow(7, this.X_ZOOM_CURRENT_GRADE) : this.pow(5, this.X_ZOOM_CURRENT_GRADE);
    }
    
    , countYZoomGrade: function() {
        var cur = this.ZOOM_Y;
        var grade = {
            one: -30,
            two: -70
            // ,
            // three: -60,
            // four: -80
        }
        this.Y_ZOOM_CURRENT_GRADE = this.Y_ZOOM_GRADE.ZERO;
        // if(cur < grade.four) {
        //     this.Y_ZOOM_CURRENT_GRADE = this.Y_ZOOM_GRADE.FOUR;
        // }
        // else if(cur < grade.three) {
        //     this.Y_ZOOM_CURRENT_GRADE = this.Y_ZOOM_GRADE.THREE;
        // }
        // else 
        if(cur < grade.two) {
            this.Y_ZOOM_CURRENT_GRADE = this.Y_ZOOM_GRADE.TWO;
        }
        else if(cur < grade.one) {
            this.Y_ZOOM_CURRENT_GRADE = this.Y_ZOOM_GRADE.ONE;
        }
        this.PRICE_POINTS = this.FIXED_PRICE_POINTS * this.Y_ZOOM_CURRENT_GRADE;
    }
    
    , countZoomGrade: function() {
        this.countXZoomGrade();
        this.countYZoomGrade();
    }
    
    , getBorderTS: function () {
        return this.START_POINT_ON_NULL + this.WIDTH * this.TIME_PER_PX;
    }

    , getBorderPrice: function () {
        return this.START_PRICE + this.HEIGHT * this.PRICE_PER_PX;
    }
    
    , getCurrentId: function(id) {
        return id - App.CurrentGraph.FirstIdOrder;
    }

    , getXCordForPx: function (n) {
        return (n - this.START_POINT_ON_NULL) / this.OX_SCALE;
    }

    , getYCordForPrice: function (n) {
        var delta_indent = (App.currentPlatform === 'PC') ? this.DELTA_INDENT : this.DELTA_INDENT_MOBILE;
        return this.HEIGHT - delta_indent - ((n - this.START_PRICE) / this.PRICE_PER_PX);
    }
    
    , zoomRecount: function() {
        var zoom = this.TOTAL_ZOOM;
        var ctx = App.CurrentGraph.tmpCtx;
        ctx.restore();
        ctx.save();
        ctx.scale(zoom, zoom);
        this.WIDTH = this.FIXED_WIDTH / zoom;
        this.HEIGHT = this.FIXED_HEIGHT / zoom;
        this.RIGHT_INDENT = this.FIXED_RIGHT_INDENT / zoom;
        this.BOTTOM_INDENT = this.FIXED_BOTTOM_INDENT / zoom;
        this.DELTA_INDENT = this.FIXED_DELTA_INDENT / zoom;
        this.RIGHT_INDENT_MOBILE = this.FIXED_RIGHT_INDENT_MOBILE / zoom;
        this.BOTTOM_INDENT_MOBILE = this.FIXED_BOTTOM_INDENT_MOBILE / zoom;
        this.DELTA_INDENT_MOBILE = this.FIXED_DELTA_INDENT_MOBILE / zoom;
        this.LINE_WIDTH = 1 * (1 / zoom).toFixed(1);
        this.TEXT_FONT = 14 / zoom + 'px Arial';
        this.TEXT_FONT_MOBILE = 12 / zoom + 'px Arial';
        this.HATCH_LENGHT = 8.5 / zoom;
        this.RIGHT_TEXT_INDENT = this.FIXED_RIGHT_TEXT_INDENT / zoom;
        this.RIGHT_TEXT_INDENT_MOBILE = this.FIXED_RIGHT_TEXT_INDENT_MOBILE / zoom;
        this.BOTTOM_TEXT_INDENT = this.FIXED_BOTTOM_TEXT_INDENT / zoom;
        this.BOTTOM_TEXT_INDENT_MOBILE = this.FIXED_BOTTOM_TEXT_INDENT_MOBILE / zoom;
        this.TEXT_MARKET_FONT = 'bold ' + 16 / zoom + 'px Arial';
        this.TEXT_MARKET_FONT_MOBILE = 'bold ' + 13 / zoom + 'px Arial';
        this.INDICATORS_INDENT = this.FIXED_INDICATORS_INDENT / zoom;
    }
    
    , zoomYRecount: function() {
        var zoom = this.TOTAL_ZOOM;
        var zoom_y = Math.abs(Math.pow(this.POWER_OF_GRAPH_Y , this.ZOOM_Y * 0.2));
        
        this.TEXT_TICK_FONT = 11 / zoom * zoom_y  + 'px Arial';
        this.TEXT_TICK_FONT_MOBILE = 9 / zoom * zoom_y + 'px Arial';
        
        this.TEXT_ORDER_FONT = 17 / zoom * zoom_y + 'px Arial';
        this.TEXT_ORDER_FONT_MOBILE = 15 / zoom * zoom_y + 'px Arial';
    }

    , realY: function (y) {
        var delta_indent = (App.currentPlatform === 'PC') ? this.DELTA_INDENT : this.DELTA_INDENT_MOBILE;
        return this.HEIGHT - delta_indent - y;
    }

    , calculateIndentOnX: function () {
        var timeUnitsInOneGridMark = this.OX_SCALE * this.TIME_STEP;
        var startTime = this.START_POINT_ON_NULL;

        var timeUnitsInSmallInterval = (startTime >= 0) ? startTime % timeUnitsInOneGridMark : ( timeUnitsInOneGridMark + startTime % timeUnitsInOneGridMark);

        var smallIntervalTimeUnits = (timeUnitsInOneGridMark - (timeUnitsInSmallInterval));
        var smallIntervalPixels = smallIntervalTimeUnits / this.OX_SCALE;
        smallIntervalPixels = (smallIntervalPixels >= 0) ? smallIntervalPixels : (smallIntervalPixels + this.TIME_STEP);

        return smallIntervalPixels;
    }

    // Returns size of small interval behind the first grid line in PIXELS
    , calculateIndentOnY: function () {
        var step = this.PRICE_STEP,
            rounding = this.ROUNDING;
        var priceUnitsInOneGridMark = this.round(this.PRICE_PER_PX * step, rounding);
        var startPrice = this.START_PRICE;
        
        var val = startPrice % priceUnitsInOneGridMark;
        
        var priceUnitsInSmallInterval = (startPrice >= 0 ) ? val : ( priceUnitsInOneGridMark + val);
        var smallIntervalPriceUnits = priceUnitsInOneGridMark - priceUnitsInSmallInterval;
        var smallIntervalPixels = smallIntervalPriceUnits / this.PRICE_PER_PX;
        smallIntervalPixels = (smallIntervalPixels >= 0) ? smallIntervalPixels : (smallIntervalPixels + step);
        return Math.floor(smallIntervalPixels);
    }

    , pxToScale: function (x) {
        return x * this.OX_SCALE;
    }

    , pxToPrice: function (y) {
        return y * this.PRICE_PER_PX;
    }

    //перевод метки времени в формат ГГГГ-ММ-ДД
    , tsToData: function (ts) {
        var fullData = new Date(ts),
            year = fullData.getFullYear(),
            month = fullData.getMonth() + 1,
            day = fullData.getDate();

        if (month < 10) month = '0' + month;
        if (day < 10) day = '0' + day;

        return year + '-' + month + '-' + day;
    }

    //перевод метки времени в формат ЧЧ:ММ:СС
    , tsToTime: function (ts) {
        var fullData = new Date(ts),
            hours = fullData.getHours(),
            minutes = fullData.getMinutes(),
            seconds = fullData.getSeconds();

        if (hours < 10) hours = '0' + hours;
        if (minutes < 10) minutes = '0' + minutes;
        if (seconds < 10) seconds = '0' + seconds;
    
        if(App.CurrentGraph.CurType !== 'ordertape'){
            return hours + ':' + minutes;
        }
        else {
            return hours + ':' + minutes + ':' + seconds;
        }
    }
    
    , round: function(x, quantity, additive) {
        additive = (additive !== undefined) ? additive : 0;
        var t = Math.pow(10, quantity - additive);
        return Math.round(x * t) / t;
    }
    
    , recount: function() {
        this.countZoomGrade();
        this.setOxScale();
        this.setPriceTickStep();
        this.setPricePerPx();
        this.setPriceStep();
        this.setStartPointOnNull();
        this.setTimeStep();
        this.setOxMs();
    }
    
    , setTimeFrame: function() {
        this.TIMEFRAME = App.CurrentGraph.TIMEFRAME.val;
        this.TIMEFRAME_TS = App.CurrentGraph.TIMEFRAME.ts;
        App.CurrentGraph.loadMarketProfile();
    }
    
    , setPricePerPx: function() {
        var pricePerPx = Math.pow(this.POWER_OF_GRAPH_Y, -this.ZOOM_Y) * this.FIXED_PRICE_PER_PX;
        this.PRICE_PER_PX = pricePerPx;
    }

    , setStartPointOnNull: function () {
        var right_indent = (App.currentPlatform === 'PC') ? this.RIGHT_INDENT : this.RIGHT_INDENT_MOBILE;
        this.START_POINT_ON_NULL = this.START_OX_POINT - (this.WIDTH - right_indent) * this.OX_SCALE;
    }
    
    , setOxScale: function() {
        var oxScale = Math.pow(this.POWER_OF_GRAPH, -this.ZOOM_X) * this.FIXED_OX_SCALE;
        this.OX_SCALE = (!App.CurrentGraph.IsZoomBorderCrossing) ? oxScale : 4 * oxScale;
    }
    
    , setPriceTickStep: function(){
        this.ROUNDING = App.CurrentGraph.ROUNDING;
        this.PRICE_PER_PX = App.CurrentGraph.PRICE_PER_PX;
        this.FIXED_PRICE_PER_PX = this.PRICE_PER_PX;
        this.PRICE_TICK_STEP = App.CurrentGraph.PRICE_STEP;
    }
    
    , pow: function(x, n) {
        if(n === 0) return 1;
        if(n != 1) {
            return x * this.pow(x, n - 1);
        } 
        else {
            return x;
        }
    }
    
    , setPriceStep: function() {
        this.PRICE_STEP = Math.round(this.PRICE_POINTS * this.PRICE_TICK_STEP / this.PRICE_PER_PX);
    }
    
    , setTimeStep: function() {
        var val = this.FIXED_TIME_STEP/ this.OX_SCALE,
            grade = this.GRADE;
        this.TIME_STEP = val * grade;
    }
    
    , setOxMs: function () {
        var right_indent = (App.currentPlatform === 'PC') ? this.RIGHT_INDENT : this.RIGHT_INDENT_MOBILE;
        this.OX_MS = (this.WIDTH - right_indent) * this.OX_SCALE;
    }
    
    , setStartPrice: function() {
        var bottom_indent = (App.currentPlatform === 'PC') ? this.BOTTOM_INDENT : this.BOTTOM_INDENT_MOBILE;
        this.START_PRICE = this.round(this.MIDDLE_PRICE  - ((this.HEIGHT - bottom_indent) / 2) * this.PRICE_PER_PX, this.ROUNDING);
    }
    
    , setInstrument: function() {
        this.INSTRUMENT = App.CurrentGraph.INSTRUMENT;
        
        App.CurrentGraph.loadMarketProfile();
    }
    
    , setDelta: function() {
        this.DELTA = App.CurrentGraph.DELTA;
        App.CurrentGraph.loadMarketProfile();
    }
    
    , setIndicatorsProper: function(indicators) {
        this.INDICATORS_INDENT = 0;
        var workSpace;
        for(var i = 0; i < indicators.length; i++){
            workSpace = indicators[i].getWorkspace();
            this.INDICATORS_INDENT += workSpace.height;
        }
        this.FIXED_INDICATORS_INDENT = this.INDICATORS_INDENT;
    }
    
    , getCandleByIndex: function(index){
        if(App.CurrentGraph.CurType !== 'ordertape'){
            for(var i = 0; i < Data.Cache.Candles.length; i++){
                if(Data.Cache.Candles[i].index === index){
                    var Candle = Data.Cache.Candles[i];
                    break;
                }
            }
            if(Candle === undefined){
                return '';
            }
            else {
                if(App.CurrentGraph.CurType === 'footprint'){
                    return Candle.from;
                }
                else {
                    return Candle.startTS;  
                }
            }
        }
        else {
            for(var i = 0; i < Data.Cache.Candles.length; i++){
                if(Data.Cache.Candles[i].id === index + App.CurrentGraph.FirstIdOrder){
                    var Candle = Data.Cache.Candles[i];
                    break;
                }
            }
            if(Candle === undefined){
                return '';
            }
            else {
                return Candle.secs * 1000;  
            }
        }
    }
    
    , getCandleIndex: function(){
        return Math.ceil(this.START_POINT_ON_NULL/ this.FIXED_TIME_STEP);
    }
    
    , findeSpriteCord: function(sprite, e) {
        if(App.currentPlatform !== 'PC'){
            App.CurrentGraph.recountCord(e);
        }
        var cord = 0,
            cursor_cord = 0,
            correct = 0;
        if(sprite.type === 'Rectangle'){
            cord = {
                f_x: Math.ceil(this.getXCordForPx(sprite.f_x)),
                f_y: Math.ceil(this.getYCordForPrice(sprite.f_y)),
                s_x: Math.ceil(this.getXCordForPx(sprite.s_x)),
                s_y: Math.ceil(this.getYCordForPrice(sprite.s_y))
            }
            cursor_cord = {
                x: (App.currentPlatform === 'PC') ? App.CurrentGraph.cordX : App.CurrentGraph.cursorPositionX,
                y: (App.currentPlatform === 'PC') ? this.realY(App.CurrentGraph.cordY) : this.realY(App.CurrentGraph.cursorPositionY)
            }
            correct = {
                x:  Math.ceil(this.TIME_STEP / this.GRADE / 4),
                y:  Math.ceil(this.PRICE_STEP / 10)
            }
        }
        else if(sprite.type === 'VerticalLine'){
            cord = Math.ceil(this.getXCordForPx(sprite.x));
            cursor_cord = (App.currentPlatform === 'PC') ? App.CurrentGraph.cordX : App.CurrentGraph.cursorPositionX;
            correct = Math.ceil(this.TIME_STEP / this.GRADE / 4);
        }
        else if(sprite.type === 'HorizontalLine'){
            cord = Math.ceil(this.getYCordForPrice(sprite.y));
            cursor_cord = (App.currentPlatform === 'PC') ? this.realY(App.CurrentGraph.cordY) : this.realY(App.CurrentGraph.cursorPositionY);
            correct = Math.ceil(this.PRICE_STEP / 10);
        }
        if(typeof cord !== 'object'){
            var _return = (Math.abs(cord - cursor_cord) <= correct) ? true : false;
            return _return;
        }
        else {
            var width = (cord.s_x - cord.f_x) / 2,
                height = (cord.s_y - cord.f_y) / 2;
            var x_center_cord = cord.f_x + width,
                y_center_cord = cord.f_y + height;
            var _return = (Math.abs(x_center_cord - cursor_cord.x) < (Math.abs(width) + correct.x) && Math.abs(y_center_cord - cursor_cord.y) < (Math.abs(height) + correct.y)) ? true : false;
            return _return;
        }
    }
};