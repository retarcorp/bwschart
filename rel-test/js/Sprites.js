var RectangleSprite = function () {
    this.f_x = 0;
    this.s_x = 0;
    this.f_y = 0;
    this.s_y = 0;
    this.redact = false;
    this.type = 'Rectangle';
};

RectangleSprite.prototype = {
    constructor: RectangleSprite,

    isVisible: function () {
        var type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent,
            width = gs.WIDTH - right_indent;
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                bottom_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
                height = gs.HEIGHT - bottom_indent;
            }
            
            var f_x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.f_x) : gs.getXCordForPx(this.f_x),
                f_y = gs.getYCordForPrice(this.f_y),
                s_x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.s_x) : gs.getXCordForPx(this.s_x),
                s_y = gs.getYCordForPrice(this.s_y);
                
            var maxValX = (f_x > s_x) ? f_x : s_x,
                minValX = (f_x > s_x) ? s_x : f_x,
                maxValY = (f_y > s_y) ? f_y : s_y,
                minValY = (f_y > s_y) ? s_y : f_y;
            
            
        var _return = (minValX < width && maxValX > 0 && minValY < height && maxValY > 0) ? true : false;
        return _return;
    },

    render: function () {
        var pow = 100, adder = pow/2;
        
        
        var ctx = App.CurrentGraph.tmpCtx,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            fx = Math.round(this.f_x/pow)*pow - adder,
            sx = Math.round(this.s_x/pow)*pow - adder;
            
            if(type === 'ORDER TAPE'){
                fx = this.f_x;
                sx = this.s_x;
            }
            
            var f_x = (type === 'FOOTPRINT') ? Math.ceil(gs.getXCordForTS(fx)) + px : Math.ceil(gs.getXCordForPx(fx)) + px,
                f_y = Math.ceil(gs.getYCordForPrice(this.f_y)) + px,
                s_x = (type === 'FOOTPRINT') ? Math.ceil(gs.getXCordForTS(sx)) + px : Math.ceil(gs.getXCordForPx(sx)) + px,
                s_y = Math.ceil(gs.getYCordForPrice(this.s_y)) + px,
                maxValX = (f_x > s_x) ? f_x : s_x,
                minValX = (f_x > s_x) ? s_x : f_x,
                maxValY = (f_y > s_y) ? f_y : s_y,
                minValY = (f_y > s_y) ? s_y : f_y;
                
            f_x = minValX;
            s_x = maxValX;
            f_y = minValY;
            s_y = maxValY;
            
            var height = s_y - f_y,
                width = s_x - f_x;
                
               
            if(type !== 'ORDER TAPE'){
                f_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? f_x : Math.ceil(f_x - 0.13 * gs.TIME_STEP) + px;
                s_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? s_x : Math.ceil(s_x - 0.13 * gs.TIME_STEP) + px;
                      
                  
                if(App.CurrentGraph.IsZoomBorderCrossing && gs.IS_TIME_ZOOM_BORDER) { 
                    f_x = Math.ceil(f_x + 0.09 * gs.TIME_STEP) + px; 
                    s_x = Math.ceil(s_x + 0.11 * gs.TIME_STEP) + px; 
                }
            }
            
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                var gr_y = (f_y > s_y) ? f_y : s_y;
                height = (gr_y <= gs.HEIGHT - delta_indent) ? height : Math.ceil(height - (gr_y - (gs.HEIGHT - delta_indent)));
            }
            ctx.beginPath();
            ctx.lineWidth = gs.FIXED_LINE_WIDTH;
            ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_SPRITES;
            ctx.strokeRect(f_x, f_y, width, height);
            ctx.stroke();
    }

    , renderIfVisible: function () {
        if (this.isVisible()) {
            this.render();
        }
    }
};

var MarketSprite = function () {
    this.f_x = 0;
    this.s_x = 0;
    this.f_y = 0;
    this.s_y = 0;
    this.redact = false;
    this.r_type = '';
    this.type = 'Market';
};

MarketSprite.prototype = {
    constructor: MarketSprite,

    isVisible: function () {
        var type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent,
            width = gs.WIDTH - right_indent;
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                bottom_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
                height = gs.HEIGHT - bottom_indent;
            }
            var f_x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.f_x) : gs.getXCordForPx(this.f_x),
                f_y = gs.getYCordForPrice(this.f_y),
                s_x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.s_x) : gs.getXCordForPx(this.s_x),
                s_y = gs.getYCordForPrice(this.s_y);
                
            var maxValX = (f_x > s_x) ? f_x : s_x,
                minValX = (f_x > s_x) ? s_x : f_x,
                maxValY = (f_y > s_y) ? f_y : s_y,
                minValY = (f_y > s_y) ? s_y : f_y;
                
        var _return = (minValX < width && maxValX > 0 && minValY < height && maxValY > 0) ? true : false;
        return _return;
    },

    render: function () {
        var pow = 100, adder = pow/2;
        var ctx = App.CurrentGraph.tmpCtx,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            timeStep = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.TIME_STEP) : Math.ceil(gs.TIME_STEP / 8),
            priceStep = Math.ceil(0.5 * gs.PRICE_STEP / gs.PRICE_POINTS),
            f_x = (type === 'FOOTPRINT') ? Math.ceil(gs.getXCordForTS(this.f_x)) + px : Math.ceil(gs.getXCordForPx(this.f_x)) + px,
            f_y = Math.ceil(gs.getYCordForPrice(this.f_y)) + px,
            s_x = (type === 'FOOTPRINT') ? Math.ceil(gs.getXCordForTS(this.s_x)) + px : Math.ceil(gs.getXCordForPx(this.s_x)) + px,
            s_y = Math.ceil(gs.getYCordForPrice(this.s_y)) + px;
                
        f_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? f_x : Math.ceil(f_x - 0.15 * gs.TIME_STEP) + 5 * px;
        s_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? s_x : Math.ceil(s_x - 0.15 * gs.TIME_STEP) + 5 * px;
                
        // if (type === 'FOOTPRINT') {
        //     var f_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.getXCordForTS(this.f_x)) + px : Math.ceil(gs.getXCordForTS(this.f_x - App.CurrentGraph.TIMEFRAME.ts/2)) + px,
        //         s_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.getXCordForTS(this.s_x)) + px : Math.ceil(gs.getXCordForTS(this.s_x - App.CurrentGraph.TIMEFRAME.ts/2)) + px;
        // } else {
        //     f_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.getXCordForPx(this.f_x)) + px : Math.ceil(gs.getXCordForPx(this.f_x - gs.FIXED_TIME_STEP/2)) + px,
        //     s_x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.getXCordForPx(this.s_x)) + px : Math.ceil(gs.getXCordForPx(this.s_x - gs.FIXED_TIME_STEP/2)) + px;
        // }
                
        if(App.CurrentGraph.IsZoomBorderCrossing && gs.IS_TIME_ZOOM_BORDER) { 
            f_x = Math.ceil(f_x + 0.145 * gs.TIME_STEP) + px; 
            s_x = Math.ceil(s_x + 0.06 * gs.TIME_STEP) + px; 
        }
        var maxValY = (f_y > s_y) ? f_y : s_y,
            minValY = (f_y > s_y) ? s_y : f_y,
            maxValX = (f_x > s_x) ? f_x : s_x,
            minValX = (f_x > s_x) ? s_x : f_x,
            width = maxValX - minValX,
            height = maxValY - minValY;
        // var text = App.CurrentGraph.getTotalValue(minValX, maxValX, minValY, maxValY);
        var obj = App.CurrentGraph.getTotalValue(this.f_x, this.s_x, this.f_y, this.s_y);
        
        var text = obj.val,
            ticks = obj.ticks;
            
            
        
        var len = ticks.length;
        if(ticks[0] !== undefined){ 
            var max_amount = ticks[0][Object.keys(ticks[0])[0]],
                x_ticks_cord = minValX,
                y_ticks_cord = maxValY,
                price_per_px = gs.PRICE_PER_PX,
                width_of_ticks = Math.ceil(maxValX - minValX + timeStep),
                height_of_ticks = Math.floor((gs.PRICE_TICK_STEP) / price_per_px);
            for(var i = 0; i < len; i++){
                var _x_ticks_cord = minValX  - 0.5 * timeStep + px,
                    tick_price = Object.keys(ticks[i])[0] * 1, 
                    _y_ticks_cord = Math.ceil(gs.getYCordForPrice(gs.round(tick_price, gs.ROUNDING))) - Math.floor(height_of_ticks / 2) - px,
                    _width_of_tick = Math.ceil(width_of_ticks * ticks[i][Object.keys(ticks[i])[0]] / max_amount), //ширина тика
                    _ticks_color = 'rgba(42, 154, 254, 0.5)'; 
                ctx.fillStyle = _ticks_color;
                ctx.fillRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
            }
        }    
            
            
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.fillStyle = "rgba(42, 154, 254, 0.2)";
        // ctx.strokeStyle = "#ff00ff";//App.CurrentGraph.visualSettings.DIR_SPRITES;
        ctx.fillRect(minValX - 0.5 * timeStep, maxValY + priceStep, width + timeStep, -height - 2 * priceStep);
        
        this.f_x_px = minValX - 0.5 * timeStep;
        this.s_y_px = maxValY + priceStep;
        this.f_y_px = this.s_y_px -height - 2 * priceStep;
        this.s_x_px = this.f_x_px + width + timeStep;
        ctx.fillStyle = App.CurrentGraph.visualSettings.DIR_TEXT;
        ctx.textBaseline = 'bottom';
        ctx.textAlign = 'right';
        ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_MARKET_FONT : gs.TEXT_MARKET_FONT_MOBILE;
        ctx.fillText(text, minValX + width + 0.5 * timeStep - 2, minValY + height + priceStep - 2);
        
        
    }

    , renderIfVisible: function () {
        if (this.isVisible()) {
            this.render();
        }
    }
};

var HorizontalLineSprite = function(){
    this.y = 0;
    this.type = 'HorizontalLine';
    this.subtype = arguments[0];
};

HorizontalLineSprite.prototype = {
    constructor: HorizontalLineSprite,
    
    isVisible: function() {
        var gs = App.CurrentGraph.GraphSettings,
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent,
            y = gs.getYCordForPrice(this.y);
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                bottom_indent = (App.currentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
                height = gs.HEIGHT - bottom_indent;
            }
        var _return = (y < height && y >= 0) ? true : false;
        return _return;
    },
    
    render: function() {
        var ctx = App.CurrentGraph.tmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            _y = Math.ceil(gs.getYCordForPrice(this.y)) + px,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent;
            
        ctx.beginPath();
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.strokeStyle = (this.subtype == "CurrentPrice") ? App.CurrentGraph.visualSettings.DIR_VERTICAL_LINE_LAST_PRICE : App.CurrentGraph.visualSettings.DIR_SPRITES;
        
        // console.log(App.CurrentGraph.visualSettings.DIR_VERTICAL_LINE_LAST_PRICE, ctx.strokeStyle)
        
        ctx.moveTo(0, _y);
        ctx.lineTo(width, _y);
        ctx.stroke();
    },
    
    renderIfVisible: function() {
        if(this.isVisible()) {
            this.render();
        }
    }
};

var VerticalLineSprite = function(subtype){
    this.x = 0;
    this.type = 'VerticalLine';
    
    if (subtype) {
        this.subtype = subtype;
    }
};

VerticalLineSprite.prototype = {
    constructor: VerticalLineSprite,
    
    isVisible: function() {
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.x) : gs.getXCordForPx(this.x);
            _return = (x < width && x >= 0) ? true : false;
        return _return;
    },
    
    render: function() {
        // var l = Math.log(App.CurrentGraph.TIMEFRAME.ts) * Math.LOG10E + 1 | 0;
        var pow = 100,
            adder = pow/2;//Math.pow(10, 4);
        var ctx = App.CurrentGraph.tmpCtx,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            x = Math.ceil(this.x),
            _x = 0,
            bottom_indent = 0;
        if(type === 'FOOTPRINT'){
            _x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.getXCordForTS(x)) + px : Math.ceil(gs.getXCordForTS(x - 0.5 * gs.TIMEFRAME_TS)) + px;
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE;
        }
        else if(type === 'DELTA'){
            _x = (!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)) ? Math.ceil(gs.getXCordForPx(Math.round((x)/pow)*pow - adder)) + px : Math.ceil(gs.getXCordForPx(Math.round((x - 0.5 * gs.FIXED_TIME_STEP)/pow)*pow))+px;
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        }
        else {
            pow /= 5;
            adder /= 5;
            _x =  Math.ceil(gs.getXCordForPx(Math.ceil(x/pow)*pow - adder)) + px;
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
        }
        
        switch (this.subtype) {
            case "day":
                ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_VERTICAL_LINE_END_DAY;
                break;
            case "month":
                ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_VERTICAL_LINE_END_MONTH;
                break;
            default:
                ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_SPRITES;;
        }
        
        var height = gs.HEIGHT - bottom_indent;
        // _x = (!App.CurrentGraph.IsZoomBorderCrossing) ? _x : Math.ceil(_x - 0.25 * gs.TIME_STEP) + px;
        
        ctx.beginPath();
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.moveTo(_x, 0);
        ctx.lineTo(_x, height);
        ctx.stroke();
    },
    
    renderIfVisible: function() {
        if(this.isVisible()) {
            this.render();
        }
    }
};

var YDashLineSprite = function(gtype){
    this.gtype = gtype;
    this.y = 0;
    this.type = 'HorizontalDashLine';
};

YDashLineSprite.prototype = {
    constructor: YDashLineSprite,
    
    isVisible: function(){
        var gs = App.CurrentGraph.GraphSettings,
            indicatorsIndent = (this.gtype === undefined) ? gs.INDICATORS_INDENT : 0
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent - indicatorsIndent,
            y = (this.gtype === undefined) ? gs.getYCordForPrice(this.y) : this.y;
        var _return = (y < height && y > 0) ? true : false;
        return _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            ctx = App.CurrentGraph.tmpCtx,
            px = gs.PERFECT_PX,
            y = (this.gtype === undefined) ? Math.ceil(gs.getYCordForPrice(this.y)) + px : Math.ceil(this.y) + px;
        if(gs.ZOOM_Y < -30){
            y += 4 * px;
        }
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.strokeStyle = "#888888";
        ctx.beginPath();
        ctx.setLineDash([3]);
        ctx.moveTo(0, y);
        ctx.lineTo(gs.WIDTH, y);
        ctx.stroke();
        // ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_SPRITES;
        ctx.setLineDash([0]);
    },
    
    renderIfVisible: function(){
        if(this.isVisible()){
            this.render();
        }
    }
};

var XDashLineSprite = function(){
    this.x = 0;
    this.type = 'VerticalDashLine';
};

XDashLineSprite.prototype = {
    constructor: XDashLineSprite,
    
    isVisible: function(){
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.x) : Math.ceil(gs.getXCordForPx(this.x));
        var _return = (x < width) ? true : false;
        return  _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            ctx = App.CurrentGraph.tmpCtx,
            px = gs.PERFECT_PX,
            
            
            x = (type === 'FOOTPRINT') ? Math.ceil(gs.getXCordForTS(this.x)) + px : Math.ceil(gs.getXCordForPx(this.x)) + px;
        
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.strokeStyle = "#888888";
        ctx.beginPath();
        ctx.setLineDash([3]);
        ctx.moveTo(x, 0);
        ctx.lineTo(x, gs.HEIGHT);
        ctx.stroke();
        ctx.strokeStyle = App.CurrentGraph.visualSettings.DIR_SPRITES;
        ctx.setLineDash([0]);
    },
    
    renderIfVisible: function(){
        if(this.isVisible()){
            this.render();
        }
    }
};

var PriceFootnoteSprite = function(gtype, index) {
    this.index = index;
    this.gtype = gtype;
    this.y = 0;
    this.type = 'PriceFootnote';
}

PriceFootnoteSprite.prototype = {
    constructor: PriceFootnoteSprite,
    
    isVisible: function(){
        var gs = App.CurrentGraph.GraphSettings,
            indicatorsIndent = (this.gtype === undefined) ? gs.INDICATORS_INDENT : 0
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent - indicatorsIndent;
            y = (this.gtype === undefined) ? gs.getYCordForPrice(this.y) : this.y;
        var _return = (y < height) ? true : false;
        return _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            ctx = App.CurrentGraph.tmpCtx,
            px = gs.PERFECT_PX,
            priceStep = 20 / gs.TOTAL_ZOOM,//gs.PRICE_STEP / gs.PRICE_POINTS / gs.TOTAL_ZOOM,
            y = (this.gtype === undefined) ? gs.getYCordForPrice(this.y) - 0.5 * priceStep + 2 * px : Math.ceil(this.y) - 0.5 * priceStep + 2 * px;
        var right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var indent = (App.currentPlatform === 'PC') ? gs.RIGHT_TEXT_INDENT : gs.RIGHT_TEXT_INDENT_MOBILE;
        var text = (this.gtype === undefined) ? this.y.toFixed(gs.ROUNDING) : Math.floor(gs.realY(this.y) - 100 * this.index);
            ctx.fillStyle = "#000000";
            ctx.font = (App.currentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;
            ctx.textAlign = "center";
            ctx.fillRect(gs.WIDTH - right_indent, y, right_indent, priceStep);
            ctx.fillStyle = '#FFFFFF';
            ctx.fillText(text, gs.WIDTH - right_indent + indent, y + 0.5 * priceStep)
    },
    
    renderIfVisible: function(){
        if(this.isVisible()){
            this.render();
        }
    }
}

var TimeFootnoteSprite = function() {
    this.x = 0;
    this.type = 'TimeFootnote';
}

TimeFootnoteSprite.prototype = {
    constructor: TimeFootnoteSprite,
    
    isVisible: function(){
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            right_indent = (App.currentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.x) : Math.ceil(gs.getXCordForPx(this.x));
        var _return = (x < width) ? true : false;
        return  _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            ctx = App.CurrentGraph.tmpCtx,
            px = gs.PERFECT_PX,
            timeStep = gs.TIME_STEP,
            timeframe = gs.TIMEFRAME_TS,
            oneSec = 1000,
            timePerPx = gs.TIME_PER_PX,
            bottom_indent = (App.currentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            textY = gs.HEIGHT - 0.5 * bottom_indent,
            y = gs.HEIGHT - bottom_indent,
            height = bottom_indent,
            width = (App.CurrentGraph.IsYAxeZoomFlag) ? 60 : 60 / gs.TOTAL_ZOOM,
            x = (type === 'FOOTPRINT') ? gs.getXCordForTS(this.x) + px - 0.5 * width : gs.getXCordForPx(this.x) + px - 0.5 * width;
            // console.log(y)
            ctx.fillStyle = '#000000';
            if(timeframe !== undefined){
                if(gs.TIMEFRAME === 'D1'){
                    var currentTime = (!App.CurrentGraph.IsZoomBorderCrossing ) ? gs.tsToData(this.x - 0.5 * timeframe) : gs.tsToData(this.x);
                    x -= 7;
                    width += 14;
                }
                else {
                    var currentTime = (!App.CurrentGraph.IsZoomBorderCrossing ) ? gs.tsToTime(this.x - 0.5 * timeframe) : gs.tsToTime(this.x);
                    var currentDate = gs.tsToData(this.x);
                }
            }
            else {
                var fixed_ts = gs.FIXED_TIME_STEP;
                //console.log(gs.getCandleByIndex(-2));
                if(App.CurrentGraph.CurType !== 'ordertape'){
                    var pos = Math.ceil((this.x - 0.5 * fixed_ts)/fixed_ts);
                }
                else {
                    
                    if(!(App.CurrentGraph.IsZoomBorderCrossing || gs.IS_TIME_ZOOM_BORDER)){
                        // console.log('1')
                        fixed_ts /= 5;
                    var pos = Math.ceil((this.x - 0.5 * fixed_ts)/fixed_ts);
                    }
                    else {
                        // console.log('2')
                        fixed_ts /= 5;
                    var pos = Math.ceil((this.x - 0.5 * fixed_ts)/fixed_ts);
                        
                    }
                }
                var ts = gs.getCandleByIndex(pos);
                var currentTime = '';//(gs.ZOOM > 0) ? Math.ceil(this.x - 0.5 * gs.FIXED_TIME_STEP) : this.x;
                if(ts !== ""){
                    currentTime = gs.tsToTime(ts);
                    var currentDate = gs.tsToData(ts);
                }
                else {
                    ctx.fillStyle = '#FFFFFF';
                    y += 1 / gs.TOTAL_ZOOM;
                }
                    
            }
            /*if(timeframe !== undefined){
                if(gs.TIMEFRAME === 'D1'){
                    var currentTime = (!App.CurrentGraph.IsZoomBorderCrossing ) ? gs.tsToData(this.x - 0.5 * timeframe) : gs.tsToData(this.x);
                    x -= 7;
                    width += 14;
                }
                else {
                    var currentTime = (!App.CurrentGraph.IsZoomBorderCrossing ) ? gs.tsToTime(this.x - 0.5 * timeframe) : gs.tsToTime(this.x);
                    var currentDate = gs.tsToData(this.x);
                }
            }
            else {
                //console.log(gs.getCandleByIndex(-2));
                var pos = Math.ceil((this.x - 0.5 * gs.FIXED_TIME_STEP)/gs.FIXED_TIME_STEP);
                var ts = gs.getCandleByIndex(pos);
                var currentTime = '';//(gs.ZOOM > 0) ? Math.ceil(this.x - 0.5 * gs.FIXED_TIME_STEP) : this.x;
                if(ts !== ""){
                    currentTime = gs.tsToTime(ts);
                    var currentDate = gs.tsToData(ts);
                }
                else {
                    ctx.fillStyle = '#FFFFFF';
                    y += 1 / gs.TOTAL_ZOOM;
                }
                    
            }*/
        
        // width = width / gs.TOTAL_ZOOM;
        // width /= gs.TOTAL_ZOOM;
        if(currentDate !== undefined){
            ctx.font = (App.CurrentGraph.IsXAxeZoomFlag || App.CurrentGraph.IsYAxeZoomFlag) ? '12px Arial' : 12 / gs.TOTAL_ZOOM + 'px Arial';
            ctx.fillRect(x-5, y, width+10, height);
            ctx.fillStyle = '#fff';
            var otp = (App.CurrentGraph.IsXAxeZoomFlag) ? 6 : 6 / gs.TOTAL_ZOOM;
            ctx.textAlign = "center";
            ctx.fillText(currentTime, x + 0.5 * width, textY-otp);
            ctx.fillText(currentDate, x + 0.5 * width, textY+otp);
        }
        else {
            ctx.font = 13 / gs.TOTAL_ZOOM + 'px Arial';//'13px Arial';    
            ctx.fillRect(x, y, width, height);
            ctx.fillStyle = '#fff';
            ctx.textAlign = "center";
            ctx.fillText(currentTime, x + 0.5 * width, textY);
        }
                
    },
    
    renderIfVisible: function(){
        if(this.isVisible()){
            this.render();
        }
    }
}