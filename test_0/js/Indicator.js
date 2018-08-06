// конструктор индикаторов
var Indicator = function(type, index) {
    this.IndicatorType = type;
    this.Index = index;
    this.yDashLineSprite = new YDashLineSprite(type, index);
    this.PriceFootnoteSprite = new PriceFootnoteSprite(type, index, this.MaxTicksSum);
};

// класс индикаторов
Indicator.prototype = {
    
    // объект со свойствами индикатора
    IndicatorWorkspace: null,
    
    // тип индикатора
    IndicatorType: null,
    
    // позиции курсора на индикаторе
    CursorPositionX: 0,
    CursorPositionY: 0, 
    
    // максимальноек кол-во тиков
    MaxTicksSum: 0,
    
    // высота индикатора(ПК)
    Height: 100,
    
    // высота индикатора(мобильное устройство)
    HeightMobile: 60,
    
    // флаг состояния фокуса курсора на конкретной свече на индикаторе
    IsIndicatorMark: false,
    
    // вызывает отрисовку
    onGraphRender: function(candles, ctx, gs) {
        this.draw(candles, ctx, gs);
    },
    
    // отрисовывает данные индикатора
    draw: function(candles, ctx, gs) {
        var t = this;
        this.drawWorkspace(ctx, gs);
        this.countMaxTicksSum(candles, gs);
        this.drawDataIsVisible(candles, ctx, gs);
        this.drawMainWorkSpace(ctx, gs);
        // this.drawMarks(ctx, gs);
        this.yDashLineSprite.renderIfVisible();
        // this.PriceFootnoteSprite.renderIfVisible();
    },
    
    // отрисовывает метки по оси ОУ на индикаторе
    drawMarks: function(ctx, gs) {
        var px = gs.PERFECT_PX,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            index = this.Index,
            zoom = gs.TOTAL_ZOOM,
            lineWidth = gs.FIXED_LINE_WIDTH,
            r_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            x = gs.WIDTH - r_indent,
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
    
    // отрисовывает основное пространство индикатора
    drawMainWorkSpace: function(ctx, gs) {
        var px = gs.PERFECT_PX,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            index = this.Index,
            zoom = gs.TOTAL_ZOOM,
            lineWidth = gs.FIXED_LINE_WIDTH,
            rightIndent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            x = gs.WIDTH - rightIndent,
            y = gs.realY((-px + h * index) / zoom),
            height = -h / zoom,
            lineW = gs.LINE_WIDTH,
            textFont = 9 / zoom + 'pt Arial',
            text_x = 5 / zoom,
            text_y = gs.realY((0.8 * h + h * index) / zoom),
            text = this.IndicatorType;
        
        ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_INDICATOR_TEXT;
        ctx.font = textFont;
        ctx.textAlign = "left";
        if(this.IndicatorType !== 'Order'){
            ctx.fillText(text, text_x, text_y);
        }
        ctx.lineWidth = lineWidth;
        ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_PRICE_FILL;
        ctx.fillRect(x, y + 10, rightIndent, height - 10);
        ctx.strokeStyle = "#000000";
        ctx.beginPath();
            ctx.moveTo(x + px, y);
            ctx.lineTo(x + px, y + height );
        ctx.stroke();
        
        if(this.IndicatorType !== 'Order' && App.CurrentPlatform === 'PC'){
            var cros_x = x - 5 / zoom,
                cros_y = y + 5 / zoom + height;
                cros_w = -10 / zoom;
                cros_h = 10 / zoom,
                len = 10 / zoom;
            
            ctx.strokeStyle = App.CurrentGraph.VisualSettings.DIR_INDICATOR_CLOSE_BTN;
            ctx.strokeRect(cros_x, cros_y, cros_w, cros_h);
            ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_INDICATOR_FILL;
            ctx.fillRect(cros_x, cros_y, cros_w, cros_h);
            ctx.beginPath();
                ctx.moveTo(cros_x, cros_y);
                ctx.lineTo(cros_x - len, cros_y + len);
                ctx.moveTo(cros_x, cros_y + len);
                ctx.lineTo(cros_x - len, cros_y);
            ctx.stroke();
        }
    },
    
    // отрисовывает на холсте рабочую зону 
    drawWorkspace: function(ctx, gs) {
        var index = this.Index,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            px = gs.PERFECT_PX,
            zoom = gs.TOTAL_ZOOM,
            lineWidth = gs.FIXED_LINE_WIDTH,
            x = 0,
            y = gs.realY((h * index - px) / zoom),
            rightIndent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH,
            height = -h / zoom,
            lineW = gs.LINE_WIDTH,
            textFont = gs.TEXT_FONT;
        
        ctx.lineWidth = lineWidth;
        if (this.IndicatorType == "Order") {
            ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_BG;
        } else {
            ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_INDICATOR_FILL;
        }
        
        ctx.fillRect(x, y, width, height);
        ctx.strokeStyle = "#000000";
        ctx.strokeRect(x, y, width - rightIndent, height);
    },
    
    // отрисовывает данные индикатора ленты ордеров
    drawDataOrder: function(candle, ctx, gs) {
        var graphType = App.CurrentGraph.type;
        var index = this.Index,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            px = gs.PERFECT_PX,         
            zoom = gs.TOTAL_ZOOM,
            x = 0,
            y = gs.realY((h * index) / zoom),
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            width = gs.TIME_STEP / 5 / grade,
            fixed_time_step = gs.FIXED_TIME_STEP / 5,
            fheight = 0.9 * h,
            height = 0 / zoom,
            VisualSettings = App.CurrentGraph.VisualSettings;
            dirP = VisualSettings.DIR_PLUS,
            dirPL = VisualSettings.DIR_PLUS_LIGHT,
            dirM = VisualSettings.DIR_MINUS,
            dirML = VisualSettings.DIR_MINUS_LIGHT,
            volume = candle.volume,
            id = gs.getCurrentId(candle.id);
            height = Math.ceil(fheight * candle.volume / this.MaxTicksSum / zoom),
            fillStyle = (candle.direction !== 1) ? dirP : dirM;
        
        width = (width <= 1) ? 1 : width;
        ctx.textAlign = "center";
        x = Math.ceil(gs.getXCordForPx(id * fixed_time_step)) + px;
        ctx.fillStyle = fillStyle;
        ctx.fillRect(x, y, width, -height);
        ctx.font = gs.TEXT_FONT;
        ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_TEXT;
        ctx.textAlign = "right";
        this.findCurrentSprite(candle, gs);
        if(this.IsIndicatorMark){
            ctx.fillText(volume + ' ', x + 0.5 * width, y - 0.5 * h / zoom);
        }
    },
    
    // отрисовывает данные индикатора DELTA
    drawDataDelta: function(candle, ctx, gs) {
        var graphType = App.CurrentGraph.type;
        var index = this.Index,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            px = gs.PERFECT_PX,
            zoom = gs.TOTAL_ZOOM,
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            x = 0,
            y = gs.realY((0.5 * h + h * index) / zoom),
            fixed_time_step = gs.FIXED_TIME_STEP,
            width = gs.TIME_STEP / grade,
            fheight = 0.45 * h,
            height = 0 / zoom,
            VisualSettings = App.CurrentGraph.VisualSettings;
            dirP = VisualSettings.DIR_PLUS,
            dirPL = VisualSettings.DIR_PLUS_LIGHT,
            dirM = VisualSettings.DIR_MINUS,
            dirML = VisualSettings.DIR_MINUS_LIGHT,
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
        x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? Math.ceil(gs.getXCordForPx(candle.index * fixed_time_step)) + px : Math.ceil(gs.getXCordForPx(candle.index * fixed_time_step) - 0.5 * width) + px;
        ctx.fillStyle = "#222";
        ctx.fillRect(x + 0.5 * width + px, y, px,  minDelta);
        ctx.fillRect(x + 0.5 * width + px, y, px, maxDelta);
        ctx.fillStyle = fillStyle;
        ctx.fillRect(x, y, width, -height);
        
        ctx.font = gs.TEXT_FONT;
        ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_INDICATOR_TEXT;
        ctx.textAlign = "right";
        this.findCurrentSprite(candle, gs);
        if(this.IsIndicatorMark){
            ctx.fillText(difference + ' ', x + 0.5 * width, y - height/Math.abs(height) * 0.25 * h / zoom);
        }
    },
    
    // отрисовывает данные индикатора VOLUME
    drawDataVolume: function(candle, ctx, gs) {
        var graphType = App.CurrentGraph.type;
        var index = this.Index,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            px = gs.PERFECT_PX,
            zoom = gs.TOTAL_ZOOM,
            x = 0,
            y = gs.realY((h * index) / zoom),
            grade = gs.GRADE,
            x_zoom_cur_grade = gs.X_ZOOM_CURRENT_GRADE,
            fixed_time_step = gs.FIXED_TIME_STEP,
            width = gs.TIME_STEP / grade,
            fheight = 0.9 * h,
            height = -fheight / zoom,
            VisualSettings = App.CurrentGraph.VisualSettings;
            dirP = VisualSettings.DIR_PLUS,
            dirPL = VisualSettings.DIR_PLUS_LIGHT,
            dirM = VisualSettings.DIR_MINUS,
            dirML = VisualSettings.DIR_MINUS_LIGHT;
        
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
        
        x = (!App.CurrentGraph.IsZoomBorderCrossing && (x_zoom_cur_grade === gs.X_ZOOM_GRADE.ZERO)) ? Math.ceil(gs.getXCordForPx(candle.index * fixed_time_step)) + px : Math.ceil(gs.getXCordForPx(candle.index * fixed_time_step) - 0.5 * width) + px;

        ctx.fillStyle = fillStyle;
        ctx.fillRect(x, y, width, height);
        ctx.font = gs.TEXT_FONT;
        ctx.fillStyle = App.CurrentGraph.VisualSettings.DIR_INDICATOR_TEXT;
        ctx.textAlign = "right";
        this.findCurrentSprite(candle, gs);
        if(this.IsIndicatorMark){
            ctx.fillText(ticksSum + ' ', x + 0.5 * width, y - 0.5 * h / zoom);
        }
    },
    
    // выбирает какого типа данные отрисовать и вызывает их отрисовку
    drawData: function(candle, ctx, gs) {
        var volume = 'Volume',
            delta = 'Delta',
            order = 'Order';
        if(this.IndicatorType === volume) {
            this.drawDataVolume(candle, ctx, gs);
        }
        else if(this.IndicatorType === delta) {
            this.drawDataDelta(candle, ctx, gs);
        }
        else if(this.IndicatorType === order) {
            this.drawDataOrder(candle, ctx, gs);
        }
    },
    
    // вычисляет максимальный объем свечи для индикатора VOLUME
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
    
    // вычисляет максимальный объем свечи для индикатора DELTA
    countMaxTicksSumDelta: function(candles, gs) {
        var t = this;
        this.MaxTicksSum = 0;
        
        candles.forEach(function(candle){
            if(t.dataIsVisible(candle, gs)){
                var askSum = 0,
                    bidSum = 0,
                    difference = 0,
                    ticks = candle.getTicks(),
                    len = ticks.length,
                    minDelta = candle.deltaShadow.min,
                    maxDelta = candle.deltaShadow.max;
                    
                for(var i = 0; i < len; i++){
                    askSum += ticks[i].ask;
                    bidSum += ticks[i].bid;
                }
                difference = Math.abs(askSum - bidSum);
                t.MaxTicksSum = (t.MaxTicksSum < difference) ? difference : t.MaxTicksSum;
                
                if(t.MaxTicksSum < Math.abs(minDelta)) {
                    t.MaxTicksSum = Math.abs(minDelta);
                }
                if(t.MaxTicksSum < Math.abs(maxDelta)){
                    t.MaxTicksSum = Math.abs(maxDelta);
                }
            }
        });
    },
    
    // вычисляет максимальный объем свечи для индикатора ленты ордеров
    countMaxTicksSumOrder: function(candles, gs) {
        var t = this;
        this.MaxTicksSum = 0;
        
        candles.forEach(function(candle){
            if(t.dataIsVisible(candle, gs)){
                var volume = candle.volume;
                t.MaxTicksSum = (t.MaxTicksSum < volume) ? volume : t.MaxTicksSum;
            }
        });
    },
    
    // выбирает какого типа индикатора необходимо посчитать максимальный объем свечи
    countMaxTicksSum: function(candles, gs) {
        var volume = 'Volume',
            delta = 'Delta',
            order = 'Order';
        if(this.IndicatorType === volume) {
            this.countMaxTicksSumVolume(candles, gs);
        }
        else if(this.IndicatorType === delta) {
            this.countMaxTicksSumDelta(candles, gs);
        }
        else if(this.IndicatorType === order) {
            this.countMaxTicksSumOrder(candles, gs);
        }
    },
    
    // находит позицию свечи, на которую наведен курсор
    findCurrentSprite: function(candle, gs) {
        var graphType = App.CurrentGraph.type;
        var t = this;
        if(graphType === 'DELTA' || graphType === 'FOOTPRINT') {
            var timeStep = gs.FIXED_TIME_STEP;
            var cord = Math.floor(App.CurrentGraph.cordForVerticalLine + 0.1 * timeStep);
            var candlefrom = Math.floor(candle.index * timeStep);
            if(candlefrom <= cord && candlefrom + timeStep >= cord){
                t.IsIndicatorMark = true;
            }
            else {
                t.IsIndicatorMark = false;
            }
        }
        else {
            var timeStep = gs.FIXED_TIME_STEP / 5;
            var cord = Math.floor(App.CurrentGraph.cordForVerticalLine + 0.1 * timeStep);
            var id = gs.getCurrentId(candle.id);
            var candlefrom = Math.floor(id * timeStep);
            if(candlefrom <= cord && candlefrom + timeStep >= cord){
                t.IsIndicatorMark = true;
            }
            else {
                t.IsIndicatorMark = false;
            }
        }
    },
    
    // определяет данные каких свеч видны
    dataIsVisible: function(candle, gs) {
        var graphType = App.CurrentGraph.type;
        var grade = gs.GRADE;
        if(graphType === 'DELTA' || graphType === 'FOOTPRINT'){
            var startPointOfCandle = gs.getXCordForPx(candle.index * gs.FIXED_TIME_STEP);
            var visible = false;
            var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
            var timePerPixel = gs.TIME_PER_PX,
                stepOfCandle = gs.TIME_STEP / grade,
                widthOfGraph = gs.WIDTH - right_indent;
                
            if(candle.start_price !== 0 && candle.last_price !== 0){
                visible  = (startPointOfCandle + stepOfCandle >= 0 && startPointOfCandle <= widthOfGraph);
            }
            return visible;
        }
        else {
            var id = gs.getCurrentId(candle.id),
                fixed_time_step = gs.FIXED_TIME_STEP / 5;
            var startPointOfCandle = gs.getXCordForPx(id * fixed_time_step);
            var visible = false;
            var right_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE;
            var timePerPixel = gs.TIME_PER_PX;
                stepOfCandle = gs.TIME_STEP / 5 / grade,
                widthOfGraph = gs.WIDTH - right_indent;
                
            if(candle.price !== 0){
                visible  = (startPointOfCandle + stepOfCandle >= 0 && startPointOfCandle <= widthOfGraph);
            }
            return visible;
        }
        
    },
    
    // отрисовывает данные свеч, если они видны
    drawDataIsVisible: function(candles, ctx, gs) {
        var t = this;
        candles.forEach(function(candle){
            if (t.dataIsVisible(candle, gs)) {
                // console.log('ВИдно')
                t.drawData(candle, ctx, gs);
            }
        });
    },
    
    // возвращает данные об индикаторе
    getWorkspace: function(gs) {
        var h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
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
    
    // вызвыает функцию для отрисовки элементов курсора на индикаторе
    onGraphMouseMove: function(e, gs) {
        this.onMouseMove(e, gs);
    },
    
    // определяет действие при нажатии ЛКМ на индикаторе(поиск кнопки закрытия индикатора(возвращает индекс индикатора, который необходимо закрыть))
    onMouseClick: function(e, gs) {
        var zoom = gs.TOTAL_ZOOM;
        var x = (e.clientX - 40) / zoom,
            graphType = App.CurrentGraph.type,
            y = e.clientY / zoom,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            index = this.Index,
            r_indent = (App.CurrentPlatform === 'PC') ? gs.RIGHT_INDENT : gs.RIGHT_INDENT_MOBILE,
            width = gs.WIDTH - r_indent,
            height = (graphType === 'FOOTPRINT') ? gs.HEIGHT - gs.BOTTOM_INDENT - h * (++index) / zoom : gs.HEIGHT - gs.DELTA_INDENT - h * (++index) / zoom,
            len = 10 / zoom;
            
        if(x > width - 2.5 * len && x < width - 0.5 * len && y < height + 2.5 * len && y > height + 0.5 * len){
            return index;
        }
        else {
            return null;
        }
    },
    
    // пересчет значений при дввижении мыши в области индикатора
    onMouseMove: function(e, gs) {
        var zoom = gs.TOTAL_ZOOM;
        var x = (e.clientX - 40) / zoom,
            graphType = App.CurrentGraph.type,
            y = e.clientY / zoom,
            h = (App.CurrentPlatform === 'PC') ? this.Height : this.HeightMobile,
            index = this.Index;
        
        if(gs.realY(y) >= h * index / zoom && gs.realY(y) <= h * (++index) / zoom){
            this.CursorPositionX = x;
            this.CursorPositionY = gs.realY(y);
            this.yDashLineSprite.y = y;
            this.PriceFootnoteSprite.y = y;
            this.PriceFootnoteSprite.max = this.MaxTicksSum;
        }
        else {
            this.yDashLineSprite.y = -500;
            this.PriceFootnoteSprite.y = -500;
        }
    },
    
    // устанавливает индекс индикатора
    setIndex: function(index) {
        this.Index = index;
        this.yDashLineSprite.index = this.Index;
        this.PriceFootnoteSprite.index = this.Index;
    }
    
};