var OrderTape = function () {
    this.INSTRUMENT = null;
};

OrderTape.prototype = new Delta('ordertape');

OrderTape.prototype.type = App.GraphType.ORDER;

OrderTape.prototype.setInstrument = function (instrument) {
    this.INSTRUMENT = instrument.name;
    this.PRICE_STEP = instrument.step;
    this.NORMAL_PRICE_STEP = instrument.step;
    this.PRICE_PER_PX = instrument.pricePerPx;
    this.ROUNDING = instrument.rounding;
};

OrderTape.prototype.getSprites = function(f, id){
   var gs = this.GraphSettings;
    if(!Graph.requestInProcess){
        Graph.requestInProcess = true;
            
        if (App.CurrentGraph.CurType === 'ordertape'){
            Data.getCandlesForInterval({
                id: id,
                instrument: App.CurrentGraph.INSTRUMENT, 
                f: f
            });
        }
            
            
    }
    if(this.XDashLineSprite !== undefined){
        this.XDashLineSprite.renderIfVisible();
        this.YDashLineSprite.renderIfVisible();
    }
}

var CandleSpriteOrderTape = function (Candle) {
    this.Candle = Candle; //свеча (объект)
};

CandleSpriteOrderTape.prototype = {
    constructor: CandleSpriteOrderTape
    , isVisible: function () {
        var gs = App.CurrentGraph.GraphSettings,
            id = gs.getCurrentId(this.Candle.id),
            startPointOfCandle = gs.getXCordForPx(id * gs.FIXED_TIME_STEP / 5);
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            price_step = gs.PRICE_STEP / 10;
        var startPricePointOfGraph = gs.START_PRICE, 
            widthOfGraph = gs.WIDTH - right_indent,
            stepOfCandle = gs.TIME_STEP / 5, 
            price_per_px = gs.PRICE_PER_PX,
            maxPrice = gs.getYCordForPrice(this.Candle.maxPrice), 
            minPrices = gs.getYCordForPrice(this.Candle.minPrice),
            _h = gs.PRICE_TICK_STEP / price_per_px,
            x_visible  = (startPointOfCandle + stepOfCandle >= 0 && startPointOfCandle <= widthOfGraph),
            y_visible = (maxPrice <= gs.getYCordForPrice(startPricePointOfGraph) && minPrices >= 0);
        if(x_visible && y_visible) {
            if(!this.Candle.finished){
                gs.lastCandleVisible = true;
            }
            else {
                gs.lastCandleVisible = false; 
            }
        }
        return x_visible && y_visible;

    }

    , render: function () {
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            green = App.CurrentGraph.visualSettings.DIR_PLUS,                 
            red = App.CurrentGraph.visualSettings.DIR_MINUS,                  
            px = gs.PERFECT_PX,      
            maxPrice = gs.getYCordForPrice(this.Candle.maxPrice), 
            minPrice = gs.getYCordForPrice(this.Candle.minPrice),
            price_per_px = gs.PRICE_PER_PX,
            y_cord_shift = 0.8 * gs.PRICE_STEP / gs.PRICE_POINTS / 2,
            fixed_time_step = gs.FIXED_TIME_STEP,
            id = gs.getCurrentId(this.Candle.id),
            _width = Math.ceil(gs.TIME_STEP / 5) - 6 * px,
            _h = 0.8 * Math.ceil((gs.PRICE_TICK_STEP) / price_per_px) - 3*px,
            _x = gs.getXCordForPx(id * fixed_time_step / 5) + 3 * px;
        var _height = (maxPrice === minPrice) ? _h : minPrice - maxPrice + _h,
            _y = Math.ceil(maxPrice - 0.5 * _h) + px;
            
            
        if(!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)){    
            ctx.fillStyle = (this.Candle.direction !== 1) ? green : red;
            ctx.fillRect(_x, _y, _width, _height);
            ctx.lineWidth = gs.LINE_WIDTH;
            if (gs.ZOOM_Y > gs.MIN_Y_ZOOM * 0.6) {
                ctx.textAlign = 'center';
                ctx.textBaseline = 'bottom';
                ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_TEXT;
                ctx.font = (App.CurrentPlatform === 'PC') ? gs.TEXT_ORDER_FONT : gs.TEXT_ORDER_FONT_MOBILE;
                var y_text = _y + 2*y_cord_shift - 5 * px;//объем будет на позиции реальной цены
                ctx.fillText(this.Candle.volume, _x + 0.5 * _width, y_text, 0.8*_width);
            } 
        
        }
        else {
            _width /= 4;
            if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                _width /= 4;
            }
            _x = gs.getXCordForPx(id * fixed_time_step / 5) + 3 * px;
            /*_y = Math.ceil(gs.getYCordForPrice(this.Candle.maxPrice)) + px;
            _y -=  y_cord_shift;*/
            ctx.fillStyle = (this.Candle.direction !== 1) ? green : red;
            ctx.lineWidth = gs.LINE_WIDTH;
            ctx.fillRect(_x, _y, _width, _height);
            // ctx.strokeRect(_x, _y, _width, _height);
            if(!(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing)) {
                
                if (gs.ZOOM_Y > gs.MIN_Y_ZOOM * 0.6) {
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'bottom';
                    ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_TEXT;
                    ctx.font = (App.CurrentPlatform === 'PC') ? gs.TEXT_ORDER_FONT : gs.TEXT_ORDER_FONT_MOBILE;
                    var y_text = _y + 2*y_cord_shift - 5 * px;//объем будет на позиции реальной цены
                    ctx.fillText(this.Candle.volume, _x + 0.5 * _width, y_text, 0.7*_width);
                }
            }
        }
    }

    , renderIfVisible: function () {
        if (this.isVisible()) {
            this.render();
        }
    }
    
    , isTimeVisible: function() {
        var gs = App.CurrentGraph.GraphSettings,
            id = gs.getCurrentId(this.Candle.id);
        var startPointOfCandle = gs.getXCordForPx(id * gs.FIXED_TIME_STEP / 5);
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        var startTimePointOfGraph = gs.START_POINT_ON_NULL, // значение времени в левом нижнем углу
            startPricePointOfGraph = gs.START_PRICE, //значение цены в правом нинем углу
            widthOfGraph = gs.WIDTH - right_indent, //ширина графика
            heightOfGraph = gs.HEIGHT - bottom_indent, //высота графика
            stepOfCandle = gs.TIME_STEP;
            x_visible  = (startPointOfCandle + stepOfCandle >= 0 && startPointOfCandle + stepOfCandle/2 <= widthOfGraph); //провяет, находится ли свеча в поле зрения( по оси ох);
        return x_visible;
        
    }
    
    , timeRender: function() {
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            time_step = gs.TIME_STEP / 5,
            fixed_time_step = gs.FIXED_TIME_STEP / 5,
            id = gs.getCurrentId(this.Candle.id),
            _x = Math.ceil(gs.getXCordForPx(id * fixed_time_step) + 0.5 * time_step) + px,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE
            delta_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE,
            _y = gs.HEIGHT - 0.5 * bottom_indent + 2,
            centerY = gs.realY(0) + px + delta_indent - bottom_indent,
            cord_of_mark_Y = gs.realY(-gs.HATCH_LENGHT) + delta_indent - bottom_indent;
            
            ctx.font = (App.CurrentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;              
            // ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_TEXT;
            ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_PRICE_TEXT; 
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
                
            if(!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)){ 
                if(id % 4 === 0){
                    ctx.fillText(gs.tsToTime(this.Candle.secs*1000), _x, _y, 1.8 * time_step);
                    ctx.lineWidth = gs.LINE_WIDTH;
                    ctx.strokeStyle = '#000000';
                    
                    ctx.beginPath();
                    ctx.moveTo(_x, centerY);
                    ctx.lineTo(_x, cord_of_mark_Y);
                    ctx.stroke();
                }
            }
            else if(App.CurrentGraph.IsZoomBorderCrossing && gs.IS_TIME_ZOOM_BORDER)
            {
                if(id % 64 === 0){
                    ctx.fillText(gs.tsToTime(this.Candle.secs*1000), _x - 0.5 * time_step, _y, 2*time_step);
                    ctx.lineWidth = gs.LINE_WIDTH;
                    ctx.strokeStyle = '#000000';
                    
                    ctx.beginPath();
                    ctx.moveTo(Math.ceil(_x - 0.5 * time_step) + px, centerY);
                    ctx.lineTo(Math.ceil(_x - 0.5 * time_step) + px, cord_of_mark_Y);
                    ctx.stroke();
                }
            }
            else if(id % 28 === 0){
                ctx.fillText(gs.tsToTime(this.Candle.secs * 1000), _x - 0.5 * time_step, _y, 2*time_step);
                ctx.lineWidth = gs.LINE_WIDTH;
                ctx.strokeStyle = '#000000';
                
                ctx.beginPath();
                ctx.moveTo(Math.ceil(_x - 0.5 * time_step) + px, centerY);
                ctx.lineTo(Math.ceil(_x - 0.5 * time_step) + px, cord_of_mark_Y);
                ctx.stroke();
            }
    }
    
    , timeRenderIfVisible: function(){
        if(this.isTimeVisible()){
            this.timeRender();
        }
    }
};