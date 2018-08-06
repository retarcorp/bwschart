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
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            timeStep = gs.TIME_STEP / grade,
            width = gs.WIDTH - right_indent;
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                bottom_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
                height = gs.HEIGHT - bottom_indent;
            }
            
            var f_x = gs.getXCordForPx(this.f_x),
                f_y = gs.getYCordForPrice(this.f_y),
                s_x = gs.getXCordForPx(this.s_x),
                s_y = gs.getYCordForPrice(this.s_y);
            
            f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? f_x : Math.ceil(f_x - 0.5 * timeStep);
            s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? s_x : Math.ceil(s_x - 0.5 * timeStep);
            var maxValX = (f_x > s_x) ? f_x : s_x,
                minValX = (f_x > s_x) ? s_x : f_x,
                maxValY = (f_y > s_y) ? f_y : s_y,
                minValY = (f_y > s_y) ? s_y : f_y;
            
            
        var _return = (minValX < width && maxValX > 0 && minValY < height && maxValY > 0) ? true : false;
        return _return;
    },

    render: function () {
        var pow = 100, adder = pow/2;
        
        
        var ctx = App.CurrentGraph.TmpCtx,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            timeStep = gs.TIME_STEP / grade,
            px = gs.PERFECT_PX,
            fx = Math.round(this.f_x/pow)*pow - adder,
            sx = Math.round(this.s_x/pow)*pow - adder;
            
            if(type === 'ORDER TAPE'){
                fx = this.f_x;
                sx = this.s_x;
            }
            
            var f_x = Math.ceil(gs.getXCordForPx(fx)) + px,
                f_y = Math.ceil(gs.getYCordForPrice(this.f_y)) + px,
                s_x = Math.ceil(gs.getXCordForPx(sx)) + px,
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
                f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? f_x : Math.ceil(f_x - 0.5 * timeStep) + px;
                s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? s_x : Math.ceil(s_x - 0.5 * timeStep) + px;
            }
            
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                var gr_y = (f_y > s_y) ? f_y : s_y;
                height = (gr_y <= gs.HEIGHT - delta_indent) ? height : Math.ceil(height - (gr_y - (gs.HEIGHT - delta_indent)));
            }
            ctx.beginPath();
            ctx.lineWidth = gs.FIXED_LINE_WIDTH;
            ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_SPRITES;
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
            curGraph = App.CurrentGraph,
            gs = App.CurrentGraph.GraphSettings,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            timeStep = gs.TIME_STEP / grade,
            width = gs.WIDTH - right_indent,
            corrective_shift = 0.25 * timeStep;
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                bottom_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
                height = gs.HEIGHT - bottom_indent;
            }
            var f_x = gs.getXCordForPx(curGraph.findeCandleCordByTs(this.f_x)),
                f_y = gs.getYCordForPrice(this.f_y),
                s_x = gs.getXCordForPx(curGraph.findeCandleCordByTs(this.s_x)),
                s_y = gs.getYCordForPrice(this.s_y);
                
            f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? f_x : Math.ceil(f_x - corrective_shift);
            s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? s_x : Math.ceil(s_x - timeStep + corrective_shift);
            var maxValX = (f_x > s_x) ? f_x : s_x,
                minValX = (f_x > s_x) ? s_x : f_x,
                maxValY = (f_y > s_y) ? f_y : s_y,
                minValY = (f_y > s_y) ? s_y : f_y;
                
        var _return = (minValX < width && maxValX > 0 && minValY < height && maxValY > 0) ? true : false;
        return _return;
    },

    render: function () {
        var pow = 100, adder = pow/2;
        var ctx = App.CurrentGraph.TmpCtx,
            curGraph = App.CurrentGraph,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            timeStep = gs.TIME_STEP / grade,
            priceStep = Math.ceil(0.5 * gs.PRICE_STEP / gs.PRICE_POINTS),
            f_x = Math.ceil(gs.getXCordForPx(curGraph.findeCandleCordByTs(this.f_x))) + px,
            f_y = Math.ceil(gs.getYCordForPrice(this.f_y)) + px,
            s_x = Math.ceil(gs.getXCordForPx(curGraph.findeCandleCordByTs(this.s_x))) + px,
            s_y = Math.ceil(gs.getYCordForPrice(this.s_y)) + px,
            corrective_shift = 0.25 * timeStep;
                
        f_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? f_x : Math.ceil(f_x - corrective_shift) + px;
        s_x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? s_x : Math.ceil(s_x - timeStep + corrective_shift) - 3 * px;
        var maxValY = (f_y > s_y) ? f_y : s_y,
            minValY = (f_y > s_y) ? s_y : f_y,
            maxValX = (f_x > s_x) ? f_x : s_x,
            minValX = (f_x > s_x) ? s_x : f_x,
            width = maxValX - minValX,
            height = maxValY - minValY;
        var obj = App.CurrentGraph.getTotalValue(curGraph.findeCandleCordByTs(this.f_x), curGraph.findeCandleCordByTs(this.s_x), this.f_y, this.s_y);
        
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
                    _width_of_tick = Math.ceil(width_of_ticks * ticks[i][Object.keys(ticks[i])[0]] / max_amount), 
                    _ticks_color = 'rgba(42, 154, 254, 0.5)'; 
                ctx.fillStyle = _ticks_color;
                ctx.fillRect(_x_ticks_cord, _y_ticks_cord, _width_of_tick, height_of_ticks);
            }
        }    
            
            
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.fillStyle = "rgba(42, 154, 254, 0.2)";
        ctx.fillRect(minValX - 0.5 * timeStep, maxValY + priceStep, width + timeStep, -height - 2 * priceStep);
        
        this.f_x_px = minValX - 0.5 * timeStep;
        this.s_y_px = maxValY + priceStep;
        this.f_y_px = this.s_y_px -height - 2 * priceStep;
        this.s_x_px = this.f_x_px + width + timeStep;
        ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_TEXT;
        ctx.textBaseline = 'bottom';
        ctx.textAlign = 'right';
        ctx.font = (App.CurrentPlatform === 'PC') ? gs.TEXT_MARKET_FONT : gs.TEXT_MARKET_FONT_MOBILE;
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
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent,
            y = gs.getYCordForPrice(this.y);
            if(App.CurrentGraph.type !== 'FOOTPRINT'){
                bottom_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;
                height = gs.HEIGHT - bottom_indent;
            }
        var _return = (y < height && y >= 0) ? true : false;
        return _return;
    },
    
    render: function() {
        var ctx = App.CurrentGraph.TmpCtx,
            gs = App.CurrentGraph.GraphSettings,
            px = gs.PERFECT_PX,
            _y = Math.ceil(gs.getYCordForPrice(this.y)) + px,
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent;
            
        ctx.beginPath();
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.strokeStyle = (this.subtype == "CurrentPrice") ? App.CurrentGraph.VisualSettings.DIR_VERTICAL_LINE_LAST_PRICE : App.CurrentGraph.VisualSettings.DIR_SPRITES;
        
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
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            x = gs.getXCordForPx(this.x);
            _return = (x < width && x >= 0) ? true : false;
        return _return;
    },
    
    render: function() {
        // var l = Math.log(App.CurrentGraph.TIMEFRAME.ts) * Math.LOG10E + 1 | 0;
        var pow = 100,
            adder = pow/2;//Math.pow(10, 4);
        var ctx = App.CurrentGraph.TmpCtx,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            px = gs.PERFECT_PX,
            x = Math.ceil(this.x),
            _x = 0,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.DELTA_INDENT : gs.DELTA_INDENT_MOBILE;;
        if(type === 'DELTA' || type === 'FOOTPRINT'){
                
            if(this.subtype) {
                _x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? 
                Math.ceil(gs.getXCordForPx(x + 0.5 * gs.FIXED_TIME_STEP)) + px : 
                Math.ceil(gs.getXCordForPx(x)) + px;
            }
            else {
                _x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? Math.ceil(gs.getXCordForPx(Math.round((x)/pow)*pow - adder)) + px : Math.ceil(gs.getXCordForPx(Math.round((x - 0.5 * gs.FIXED_TIME_STEP)/pow)*pow))+px;
            }
        }
        else {
            pow /= 5;
            adder /= 5;
            _x =  Math.ceil(gs.getXCordForPx(Math.ceil(x/pow)*pow - adder)) + px;
        }
        
        switch (this.subtype) {
            case "day":
                ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_VERTICAL_LINE_END_DAY;
                break;
            case "month":
                ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_VERTICAL_LINE_END_MONTH;
                break;
            default:
                ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_SPRITES;
        }
        var height = gs.HEIGHT - bottom_indent;
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
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent - indicatorsIndent,
            y = (this.gtype === undefined) ? gs.getYCordForPrice(this.y) : this.y;
        var _return = (y < height && y > 0) ? true : false;
        return _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            ctx = App.CurrentGraph.TmpCtx,
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
        // ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_SPRITES;
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
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            x = Math.ceil(gs.getXCordForPx(this.x));
        var _return = (x < width) ? true : false;
        return  _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            ctx = App.CurrentGraph.TmpCtx,
            px = gs.PERFECT_PX,
            x = Math.ceil(gs.getXCordForPx(this.x)) + px;
        
        ctx.lineWidth = gs.FIXED_LINE_WIDTH;
        ctx.strokeStyle = "#888888";
        ctx.beginPath();
        ctx.setLineDash([3]);
        ctx.moveTo(x, 0);
        ctx.lineTo(x, gs.HEIGHT - gs.BOTTOM_INDENT);
        ctx.stroke();
        ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_SPRITES;
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
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            height = gs.HEIGHT - bottom_indent - indicatorsIndent;
            y = (this.gtype === undefined) ? gs.getYCordForPrice(this.y) : this.y;
        var _return = (y < height) ? true : false;
        return _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            ctx = App.CurrentGraph.TmpCtx,
            px = gs.PERFECT_PX,
            priceStep = 20 / gs.TOTAL_ZOOM,//gs.PRICE_STEP / gs.PRICE_POINTS / gs.TOTAL_ZOOM,
            y = (this.gtype === undefined) ? gs.getYCordForPrice(this.y) - 0.5 * priceStep + 2 * px : Math.ceil(this.y) - 0.5 * priceStep + 2 * px;
        var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
        var indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_TEXT_INDENT : gs.RIGHT_TEXT_INDENT_MOBILE;
        var text = (this.gtype === undefined) ? this.y.toFixed(gs.ROUNDING) : Math.floor(gs.realY(this.y) - 100 * this.index);
            ctx.fillStyle = "#000000";
            ctx.font = (App.CurrentPlatform === 'PC') ? gs.TEXT_FONT : gs.TEXT_FONT_MOBILE;
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
            right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - right_indent,
            x = Math.ceil(gs.getXCordForPx(this.x));
        var _return = (x < width) ? true : false;
        return  _return;
    },
    
    render: function(){
        var gs = App.CurrentGraph.GraphSettings,
            type = App.CurrentGraph.type,
            ctx = App.CurrentGraph.TmpCtx,
            px = gs.PERFECT_PX,
            timeframe = gs.TIMEFRAME_TS,
            oneSec = 1000,
            timePerPx = gs.TIME_PER_PX,
            bottom_indent = (App.CurrentPlatform === 'PC') ? gs.BOTTOM_INDENT : gs.BOTTOM_INDENT_MOBILE,
            textY = gs.HEIGHT - 0.5 * bottom_indent,
            y = gs.HEIGHT - bottom_indent,
            height = bottom_indent,
            width = (App.CurrentGraph.IsYAxeZoomFlag) ? 60 : 60 / gs.TOTAL_ZOOM,
            x = gs.getXCordForPx(this.x) + px - 0.5 * width;
            ctx.fillStyle = '#000000';
            var fixed_ts = gs.FIXED_TIME_STEP;
            
            fixed_ts = (App.CurrentGraph.CurType !== 'ordertape') ? fixed_ts : fixed_ts / 5;
            var pos = Math.ceil((this.x - 0.5 * fixed_ts)/fixed_ts);
            var ts = gs.getCandleByIndex(pos);
            var currentTime = '';
            if(ts !== ""){
                currentTime = gs.tsToTime(ts);
                var currentDate = gs.tsToData(ts);
            }
            else {
                ctx.fillStyle = 'rgba(0,0,0,0)';
            }
                    
        if(currentDate !== undefined){
            ctx.font = 12 / gs.TOTAL_ZOOM + 'px Arial';
            ctx.fillRect(x-5, y, width+10, height);
            ctx.fillStyle = '#fff';
            var otp = 6 / gs.TOTAL_ZOOM;
            ctx.textAlign = "center";
            ctx.fillText(currentTime, x + 0.5 * width, textY-otp);
            ctx.fillText(currentDate, x + 0.5 * width, textY+otp);
        }
        else {
            ctx.font = 13 / gs.TOTAL_ZOOM + 'px Arial';  
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