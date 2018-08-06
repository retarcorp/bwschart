// общий класс графика
var Chart = function(type) {
    this.CurType = type;
};

var SUT = false;

var startUT = function() {
    SUT = true;
};

// функции класса
Chart.prototype = {
    
    // конструктор
    constructor: Chart,
    
    // флаг состояния автоотслеживания
    SupervisorEnable: false,
    
    // тип графика
    GraphType: "",

    // настройки графика
    GraphSettings: null,
    
    // визуальные настройки графика
    VisualSettings: null,
    
    // последние свечи
    LastDeltaCandle: null,
    LastOrderCandle: null,

    // DOM Element Canvas
    Canvas: null, 

    // временный холст
    TmpCanvas: null,
    
    // контекст основного холста
    Ctx: null,
    
    // контекст временного холста
    TmpCtx: null,

    // данные холста
    ImgData: null,

    // флаг состояние ЛКМ (false - не нажата, true - нажата)
    MouseFlag: false,
    
    // координаты курсора мыши
    CursorPositionX: 0,
    CursorPositionY: 0,
    
    // предыдущие координаты мыши
    PreCordX: 0,
    PreCordY: 0,
    
    // координаты первого нажатия пальцем на экран
    CursorPositionXforFirstTouch: 0,
    CursorPositionYforFirstTouch: 0,
    
    // координаты второго нажатия пальцем на экран
    CursorPositionXforSecTouch: 0,
    CursorPositionYforSecTouch: 0,   
    
    //флаги состояния для коректировки начальной цены
    FlagForStartPrice: true, 
    FlagForStartPriceF: true,
    
    //флаг состояния редактора спрайтов
    SpritesEdditor: false, 
    
    // флаг первого запуска приложения
    AppFirstStartedFlag: true,
    
    // координаты курсора мыши для построения спрайтов
    XCordCursorLine: 0,
    YCordCursorLine: 0,
    XDashLineSprite: 0,
    YDashLineSprite: 0,
    
    // спрайт индикатора цены и времени
    PriceFootnoteSprite: null, 
    TimeFootnoteSprite: null,
    
    // массив спрайтов (прмоугольники, линии и т.д.)
    Sprites: [], 
    
    // массив спрайтов (линии дня, месяца)
    DaySprites: [],
    
    // массив всех дней, на которых стоят линия дня/месяца
    Days: [],
    
    // массив профилей рынка
    MarketProfileSprites: [],
    
    // флаг установки начальной цены
    IsStartValueNotReceiced: true,
    
    // свечи, которые попадают в облась видимости
    VisibleCandles: [],
    
    // флаг активности редактора профилей рынка
    MarketProfileRedact: false,
    
    // флаг состояния косания пальцем экрана
    Touch: false,
    
    // координаты для построения спрайта прямоугольника
    CordForRectangleSprite: {
        first_x: 0,
        second_x: 0,
        first_y: 0,
        second_y: 0
    }, 
    
    // координата для постоянеия спрайта горизонтальной и вертикальной линии
    CordForHorizontalLine: 0, 
    CordForVerticalLine: 0,
    
    // текущий выбраный спрайт для построения
    CurrentSprite: '', 
    
    // редактор прямоугольника для PC и Mobile
    RectangleEdditor: false, 
    RectangleEdditorMobile: false,
    
    // флаг перехода за границу зума (false - перехода не было, true - переход был)
    IsZoomBorderCrossing: false,
    
    // флаг состояния активации зума по осевым линиям (false - зума не происходит, true - зум происходит)
    IsAxesZoom: false,

    // массив активный индикаторов    
    Indicators: [],
    
    // флаги состояния активации индикаторов
    IsVolumeIndicatorCreate: false,
    IsDeltaIndicatorCreate: false,
    IsOrderIndicatorCreate: false,
    
    // свеча?
    CandleSprite: null,
    
    // айди первого тика на ленте ордеров (необходимо для корректного отображения всей ленты ордеров)
    FirstIdOrder: 0,
    
    CurTypes: {
        delta: "delta",
        ordertape: "ordertape",
        footprint: "footprint"
    },
    
    // инициализация графика
    init: function(canvas, callback){
        this.GraphSettings = new GraphSettings();
        var curTypes = this.CurTypes;
        this.Canvas = canvas;
        this.Ctx = this.Canvas.getContext("2d");
        this.TmpCanvas = document.createElement('canvas');
        this.TmpCtx = this.TmpCanvas.getContext('2d');
        this.getDimensions();
        switch(this.CurType) {
            case curTypes.delta: this.VisualSettings = App.DeltaVisualSettings; break;
            case curTypes.ordertape: this.VisualSettings = App.OrderVisualSettings; break;
            case curTypes.footprint: this.VisualSettings = App.FootprintVisualSettings; this.GraphSettings.setTimeFrame(); break;
        }
        if(this.AppFirstStartedFlag){
            this.createMainSprite();
        }
        this.TmpCtx.save();
        this.recursiveRender();
        this.buildCurrentPrice(this.recursiveRender());
        Graph.Timer;
        callback();
    },
    
    // создает индикаторы по переданному типу
    createIndicator: function(type){
        var gs = this.GraphSettings,
            volume = 'Volume',
            delta = 'Delta',
            indicators = this.Indicators,
            ctx = this.TmpCtx,
            gs = this.GraphSettings;
            
        if(type === volume && this.IsVolumeIndicatorCreate && App.CurrentPlatform !== 'PC') {
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
            this.IsVolumeIndicatorCreate = true;
            var newIndicator = new Indicator(volume, indicators.length);
            indicators.push(newIndicator);
            gs.setIndicatorsProper(indicators);
        }
        else if(type === delta && !this.IsDeltaIndicatorCreate){
            this.IsDeltaIndicatorCreate = true;
            var newIndicator = new Indicator(delta, indicators.length);
            indicators.push(newIndicator);
            gs.setIndicatorsProper(indicators);
        } 
        this.render();
    },
    
    // получает и переназвачает свойства графика
    getDimensions: function() {
        var div = document.getElementsByClassName('graph')[0];
        var styles = getComputedStyle(div);
        var gs = this.GraphSettings;
        this.Canvas.height = parseInt(styles.height);
        this.Canvas.width = parseInt(styles.width);
        this.TmpCanvas.height = parseInt(styles.height);
        this.TmpCanvas.width = parseInt(styles.width);
        gs.HEIGHT = this.Canvas.height;
        gs.WIDTH = this.Canvas.width;
        gs.FIXED_WIDTH = this.Canvas.width;
        gs.FIXED_HEIGHT = this.Canvas.height;
        gs.zoomRecount();
    },
    
    // запускает отрисовку графика
    render: function(f) { 
        if(SUT){
            console.time();
        }
        var gs = this.GraphSettings;
        gs.recount();
        this.resetCanvas();
        gs.lastCandleVisible = true;
        
        if(!gs.lastCandleVisible && Data.Cache.containsInterval(gs.START_POINT_ON_NULL, gs.OX_MS)){
            this.buildData(f, Data.Cache.get(gs.START_POINT_ON_NULL, gs.OX_MS), true); 
        }else{
            this.buildData(f, Data.Cache.get(gs.START_POINT_ON_NULL, gs.OX_MS), false); 
        }
        if (App.Supervisor && !this.SupervisorEnable && (Data.LastABI || Data.LastDelta || Data.LastFootprint)) {
            
            this.SupervisorEnable = true;
            
            if (this.CurType === "delta") {
                Data.LastDelta = Data.Cache.Candles[Data.Cache.Candles.length-1];
                this.SupervisorEnable = true;
                this.transform({
                    new_start_ox: (Data.LastDelta.index * gs.FIXED_TIME_STEP + gs.FIXED_WIDTH/2) * gs.OX_SCALE,
                    new_start_price: this.currentPrice.y - gs.pxToPrice(gs.HEIGHT / 2),
                });
                
            } else if(this.CurType === 'footprint') {
                Data.LastFootprint = Data.Cache.Candles[Data.Cache.Candles.length-1];
                this.SupervisorEnable = true;
                this.transform({
                    new_start_ox: (Data.LastFootprint.index * gs.FIXED_TIME_STEP + gs.FIXED_WIDTH/2) * gs.OX_SCALE,
                    new_start_price: this.currentPrice.y - gs.pxToPrice(gs.HEIGHT / 2),
                });
            } else if (this.CurType === "ordertape"){
                var id1 = gs.getCurrentId(Data.Cache.Candles[0].id),    
                    id2 = gs.getCurrentId(Data.Cache.Candles[Data.Cache.Candles.length-1].id),
                    
                    new_start_ox = gs.getXCordForPx(id2 * gs.FIXED_TIME_STEP / 5)*gs.OX_SCALE,
                    new_start_price =  Data.LastABI.price - gs.pxToPrice(gs.HEIGHT / 2);
                    
                App.CurrentGraph.onDragged(new_start_ox - gs.WIDTH/2*gs.OX_SCALE, 0, true);
            }
            
        }
        
        
        if (!App.Supervisor && this.SupervisorEnable) {
            this.SupervisorEnable = false;
        }
        if(SUT){
            console.timeEnd();
            console.trace();
            SUT = false;
            debugger;
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
    
    // переопределяет координаты касания пальца к экрану (используеться только в событиях касаний)
    recountCord: function(e){
        var gs = this.GraphSettings;
        this.CursorPositionX = (e.touches[0].clientX - 40) / gs.TOTAL_ZOOM;
        this.CursorPositionY = gs.realY(e.touches[0].clientY / gs.TOTAL_ZOOM);
        this.onMoveForCursor(e);
    },
    
    // создает горизонтальную линию 
    createHorizontalLine: function(e) {
        var gs = this.GraphSettings;
        var newSprite = new HorizontalLineSprite();
        if(e.type === "mousedown"){
            newSprite.y = this.CordForHorizontalLine;
            this.Sprites.push(newSprite);
            this.SpritesEdditor = false;
            Ui.addHelpBar('', false);
        }
        else if(e.type === "touchstart"){
            if(this.Touch === true){
                this.recountCord(e);
                newSprite.y = this.CordForHorizontalLine;
                this.Sprites.push(newSprite);
                this.SpritesEdditor = false;
                Ui.addHelpBar('', false);
                this.Touch = false;
            }
        }
    },
    
    // создает вертикальную линию
    createVerticalLine: function(e) {
        var gs = this.GraphSettings;
        var newSprite = new VerticalLineSprite();
        if(e.type === "mousedown" && App.CurrentPlatform === 'PC'){
            if(this.CurType !== 'ordertape'){
                newSprite.x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.CordForVerticalLine : this.CordForVerticalLine + 0.5 * gs.FIXED_TIME_STEP;
            }
            else {
                newSprite.x = this.CordForVerticalLine;
            }
        }
        else if(e.type === "touchstart"){
            if(this.Touch === true){
                this.recountCord(e);
                newSprite.x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.CordForVerticalLine : this.CordForVerticalLine + 0.5 * gs.FIXED_TIME_STEP;
                this.Touch = false;
            }
        }
        this.Sprites.push(newSprite);
        this.SpritesEdditor = false;
        Ui.addHelpBar('', false);
    },
    
    // получает значение всех покупок-продаж для профиля рынка, по переданным координатам его углов
    getTotalValue: function(f_x, s_x, f_y, s_y) {
        // для оптимизации нужно придумать способ постоянно не вызывать эту функцию, если это необходимо
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
            var lnt = nTicks.length,
                coun = 0;
            
            nTicks.sort(function(a, b){
                return Object.keys(a)[0] - Object.keys(b)[0];
            });
            for(var i = 0; i < lnt; i++){
                for(var j = i+1; j < lnt; j++){
                    if(Object.keys(nTicks[i])[0] === Object.keys(nTicks[j])[0]){
                        nTicks[i][Object.keys(nTicks[i])[0]] += nTicks[j][Object.keys(nTicks[j])[0]];
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
    
    // создает прямоугольник
    createRectangle: function() {
        var gs = this.GraphSettings;
        var newSprite = new RectangleSprite();
        
        if(this.CurType !== 'ordertape'){
            newSprite.f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.CordForRectangleSprite.first_x : this.CordForRectangleSprite.first_x + 0.5 * gs.FIXED_TIME_STEP;
            newSprite.s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.CordForRectangleSprite.second_x : this.CordForRectangleSprite.second_x + 0.5 * gs.FIXED_TIME_STEP;
        }
        else {
            newSprite.f_x = this.CordForRectangleSprite.first_x;
            newSprite.s_x = this.CordForRectangleSprite.second_x;
        }
        newSprite.f_y = this.CordForRectangleSprite.first_y;
        newSprite.s_y =this.CordForRectangleSprite.second_y;
        this.Sprites.push(newSprite);
        Ui.addHelpBar('', false);
    },
    
    // создает профиль рынка
    createMarketProfile: function() {
        // console.log('create mp')
        var gs = this.GraphSettings;
        var newSprite = new MarketSprite();
        
        var f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.CordForRectangleSprite.first_x : this.CordForRectangleSprite.first_x + gs.FIXED_TIME_STEP;
        var s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (gs.X_ZOOM_CURRENT_GRADE === gs.X_ZOOM_GRADE.ZERO)) ? this.CordForRectangleSprite.second_x : this.CordForRectangleSprite.second_x + gs.FIXED_TIME_STEP;
        newSprite.f_x = this.findCandleTsByCord(f_x)/1000;
        newSprite.f_y = this.CordForRectangleSprite.first_y;
        newSprite.s_x = this.findCandleTsByCord(s_x)/1000;
        newSprite.s_y = this.CordForRectangleSprite.second_y;
        
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
    
    // выбирает какую функцию использовать для поиска свечи по переданой координате
    findCandleTsByCord: function(cord) {
        if(this.CurType === 'delta'){
            return this.findDeltaCandleTsByCord(cord);
        }
        else if(this.CurType === 'footprint'){
            return this.findFootprintCandleTsByCord(cord);
        }
    },
    
    // находит дельта свечу по переданой координате
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
    
    // находит футпринт свечу по переданой координате
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
    
    // выбирает какую функцию использовать для поиска свечи по переданой метки времени
    findeCandleCordByTs: function(ts) {
        ts *= 1000;
        if(this.CurType === 'delta'){
            return this.findDeltaCandleCordByTs(ts);
        }
        else if(this.CurType === 'footprint'){
            return this.findFootprintCandleCordByTs(ts);
        }
    },
    
    // находит дельта свечу по переданой метке времени
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
    
    // находит футпринт свечу по переданой координате
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
    
    // загружает профиль рынка
    loadMarketProfile: function(ins, ans) {
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
                        MarketArr.push(new MarketSprite());
                    
                        MarketArr[MarketArr.length - 1].f_x = elem.startTS;
                        MarketArr[MarketArr.length - 1].s_x = elem.endTS;
                    
                        MarketArr[MarketArr.length - 1].f_y = elem.startPrice;
                        MarketArr[MarketArr.length - 1].s_y = elem.endPrice;
                        
                        MarketArr[MarketArr.length - 1].send = elem;
                        
                        this.Sprites.push(MarketArr[MarketArr.length - 1]); 
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
    
    // обновляет профиль рынка
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
            market.send = {
                id: market.send.id,
                instrument: market.send.instrument,
                timeframe: market.send.timeframe,
                startTS: (market.f_x < market.s_x) ? market.f_x : market.s_x,
                endTS: (market.f_x > market.s_x) ? market.f_x : market.s_x,
                startPrice: (market.f_y < market.s_y) ? market.f_y : market.s_y,
                endPrice: (market.f_y > market.s_y) ? market.f_y : market.s_y
            }
        }
    },
    
    // создает основные спрайты для графика (такие как вертикальные штриховые линии, указатели текушей цены и тд)
    createMainSprite: function() {
        var gs = this.GraphSettings;
        this.AppFirstStartedFlag = false;
        this.XDashLineSprite = new XDashLineSprite();
        this.YDashLineSprite = new YDashLineSprite();
        this.PriceFootnoteSprite = new PriceFootnoteSprite();
        this.currentPriceLine = new HorizontalLineSprite('CurrentPrice');
        this.currentPrice = new PriceFootnoteSprite();
        this.TimeFootnoteSprite = new TimeFootnoteSprite();
        
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
    },
    
    // очищает все добавленые пользователем спрайты с графика
    removeAllSprites: function() {
        this.SpritesEdditor = false;
        
        this.MarketProfileSprites.forEach( (market) => {
            Data.deleteMarketProfile(market.send.id);
        });
        
        this.Sprites.splice(0, this.Sprites.length);
        this.MarketProfileSprites.splice(0, this.MarketProfileSprites.length);
    },
    
    // выбивает какой спрайт создать
    createSprite: function(e){
        if(this.SpritesEdditor){
            switch(this.CurrentSprite){
                case 'horizontal-line': this.createHorizontalLine(e); break;
                case 'vertical-line': this.createVerticalLine(e); break;
                case 'rectangle': this.RectangleEdditor = true; this.RectangleEdditorMobile = true; break;
                case 'market-profile': this.RectangleEdditor = true; this.RectangleEdditorMobile = true; this.marketEdditor = true; break;
                // case 'move': console.log(this.CurrentSprite); break;
                case 'remove': this.findSprite(e); break;
            }
        }
    },
    
    // очищает массив спрайтов
    clearSprites: function(clear) {
        if (typeof clear == "object") {
            var length = this.Sprites.length;
            var buf = [];
            this.Sprites.forEach( (sprite) =>  {
                if (sprite.type !== clear.type) {
                    buf.push(sprite);
                }
            });
            this.Sprites = buf;
             
        }
    },
    
    // находит нужный спрайт
    findSprite: function(e) {
        if(this.Sprites !== undefined){
            for(var i = this.Sprites.length - 1; i >= 0; i--){
                 if(this.GraphSettings.findeSpriteCord(this.Sprites[i], e))
                {
                    if (this.Sprites[i].type == "Market") {
                        Data.deleteMarketProfile(this.Sprites[i].send.id);
                    }
                    this.Sprites.splice(i, 1);
                    break;
                }
            }
        }
        this.SpritesEdditor = false;
        Ui.addHelpBar('', false);
    },
    
    // очищает холст и отрисовывает сетку
    resetCanvas: function() {
        this.TmpCtx.fillStyle = this.VisualSettings.DIR_BG;
        this.TmpCtx.fillRect(0, 0, this.GraphSettings.WIDTH, this.GraphSettings.HEIGHT);
        this.drawGrid();
    },
    
    // вызывает таймер для отправки запросов на текущую цену
    buildCurrentPrice: function(f) {
        Graph.Timer = setTimeout(this.buildCurrentPrice.bind(this), 5000, f);
        Graph.requestInProcessForCurrentPrice = true;
        Data.getStartValue(App.CurrentGraph.INSTRUMENT, f, false);
    },
    
    // определяет какого типа запросы необходимо посылать и после вызывает отрисовку всех элементов на графике
    buildData: function(f, candles, isFullIntervalInCache) {
        var t = this;
        var gs = App.CurrentGraph.GraphSettings;
        
        this.currentPriceLine.renderIfVisible();  
        
        if(App.CurrentGraph.IsStartValueNotReceiced && this.CurType === 'footprint'){
            App.CurrentGraph.IsStartValueNotReceiced = false;
            Graph.RequestInProcess = true;
            Data.getStartValue(App.CurrentGraph.INSTRUMENT, f, true);
        }
        else if(this.FlagForStartPrice && !Graph.RequestInProcess && !App.CurrentGraph.IsStartValueNotReceiced && this.CurType === 'footprint') {
            gs.MIDDLE_PRICE = Data.LastValue.price;
            gs.START_TS = 1 * Data.LastValue.date + 3 * gs.TIMEFRAME_TS;
            this.FlagForStartPrice = false;
            gs.setStartPrice();
        }
        
        if(t.FlagForStartPrice && candles.length !== 0 && this.CurType !== 'footprint'){
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
            
            this.FirstIdOrder = Data.RightOrderCandle.id;
            t.FlagForStartPrice = false;
            gs.setStartPrice();
        } 
        if(isFullIntervalInCache){
            t.buildSprites(candles);
            this.drawMainGraph();
        }else{
            if(candles.length!==0){
                t.buildSprites(candles);
            }
            var index = gs.getCandleIndex();
            if(this.CurType === 'delta'){
                App.CurrentGraph.getSprites(f, index);
            }
            else if(this.CurType === 'ordertape') {
                App.CurrentGraph.getSprites(f, index*5 + this.FirstIdOrder);
            }
            else if(this.CurType === 'footprint' && !this.FlagForStartPrice) {
                App.CurrentGraph.getSprites(f, index);
            }
            this.drawMainGraph(candles);
        }
    },
    
    // отрисовывает индикаторы
    buildIndicators: function(candles) {
        var t = this,
            ctx = this.TmpCtx,
            gs = this.GraphSettings;
        
        for(var i = this.Indicators.length - 1; i >= 0; i--){
            this.Indicators[i].onGraphRender(candles, ctx, gs);
        }
    },

    //просто создание спрайтов и отрисовка
    buildSprites: function (candles) {
        var t = this,
            ctx = this.TmpCtx,
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
        
        if(this.Sprites !== undefined){
            this.Sprites.forEach(function(elem){
                sprites.push(elem);
            });
            this.DaySprites.forEach(function(elem){
                sprites.push(elem);
            });
        }
        
       sprites.forEach(function(candle){
            candle.renderIfVisible();
       });
    },
    
    // вычисляет где необходимо отрисовать линии начала дня/месяца
    buildTimeSprites: function(candles) {
        var gs = this.GraphSettings,
            ctx = ctx = App.CurrentGraph.TmpCtx,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            t = this,
            bufVis = [],
            vis = false;
        ctx.fillStyle = this.VisualSettings.DIR_TIME_FILL;
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
        
        this.VisibleCandles = bufVis;
        this.drawEndLines("day");
        this.CandleSprite = candles;
    },
    
    // отрисовывает все необходимые для графика элементы
    drawMainGraph: function(candles) {
        this.fillRect();
        this.drawAxes();
        this.drawGridMarks();
        if(this.Indicators.length !== 0 && candles !== undefined){
            this.buildIndicators(candles);
        }
        this.YDashLineSprite.renderIfVisible();
        this.PriceFootnoteSprite.renderIfVisible();
        this.currentPrice.renderIfVisible();
        this.buildTimeSprites(candles);
        this.XDashLineSprite.renderIfVisible();
        this.TimeFootnoteSprite.renderIfVisible();
        this.transferImgData();
    },
    
    // отрисовывает линии начала дня/месяца
    drawEndLines: function(type) {
        var gs = this.GraphSettings,
            gp = App.CurrentGraph,
            day = "",
            candleDay = "";
        this.VisibleCandles.forEach( (Candle, i, mas) => {
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
                        case 'footprint': check = new Date(mas[i+1].Candle.from).getHours() - new Date(Candle.Candle.from).getHours(); break;
                    }
                }
                else {
                    check = new Date(Candle.Candle.from).getMonth() - new Date(mas[i+1].Candle.from).getMonth();
                }

                if (check < 0 && !this.Days.find( function(elem){
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
            day = y+"-"+adderM+m+"-"+adderD+d;
            this.Days.push(day);
            gp.candleStartDay.flag = true;
            gp.DaySprites.push(v);
        }
        
        gp.candleStartDay = null;
        gp.candleEndDay = null;
        gp.candleEndMonth = null;
        
    },
    
    // перерисовывает пространства под графиком и справа от него
    fillRect: function() {
        var ctx = this.TmpCtx,
            gs = this.GraphSettings;
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        ctx.fillStyle = "#ffffff";
        ctx.fillRect(0, gs.HEIGHT - bottom_indent, gs.WIDTH, bottom_indent);//заливка нижнего пространства
        ctx.fillRect(gs.WIDTH - right_indent, 0, right_indent, gs.HEIGHT);//заливка правого пространства
    },
    
    // отрисовывает оси графика
    drawAxes: function () {
        var ctx = this.TmpCtx,
            gs = this.GraphSettings,
            px = gs.PERFECT_PX,
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            delta_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE,
            centerX = gs.WIDTH - right_indent,
            centerY = Math.ceil(gs.HEIGHT - bottom_indent);
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
    
    // все imagedata буферного холста переприсваевает на видимый холст
    transferImgData: function () {
        this.Ctx.putImageData(this.TmpCtx.getImageData(0, 0, this.GraphSettings.WIDTH, this.GraphSettings.HEIGHT), 0, 0);
    },

    //отрисовка сетки на графике
    drawGrid: function () {
        var ctx = this.TmpCtx;
        ctx.strokeStyle = this.VisualSettings.DIR_GRID;
        ctx.lineWidth = App.CurrentGraph.GraphSettings.LINE_WIDTH;
        this.drawXGrid();
        this.drawYGrid();
    },

    //отрисовка вертикальных линий
    drawXGrid: function () {
        var ctx = this.TmpCtx,
            gs = this.GraphSettings,
            px = gs.PERFECT_PX,
            pixelsPerGridMark = gs.TIME_STEP,
            smallIntervalPixelsWidth = gs.calculateIndentOnX(),
            currentW = smallIntervalPixelsWidth,
            delta_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE,
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
        var ctx = this.TmpCtx,
            gs = this.GraphSettings;
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var delta_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
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
    
    // отрисовывает метки на осях
    drawGridMarks: function () { 
        this.drawYGridMarks();
    },

    // отрисовывает метки на оси OY
    drawYGridMarks: function () {
        var ctx = this.TmpCtx,
            gs = this.GraphSettings,
            px = gs.PERFECT_PX,
            pricePerPixel = gs.PRICE_PER_PX, // How many PRICE units in 1 PIXEL currently
            pixelsPerGridMark = gs.PRICE_STEP, // Pixels in one vertical mark on Y grid
            startPrice = gs.START_PRICE; // Price units on zero point in corner of graph

        var priceUnitsInGridMark = gs.round(pixelsPerGridMark * pricePerPixel, gs.ROUNDING);

        var firstGridMarkPrice = (startPrice % priceUnitsInGridMark ) ?
            (startPrice + priceUnitsInGridMark - startPrice % priceUnitsInGridMark)
            : startPrice + priceUnitsInGridMark; // Price on first grid mark visible on axe

        if (startPrice < 0) {
            firstGridMarkPrice -= priceUnitsInGridMark;
        }
        var smallIntervalPixelsHeight = gs.calculateIndentOnY();
        
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            delta_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_TEXT_INDENT : gs.RIGHT_TEXT_INDENT_MOBILE,
            currentH = delta_indent + smallIntervalPixelsHeight,
            currentGridMarkPrice = firstGridMarkPrice,
            centerX = gs.WIDTH - right_indent + px,
            cord_of_mark_X = gs.WIDTH - right_indent + gs.HATCH_LENGHT;
            
        ctx.fillStyle = this.VisualSettings.DIR_PRICE_FILL;
        ctx.fillRect(gs.WIDTH - right_indent, 0, right_indent, gs.HEIGHT);
        ctx.beginPath();
        ctx.moveTo(gs.WIDTH - right_indent, 0);
        ctx.lineTo(gs.WIDTH - right_indent, gs.HEIGHT - bottom_indent);
        ctx.stroke();
        
        ctx.lineWidth = gs.LINE_WIDTH;
        ctx.fillStyle = this.VisualSettings.DIR_PRICE_TEXT; 
        ctx.strokeStyle = '#000000';
        ctx.font = (App.CurrentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        
        ctx.beginPath();
        while (currentH < gs.HEIGHT) {
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

    // определяет на какую клавишу нажали и от результата выбирает куда двигать график
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
                val = -gs.TIME_STEP;
                this.onDragged(val, 'left');
                break;
            case up:
                val = gs.PRICE_STEP / gs.PRICE_POINTS;
                this.onDragged(val, 'up');
                break;
            case right:
                val = gs.TIME_STEP;
                this.onDragged(val, 'right');
                break;
            case down:
                val = -gs.PRICE_STEP / gs.PRICE_POINTS;
                this.onDragged(val, 'down');
                break;
        }
        this.onMoveForCursor();
    },
    
    // переопределяет координаты и вызов необходимых функций при нажатии на ЛКМ или касание пальца
    onDown: function (e) {
        var gs = this.GraphSettings;
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var delta_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        var zoom = gs.TOTAL_ZOOM;
        if(e.type === 'mousedown' && App.CurrentPlatform === 'PC'){
            this.findIndicatorZoneClose(e, gs);
            var x = (e.clientX - 40) / zoom,
                y = e.clientY / zoom,
                marketSprites = this.MarketProfileSprites;
            if (marketSprites.length) {
                marketSprites.forEach( (elem) => {
                   var maxValX = (elem.f_x > elem.s_x) ? elem.f_x : elem.s_x,
                       minValX = (elem.f_x > elem.s_x) ? elem.s_x : elem.f_x,
                       maxValY = (elem.f_y > elem.s_y) ? elem.f_y : elem.s_y,
                       minValY = (elem.f_y > elem.s_y) ? elem.s_y : elem.f_y;
                    
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
                if(this.RectangleEdditor){
                    this.CordForRectangleSprite.first_x = this.XDashLineSprite.x;
                    this.CordForRectangleSprite.first_y = this.YDashLineSprite.y;
                } else if (!this.MarketProfileRedact) {
                    this.MouseFlag = true;
                    this.CursorPositionX = x;
                    this.CursorPositionY = gs.realY(y);
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
                    if(this.RectangleEdditor && this.RectangleEdditorMobile){
                        this.recountCord(e);
                        this.CordForRectangleSprite.first_x = this.XDashLineSprite.x;
                        this.CordForRectangleSprite.first_y = this.YDashLineSprite.y;
                        this.RectangleEdditorMobile = false;
                        App.ClickForEvent = false;
                    }
                    else if(this.RectangleEdditor){
                        this.recountCord(e);
                        this.CordForRectangleSprite.second_x = this.XDashLineSprite.x;
                        this.CordForRectangleSprite.second_y = this.YDashLineSprite.y;
                        if(!this.marketEdditor) {
                            this.createRectangle();
                        }
                        else {
                            this.createMarketProfile();
                        }
                        this.RectangleEdditor = false;
                        this.SpritesEdditor = false;
                    }
                    else {
                        this.MouseFlag = true;
                        this.recountCord(e);
                    }
                }
            }
            else if(e.touches.length === 2){
                var x1 = (e.touches[1].clientX - 40) / zoom,
                    y1 = e.touches[1].clientY / zoom;
                if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent) && (x1 <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent)) {
                    this.CursorPositionXforFirstTouch = x;
                    this.CursorPositionYforFirstTouch = gs.realY(y);
                    this.CursorPositionXforSecTouch = x1;
                    this.CursorPositionYforSecTouch = gs.realY(y1);
                }
            }
        }
    },
    
    // находит зону кнопки закрытия индикаторов
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
    
    // находит основную зону индикатора
    findIndicatorZone: function(e, gs){
        if(this.Indicators.length !== 0){
            this.Indicators.forEach(function(elem){
                elem.onGraphMouseMove(e, gs);
            });
        }
    },
    
    // переопределение координат и прочие действия при движении мыши или пальца 
    onMove: function (e) {
        var gs = this.GraphSettings;
        var zoom = gs.TOTAL_ZOOM;
        var X = (e.clientX - 40) / zoom,
            Y = e.clientY / zoom;
        this.cordX = X;
        this.cordY = gs.realY(Y);
        var x = 0, y = 0, xS = 0, yS = 0, deltaX = 0, deltaY = 0;
        if(e.type === 'mousemove' && App.CurrentPlatform === 'PC'){
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
                                    elem.f_x = this.findCandleTsByCord(this.CordForVerticalLine)/1000;
                                }
                                else {
                                    elem.s_x = this.findCandleTsByCord(this.CordForVerticalLine)/1000;
                                }
                                break;
                                
                            case 'right': 
                                if (elem.f_x > elem.s_x) {
                                    elem.f_x = this.findCandleTsByCord(this.CordForVerticalLine)/1000;
                                }
                                else {
                                    elem.s_x = this.findCandleTsByCord(this.CordForVerticalLine)/1000;
                                }
                                break;
                                
                            case 'down':
                                if (elem.f_y > elem.s_y) {
                                    elem.s_y = this.CordForHorizontalLine;
                                }
                                else {
                                    elem.f_y = this.CordForHorizontalLine;
                                }
                                break;
                                
                            case 'up':
                                if (elem.f_y < elem.s_y) {
                                    elem.s_y = this.CordForHorizontalLine;
                                }
                                else {
                                    elem.f_y = this.CordForHorizontalLine;
                                }
                                break;
                        }
                    }
                });
            }
            
            if (this.MouseFlag && !this.MarketProfileRedact) {
                deltaX += (this.CursorPositionX - x) * gs.OX_SCALE;
                deltaY += (this.CursorPositionY - y) * gs.PRICE_PER_PX;
                this.onDragged(deltaX, deltaY);
                this.CursorPositionX = x;
                this.CursorPositionY = y;
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
                if (this.MouseFlag) {
                    x = X;
                    y = gs.realY(Y);
                    this.cordX = x;
                    this.cordY = y;
                    deltaX += (this.CursorPositionX - x) * gs.OX_SCALE;
                    deltaY += (this.CursorPositionY - y) * gs.PRICE_PER_PX;
                    this.onDragged(deltaX, deltaY);
                    this.CursorPositionX = x;
                    this.CursorPositionY = y;
                }
            }
            else if (e.touches.length === 2){
                var X1 = (e.touches[1].clientX - 40) / zoom,
                    Y1 = e.touches[1].clientY / zoom;
                //console.log(e)
                var xft = this.CursorPositionXforFirstTouch,
                    xst = this.CursorPositionXforSecTouch,
                    yft = this.CursorPositionYforFirstTouch,
                    yst = this.CursorPositionYforSecTouch,
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
    
    // определяет находиться ли курсов в поле под осью OX и правее оси OY
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
    
    // определяет на сколько нужно роизвести зум при движении по линиям осей с зажатой ЛКМ
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
    
    // переопределение координат для отрисовки спрайтов-линий
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
            var cordX = this.CursorPositionX,
                cordY = this.CursorPositionY;
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
            
            if(!this.MouseFlag || e !== undefined){
                if(this.IsZoomBorderCrossing || (x_zoom_cur_grade > gs.X_ZOOM_GRADE.ZERO)) adder = 0;
                    if(App.CurrentGraph.CurType !== 'ordertape'){
                        this.XDashLineSprite.x = Math.round(_x/pow)*pow-adder;
                    }
                    else {
                        this.XDashLineSprite.x = _x;
                    }
                    this.TimeFootnoteSprite.x = _x;
                    this.Touch = true;
                    if(this.spritesEdditorr || this.Touch){
                        this.CordForVerticalLine = _x;
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
                
                this.YDashLineSprite.y = _y;
                this.PriceFootnoteSprite.y = _y;
                this.Touch = true;
                if(this.SpritesEdditor || this.Touch){
                    this.CordForHorizontalLine = _y;
                }
            }
            this.recursiveRender();
        }
    },

    // переопределяет координаты и производит остальные действия при поднятии ЛКМ или снятия касания с жкрана пальцем
    onUp: function (e) {
        var gs = this.GraphSettings;
        this.IsAxesZoom = false;
        if(e.type === 'mouseup' && App.CurrentPlatform === 'PC'){
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
            if(this.RectangleEdditor){
                this.CordForRectangleSprite.second_x = this.XDashLineSprite.x;
                this.CordForRectangleSprite.second_y = this.YDashLineSprite.y;
                if(!this.marketEdditor) {
                    this.createRectangle();
                }
                else {
                    this.createMarketProfile();
                    this.marketEdditor = false;
                }
                this.RectangleEdditor = false;
                this.SpritesEdditor = false;
            } else if (!this.MarketProfileRedact) {
                this.MouseFlag = false;
                this.CursorPositionX = (e.clientX - 40) / gs.TOTAL_ZOOM;//gs.realX(e.clientX - 50);
                this.CursorPositionY = gs.realY(e.clientY / gs.TOTAL_ZOOM);
            }
        }
        else if (e.type === 'touchend') {
            this.MouseFlag = false;
        }
    },

    // определяет на сколько нужно сдвинуть график при движении мыши с зажатой ЛКМ
    onDragged: function (x, y, Supervisor) {
        if (!App.Supervisor || Supervisor ) {
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
    
    // определяет на сколько нужно отдалить/приблизить график при прокрутке колесиком мыши или движениях двумя пальцами по экрану
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
    
    // определяет что нужно сделать при масштабировании колесиком или двумя пальцами(приблизить или отдалить)
    zoomOnWheel: function (flag, cord) {
        var gs = this.GraphSettings;
        if (flag === 'in') {
            this.zoomIn(1, cord);
        }
        else if (flag === 'out') {
            this.zoomOut(1, cord);
        }
    },
    
    // определяет на сколько нужно приблизить график при масштабировании колесиком или двумя пальцами
    zoomIn: function (power, cord) {
        var gs = this.GraphSettings;
        var max = 1,
            TransformQuery = {};
        if (gs.TOTAL_ZOOM !== max) {
            var bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
            cord.W = gs.WIDTH - right_indent;
            cord.H = gs.HEIGHT - bottom_indent;
            TransformQuery.zoom = (gs.TOTAL_ZOOM < max) ? (1 * (gs.TOTAL_ZOOM + 0.01 * power).toFixed(2)) : gs.TOTAL_ZOOM;
            TransformQuery.cord = cord;
            this.transform(TransformQuery);
        }
    },
    
    // определяет на сколько нужно отдалить график при масштабировании колесиком или двумя пальцами
    zoomOut: function (power, cord) {
        var gs = this.GraphSettings;
        var min = 0.4,
            TransformQuery = {};
        if (gs.TOTAL_ZOOM !== min) {
            var bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
            cord.W = gs.WIDTH - right_indent;
            cord.H = gs.HEIGHT - bottom_indent;
            TransformQuery.zoom = (gs.TOTAL_ZOOM > min) ? (1 * (gs.TOTAL_ZOOM - 0.01 * power).toFixed(2)) : gs.TOTAL_ZOOM;
            TransformQuery.cord = cord;
            this.transform(TransformQuery);
        }
    },
    
    // определяет что нужно делать и делает это, по переанным параметрам (сдвинуть график, отдалить и тд)
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
            this.YCordCursorLine += q.transform_Price;
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
                    gs.START_OX_POINT += Math.abs(gs.START_OX_POINT - this.CordForVerticalLine - gs.pxToScale((gs.WIDTH - q.cord.X - 100))*4);
                    gs.IS_ZOOM_BORDER = true;
                } 
                
                if (!(App.CurrentGraph.IsZoomBorderCrossing) && gs.IS_ZOOM_BORDER) {
                    gs.START_OX_POINT = this.CordForVerticalLine + gs.pxToScale((gs.WIDTH - q.cord.X - 100)/4);
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
                bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
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

// Объект настроек графика 
var GraphSettings = function () { 
    this.TOTAL_ZOOM = 1;                 // текущий масштаб графика (для колесика)
    this.ZOOM_X = 9;                     // масштаб графика по оси ОХ
    this.ZOOM_Y = 0;                     // масштаб графика по оси ОУ
    this.WIDTH = 0;                      // ширина холста
    this.HEIGHT = 0;                     // высота холста
    this.FIXED_WIDTH = 0;                // фиксированная ширина холста
    this.FIXED_HEIGHT = 0;               // фиксированная высота холста
    
    this.IS_ZOOM_BORDER = false;         // флаг состояние перехода через конкретное значение масштаба колесиком
    this.IS_TIME_ZOOM_BORDER = false;    // флаг состояния перехода через конкретное знаение масштаба по оси ОХ
    this.X_ZOOM_GRADE = {                // фиксированные значения степени масштаба по оси ОХ
        ZERO: 0,
        ONE: 1,
        TWO: 2,
        THREE: 3,
        FOUR: 4
    };
    this.X_ZOOM_CURRENT_GRADE = 0;       // текущяя степень масштаба по оси ОХ
    this.GRADE = 1;                      // текущаяя степень масштаба
    
    this.Y_ZOOM_GRADE = {                // фиксированные значения степени мастаба по оси ОУ
        ZERO: 1,
        ONE: 3,
        TWO: 5,
        THREE: 7,
        FOUR: 9
    };
    this.Y_ZOOM_CURRENT_GRADE = 1;       // текущаяя степень масштаба по оси ОУ
    
    this.MIN_X_ZOOM = -200;              // минимальное значение масштаба по оси ОХ
    this.MIN_Y_ZOOM = -100;              // минимальное значение масштаба по оси ОУ
    this.MAX_X_ZOOM = 9;                 // максимальное значение масштаба по оси ОХ
    this.MAX_Y_ZOOM = 0;                 // максимальное значение масштаба по оси ОУ
    
    this.START_TS = 0;                   // значение метки времени в левом нижнем углу графика
    this.START_OX_POINT = 300;           // значение координаты в левом нижнем углу графика
    this.START_POINT_ON_NULL = 0;        // значение координаты в правом нижнем углу графика
    this.TIME_STEP = 0;                  // шаг отрисовки свеч по оси ОХ
    this.FIXED_TIME_STEP = 100;          // фиксированный шаг отрисовки свеч по оси ОХ
    this.OX_MS = 0;                      // значение показывающее сколько единиц координат содержится в одном пикселе
    
    this.START_PRICE = 0;                // значение цены в правом нижнем углу графика
    this.PRICE_PER_PX = 0;               // значение показывающее сколько единиц цены содержиться в одном пикселе
    this.FIXED_PRICE_PER_PX = 0;         // фиксированное значение показывающее сколько единиц цены содержиться в одном пикселе
    this.PRICE_STEP = 0;                 // шаг отрисовки по оси ОУ
    this.PRICE_POINTS = 5;               // величина отвечающаяя за кол-во раздровлений одного шага цены
    this.FIXED_PRICE_POINTS = 5;         // фиксированная величина отвечающаяя за кол-во раздровлений одного шага цены
    this.PRICE_TICK_STEP = 0;            // шаг отрисовки тиков цены
    this.MIDDLE_PRICE = 0;               // содержит в себе цену, которая должна быть посередине экрана
    
    this.RIGHT_INDENT = 85;              // отступ справа для ПК
    this.FIXED_RIGHT_INDENT = 85;        // фиксированный отступ справа для ПК
    this.RIGHT_INDENT_MOBILE = 70;       // отступ справа для мобильных устройств
    this.FIXED_RIGHT_INDENT_MOBILE = 70; // фиксированный отступ справа для мобильных устройств
    
    this.BOTTOM_INDENT = 30;             // нижний отступ для ПК
    this.FIXED_BOTTOM_INDENT = 30;       // фиксированный нижний отступ для ПК
    this.BOTTOM_INDENT_MOBILE = 25;      // нижний отступ для мобильных устройств
    this.FIXED_BOTTOM_INDENT_MOBILE = 25;// фиксированный нижний отступ для мобильных устройств
    
    this.TEXT_FONT = '14px Arial';       // стиль основного текста для ПК
    this.TEXT_FONT_MOBILE = '12px Arial';// стиль основного текста для мобильных устройств
    this.TEXT_TICK_FONT = '11px Arial';  // стиль текста для тиков для ПК
    this.TEXT_TICK_FONT_MOBILE = '9px Arial'; // стиль текста для тиков для мобильных устройств
    this.TEXT_MARKET_FONT = 'bold 16px Arial';// стиль текста для профиля рынка для ПК
    this.TEXT_MARKET_FONT_MOBILE = 'bold 13px Arial';// стиль текста для профиля рынка для мобильных устройств
    this.TEXT_ORDER_FONT = '17px Arial'; // стиль текста для графика ленты ордеров для ПК
    this.TEXT_ORDER_FONT_MOBILE = '15px Arial'; // стиль текста для графика ленты ордеров для мобильных устройств
    
    this.PERFECT_PX = 0.5;               // константное значение для исключения размытости в отрисовки
    this.INSTRUMENT = 0;                 // текущий инструмент
    
    this.POWER_OF_GRAPH = 1.03;          // константное значение для масштабирования графика колесиком и по оси ОХ
    this.POWER_OF_GRAPH_Y = 1.02;        // константное значение для масштабирования графика по оси ОУ
    this.lastCandleVisible = true;       // флаг указывающий на то, видна ли последняя свеча
    this.ROUNDING = 0;                   // степень округления значений цены
    this.LINE_WIDTH = 1;                 // ширина линий для отрисовки
    this.HATCH_LENGHT = 8.5;             // длинна меток на осях
    
    this.OX_SCALE = 1;                   // масштаб оси ОХ
    this.FIXED_OX_SCALE = 1;             // фиксированный масштаб оси ОХ
     
    this.ZOOM = 20;                      // текущий масштаб (для масштаба колесиком или пальцами)


     // проверить необходимость этих переменных {
    this.DELTA_INDENT = 30;              // отступ для индикаторов(ПК)
    this.DELTA_INDENT_MOBILE = 25;       // отступ для индикаторов(мобильные устройства)
    this.FIXED_DELTA_INDENT = 30;        // фиксированный отступ для индикаторов(ПК)
    this.FIXED_DELTA_INDENT_MOBILE = 25; // фиксированный отступ для индикаторов(мобильные устройства)
     // }
     
    this.DELTA = 0;                      // текущее значение дельты
    
    this.RIGHT_TEXT_INDENT = 46.5;       // правый отступ для текста(ПК)
    this.FIXED_RIGHT_TEXT_INDENT = 46.5; // фиксированный правый отступ для текста(ПК)
    this.RIGHT_TEXT_INDENT_MOBILE = 40;  // правый отступ для текста(мобильные устройства)
    this.FIXED_RIGHT_TEXT_INDENT_MOBILE = 40; // фиксированный правый отступ для текста(мобильные устройства)
    
    this.BOTTOM_TEXT_INDENT = 17.5;      // нижний отступ для текста(ПК)
    this.FIXED_BOTTOM_TEXT_INDENT = 17.5;// фиксированный отступ для текста(ПК)
    this.BOTTOM_TEXT_INDENT_MOBILE = 16; // нижний отступ для текса(мобильные устройства)
    this.FIXED_BOTTOM_TEXT_INDENT_MOBILE = 16; // фиксированный нижний отступ для текста(мобильные устройства)
    
    this.INDICATORS_INDENT = 0;          // отступ для индикаторов
    this.FIXED_INDICATORS_INDENT = 0;    // фиксированный отступ для индикаторов
     
    this.TIMEFRAME = 0;                  // текущий таймфрейм(String)
    this.TIMEFRAME_TS = 0;               // текущий таймфрейм(Integer)
};

GraphSettings.prototype = {
    constructor: GraphSettings
    
    // переопределение масштаба графика при масштабировании по оси ОХ
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
    
    // переопределение масштаба графика при масштаббировании по оси ОУ
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
    
    // переопределение масштаба графика по осям OX и OY
    , countZoomGrade: function() {
        this.countXZoomGrade();
        this.countYZoomGrade();
    }
    
    // возвращает ID для свеч ленты ордеров, предназначенный для отрисовки
    , getCurrentId: function(id) {
        return id - App.CurrentGraph.FirstIdOrder;
    }
    
    // возвращает координату по ОХ через ее фиксированную координату
    , getXCordForPx: function (n) {
        return (n - this.START_POINT_ON_NULL) / this.OX_SCALE;
    }

    // возвращает координату по ОУ через ее фиксированную координату
    , getYCordForPrice: function (n) {
        var delta_indent = (App.CurrentPlatform === 'PC') ? this.DELTA_INDENT : this.DELTA_INDENT_MOBILE;
        return this.HEIGHT - delta_indent - ((n - this.START_PRICE) / this.PRICE_PER_PX);
    }
    
    // переопределяет велечины для коректной отрисовки после масштабирования
    , zoomRecount: function() {
        var zoom = this.TOTAL_ZOOM;
        var ctx = App.CurrentGraph.TmpCtx;
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
    
    // переопределяет значения при масштабировании по оси ОУ
    , zoomYRecount: function() {
        var zoom = this.TOTAL_ZOOM;
        var zoom_y = Math.abs(Math.pow(this.POWER_OF_GRAPH_Y , this.ZOOM_Y * 0.2));
        
        this.TEXT_TICK_FONT = 11 / zoom * zoom_y  + 'px Arial';
        this.TEXT_TICK_FONT_MOBILE = 9 / zoom * zoom_y + 'px Arial';
        
        this.TEXT_ORDER_FONT = 17 / zoom * zoom_y + 'px Arial';
        this.TEXT_ORDER_FONT_MOBILE = 15 / zoom * zoom_y + 'px Arial';
    }
    
    // возвращает коректные значение координаты по ОУ 
    , realY: function (y) {
        var delta_indent = (App.CurrentPlatform === 'PC') ? this.DELTA_INDENT : this.DELTA_INDENT_MOBILE;
        return this.HEIGHT - delta_indent - y;
    }

    // Returns size of small interval behind the first grid line in PIXELS
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

    // возвращает координату при текущем масштабе оси ОХ
    , pxToScale: function (x) {
        return x * this.OX_SCALE;
    }

    // возвращает координату при текущем масштабе оси ОУ
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
    
    // возвращает округленное до задоного знака число
    , round: function(x, quantity, additive) {
        additive = (additive !== undefined) ? additive : 0;
        var t = Math.pow(10, quantity - additive);
        return Math.round(x * t) / t;
    }
    
    // вызывает функции пересчета значений
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
    
    // переопределяет текущий таймфрейм
    , setTimeFrame: function() {
        this.TIMEFRAME = App.CurrentGraph.TIMEFRAME.val;
        this.TIMEFRAME_TS = App.CurrentGraph.TIMEFRAME.ts;
        App.CurrentGraph.loadMarketProfile();
    }
    
    // переопределяет кол-во единиц цены в одном пикселе
    , setPricePerPx: function() {
        var pricePerPx = Math.pow(this.POWER_OF_GRAPH_Y, -this.ZOOM_Y) * this.FIXED_PRICE_PER_PX;
        this.PRICE_PER_PX = pricePerPx;
    }

    // переопределяет значение координаты оси ОХ в правом нижнем углу графика
    , setStartPointOnNull: function () {
        var right_indent = (App.CurrentPlatform === 'PC') ? this.RIGHT_INDENT : this.RIGHT_INDENT_MOBILE;
        this.START_POINT_ON_NULL = this.START_OX_POINT - (this.WIDTH - right_indent) * this.OX_SCALE;
    }
    
    // переопределяет масштаб оси ОХ
    , setOxScale: function() {
        var oxScale = Math.pow(this.POWER_OF_GRAPH, -this.ZOOM_X) * this.FIXED_OX_SCALE;
        this.OX_SCALE = (!App.CurrentGraph.IsZoomBorderCrossing) ? oxScale : 4 * oxScale;
    }
    
    // переопределяет шаг отрисовки тиков цены 
    , setPriceTickStep: function(){
        this.ROUNDING = App.CurrentGraph.ROUNDING;
        this.PRICE_PER_PX = App.CurrentGraph.PRICE_PER_PX;
        this.FIXED_PRICE_PER_PX = this.PRICE_PER_PX;
        this.PRICE_TICK_STEP = App.CurrentGraph.PRICE_STEP;
    }
    
    // возвращает переданное число в переданную степень
    , pow: function(x, n) {
        if(n === 0) return 1;
        if(n != 1) {
            return x * this.pow(x, n - 1);
        } 
        else {
            return x;
        }
    }
    
    // переопределяет шаг приращения к координатам по оси ОУ
    , setPriceStep: function() {
        this.PRICE_STEP = Math.round(this.PRICE_POINTS * this.PRICE_TICK_STEP / this.PRICE_PER_PX);
    }
    
    // переопределяет шаг приращения к координатам по оси ОХ
    , setTimeStep: function() {
        var val = this.FIXED_TIME_STEP/ this.OX_SCALE,
            grade = this.GRADE;
        this.TIME_STEP = val * grade;
    }
    
    // переопределяет масштаб оси ОХ
    , setOxMs: function () {
        var right_indent = (App.CurrentPlatform === 'PC') ? this.RIGHT_INDENT : this.RIGHT_INDENT_MOBILE;
        this.OX_MS = (this.WIDTH - right_indent) * this.OX_SCALE;
    }
    
    // переопределяет значение координаты оси ОХ в левом нижнем углу графика
    , setStartPrice: function() {
        var bottom_indent = (App.CurrentPlatform === 'PC') ? this.BOTTOM_INDENT : this.BOTTOM_INDENT_MOBILE;
        this.START_PRICE = this.round(this.MIDDLE_PRICE  - ((this.HEIGHT - bottom_indent) / 2) * this.PRICE_PER_PX, this.ROUNDING);
    }
    
    // переопределяет текущий инструмент
    , setInstrument: function() {
        this.INSTRUMENT = App.CurrentGraph.INSTRUMENT;
        
        App.CurrentGraph.loadMarketProfile();
    }
    
    // переопрделяет текущую дельту
    , setDelta: function() {
        this.DELTA = App.CurrentGraph.DELTA;
        App.CurrentGraph.loadMarketProfile();
    }
    
    // переопределяет свойства индикаторов
    , setIndicatorsProper: function(indicators) {
        this.INDICATORS_INDENT = 0;
        var workSpace;
        for(var i = 0; i < indicators.length; i++){
            workSpace = indicators[i].getWorkspace();
            this.INDICATORS_INDENT += workSpace.height;
        }
        this.FIXED_INDICATORS_INDENT = this.INDICATORS_INDENT;
    }
    
    // возвращает метку времени свечи по переданному индексу
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
    
    // возвращает индек свечи находящейся по координате правого нижнего угла графика
    , getCandleIndex: function(){
        return Math.ceil(this.START_POINT_ON_NULL/ this.FIXED_TIME_STEP);
    }
    
    // возвращает координату нужного спрайта 
    , findeSpriteCord: function(sprite, e) {
        if(App.CurrentPlatform !== 'PC'){
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
                x: (App.CurrentPlatform === 'PC') ? App.CurrentGraph.cordX : App.CurrentGraph.CursorPositionX,
                y: (App.CurrentPlatform === 'PC') ? this.realY(App.CurrentGraph.cordY) : this.realY(App.CurrentGraph.CursorPositionY)
            }
            correct = {
                x:  Math.ceil(this.TIME_STEP / this.GRADE / 4),
                y:  Math.ceil(this.PRICE_STEP / 10)
            }
        }
        else if(sprite.type === 'VerticalLine'){
            cord = Math.ceil(this.getXCordForPx(sprite.x));
            cursor_cord = (App.CurrentPlatform === 'PC') ? App.CurrentGraph.cordX : App.CurrentGraph.CursorPositionX;
            correct = Math.ceil(this.TIME_STEP / this.GRADE / 4);
        }
        else if(sprite.type === 'HorizontalLine'){
            cord = Math.ceil(this.getYCordForPrice(sprite.y));
            cursor_cord = (App.CurrentPlatform === 'PC') ? this.realY(App.CurrentGraph.cordY) : this.realY(App.CurrentGraph.CursorPositionY);
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