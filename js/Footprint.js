var FootPrintGraph = function () {
    this.TIMEFRAME = null;
    this.INSTRUMENT = null;
    this.TIMEFRAME_TS = null;
};

FootPrintGraph.prototype = new Delta('footprint');//new Graph();

FootPrintGraph.prototype.type = App.GraphType.FOOTPRINT;

FootPrintGraph.prototype.setTimeframe = function (timeframe) {
    this.TIMEFRAME = timeframe;
};

FootPrintGraph.prototype.setInstrument = function (instrument) {
    this.INSTRUMENT = instrument.name;
    this.PRICE_STEP = instrument.step;
    this.NORMAL_PRICE_STEP = instrument.step;
    this.PRICE_PER_PX = instrument.pricePerPx;
    this.ROUNDING = instrument.rounding;
};

//мы должны запросить данные и сохранить их в кеш. Дальше вызывается f для рекурсивного рендеринга
FootPrintGraph.prototype.getSprites = function (f, index) {
    var gs = this.GraphSettings;
    if(!Graph.requestInProcess){
        
        Graph.requestInProcess = true;
        Data.getCandlesForInterval({
            instrument: App.CurrentGraph.INSTRUMENT, 
            timeframe: App.CurrentGraph.TIMEFRAME, 
            candle_index: index,
            f: f
        });
    }
};

var CandleSprite = function (Candle) {
    this.Candle = Candle; //свеча (объект)
    this.WIDTH_OF_COLUMN = 17; //ширина колонки свечи
    this.positionOfFirstTick = 0; //позиция первого тика
    this.positionOfLastTick = 0; //позиция последнего тика
    this.correctHolidays = 0;
    this.type = "Candle";
};

CandleSprite.prototype = {
    constructor: CandleSprite
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
                heightOfGraph = gs.HEIGHT - bottom_indent, 
                grade = gs.GRADE,
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
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            vs = App.CurrentGraph.visualSettings;
            
        var candle_start_price = this.Candle.start_price,
            candle_last_price = this.Candle.last_price,
            rounding = gs.ROUNDING,
            green = vs.DIR_PLUS,             
            light_green = vs.DIR_PLUS_LIGHT,       
            red = vs.DIR_MINUS,                
            light_red = vs.DIR_MINUS_LIGHT, 
            gray = vs.DIR_0,
            candle_outline = vs.DIR_CANDLE_OUTLINE,
            px = gs.PERFECT_PX,             
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            line_width = gs.LINE_WIDTH,
            time_step = gs.TIME_STEP / grade,     
            fixed_time_step = gs.FIXED_TIME_STEP,
            index = this.Candle.index,
            price_tick_step = gs.PRICE_TICK_STEP,
            price_per_px = gs.PRICE_PER_PX, 
            y_cord_shift = 0.8 * gs.PRICE_STEP / gs.PRICE_POINTS / 2;
            
        var bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var delta_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        
        var _x = Math.ceil(gs.getXCordForPx(index * fixed_time_step)) + px,
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
            ctx.lineWidth = line_width;
            ctx.strokeStyle = candle_outline;
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
                    ctx.lineWidth = line_width;
                    ctx.strokeStyle = candle_outline;//"#666666";
                    ctx.strokeRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
                    
                    if (gs.ZOOM_Y > gs.MIN_Y_ZOOM * 0.6) {
                        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_TICK_FONT : gs.TEXT_TICK_FONT_MOBILE;
                        ctx.font = (array_of_ticks[i].isMain) ? 'bold ' + ctx.font : ctx.font; 
                        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_TEXT;
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'middle';
                        ctx.textAlign = 'right';
                        ctx.fillText(array_of_ticks[i].bid, _bid_x_cord, _y_cord, time_step / 2);
                        ctx.textAlign = 'left';
                        ctx.fillText(array_of_ticks[i].ask, _ask_x_cord, _y_cord, time_step / 2);
                    }
                }
            }
        }
        else {
            if(x_zoom_cur_grade <= gs.X_ZOOM_GRADE.TWO) _width *= 4;
            var array_of_ticks = this.Candle.getTicks(),
                x_pos_collumn = Math.ceil(_x - _width / 2) - px, 
                x_pos = Math.floor(x_pos_collumn + _width / 2) + px, 
                max_y_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[0].price).toFixed(rounding))),
                min_y_cord = Math.ceil(gs.getYCordForPrice((array_of_ticks[array_of_ticks.length - 1].price).toFixed(rounding))),
                __h = -(delta_indent - bottom_indent - px);
            ctx.strokeStyle = candle_outline;
            ctx.lineWidth = line_width;
            ctx.beginPath();
            ctx.moveTo(x_pos, max_y_cord);
            ctx.lineTo(x_pos, min_y_cord);
            ctx.stroke();
            ctx.lineWidth = line_width;;
            ctx.fillStyle = (candle_start_price <= candle_last_price) ? green : red;
            if (candle_start_price - candle_last_price === 0) ctx.fillStyle = gray;
            ctx.strokeStyle = candle_outline;
            ctx.fillRect(x_pos_collumn, _y, _width, _height);
            if(x_zoom_cur_grade <= gs.X_ZOOM_GRADE.ONE)  ctx.strokeRect(x_pos_collumn, _y, _width, _height);
        }
    }

    , renderIfVisible: function () {
        if (this.isVisible()) {
            this.render();
            return true;
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
                grade = gs.GRADE,
                widthOfGraph = gs.WIDTH - right_indent, 
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
            line_width = gs.LINE_WIDTH,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            x_zoom_grade = gs.X_ZOOM_GRADE,
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
        var text = (gs.TIMEFRAME === 'D1') ? gs.tsToData(this.Candle.from) : gs.tsToTime(this.Candle.from);
            
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
};