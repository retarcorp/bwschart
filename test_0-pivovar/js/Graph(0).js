var Graph = function () {
};

Graph.prototype = {
    
    flag: true,

    constructor: Graph,
    
    graphType: 'footprint',

    GraphSettings: null,

    Canvas: null, // DOM Element Canvas

    tmpCanvas: null,

    Ctx: null, //Ctx

    tmpCtx: null,

    imgData: null,

    Type: null, //тип события для обработки перемещения графика

    mouseFlag: false,

    cursorPositionX: 0,

    cursorPositionY: 0,
    
    cursorPositionXforFirstTouch: 0,
    
    cursorPositionYforFirstTouch: 0,
    
    cursorPositionXforSecTouch: 0,
    
    cursorPosirionYforSecTouch: 0,   
    
    requestInProcess: false, //флаг состояния отправки запроса
    
    flagForStartPrice: true, //флаг состояния для коректировки начальной цены
    
    spritesEdditor: false, //флаг состояния едитора спрайтов
    
    appFirstStartedFlag: true,// флаг первого запуска
    
    xCordCursorLine: 0, //координата по иксу курсора мыши
    
    yCordCursorLine: 0, //координата по игреку курсора мыши
    
    xDashLineSprite: null,//координата по иксу для пунктирной вертикальной линии
    
    yDashLineSprite: null,//координата по игреку для пунктирной горизонтальной линии
    
    priceFootnoteSprite: null, //спрайт индикатора цены
    
    timeFootnoteSprite: null,//спрайт индикатора времени
    
    sprites: [], //массив спрайтов
    
    touch: false,
    
    IsZoomBorderCrossing: false,
    
    IsStartValueNotReceiced: true,
    
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
    
    visualSettings: null,
    
    init: function (canvas, callback) {
        this.flagForStartPrice = true;
        this.GraphSettings = new FootprintGraphSettings(
            // /*zoom*/                       20,
            // /*speed_of_moving_graph*/      3,
            /*price_per_px*/               0.000002,
            /*price_points*/               5,
            /*min_px_per_detailed_candle*/ 60
                                           
        );
        this.visualSettings = new VisualSettings();
        this.Canvas = canvas;
        this.Ctx = this.Canvas.getContext("2d");
        this.tmpCanvas = document.createElement('canvas');
        this.tmpCtx = this.tmpCanvas.getContext('2d');
        this.getDimensions();
        // this.GraphSettings.START_TS = Date.now() + this.GraphSettings.TIMEFRAME_TS  - 7200000;
        if(this.appFirstStartedFlag){
            this.createMainSprite();
        }
        this.tmpCtx.save();
        this.recursiveRender();
        callback();
    },
    
    createHorizontalLine: function(e) {
        var gs = this.GraphSettings;
        var newSprite = new HorizontalLineSprite();
        if(e.type === "mousedown"  && App.currentPlatform === 'PC'){
            
            
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
        if(e.type === "mousedown"  && App.currentPlatform === 'PC'){
            newSprite.x = (!App.CurrentGraph.IsZoomBorderCrossing) ? this.cordForVerticalLine : this.cordForVerticalLine + 0.5 * gs.TIMEFRAME_TS;
            this.sprites.push(newSprite);
            this.spritesEdditor = false;
            Ui.addHelpBar('', false);
        }
        else if(e.type === "touchstart"){
            if(this.touch === true){  
                this.recountCord(e);
                newSprite.x = (!App.CurrentGraph.IsZoomBorderCrossing) ? this.cordForVerticalLine : this.cordForVerticalLine + 0.5 * gs.TIMEFRAME_TS;
                this.sprites.push(newSprite);
                this.spritesEdditor = false;
                Ui.addHelpBar('', false);
                this.touch = false;
            }
        }
    },
    
    recountCord: function(e){
        var gs = this.GraphSettings;
        this.cursorPositionX = (e.touches[0].clientX - 40) / gs.TOTAL_ZOOM;
        this.cursorPositionY = gs.realY(e.touches[0].clientY / gs.TOTAL_ZOOM);
        this.onMoveForCursor(e);
    },
    
    createRectangle: function() {
        var gs = this.GraphSettings;
        var timeframe = gs.TIMEFRAME_TS;
        var newSprite = new RectangleSprite();
        newSprite.f_x = (!App.CurrentGraph.IsZoomBorderCrossing) ? this.cordForRectangleSprite.first_x : this.cordForRectangleSprite.first_x + 0.5 * timeframe;
        newSprite.f_y = this.cordForRectangleSprite.first_y;
        newSprite.s_x = (!App.CurrentGraph.IsZoomBorderCrossing) ? this.cordForRectangleSprite.second_x : this.cordForRectangleSprite.second_x + 0.5 * timeframe;
        newSprite.s_y =this.cordForRectangleSprite.second_y;
        this.sprites.push(newSprite);
        Ui.addHelpBar('', false);
        // console.log(newSprite);
    },
    
    createMainSprite: function() {
        this.appFirstStartedFlag = false;
        this.xDashLineSprite = new XDashLineSprite();
        this.yDashLineSprite = new YDashLineSprite();
        this.priceFootnoteSprite = new PriceFootnoteSprite();
        this.timeFootnoteSprite = new TimeFootnoteSprite();
    },
    
    removeAllSprites: function() {
        this.spritesEdditor = false;
        this.sprites = [];
    },
    
    createSprite: function(e){
        if(this.spritesEdditor){
            // console.log("СОЗДАНИЕ СПРАЙТА");//this.currentSprite)
            switch(this.currentSprite){
                case 'horizontal-line': this.createHorizontalLine(e); break;
                case 'vertical-line': this.createVerticalLine(e); break;
                case 'rectangle': this.rectangleEdditor = true; this.rectangleEdditorMobile = true; break;
                // case 'move': console.log(this.currentSprite); break;
                case 'remove': this.findSprite(e); break;
            }
        }
    },
    
    findSprite: function(e) {
        if(this.sprites !== undefined){
            for(var i = this.sprites.length - 1; i >= 0; i--){
                
                if(this.GraphSettings.findSpriteCord(this.sprites[i], e))
                {
                    this.sprites.splice(i, 1);
                    break;
                }
            }
        }
        this.spritesEdditor = false;
        Ui.addHelpBar('', false);
    },
    
    // @TODO must return TRUE if last candle is now visible on graph
    isLastCandleVisible: function(){
        // console.log('isLastCndlVis', this.GraphSettings.lastCandleVisible);
        return this.GraphSettings.lastCandleVisible;
    },
    
    //flag, чтобы если мы запросили свечи, которых не хватает, но последняя при этом не видна, чтобы они отрисовались
    recursiveRender: function(flag){
        // console.log('recursiveRender');
        var t = this;
        this.render(function(flag){
            if(flag || t.isLastCandleVisible()){
                t.recursiveRender();
            }
        })  
    },

    getDimensions: function () {
        //console.log('getDim');
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
        gs.setOxMs(); 
        gs.setTimeFrame();
        gs.zoomRecount();
        if(this.flagForStartPrice){
            gs.setPriceTickStep();
        }
        
    },

    onResize: function () {
        this.getDimensions();
        this.recursiveRender(true);
    },

    render: function (f) {
        // console.log(Graph.requestInProcess)
        // console.log(Data.Cache.Candles)
        // console.log('render');
        var gs = this.GraphSettings;
        gs.recount();
        this.resetCanvas();
        // Если видимый участок полностью есть в кэше (без последней свечи), рисуем данные из кэша синхронно
        // И НЕ вызываем buildData
        // Если видимый участок не полностью кэширован, то отрисовать то, что есть в кэше и вызвать buildData, 
        // который получит данные и перерисует полностью все (перерисовывать не нужно, нужно запросом создать свечи и сохранить их в кеш)

        if(!gs.lastCandleVisible && Data.Cache.containsInterval(gs.START_TS_ON_NULL, gs.OX_MS)){
            //синхронная отрисовка
            // console.log('sync');
            // console.log(gs.lastCandleVisible, Data.Cache.containsInterval(gs.START_TS_ON_NULL, gs.OX_MS));
            this.buildData(f, Data.Cache.get(gs.START_TS_ON_NULL, gs.OX_MS), true); 
        }else{
            //запрос на сервер всего отрезка/только последней свечи
            // console.log('async');
            this.buildData(f, Data.Cache.get(gs.START_TS_ON_NULL, gs.OX_MS), false);  
        }
    },

    resetCanvas: function () { //заливка холста
        //console.log('resetCanvas');
        this.tmpCtx.fillStyle = this.visualSettings.DIR_BG;
        this.tmpCtx.fillRect(0, 0, this.GraphSettings.WIDTH, this.GraphSettings.HEIGHT);
        this.drawGrid();//отрисовка сетки
    },
    
    drawMainGraph: function() {
        this.fillRect();//заливка пустых пространст под и слева от графика
        this.drawAxes();//отрисовка осей
        this.drawGridMarks();//отрисовка меток на координатных осях
        this.xDashLineSprite.renderIfVisible();
        this.yDashLineSprite.renderIfVisible();
        this.priceFootnoteSprite.renderIfVisible();
        this.timeFootnoteSprite.renderIfVisible();
        this.transferImgData();
    },

    fillRect: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        ctx.fillStyle = "#ffffff";
        ctx.fillRect(0, gs.HEIGHT - bottom_indent, gs.WIDTH, bottom_indent);//заливка нижнего пространства
        ctx.fillRect(gs.WIDTH - right_indent, 0, right_indent, gs.HEIGHT);//заливка правого пространства
    },

    buildData: function (f, candles, isFullIntervalInCache) {
        //console.log('buildData');
        var gs = App.CurrentGraph.GraphSettings;
        
        if(App.CurrentGraph.IsStartValueNotReceiced){
            App.CurrentGraph.IsStartValueNotReceiced = false;
            Graph.requestInProcess = true;
            Data.getStartValue(App.CurrentGraph.INSTRUMENT, f);
        }
        else if(this.flagForStartPrice) {
            // Graph.requestInProcess = false;
            //console.log("Время последней свечи: " + new Date(Data.LastValue.date))
            gs.MIDDLE_PRICE = Data.LastValue.price;
            gs.START_TS = 1 * Data.LastValue.date + 3 * gs.TIMEFRAME_TS;
            // console.log(App.CurrentGraph.TIMEFRAME )
            this.flagForStartPrice = false;
            gs.setStartPrice();
            gs.setStartTsOnNull();
        }
        /*
        if(this.flagForStartPrice && candles.length !== 0){
            // console.log(this.flagForStartPrice, 2)
            var middle_price = 0;
            for(var i = candles.length - 1; i >= 0; i--){
                if(candles[i].start_price !== 0){
                    middle_price = candles[i].start_price;
                    break;
                }
            }
            gs.MIDDLE_PRICE = (middle_price === 0) ? Data.LocalStorage.get('start_price' + App.CurrentGraph.INSTRUMENT) : middle_price;
                //сделать чтобы принимал аргумент или чтобы было понятно, что вызывается только один раз
            // gs.MIDDLE_PRICE = (candles[candles.length - 1].start_price !== 0) ? candles[candles.length - 1].start_price : Data.LocalStorage.get('start_price' + App.CurrentGraph.INSTRUMENT) ;
            this.flagForStartPrice = false;
            gs.setStartPrice();
            
        } 
        */
        
        if(isFullIntervalInCache){
            // console.log('without http');
            this.buildSprites(candles);
        }else{
            if(candles.length!==0){
                this.buildSprites(candles);
            }
            // console.log('with http');
            App.CurrentGraph.getSprites(f);
        }
        this.drawMainGraph();
    },

    //просто создание спрайтов и отрисовка
    buildSprites: function (candles) {
        // console.log('buildSprites');
        // console.log(candles);
        var t = this;
        var sprites = candles.map(function(candle){
            return new CandleSprite(candle);
        });
        
        if(this.sprites != undefined){
            this.sprites.forEach(function(elem){
                sprites.push(elem);
            });
        }
        
        sprites.forEach(function(candle){
            candle.renderIfVisible();
        });
    },

    drawAxes: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
            
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var centerX = gs.WIDTH - right_indent;
        var centerY = gs.realY(0);
        var px = gs.PERFECT_PX;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;

        ctx.strokeStyle = '#000000';
        ctx.lineWidth = gs.LINE_WIDTH;
        ctx.beginPath();
        ctx.moveTo(px, gs.HEIGHT - bottom_indent + px); //левый нижний угол
        ctx.lineTo(centerX + px, centerY + px); //центр
        ctx.lineTo(gs.WIDTH - right_indent + px, px); //правый верхний угол
        ctx.stroke();
    },

    //отрисовка сетки на графике
    drawGrid: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        ctx.strokeStyle = this.visualSettings.DIR_GRID;
        ctx.lineWidth = gs.LINE_WIDTH;
        this.drawXGrid();
        this.drawYGrid();
    },

    //отрисовка вертикальных линий
    drawXGrid: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        //console.log('drawGrid');
        var px = gs.PERFECT_PX,
            pixelsPerGridMark = gs.TIME_STEP,
            smallIntervalPixelsWidth = gs.calculateIndentOnX(),
            currentW = smallIntervalPixelsWidth,
            centerY = gs.realY(0);
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
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var px = gs.PERFECT_PX,
            pixelsPerGridMark = gs.PRICE_STEP, // Pixels in one vertical mark on Y grid
            smallIntervalPixelsHeight = gs.calculateIndentOnY(),
            currentH = bottom_indent + smallIntervalPixelsHeight,
            centerX = gs.WIDTH - right_indent + px;
            // console.log(pixelsPerGridMark);
        ctx.beginPath();
        while (currentH < gs.HEIGHT) {
            var yCord = gs.HEIGHT - Math.floor(currentH) + px;
            ctx.moveTo(centerX, yCord);
            ctx.lineTo(px, yCord);
            currentH += pixelsPerGridMark;
        }
        ctx.stroke();
    },

    // отрисовка меток на осях
    drawGridMarks: function () { //метки на кооржинатных осях
        this.drawYGridMarks();
        this.drawXGridMarks();
    },

    //отрисовка меток на оси ОХ
    drawXGridMarks: function () {
        //console.error(gs.tsToTime(gs.START_TS_ON_NULL))
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var px = gs.PERFECT_PX;
        var timePerPixel = gs.TIME_PER_PX;
        var pixelsPerGridMark = gs.TIME_STEP;
        var startTime = gs.START_TS_ON_NULL;

        var timeUnitsInGridMark = pixelsPerGridMark * timePerPixel;

        var firstGridMarkTime = (startTime % timeUnitsInGridMark) ?
            (startTime + timeUnitsInGridMark - startTime % timeUnitsInGridMark)
            : startTime + timeUnitsInGridMark;

        if (startTime < 0) {
            firstGridMarkTime -= timeUnitsInGridMark;
        }
        var smallIntervalPixelsWidth = gs.calculateIndentOnX();
        //console.warn(startTime);
        if (smallIntervalPixelsWidth)

        ctx.lineWidth = gs.LINE_WIDTH;
        ctx.fillStyle = '#000000';
        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';

        var currentW = smallIntervalPixelsWidth - pixelsPerGridMark / 2;
        var currentGridMarkTime = (!App.CurrentGraph.IsZoomBorderCrossing) ? firstGridMarkTime - gs.TIMEFRAME_TS : firstGridMarkTime - 2 * gs.TIMEFRAME_TS;
        var centerY = gs.realY(0) + px;
        var cord_of_mark_Y = gs.realY(-gs.HATCH_LENGHT);
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_TEXT_INDENT : gs.BOTTOM_TEXT_INDENT_MOBILE;//17.5 : 16;
        ctx.beginPath();
        while (currentW < gs.WIDTH - right_indent) {
            var xCord = Math.floor(currentW) + px;
            var yCord = gs.HEIGHT - bottom_indent + indent;
            ctx.moveTo(xCord, centerY);
            ctx.lineTo(xCord, cord_of_mark_Y);
            //ctx.fillStyle = gs.visualSettings.DIR_TEXT;
            if(gs.TIMEFRAME === 'D1'){
                ctx.fillText(gs.tsToData(currentGridMarkTime), xCord, yCord, 0.75 * pixelsPerGridMark);
            }
            else {
                ctx.fillText(gs.tsToTime(currentGridMarkTime), xCord, yCord/* + 16*/, 0.75 * pixelsPerGridMark);
            }
            currentW += pixelsPerGridMark;
            currentGridMarkTime += timeUnitsInGridMark;
        }
        ctx.stroke();
    },

    //отрисовка меток на оси ОУ
    drawYGridMarks: function () {
        var ctx = this.tmpCtx,
            gs = this.GraphSettings;
        var px = gs.PERFECT_PX,
            pricePerPixel = gs.PRICE_PER_PX, // How many PRICE units in 1 PIXEL currently
            pixelsPerGridMark = gs.PRICE_STEP, // Pixels in one vertical mark on Y grid
            startPrice = gs.START_PRICE; // Price units on zero point in corner of graph

        var priceUnitsInGridMark = pixelsPerGridMark * pricePerPixel;

        var firstGridMarkPrice = (startPrice % priceUnitsInGridMark ) ?
            (startPrice + priceUnitsInGridMark - startPrice % priceUnitsInGridMark)
            : startPrice + priceUnitsInGridMark; // Price on first grid mark visible on axe
        if (startPrice < 0) {
            firstGridMarkPrice -= priceUnitsInGridMark;
        }
        
        firstGridMarkPrice = firstGridMarkPrice;
        
        var smallIntervalPixelsHeight = gs.calculateIndentOnY();
        // console.log('gridMarks: ',smallIntervalPixelsHeight, gs.calculateIndentOnY());
        ctx.lineWidth = gs.LINE_WIDTH;
        ctx.fillStyle = '#000000';
        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var currentH = bottom_indent + smallIntervalPixelsHeight,
            currentGridMarkPrice = firstGridMarkPrice,
            centerX = gs.WIDTH - right_indent + px,
            cord_of_mark_X = gs.WIDTH - right_indent + gs.HATCH_LENGHT;
        ctx.beginPath();
        var indent = (App.currentPlatform === 'PC') ? gs.RIGHT_TEXT_INDENT : gs.RIGHT_TEXT_INDENT_MOBILE;
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
                val = -gs.TIME_STEP/2;//-gs.pxToTime(speed);
                this.onDragged(val, 'left');
                break;
            case up:
                val = gs.PRICE_STEP / gs.PRICE_POINTS;//gs.pxToPrice(speed);
                this.onDragged(val, 'up');
                break;
            case right:
                val = gs.TIME_STEP/2;//gs.pxToTime(speed);
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
        var zoom = gs.TOTAL_ZOOM;
        if(e.type === 'mousedown'  && App.currentPlatform === 'PC'){
            // console.log("MOUSEDOWN");
            var x = (e.clientX - 40) / zoom,
                y = e.clientY / zoom;
            if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent)) {
                if(this.rectangleEdditor){
                    this.cordForRectangleSprite.first_x = this.xDashLineSprite.x;
                    this.cordForRectangleSprite.first_y = this.yDashLineSprite.y;
                }
                else {
                    this.mouseFlag = true;
                    this.cursorPositionX = x;
                    this.cursorPositionY = gs.realY(y);
                    this.onMoveForCursor(e);
                }
            }
        }
        else if(e.type === 'touchstart'){
            var x = (e.touches[0].clientX - 40) / zoom,
                y = e.touches[0].clientY / zoom;
            // console.log("TOUCHSTART");
            if(e.touches.length === 1){
                console.log('touch.length = 1')
                if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent)) {
                    // console.log(this.rectangleEdditor, this.rectangleEdditorMobile)
                    if(this.rectangleEdditor && this.rectangleEdditorMobile){
                        // console.log("ПЕРВЫЙ КЛИК ПОШЕЛ")
                        // console.log()
                        this.recountCord(e);
                        
                        this.cordForRectangleSprite.first_x = this.xDashLineSprite.x;
                        this.cordForRectangleSprite.first_y = this.yDashLineSprite.y;
                        this.rectangleEdditorMobile = false;
                        App.clickForEvent = false;
                    }
                    else if(this.rectangleEdditor){
                        console.log("ВТОРОЙ КЛИК ПОШЕЛ")
                        
                        this.recountCord(e);
                        this.cordForRectangleSprite.second_x = this.xDashLineSprite.x;
                        this.cordForRectangleSprite.second_y = this.yDashLineSprite.y;
                        this.createRectangle();
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
                if ((x <= gs.WIDTH - right_indent) && (y <= gs.HEIGHT - bottom_indent) && (x1 <= gs.WIDTH - right_indent) && (y1 <= gs.HEIGHT - bottom_indent)) {
                    this.cursorPositionXforFirstTouch = x;
                    this.cursorPositionYforFirstTouch = gs.realY(y);
                    this.cursorPositionXforSecTouch = x1;
                    this.cursorPositionYforSecTouch = gs.realY(y1);
                }
            }
        }
    },

    //функция для обработчика событий при движении мыши
    onMove: function (e) {
        var gs = this.GraphSettings;
        var zoom = gs.TOTAL_ZOOM;
        var X = (e.clientX - 40) / zoom,
            Y = e.clientY / zoom;
        this.cordX = X;
        this.cordY = gs.realY(Y);
        var x = 0, y = 0, xS = 0, yS = 0, deltaX = 0, deltaY = 0;
        if(e.type === 'mousemove'){///////////////// Для мышки
            // console.log('mousemove')
            this.onMoveForCursor();
            if (this.mouseFlag) {
                x = X;//gs.realX(e.clientX - 50);
                y = gs.realY(Y);
                deltaX += (this.cursorPositionX - x) * gs.TIME_PER_PX;
                deltaY += (this.cursorPositionY - y) * gs.PRICE_PER_PX;
                //console.log(x, deltaX);
                this.onDragged(deltaX, deltaY);
                this.cursorPositionX = x;
                this.cursorPositionY = y;
            }
        }
        else if (e.type === 'touchmove') {/////////////////Для мобильных устройств
            var X = (e.touches[0].clientX - 40) / zoom,
                Y = e.touches[0].clientY / zoom;
            if(e.touches.length === 1){
                this.onMoveForCursor();
                if (this.mouseFlag) {
                    x = X;
                    y = gs.realY(Y);
                    this.cordX = x;
                    this.cordY = y;
                    deltaX += (this.cursorPositionX - x) * gs.TIME_PER_PX;
                    deltaY += (this.cursorPositionY - y) * gs.PRICE_PER_PX;
                    //console.log(x,y);
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

    //функция для обработчика событий при отпускании ЛКМ
    onUp: function (e) {
        var gs = this.GraphSettings;
        if(e.type === 'mouseup' && App.currentPlatform === 'PC'){
            if(this.rectangleEdditor){
                this.cordForRectangleSprite.second_x = this.xDashLineSprite.x;
                this.cordForRectangleSprite.second_y = this.yDashLineSprite.y;
                this.createRectangle();
                this.rectangleEdditor = false;
                this.spritesEdditor = false;
            } else {
                this.mouseFlag = false;
                this.cursorPositionX = (e.clientX - 40) / gs.TOTAL_ZOOM;//gs.realX(e.clientX - 50);
                this.cursorPositionY = gs.realY(e.clientY / gs.TOTAL_ZOOM);
            }
        }
        else if (e.type === 'touchend') {
            this.mouseFlag = false;
        }
    },
    
    onMoveForCursor: function(e){
        if(e === undefined){
            var gs = this.GraphSettings,
                cordX = this.cordX,//e.clientX - 40,
                cordY = this.cordY,//gs.realY(e.clientY),
                px = gs.PERFECT_PX;
        }
        else {
            var gs = this.GraphSettings,
                cordX = this.cursorPositionX,//e.clientX - 40,
                cordY = this.cursorPositionY,//gs.realY(e.clientY),
                px = gs.PERFECT_PX;
        }
        
        var priceStep = Math.floor(gs.PRICE_STEP / gs.PRICE_POINTS),
            smallIntervalOnY = gs.calculateIndentOnY() - 0.5 * priceStep;
            // console.log(gs.PRICE_STEP, gs.PRICE_POINTS, priceStep)

        var timeStep = (!App.CurrentGraph.IsZoomBorderCrossing) ? gs.TIME_STEP : gs.TIME_STEP/4,
            smallIntervalOnX = (!App.CurrentGraph.IsZoomBorderCrossing) ? gs.calculateIndentOnX() : gs.calculateIndentOnX() - 0.5 * timeStep, //gs.calculateIndentOnX() - 0.5 * timeStep,
            powX = Math.floor((cordX - smallIntervalOnX) / timeStep),
            minX = Math.floor(powX * timeStep + smallIntervalOnX),
            maxX = minX + timeStep;
        
        var powY = Math.floor((cordY - smallIntervalOnY) / priceStep);
        var minY = Math.floor(powY * priceStep + smallIntervalOnY),
            maxY = minY + priceStep;
            
        var _x = Math.floor(gs.pxToTime(minX + timeStep * 0.5) + gs.START_TS_ON_NULL);
        if(!this.mouseFlag || e !== undefined){
            if(cordX > minX && cordX < maxX){
                this.xDashLineSprite.x = _x;
                this.timeFootnoteSprite.x = _x;
                this.touch = true;
                if(this.spritesEdditor || this.touch){
                    this.cordForVerticalLine = _x;
                }
            }
            var _y = 1*((minY + 0.5 * priceStep) * gs.PRICE_PER_PX + gs.START_PRICE).toFixed(gs.ROUNDING);
            if(cordY > minY && cordY < maxY + 0.5 * priceStep){
                this.yDashLineSprite.y = _y;
                this.priceFootnoteSprite.y = _y;
                this.touch = true;
                if(this.spritesEdditor || this.touch){
                    this.cordForHorizontalLine = _y;
                }
            }
        }   
        this.recursiveRender();
    },
    
    onZoom: function (e) {
        var gs = this.GraphSettings;
        var plus = 107, //клавиша + на нумпаде
            plusS = 187, //клавиша =
            minus = 109, //клавиша - на нумпаде
            minusS = 189, //клавиша -
            key = (e.deltaY) ? e.type : e.keyCode,
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
                    ////console.log(e);
                    this.zoomOnWheel('in', cord);
                }
                else if (e.deltaY > 0) {
                    ////console.log(e);
                    this.zoomOnWheel('out', cord);
                }
                break;
        }
    },

    zoomOnWheel: function (flag, cord) {
        var gs = this.GraphSettings;
        //console.error(gs.ZOOM);
        if (flag === 'in') {
            this.zoomIn(1, cord);
        }
        else if (flag === 'out') {
            this.zoomOut(1, cord);
        }
    },

    zoomIn: function (power, cord) {
        power = (power === undefined) ? 1 : power;
        var gs = this.GraphSettings;
        //console.log("in_zoom");
        var max = 1, //максимальный зум
            TransformQuery = {};
        if (gs.TOTAL_ZOOM !== max) {
            var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
                W = gs.WIDTH - right_indent,
                H = gs.HEIGHT - bottom_indent;
            cord.W = W;
            cord.H = H;
            TransformQuery.zoom = (gs.TOTAL_ZOOM < max) ? (1 * (gs.TOTAL_ZOOM + 0.01 * power).toFixed(2)) : gs.TOTAL_ZOOM;
            TransformQuery.cord = cord;
            this.transform(TransformQuery);
        }
    },

    zoomOut: function (power, cord) {
        power = (power === undefined) ? 1 : power;
        //console.log("Out_zoom");
        var gs = this.GraphSettings;
        var min = 0.4,
            TransformQuery = {};
            //console.log(gs);
        if (gs.TOTAL_ZOOM !== min) {
            var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
                right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
                W = gs.WIDTH - right_indent,
                H = gs.HEIGHT - bottom_indent;
            cord.W = W;
            cord.H = H;
            TransformQuery.zoom = (gs.TOTAL_ZOOM > min) ? (1 * (gs.TOTAL_ZOOM - 0.01 * power).toFixed(2)) : gs.TOTAL_ZOOM;
            TransformQuery.cord = cord;
            this.transform(TransformQuery);
        }
    },
    
    transform: function (q) {
        var gs = this.GraphSettings;
        //console.log(q);
        if (q.transform_TS) {
            gs.START_TS += Math.floor(q.transform_TS);
            // this.xCordCursorLine -= Math.floor(q.transform_TS / this.GraphSettings.TIME_PER_PX);
            gs.setStartTsOnNull();
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
            var xShift = gs.pxToTime(powX * (W - fixedW)),
                yShift = gs.pxToPrice(powY * (H - fixedH));
            gs.START_TS += xShift;
            gs.START_PRICE -= yShift;
            gs.setStartTsOnNull();
        }
        this.recursiveRender();
    },

    transferImgData: function () {
        // this.imgData = ;
        this.Ctx.putImageData(this.tmpCtx.getImageData(0, 0, this.GraphSettings.WIDTH, this.GraphSettings.HEIGHT), 0, 0);
        //this.Ctx.strokeRect(135, 5, 50, 50);
    },

    //методы для обработки движения графика
    onDragged: function (x, y) {
        //создание объекта, хранящего параметры трансформации графика
        var TransformQuery = {};
        if (arguments.length === 2) {
            if (arguments[1] === 'left' || arguments[1] === 'right') {
                TransformQuery.transform_TS = x*this.GraphSettings.TIME_PER_PX;
            }
            else if (arguments[1] === 'up' || arguments[1] === 'down') {
                TransformQuery.transform_Price = x*this.GraphSettings.PRICE_PER_PX;
            }
            else {
                //console.log('x = ' + x, 'y = ' + y);
                TransformQuery.transform_TS = x;
                TransformQuery.transform_Price = y;
                TransformQuery.zoom = false;
            }
        }
        this.transform(TransformQuery);
    },
    
     // @Abstract
    getSprites: function (f) {
        var sprites = [];
        f(sprites);
    }
};

var FootPrintGraph = function () {
    this.TIMEFRAME = null;
    this.INSTRUMENT = null;
    this.TIMEFRAME_TS = null;
};

FootPrintGraph.prototype = new Graph();

FootPrintGraph.prototype.type = App.GraphType.FOOTPRINT;

FootPrintGraph.prototype.setTimeframe = function (timeframe) {
    this.TIMEFRAME = timeframe;
};

FootPrintGraph.prototype.setInstrument = function (instrument) {
    this.INSTRUMENT = instrument.name;
    this.PRICE_STEP = instrument.step;
    this.PRICE_PER_PX = instrument.pricePerPx;
    this.ROUNDING = instrument.rounding;
};

//мы должны запросить данные и сохранить их в кеш. Дальше вызывается f для рекурсивного рендеринга
FootPrintGraph.prototype.getSprites = function (f) {
    // console.log('getSprites'); 
    var gs = this.GraphSettings;
    if(!Graph.requestInProcess){
        // console.warn('start req');
        Graph.requestInProcess = true;
        // console.log(gs.START_TS_ON_NULL)
        Data.getCandlesForInterval({
            start_ts: gs.START_TS_ON_NULL,// + App.TimezoneOffset,// - 60*60*1000, 
            duration: gs.OX_MS, 
            timeframe: App.CurrentGraph.TIMEFRAME, 
            instrument: App.CurrentGraph.INSTRUMENT, 
            price_tick_step: gs.PRICE_TICK_STEP, 
            lastCandleVisible: gs.lastCandleVisible,
            f: f
        });
    }
    if(this.XDashLineSprite !== undefined){
        this.XDashLineSprite.renderIfVisible();
        this.YDashLineSprite.renderIfVisible();
    }
};

var Sprite = function () {
};

Sprite.prototype = {
    constructor: Sprite
    , isVisible: function (GraphSettings) {
    }
    , render: function (Ctx, GraphSettings) {
    }
    , renderIfVisible: function (Ctx, GraphSettings) {
    }
};


var CandleSprite = function (Candle) {
    this.Candle = Candle; //свеча (объект)
    this.WIDTH_OF_COLUMN = 17; //ширина колонки свечи
    this.positionOfFirstTick = 0; //позиция первого тика
    this.positionOfLastTick = 0; //позиция последнего тика
};

CandleSprite.prototype = {
    constructor: CandleSprite
    , isVisible: function () {
        var gs = App.CurrentGraph.GraphSettings;
        var startPointOfCandle = this.Candle.from, //метка времени свечи
            arrayOfTicks = this.Candle.getTicks(); //массив тиков свчеи
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        if(arrayOfTicks != undefined){
            var timePerPixel = gs.TIME_PER_PX,      //кол-во милисекунд в пикселе
                pricePerPixel = gs.PRICE_PER_PX, //кол-во данной валюты в пикселе
                startTimePointOfGraph = gs.START_TS_ON_NULL, // значение времени в левом нижнем углу
                startPricePointOfGraph = gs.START_PRICE, //значение цены в правом нинем углу
                widthOfGraph = startTimePointOfGraph + (gs.WIDTH - right_indent) * timePerPixel, //ширина графика
                heightOfGraph = gs.HEIGHT - bottom_indent, //высота графика
                oy_ms = heightOfGraph * pricePerPixel,
                stepOfCandle = gs.TIME_STEP * timePerPixel, //шаг отрисовки свеч
                firstTickPrice = gs.getYCordForPrice(arrayOfTicks[0].price), //начальная цена тика
                lastTickPrice = gs.getYCordForPrice(arrayOfTicks[arrayOfTicks.length - 1].price), //конечная цена тика
                x_visible  = (startPointOfCandle + stepOfCandle >= startTimePointOfGraph && startPointOfCandle <= widthOfGraph); //провяет, находится ли свеча в поле зрения( по оси ох);
               // y_visible = ();
            var y_visible = (firstTickPrice <= gs.getYCordForPrice(startPricePointOfGraph) && lastTickPrice >= 0); //проверяет, находитяс ли свеча в поле зрения ( по оси оу);
            if(x_visible && y_visible) {
                for(var i = 1; i < arrayOfTicks.length; i++){
                    this.positionOfFirstTick = (arrayOfTicks[i].price <= startPricePointOfGraph + oy_ms && arrayOfTicks[i-1].price >= startPricePointOfGraph + oy_ms) ? i : this.positionOfFirstTick;
                    this.positionOfLastTick = (arrayOfTicks[i].price > startPricePointOfGraph) ? i : this.positionOfLastTick;
                  }
                //   console.log(startPointOfCandle,this.positionOfFirstTick, this.positionOfLastTick);
                if(!this.Candle.finished){//проверяет, находится ли последняя свеча в поле зрения
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
        //console.log(ctx);
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings;
        var green = App.CurrentGraph.visualSettings.DIR_PLUS,              //зеленый цвет тика
            light_green = App.CurrentGraph.visualSettings.DIR_PLUS_LIGHT ,        //бледно-зеленый цвет тика
            red = App.CurrentGraph.visualSettings.DIR_MINUS,                //красный цвет тика
            light_red = App.CurrentGraph.visualSettings.DIR_MINUS_LIGHT,          //бледно-красный цвет тика
            px = gs.PERFECT_PX,             // == 0.5, смещает координаты на пол пикселя, что бы линия была четкая
            time_step = gs.TIME_STEP,       //шаг приращения по OX
            price_per_px = gs.PRICE_PER_PX; //цена в пиксель по OY
        
            //ОТРИСОВКА КОЛОНКИ
        var _x = Math.ceil(gs.getXCordForTS(this.Candle.from/*ВНИМАНИЕ*/)) + 7 * px, //координата верхнего левого угла колонки на ось ОХ
            _y = Math.ceil(gs.getYCordForPrice(this.Candle.start_price)) - px,  //координата верхнего левого угла колонки на ось ОУ
            _width = Math.ceil(this.WIDTH_OF_COLUMN),// * Math.pow(gs.POWER_OF_GRAPH, gs.ZOOM)), //ширина колонки
            _height = (this.Candle.start_price - this.Candle.last_price === 0) ? 1 :  Math.ceil((this.Candle.start_price - this.Candle.last_price) / price_per_px); //высота колонки
            // console.log(this.Candle)
        if(!App.CurrentGraph.IsZoomBorderCrossing){    
            ctx.fillStyle = (this.Candle.start_price <= this.Candle.last_price) ? green : red;
            ctx.fillRect(_x, _y, _width, _height);
            ctx.lineWidth = gs.LINE_WIDTH;
            ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_CANDLE_OUTLINE;
            ctx.strokeRect(_x, _y, _width, _height);
            //ОТРИСОВКА ТИКОВ
            var array_of_ticks = this.Candle.getTicks(),                //массив тиков
                width_of_ticks = Math.ceil(gs.TIME_STEP - _width) - 12, //максимальная ширина тика
                height_of_ticks = 0.8 * Math.ceil((gs.PRICE_TICK_STEP) / price_per_px); // высота тика
                //  console.log(array_of_ticks)
            if(array_of_ticks.length != 0){
                var firstPos = (this.positionOfFirstTick >= 1) ? this.positionOfFirstTick - 1 : 0;
                var lastPos = (this.positionOfLastTick <= array_of_ticks.length - 2) ? this.positionOfLastTick + 1 : this.positionOfLastTick;
                for(var i = firstPos; i <= lastPos; i++){
                    // console.log(this.positionOfFirstTick, this.positionOfLastTick)
                    var _x_ticks_cord = Math.ceil(_x + _width + 3) + px, //координата верхнего левого угла тика на ось ОХ
                        _y_ticks_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[i].price).toFixed(gs.ROUNDING))) - Math.floor(height_of_ticks / 2) + px,//координата верхнего левого угла тика на ось ОУ
                        _width_of_tick = Math.ceil(width_of_ticks * array_of_ticks[i].length), //ширина тика
                        _ticks_color = '',                       //цвет тика
                        _bid_x_cord = _x + time_step / 2 - 15,   //координата для текста кол-ва покупок по ОХ
                        _ask_x_cord = _bid_x_cord + 50,        //координата для текста кол-ва продаж по ОХ
                        _y_cord =  _y_ticks_cord + height_of_ticks / 2; //координата для текста покупок и прожад по ОУ
                    if(array_of_ticks[i].isMain){
                        _ticks_color = (array_of_ticks[i].dir === 1) ? red : green;
                    }
                    else {
                         _ticks_color = (array_of_ticks[i].dir === 1) ? light_red : light_green;
                         //console.log(_ticks_color)
                    }
                    
                    ctx.fillStyle = _ticks_color;
                    ctx.fillRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
                    ctx.lineWidth = gs.LINE_WIDTH;
                    ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_CANDLE_OUTLINE;//"#666666";
                    ctx.strokeRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
                    //console.log(array_of_ticks[i].ask,array_of_ticks[i].bid, _y_cord, array_of_ticks[i].price, i);
                    ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_TICK_FONT : gs.TEXT_TICK_FONT_MOBILE;
                    ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_TEXT;
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'middle';
                    ctx.fillText(array_of_ticks[i].bid, _bid_x_cord, _y_cord);
                    ctx.fillText(array_of_ticks[i].ask, _ask_x_cord, _y_cord);
                }
            }
        }
        else {
            var array_of_ticks = this.Candle.getTicks(), //массив тиков
                x_pos_collumn = Math.floor(_x - 24 * px /*+ 0.25 * (time_step - _width)*/) + px,//Math.floor(_x/* + time_step / 2*/ - _width / 2 - 7 * px) - px + 1, //координата х колонки
                x_pos = Math.floor(x_pos_collumn + _width / 2) + px, //координата х прямой тиков
                max_y_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[0].price).toFixed(gs.ROUNDING))),
                min_y_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[array_of_ticks.length - 1].price).toFixed(gs.ROUNDING)));
            ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_CANDLE_OUTLINE;
            ctx.lineWidth = gs.LINE_WIDTH;
            ctx.beginPath();
            ctx.moveTo(x_pos, max_y_cord);
            ctx.lineTo(x_pos, min_y_cord);
            ctx.stroke();
            ctx.lineWidth = gs.LINE_WIDTH;
            ctx.fillStyle = (this.Candle.start_price <= this.Candle.last_price) ? green : red;
            ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_CANDLE_OUTLINE;
            ctx.fillRect(x_pos_collumn, _y, _width, _height);
            ctx.strokeRect(x_pos_collumn, _y, _width, _height);
        }
    }

    , renderIfVisible: function () {
        if (this.isVisible()) {
            this.render();
        }
    }
};

var FootprintGraphSettings = function (/*zoom, speed_of_moving_graph, */price_per_px, price_points, min_px_per_detailed_candle) { 
    // this.ZOOM = zoom; 
    this.TOTAL_ZOOM = 1;
    // this.SPEED_OF_MOVING_GRAPH = speed_of_moving_graph; 
    this.WIDTH = 0; 
    this.HEIGHT = 0;
    this.FIXED_WIDTH = 0;
    this.FIXED_HEIGHT = 0;
    
    this.START_TS = 0; // метка времени справа
    this.START_TS_ON_NULL = 0; // метка времени слева
    this.TIME_PER_PX = 0; // сколько секунд в одном пикселе
    this.TIME_STEP = 0; // сколько пикселей в однгом делении
    this.FIXED_TIME_STEP = 0;
    this.FIXED_TIME_PER_PX = 0; // начальное количество секунд в пикселе
    this.PRE_FIXED_TIME_PER_PX = 0;
    this.OX_MS = 0; // количество секунд во всей оси
    
    this.START_PRICE = 0; // начальная цена
        this.START_PRICE_ON_NULL = 0; // начальная цена, которая не изменяется
    this.PRICE_PER_PX = price_per_px; // цена в одном пикселе
        this.FIXED_PRICE_PER_PX = price_per_px; // цена в одном тике, которая не изменяется 
    this.PRICE_STEP = 0; // кол-во пикселей в одном делении
    this.PRICE_POINTS = price_points; // количество тиков в шаге
    this.PRICE_TICK_STEP = 0; // шаг тика в пикселях
    this.MIDDLE_PRICE = 0; // для установки начального значения при первом открытии
        this.OY_PR = 0; // ! количество цены во всей оси
        
    
    
    this.MIN_PX_PER_DETEILED_CANDLE = min_px_per_detailed_candle; 
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
    this.TEXT_TICK_FONT = '12px Arial';
    this.TEXT_TICK_FONT_MOBILE = '11px Arial';
    this.PERFECT_PX = 0.5; //для резкоcти 
    this.INSTRUMENT = 0; 
    this.TIMEFRAME = 0; 
    this.TIMEFRAME_TS = 0; 
    this.POWER_OF_GRAPH = 1.03;
    this.lastCandleVisible = true;
    this.DELTA = 0;
    this.ROUNDING = 0;
    this.LINE_WIDTH = 1;
    this.HATCH_LENGHT = 8.5;
    
    this.RIGHT_TEXT_INDENT = 46.5;
    this.FIXED_RIGHT_TEXT_INDENT = 46.5;
    this.RIGHT_TEXT_INDENT_MOBILE = 40;
    this.FIXED_RIGHT_TEXT_INDENT_MOBILE = 40;
    
    this.BOTTOM_TEXT_INDENT = 17.5;
    this.FIXED_BOTTOM_TEXT_INDENT = 17.5;
    this.BOTTOM_TEXT_INDENT_MOBILE = 16;
    this.FIXED_BOTTOM_TEXT_INDENT_MOBILE = 16;
    
};

FootprintGraphSettings.prototype = {
    constructor: FootprintGraphSettings

    , getXCordForTS: function (n) {
        //console.log("getXCordForTS - ",n, this.START_TS_ON_NULL, this.TIME_PER_PX);
        return (n - this.START_TS_ON_NULL) / this.TIME_PER_PX;
    }

    , getYCordForPrice: function (n) {
        //console.log(n, this.START_PRICE,n - this.START_PRICE)
        var bottom_indent = (App.currentPlatform === 'PC') ? this.BOTTOM_INDENT : this.BOTTOM_INDENT_MOBILE;
        return Math.ceil(this.HEIGHT - bottom_indent - ((n - this.START_PRICE) / this.PRICE_PER_PX)) - this.PERFECT_PX;
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
        this.RIGHT_INDENT_MOBILE = this.FIXED_RIGHT_INDENT_MOBILE / zoom;
        this.BOTTOM_INDENT_MOBILE = this.FIXED_BOTTOM_INDENT_MOBILE / zoom;
        this.LINE_WIDTH = 1 * (1 / zoom).toFixed(1);
        this.TEXT_FONT = 14 / zoom + 'px Arial';
        this.TEXT_FONT_MOBILE = 12 / zoom + 'px Arial';
        this.HATCH_LENGHT = 8.5 / zoom;
        this.RIGHT_TEXT_INDENT = this.FIXED_RIGHT_TEXT_INDENT / zoom;
        this.RIGHT_TEXT_INDENT_MOBILE = this.FIXED_RIGHT_TEXT_INDENT_MOBILE / zoom;
        this.BOTTOM_TEXT_INDENT = this.FIXED_BOTTOM_TEXT_INDENT / zoom;
        this.BOTTOM_TEXT_INDENT_MOBILE = this.FIXED_BOTTOM_TEXT_INDENT_MOBILE / zoom;
    }

    , realY: function (y) {
        var bottom_indent = (App.currentPlatform === 'PC') ? this.BOTTOM_INDENT : this.BOTTOM_INDENT_MOBILE;
        return Math.ceil(this.HEIGHT - bottom_indent - y) - this.PERFECT_PX;
    }

    , calculateIndentOnX: function () {
        var timeUnitsInOneGridMark = this.TIME_PER_PX * this.TIME_STEP;
        var startTime = this.START_TS_ON_NULL;

        var timeUnitsInSmallInterval = (startTime >= 0) ? startTime % timeUnitsInOneGridMark : ( timeUnitsInOneGridMark + startTime % timeUnitsInOneGridMark);

        var smallIntervalTimeUnits = (timeUnitsInOneGridMark - (timeUnitsInSmallInterval));
        var smallIntervalPixels = smallIntervalTimeUnits / this.TIME_PER_PX;
        smallIntervalPixels = (smallIntervalPixels >= 0) ? smallIntervalPixels : (smallIntervalPixels + this.TIME_STEP);
        // console.log('timeinterval = ' + smallIntervalPixels)
        return Math.ceil(smallIntervalPixels);
    }

    // Returns size of small interval behind the first grid line in PIXELS
    , calculateIndentOnY: function () {

        var priceUnitsInOneGridMark = this.PRICE_PER_PX * this.PRICE_STEP;
        var startPrice = this.START_PRICE;

        var priceUnitsInSmallInterval = (startPrice >= 0 ) ? startPrice % priceUnitsInOneGridMark : ( priceUnitsInOneGridMark + startPrice % priceUnitsInOneGridMark);


        var smallIntervalPriceUnits = (priceUnitsInOneGridMark - (priceUnitsInSmallInterval) );
        var smallIntervalPixels = smallIntervalPriceUnits / this.PRICE_PER_PX;
        smallIntervalPixels = (smallIntervalPixels >= 0) ? smallIntervalPixels : (smallIntervalPixels + this.PRICE_STEP);
        return Math.floor(smallIntervalPixels);
    }

    , pxToTime: function (x) {
        return Math.ceil(x * this.TIME_PER_PX);
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
        var fullData = new Date(Math.floor(ts)),
            hours = fullData.getHours(),
            minutes = fullData.getMinutes(),
            seconds = fullData.getSeconds();

        if (hours < 10) hours = '0' + hours;
        if (minutes < 10) minutes = '0' + minutes;
        if (seconds < 10) seconds = '0' + seconds;

        return hours + ':' + minutes + ':' + seconds;
    }
    
    , recount: function() {
        //корректирует TIME_PER_PX (кол-во секунд в пикселе)
        this.setTimePerPX();
        //корректирует шаг отрисовки меток по оси ОХ
        this.setTimeStep();
        if(App.CurrentGraph.flagForStartPrice){
            this.setPriceTickStep();
        }
        //корректирует шаг отрисовки меток по оси OY
        this.setPriceStep();
        //устанавливает START_TS в краний правый угол
        this.setStartTsOnNull();
        //переопределяет длинну оси ОХ в секундах
        // console.log('START_PRICE = ' +this.START_PRICE)
        this.setOxMs();
    }

    , setStartTsOnNull: function () {
        //console.log('setStartTsOnNull');
        var right_indent = (App.currentPlatform === 'PC') ? this.RIGHT_INDENT : this.RIGHT_INDENT_MOBILE;
        this.START_TS_ON_NULL = this.START_TS - (this.WIDTH - right_indent) * this.TIME_PER_PX;
        //console.log(this.START_TS_ON_NULL);
    }
    , setTimePerPX: function() {
        this.TIME_PER_PX = (!App.CurrentGraph.IsZoomBorderCrossing) ? this.FIXED_TIME_PER_PX : 4 * this.FIXED_TIME_PER_PX;
    }
    
    , setTimeStep: function() {
        this.TIME_STEP = (!App.CurrentGraph.IsZoomBorderCrossing) ? this.TIMEFRAME_TS/ this.TIME_PER_PX : 4 * this.TIMEFRAME_TS/ this.TIME_PER_PX;
    }
    
    , setPriceTickStep: function(){
        this.ROUNDING = App.CurrentGraph.ROUNDING;
        this.PRICE_PER_PX = App.CurrentGraph.PRICE_PER_PX;
        this.PRICE_TICK_STEP = App.CurrentGraph.PRICE_STEP;
        // console.log(this.PRICE_TICK_STEP);
    }
    
    , setPriceStep: function() {
        this.PRICE_STEP = Math.round(this.PRICE_POINTS * this.PRICE_TICK_STEP / this.PRICE_PER_PX);
        // console.log('price_step = ' + this.PRICE_STEP);
    }
    
    , setOxMs: function () {
        var right_indent = (App.currentPlatform === 'PC') ? this.RIGHT_INDENT : this.RIGHT_INDENT_MOBILE;
        this.OX_MS = (this.WIDTH - right_indent) * this.TIME_PER_PX;
    }
    
    , setStartPrice: function() {
        var bottom_indent = (App.currentPlatform === 'PC') ? this.BOTTOM_INDENT : this.BOTTOM_INDENT_MOBILE;
        this.START_PRICE = 1*(this.MIDDLE_PRICE  - ((this.HEIGHT - bottom_indent) / 2) * this.PRICE_PER_PX).toFixed(this.ROUNDING);
        Data.LocalStorage.save('start_price' + App.CurrentGraph.INSTRUMENT, this.START_PRICE);
    }
    
    , setTimeFrame: function() {
        this.FIXED_TIME_PER_PX = App.CurrentGraph.TIMEFRAME.timePerPx;
        this.PRE_FIXED_TIME_PER_PX = this.FIXED_TIME_PER_PX;
        this.TIME_PER_PX = App.CurrentGraph.TIMEFRAME.timePerPx;
        this.setTimePerPX();
        this.TIMEFRAME = App.CurrentGraph.TIMEFRAME.val;
        this.TIMEFRAME_TS = App.CurrentGraph.TIMEFRAME.ts;
        // this.START_TS = Date.now() + this.TIMEFRAME_TS;
        //console.log(2, this.TIMEFRAME, this.TIMEFRAME_TS, this.TIME_PER_PX);
    }
    
    , setInstrument: function() {
        this.setPriceTickStep();
        this.INSTRUMENT = App.CurrentGraph.INSTRUMENT;
    }
    
    , findSpriteCord: function(sprite, e) {
        if(App.currentPlatform !== 'PC'){
            App.CurrentGraph.recountCord(e);
        }
        var cord = 0,
            cursor_cord = 0,
            correct = 0;
        if(sprite.type === 'Rectangle'){
            cord = {
                f_x: Math.ceil(this.getXCordForTS(sprite.f_x)),
                f_y: Math.ceil(this.getYCordForPrice(sprite.f_y)),
                s_x: Math.ceil(this.getXCordForTS(sprite.s_x)),
                s_y: Math.ceil(this.getYCordForPrice(sprite.s_y))
            }
            cursor_cord = {
                x: (App.currentPlatform === 'PC') ? App.CurrentGraph.cordX : App.CurrentGraph.cursorPositionX,
                y: (App.currentPlatform === 'PC') ? this.realY(App.CurrentGraph.cordY) : this.realY(App.CurrentGraph.cursorPositionY)
            }
            correct = {
                x:  Math.ceil(this.TIME_STEP / 4),
                y:  Math.ceil(this.PRICE_STEP / 10)
            }
        }
        else if(sprite.type === 'VerticalLine'){
            cord = Math.ceil(this.getXCordForTS(sprite.x));
            cursor_cord = (App.currentPlatform === 'PC') ? App.CurrentGraph.cordX : App.CurrentGraph.cursorPositionX;
            correct = Math.ceil(this.TIME_STEP / 4);
        }
        else if(sprite.type === 'HorizontalLine'){
            cord = Math.ceil(this.getYCordForPrice(sprite.y));
            cursor_cord = (App.currentPlatform === 'PC') ? this.realY(App.CurrentGraph.cordY) : this.realY(App.CurrentGraph.cursorPositionY);
            correct = Math.ceil(this.PRICE_STEP / 10);
        }
        // console.log(sprite.type, cord, this.realY(App.CurrentGraph.cordY));
        if(typeof cord !== 'object'){
            console.log(cord,cursor_cord,correct)
            var _return = (Math.abs(cord - cursor_cord) <= correct) ? true : false;
            return _return;
        }
        else {
            var width = (cord.s_x - cord.f_x) / 2,
                height = (cord.s_y - cord.f_y) / 2;
            var x_center_cord = cord.f_x + width,
                y_center_cord = cord.f_y + height;
            // var _return = (Math.abs(x_center_cord - cursor_cord.x) < (Math.abs(width) + correct.x) && Math.abs(y_center_cord - cursor_cord.y) < (Math.abs(height) + correct.y)) ? true : false;
            // return _return;
            return (Math.abs(x_center_cord - cursor_cord.x) < (Math.abs(width) + correct.x) && Math.abs(y_center_cord - cursor_cord.y) < (Math.abs(height) + correct.y));
        }
    }
};

var VisualSettings = function(){
    this.DIR_PLUS = this.defaultVisualSettings.DIR_PLUS;
    this.DIR_PLUS_LIGHT = this.defaultVisualSettings.DIR_PLUS_LIGHT;
    this.DIR_MINUS = this.defaultVisualSettings.DIR_MINUS;
    this.DIR_MINUS_LIGHT = this.defaultVisualSettings.DIR_MINUS_LIGHT;
    this.DIR_CANDLE_OUTLINE = this.defaultVisualSettings.DIR_CANDLE_OUTLINE;
    this.DIR_BG = this.defaultVisualSettings.DIR_BG;
    this.DIR_GRID = this.defaultVisualSettings.DIR_GRID;
    this.DIR_TEXT = this.defaultVisualSettings.DIR_TEXT;
    this.DIR_SPRITES = this.defaultVisualSettings.DIR_SPRITES;
};

VisualSettings.prototype = {
    constructor: VisualSettings,
    
    defaultVisualSettings: {
        DIR_PLUS: "#00FA43",
        DIR_PLUS_LIGHT: "#A8FFBF",
        DIR_MINUS: "#EF0629",
        DIR_MINUS_LIGHT: "#FF9EAC",
        DIR_CANDLE_OUTLINE: "#666666",
        DIR_BG: "#FFFFFF",
        DIR_GRID: "#e3e3e3",
        DIR_TEXT: "#000000",
        DIR_SPRITES: "#000000"
    },
    
    setVisualSettings: function(plus, minus, candle_outline, background, grid, text, sprites){
        //console.log('set');
        this.DIR_PLUS = plus;
        this.DIR_PLUS_LIGHT = /*this.RGBAToHex(*/this.hexToRGBA(plus)/*, 'p')*/;
        this.DIR_MINUS = minus;
        this.DIR_MINUS_LIGHT = /*this.RGBAToHex(*/this.hexToRGBA(minus)/*, 'm')*/;
        this.DIR_CANDLE_OUTLINE = candle_outline;
        this.DIR_BG = background;
        this.DIR_GRID = grid;
        this.DIR_TEXT = text;
        this.DIR_SPRITES = sprites;
    },
    
    hexToRGBA: function(color){
        var red = color.substring(1, 3);
        var green = color.substring(3, 5);
        var blue = color.substring(5);
        var opasity = 0.5;
        var rgba = 'rgba(' + parseInt(red, 16) + ', ' + parseInt(green, 16) + ', ' + parseInt(blue, 16) + ', ' + opasity + ')';
        //console.log(rgba);
        return rgba;
    },
    
    RGBAToHex: function(rgba, c){
        var parts = rgba.substring(rgba.indexOf("(")).split(","),
            r = parseInt(this.trim(parts[0].substring(1)), 10),
            g = parseInt(this.trim(parts[1]), 10),
            b = parseInt(this.trim(parts[2]), 10),
            a = parseFloat(this.trim(parts[3].substring(0, parts[3].length - 1))).toFixed(2);
        //console.log(r, g, b, a);
        //console.log(b.toString(16), (a*255).toString(16).substring(0,2))
        //console.log( ('#' + r.toString(16) + g.toString(16) + b.toString(16) + (a*255).toString(16).substring(0,2)));

        return ('#' + r.toString(16) + g.toString(16) + b.toString(16) + (a*255).toString(16).substring(0,2));
    },
    
    trim: function(str) {
        return str.replace(/^\s+|\s+$/gm,'');
    }
}