var Indicator = function(type, index) {
    this.IndicatorType = type;
    this.Index = index;
    this.yDashLineSprite = new YDashLineSprite(type, index);
    this.priceFootnoteSprite = new PriceFootnoteSprite(type, index);
};

Indicator.prototype = {
    
    IndicatorWorkspace: null,
    
    IndicatorType: null,
    
    CursorPositionX: 0,
    
    CursorPositionY: 0, 
    
    MaxTicksSum: 0,
    
    CandlesLength: 0,
    
    onGraphRender: function(candles, ctx, gs) {
        this.draw(candles, ctx, gs);
    },
    
    draw: function(candles, ctx, gs) {
        var t = this;
        this.drawWorkspace(ctx, gs);
        this.countMaxTicksSum(candles, gs);
        candles.forEach(function(candle){
            t.drawDataIsVisible(candle, ctx, gs);
        });
        this.drawMainWorkSpace(ctx, gs);
        // this.drawMarks(ctx, gs);
        this.yDashLineSprite.renderIfVisible();
        this.priceFootnoteSprite.renderIfVisible();
    },
    
    drawMarks: function(ctx, gs) {
        var px = gs.PERFECT_PX,
            h = 100,
            index = this.Index,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            zoom = gs.TOTAL_ZOOM,
            lineWidth = gs.FIXED_LINE_WIDTH,
            x = gs.WIDTH - right_indent,
            y = (3 + h * index) / zoom,
            hatch = gs.HATCH_LENGHT,
            step = 18 / zoom;
            
        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = "#000000";
        ctx.beginPath();
            while(y <= h * (index + 1) / zoom) {
                var cord = Math.ceil(gs.realY(y)) + px;
                ctx.moveTo(x, cord);
                ctx.lineTo(x + hatch, cord);
                y += Math.ceil(step);
            }
        ctx.stroke();
    },
    
    drawMainWorkSpace: function(ctx, gs) {
        var px = gs.PERFECT_PX,
            h = 100,
            index = this.Index,
            zoom = gs.TOTAL_ZOOM,
            lineWidth = gs.FIXED_LINE_WIDTH,
            rightIndent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            x = gs.WIDTH - rightIndent,
            // y = gs.realY((-51 + h * index) / zoom),
            // height = (-150 + h * index) / zoom,
            y = gs.realY((-px + h * index) / zoom),
            height = -h / zoom,
            lineW = gs.LINE_WIDTH,
            textFont = 9 / zoom + 'pt Arial',
            text_x = 5 / zoom,
            text_y = gs.realY((90 + h * index) / zoom),
            text = this.IndicatorType;
    
        
        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_TEXT;
        ctx.font = textFont;
        ctx.textAlign = "left";
        ctx.fillText(text, text_x, text_y);
        ctx.lineWidth = lineWidth;
        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_PRICE_FILL;
        ctx.fillRect(x, y + 10, rightIndent, height - 10);
        ctx.strokeStyle = "#000000";
        ctx.beginPath();
            ctx.moveTo(x + px, y)// - 50 / zoom);
            ctx.lineTo(x + px, y + height );
        ctx.stroke();
        
        var cros_x = x - 5 / zoom,
            cros_y = y + 5 / zoom + height;
            cros_w = -10 / zoom;
            cros_h = 10 / zoom,
            len = 10 / zoom;
        
        ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_CLOSE_BTN;
        ctx.strokeRect(cros_x, cros_y, cros_w, cros_h);
        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_FILL;
        ctx.fillRect(cros_x, cros_y, cros_w, cros_h);
        ctx.beginPath();
            ctx.moveTo(cros_x, cros_y);
            ctx.lineTo(cros_x - len, cros_y + len);
            ctx.moveTo(cros_x, cros_y + len);
            ctx.lineTo(cros_x - len, cros_y);
        ctx.stroke();
    },
    
    drawWorkspace: function(ctx, gs) {
        //отрисовывает на холсте рабочую зону
        var index = this.Index,
            h = 100,
            px = gs.PERFECT_PX,
            zoom = gs.TOTAL_ZOOM,
            lineWidth = gs.FIXED_LINE_WIDTH,
            x = 0,
            y = gs.realY((h * index - px) / zoom),
            rightIndent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH,
            height = -h / zoom,
            lineW = gs.LINE_WIDTH,
            textFont = gs.TEXT_FONT;
        
        //console.log(App.CurrentGraph.visualSettings.DIR_INDICATOR_FILL)
        
        ctx.lineWidth = lineWidth;
        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_FILL;
        ctx.fillRect(x, y, width, height);
        ctx.strokeStyle = "#000000";
        ctx.strokeRect(x, y, width - rightIndent, height);
    },
    
    drawDataDelta: function(candle, ctx, gs) {
        var graphType = App.CurrentGraph.type;
        var index = this.Index,
            h = 100,
            px = gs.PERFECT_PX,
            zoom = gs.TOTAL_ZOOM,
            x = 0,
            y = gs.realY((0.5 * h + h * index) / zoom),
            width = gs.TIME_STEP,
            fheight = 0.45 * h,
            height = 0 / zoom,
            visualSettings = App.CurrentGraph.visualSettings;
            dirP = visualSettings.DIR_PLUS,
            dirPL = visualSettings.DIR_PLUS_LIGHT,
            dirM = visualSettings.DIR_MINUS,
            dirML = visualSettings.DIR_MINUS_LIGHT,
            minDelta = fheight * candle.deltaShadow.min / this.MaxTicksSum / zoom,
            maxDelta = fheight * candle.deltaShadow.max / this.MaxTicksSum / zoom;
        
        var askSum = 0,
            bidSum = 0,
            difference = 0,
            ticks = candle.getTicks(),
            len = ticks.length;
            
        for(var i = 0; i < len; i++){
            askSum += ticks[i].ask;
            bidSum += ticks[i].bid;
        }
        
        difference = askSum - bidSum;
        
        height = Math.ceil(fheight * difference / this.MaxTicksSum / zoom);
        var fillStyle = "#ffffff";
        
        if(difference >= 0){
            fillStyle = (Math.abs(difference) === this.MaxTicksSum) ? dirP : dirPL;
        }
        else {
            fillStyle = (Math.abs(difference) === this.MaxTicksSum) ? dirM : dirML;
        }
        
        ctx.textAlign = "center";
        if(graphType === 'FOOTPRINT') {
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                x = Math.ceil(gs.getXCordForTS(candle.from)) + px;
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
            }
            if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                width /= 4;
                x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
            }
            ctx.fillStyle = "#222";//"#ffdc00";
            ctx.fillRect(x + 0.5 * width + px, y, px, minDelta);
            ctx.fillRect(x + 0.5 * width + px, y, px, maxDelta);
            ctx.fillStyle = fillStyle;//"#ffdc00";
            ctx.fillRect(x, y, width, -height);
            
            ctx.font = gs.TEXT_FONT;
            ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_TEXT;
            ctx.textAlign = "right";
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
                }
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
                }
            }
            this.findCurrentSprite(candle, gs);
            if(this.IsIndicatorMark){
                ctx.fillText(difference + ' ', x + 0.5 * width, y - height/Math.abs(height) * 0.25 * h / zoom/*, width * 0.6*/);
            }
            
        }
        else {
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP)) + px;
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
            }
            if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                width /= 4;
                x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
            }
            ctx.fillStyle = "#222";//"#ffdc00";
            ctx.fillRect(x + 0.5 * width + px, y, px,  minDelta);
            ctx.fillRect(x + 0.5 * width + px, y, px, maxDelta);
            ctx.fillStyle = fillStyle;//"#ffdc00";
            ctx.fillRect(x, y, width, -height);
            
            ctx.font = gs.TEXT_FONT;
            ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_TEXT;
            ctx.textAlign = "right";
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
                }
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
                }
            }
            this.findCurrentSprite(candle, gs);
            if(this.IsIndicatorMark){
                ctx.fillText(difference + ' ', x + 0.5 * width, y - height/Math.abs(height) * 0.25 * h / zoom/*, width * 0.6*/);
            }
        }
        
        
    },
    
    drawDataVolume: function(candle, ctx, gs) {
        var graphType = App.CurrentGraph.type;
        var index = this.Index,
            h = 100,
            px = gs.PERFECT_PX,
            zoom = gs.TOTAL_ZOOM,
            x = 0,
            y = gs.realY((h * index) / zoom),
            width = gs.TIME_STEP - 3 * px,
            fheight = 0.9 * h,
            height = -fheight / zoom,
            visualSettings = App.CurrentGraph.visualSettings;
            dirP = visualSettings.DIR_PLUS,
            dirPL = visualSettings.DIR_PLUS_LIGHT,
            dirM = visualSettings.DIR_MINUS,
            dirML = visualSettings.DIR_MINUS_LIGHT;
        
        var ticksSum = 0,
            ticks = candle.getTicks(),
            len = ticks.length;
            
        for(var i = 0; i < len; i++){
            ticksSum += (ticks[i].bid + ticks[i].ask);
        }
        
        height = -Math.ceil(fheight * ticksSum / this.MaxTicksSum / zoom);
        
        var fillStyle = "#ffffff";
        
        if(candle.start_price <= candle.last_price){
            fillStyle = (ticksSum === this.MaxTicksSum) ? dirP : dirPL;
        }
        else {
            fillStyle = (ticksSum === this.MaxTicksSum) ? dirM : dirML;
        }
        
        if(graphType === 'FOOTPRINT') {
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) { 
                width = gs.TIME_STEP - 3 * px;
                x = Math.ceil(gs.getXCordForTS(candle.from)) + px;
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
            }
            if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                width /= 4;
                x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
            }
            ctx.fillStyle = fillStyle;//"#ffdc00";
            ctx.fillRect(x, y, width, height);
            ctx.font = gs.TEXT_FONT;
            ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_TEXT;
            ctx.textAlign = "right";
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
                }
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForTS(candle.from) - 0.5 * width) + px;
                }
            }
            this.findCurrentSprite(candle, gs);
            if(this.IsIndicatorMark){
                ctx.fillText(ticksSum + ' ', x + 0.5 * width, y - 0.5 * h / zoom/*1.1 * height, width * 0.6*/);
            }
        }
        else {
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP)) + px;
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
            }
            if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                width /= 4;
                x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
            }
            ctx.fillStyle = fillStyle;//"#ffdc00";
            ctx.fillRect(x, y, width, height);
            ctx.font = gs.TEXT_FONT;
            ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_INDICATOR_TEXT;
            ctx.textAlign = "right";
            if(!(gs.IS_TIME_ZOOM_BORDER || App.CurrentGraph.IsZoomBorderCrossing)) {   
                width = gs.TIME_STEP - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
                }
            }
            else {
                width = gs.TIME_STEP / 4 - 3 * px;
                if(gs.IS_TIME_ZOOM_BORDER && App.CurrentGraph.IsZoomBorderCrossing) {
                    width /= 4;
                    x = Math.ceil(gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP) - 0.5 * width) + px;
                }
            }
            this.findCurrentSprite(candle, gs);
            if(this.IsIndicatorMark){
                ctx.fillText(ticksSum + ' ', x + 0.5 * width, y - 0.5 * h / zoom/*1.1 * height, width * 0.6*/);
            }
        }
    },
    
    drawData: function(candle, ctx, gs) {
        var volume = 'Volume',
            delta = 'Delta';
        if(this.IndicatorType === volume) {
            this.drawDataVolume(candle, ctx, gs);
        }
        else if(this.IndicatorType === delta) {
            this.drawDataDelta(candle, ctx, gs);
        }
    },
    
    findCurrentSprite: function(candle, gs) {
        var graphType = App.CurrentGraph.type;
        var t = this;
        if(graphType === 'FOOTPRINT') {
            var timeframe = gs.TIMEFRAME_TS;
            var cord = Math.floor(App.CurrentGraph.cordForVerticalLine + 0.1 * timeframe);
            // console.log(gs.tsToTime(candle.from),gs.tsToTime(cord),gs.tsToTime(candle.from + timeframe))
            if(candle.from <= cord && candle.from + timeframe >= cord){
                t.IsIndicatorMark = true;
            }
            else {
                t.IsIndicatorMark = false;
            }
        }
        else {
            // console.log(App.CurrentGraph.cordForVerticalLine, gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP))
            var timeStep = gs.FIXED_TIME_STEP;
            var cord = Math.floor(App.CurrentGraph.cordForVerticalLine + 0.1 * timeStep);
            var candlefrom = Math.floor(candle.index * gs.FIXED_TIME_STEP);
            // console.log(gs.tsToTime(candle.from),gs.tsToTime(cord),gs.tsToTime(candle.from + timeframe))
            if(candlefrom <= cord && candlefrom + timeStep >= cord){
                t.IsIndicatorMark = true;
            }
            else {
                t.IsIndicatorMark = false;
            }
        }
    },
    
    countMaxTicksSumVolume: function(candles, gs) {
        var t = this;
        this.MaxTicksSum = 0;
        candles.forEach(function(candle){
            if(t.dataIsVisible(candle, gs)){
                var ticksSum = 0,
                    ticks = candle.getTicks();
                for(var i = 0; i < ticks.length; i++){
                    ticksSum += (ticks[i].bid + ticks[i].ask);
                }
                t.MaxTicksSum = (t.MaxTicksSum < ticksSum) ? ticksSum : t.MaxTicksSum;
            }
        });
        
    },
    
    countMaxTicksSumDelta: function(candles, gs) {
        var t = this;
        this.MaxTicksSum = 0;
        
        candles.forEach(function(candle){
            if(t.dataIsVisible(candle, gs)){
                var askSum = 0,
                    bidSum = 0,
                    difference = 0,
                    ticks = candle.getTicks(),
                    len = ticks.length;
                    
                for(var i = 0; i < len; i++){
                    askSum += ticks[i].ask;
                    bidSum += ticks[i].bid;
                }
                difference = Math.abs(askSum - bidSum);
                t.MaxTicksSum = (t.MaxTicksSum < difference) ? difference : t.MaxTicksSum;
            }
        });
    },
    
    countMaxTicksSum: function(candles, gs) {
        var volume = 'Volume',
            delta = 'Delta';
        if(this.IndicatorType === volume) {
            this.countMaxTicksSumVolume(candles, gs);
        }
        else if(this.IndicatorType === delta) {
            this.countMaxTicksSumDelta(candles, gs);
        }
    },
    
    dataIsVisible: function(candle, gs) {
        var startPointOfCandle = candle.from;
        var visible = false;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var timePerPixel = gs.TIME_PER_PX;
            stepOfCandle = gs.TIME_STEP * timePerPixel,
            startTimePointOfGraph = gs.START_TS_ON_NULL,
            widthOfGraph = startTimePointOfGraph + (gs.WIDTH - right_indent) * timePerPixel;
            
        if(candle.start_price !== 0 && candle.last_price !== 0){
            visible  = (startPointOfCandle + stepOfCandle >= startTimePointOfGraph && startPointOfCandle <= widthOfGraph);
        }
        return visible;
    },
    
    drawDataIsVisible: function(candle, ctx, gs) {
        if (this.dataIsVisible(candle, gs)) {
            this.drawData(candle, ctx, gs);
        }
    },
    
    getWorkspace: function(gs) {
        var h = 100,
            cord_y = this.Index * h,
            type = this.IndicatorType;
        this.IndicatorWorkspace = {
            index: this.Index,
            x: 0,
            y: cord_y,
            height: h,
            type: type
        }
        return this.IndicatorWorkspace;
    },
    
    onGraphMouseMove: function(e, gs) {
        this.onMouseMove(e, gs);
    },
    
    onMouseClick: function(e, gs) {
        var zoom = gs.TOTAL_ZOOM;
        var x = (e.clientX - 40) / zoom,
            y = e.clientY / zoom,
            h = 100,
            index = this.Index;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            height = gs.HEIGHT - gs.BOTTOM_INDENT - h * (++index) / zoom,
            len = 10 / zoom;
            
        if(x > width - 2.5 * len && x < width - 0.5 * len && y < height + 2.5 * len && y > height + 0.5 * len){
            return index;
        }
        else {
            return null;
        }
    },
    
    onMouseMove: function(e, gs) {
        var zoom = gs.TOTAL_ZOOM;
        var x = (e.clientX - 40) / zoom,
            y = e.clientY / zoom,
            h = 100,
            index = this.Index;
        
        if(gs.realY(y) >= h * index / zoom && gs.realY(y) <= h * (++index) / zoom){
            this.CursorPositionX = x;
            this.CursorPositionY = gs.realY(y);
            this.yDashLineSprite.y = y;
            this.priceFootnoteSprite.y = y;
        }
        else {
            this.yDashLineSprite.y = -500;
            this.priceFootnoteSprite.y = -500;
        }
    },
    
    setIndex: function(index) {
        this.Index = index;
        this.yDashLineSprite.index = this.Index;
        this.priceFootnoteSprite.index = this.Index;
    }
    
};