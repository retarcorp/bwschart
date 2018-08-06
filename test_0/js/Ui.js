// объект интерфейса рабочего пространства приложения
var Ui = {
    
    parentModal: null,
    
    visualSettingsModal: null,
    
    visualSettingsBtn: null,
    
    timeframeSettingsBtn: null,
    
    deltaSettingsBtn: null,
    
    instrumentBtn: null,
    
    graphTypeBtn: null,
    
    spritesBtn: null,
    
    indicatorsBtn: null,
    
    menu:null,
    
    innerMenu: null,
    
    helpler: null,
    
    visualSettingsBtns: null,
    
    help_bar: null,
    
    clickEvent: null,
    
    CurrentInstrBlock: null,
    
    flag: true,
    
    MarketProf: null,
    
    FormInput: {
        Main: null,
        FirstInp: null,
        SecInp: null,
        Btn: null
    },
    
    FormVal: {
        Min: 0,
        
        Max: 0
    },
    
    FormFlag: 0,
    
    lastPressedBtn: {
        instrument: null,
        timeframe: null,
        delta: null
    },
    
    typeOfGraphStruct: {
        footprint: null,
        deltaGraph: null,
        footprintBtn: null,
        deltaGraphBtn: null,
        orderBtn: null
    },
    
    init: function(){
        t = this;
        
        this.help_bar = {
            bar: document.getElementById('help_bar'),
            text_box: document.getElementById('help_text')
        }
        
        this.helpler = document.getElementById('helpler');
        this.parentModal = document.getElementById('parent_modal');
        this.visualSettingsModal = document.getElementById('visual_settings-modal');
        this.visualSettingsBtn = document.getElementById('visual_settings');
        this.instrumentBtn = document.getElementById('instrument');
        this.graphTypeBtn = document.getElementById('tools');
        
        this.visualSettingsBtns = {
            colorEndOfDay: document.getElementById('color-end-of-day'),
            colorEndOfMonth: document.getElementById('color-end-of-month'),
            colorLastPrice: document.getElementById('color-last-price'),
            
            colorSpritesFootprint: document.getElementById('color-sprites-footprint'),
            colorCandleOutlineFootprint: document.getElementById('color-candle-outline-footprint'),
            colorPlusFootprint: document.getElementById('color-plus-footprint'),
            colorMinusFootprint: document.getElementById('color-minus-footprint'),
            colorBGFootprint: document.getElementById('color-background-footprint'),
            colorGridFootprint: document.getElementById('color-grid-footprint'),
            colorTextFootprint: document.getElementById('color-text-footprint'),
            colorTimeFillFootprint: document.getElementById('color-time_fill-footprint'),
            colorTimeTextFootprint: document.getElementById('color-time_text-footprint'),
            colorPriceFillFootprint: document.getElementById('color-price_fill-footprint'),
            colorPriceTextFootprint: document.getElementById('color-price_text-footprint'),
            colorIndicatorTextFootprint: document.getElementById('color-indicator_text-footprint'),
            colorIndicatorPriceFillFootprint: document.getElementById('color-indicator-price_fill-footprint'),
            colorIndicatorCloseBtnFootprint: document.getElementById('color-indicator-close-btn-footprint'),
            colorIndicatorFillFootprint: document.getElementById('color-indicator_fill-footprint'),
            
            colorSpritesDelta: document.getElementById('color-sprites-delta'),
            colorCandleOutlineDelta: document.getElementById('color-candle-outline-delta'),
            colorPlusDelta: document.getElementById('color-plus-delta'),
            colorMinusDelta: document.getElementById('color-minus-delta'),
            colorBGDelta: document.getElementById('color-background-delta'),
            colorGridDelta: document.getElementById('color-grid-delta'),
            colorTextDelta: document.getElementById('color-text-delta'),
            colorTimeFillDelta: document.getElementById('color-time_fill-delta'),
            colorTimeTextDelta: document.getElementById('color-time_text-delta'),
            colorPriceFillDelta: document.getElementById('color-price_fill-delta'),
            colorPriceTextDelta: document.getElementById('color-price_text-delta'),
            colorIndicatorTextDelta: document.getElementById('color-indicator_text-delta'),
            colorIndicatorPriceFillDelta: document.getElementById('color-indicator-price_fill-delta'),
            colorIndicatorCloseBtnDelta: document.getElementById('color-indicator-close-btn-delta'),
            colorIndicatorFillDelta: document.getElementById('color-indicator_fill-delta'),
            
            colorSpritesOrder: document.getElementById('color-sprites-order'),
            colorCandleOutlineOrder: document.getElementById('color-candle-outline-order'),
            colorPlusOrder: document.getElementById('color-plus-order'),
            colorMinusOrder: document.getElementById('color-minus-order'),
            colorBGOrder: document.getElementById('color-background-order'),
            colorGridOrder: document.getElementById('color-grid-order'),
            colorTextOrder: document.getElementById('color-text-order'),
            colorTimeFillOrder: document.getElementById('color-time_fill-order'),
            colorTimeTextOrder: document.getElementById('color-time_text-order'),
            colorPriceFillOrder: document.getElementById('color-price_fill-order'),
            colorPriceTextOrder: document.getElementById('color-price_text-order')
        };
        
        this.graph = document.querySelector('.graph');
        this.supervisorOption = document.getElementById('supervisor');
        
        this.MarketProf = document.getElementById('market-profile');
        
        this.lastPressedBtn = {
            instrument: document.getElementById('EUR'),
            timeframe: document.getElementById('M1'),
            delta: document.getElementById('hundred')
        };
        
        this.typeOfGraphStruct = {
            footprint: document.getElementById('footprint'),
            deltaGraph: document.getElementById('deltaGraph'),
            footprintBtn: document.getElementById('FOOTPRINT'),
            deltaGraphBtn: document.getElementById('DELTA'),
            orderBtn: document.getElementById('ORDERTAPE')
        };
        this.FormInput = {
            Main: document.getElementById('form-imput'),
            FirstInp: document.getElementById('form-imput-one'),
            SecInp: document.getElementById('form-imput-two'),
            Btn: document.getElementById('form-btn')
        }
        
        this.setVisualSettingsColor();
        
        this.timeframeSettingsBtn = document.getElementById('timeframe');
        this.deltaSettingsBtn = document.getElementById('delta');
        this.spritesBtn = document.getElementById('sprites');
        this.indicatorsBtn = document.getElementById('indicators');
        
        this.menu = document.getElementById('menu-settings');
        this.innerMenu = document.getElementsByClassName('inner-menu');
        this.about = document.getElementById('about');
        this.FormInput.Btn.addEventListener('click', this.onImputClick);
        
        this.visualSettingsBtn.addEventListener('click', this.changeVisualSettings);
        this.timeframeSettingsBtn.addEventListener('click', this.changeTimeframe);
        this.deltaSettingsBtn.addEventListener('click', this.changeDelta);
        this.instrumentBtn.addEventListener('click', this.changeInstrument);
        this.graphTypeBtn.addEventListener('click', this.changeGraphType);
        this.parentModal.addEventListener('click', this.onModal.bind(this));
        this.supervisorOption.addEventListener('click', this.enableSupervisor);
        this.visualSettingsModal.addEventListener('click', this.onVisualSettingsModal);
        // this.about.addEventListener('click', this.onAbout);
        this.menu.addEventListener('click', this.onMenu);
        this.graph.addEventListener('click', this.onGraph);
        this.spritesBtn.addEventListener('click', function(e){
            t.drawSprite(e.target.id);
        });
        if(this.flag){
            this.indicatorsBtn.addEventListener('click', this.onIndicators.bind(this));
            this.flag = false;
        }
        this.CurrentInstrBlock = document.getElementById('current-instr');
        this.setCurrentInstrBlock();
    },
    
    addHelpBar: function(target, flag) {
        if(flag){
            if(target === '' || target === 'sprites' || target === 'move'){
                // console.log("Ошибка природы")
            }
            else {
                App.CurrentGraph.Canvas.classList.add('pointer');
                this.help_bar.bar.classList.add('help_bar_move');
                this.help_bar.text_box.classList.remove('hide_modal');
            }
            switch(target) {
                case 'horizontal-line':
                    this.help_bar.text_box.innerText = 'Для установки линии на графике нажмите на нужную строку курсором или пальцем.';
                    break;
                case 'vertical-line': 
                    this.help_bar.text_box.innerText = 'Для установки линии на графике нажмите на нужный столбец курсором или пальцем.';
                    break;
                case 'rectangle':
                    this.help_bar.text_box.innerText = (App.CurrentPlatform === 'PC') ? 'Для создания прямоугольника нажмите и потяните на графике с одного угла, до другого.' : 'Для создания прямоугольника кликните первый раз для установки первой точки грани прямоугольника и второй раз для установки диаметрально-противоположной точки грани.';
                    break;
                case 'market-profile':
                    this.help_bar.text_box.innerText = (App.CurrentPlatform === 'PC') ? 'Для создания прямоугольника нажмите и потяните на графике с одного угла, до другого.' : 'Для создания прямоугольника кликните первый раз для установки первой точки грани прямоугольника и второй раз для установки диаметрально-противоположной точки грани.';
                    break;
                case 'move': 
                    break;
                case 'remove': 
                    this.help_bar.text_box.innerText = 'Для удаления элемента кликните на него(удалится последний добавленный элемент в области клика).';
                    break;
            }
        }
        else {
            App.CurrentGraph.Canvas.classList.remove('pointer');
            this.help_bar.bar.classList.remove('help_bar_move');
            this.help_bar.text_box.classList.add('hide_modal');
        }
    },
    
    onImputClick: function(e) {
        Data.Request.onXHRChanged();
        var min = 1 * Ui.FormInput.FirstInp.value,
            max = 1 * Ui.FormInput.SecInp.value;
            
        Data.lastABI = null;
        
        Ui.FormVal = {
            Min: min,
            Max: max
        }
        
        if(min === 0 && max === 0){
            Ui.FormFlag = 0;
        }
        else if(min !== 0 && max === 0){
            Ui.FormFlag = 1;
        }
        else if(min !== 0 && max >= min){
            Ui.FormFlag = 2;
        }
        else if(min === 0 && max !== 0){
            Ui.FormFlag = 3;
        }
        else {
            Ui.FormFlag = 1;
        }
        Data.Cache.Candles.splice(0, Data.Cache.Candles.length);
        App.CurrentGraph.CandleSprite.splice(0, App.CurrentGraph.CandleSprite.length);
        App.CurrentGraph.GraphSettings.START_OX_POINT = Data.RightOrderCandle.id - App.CurrentGraph.FirstIdOrder;
        App.CurrentGraph.GraphSettings.setStartPointOnNull();
        
        Data.FlagForOrderChange = true;
        App.CurrentGraph.FlagForStartPrice = true;
        
        App.CurrentGraph.recursiveRender();
    },
    
    drawSprite: function(target){
        if(Data.Cache.Candles.length !== 0){
            if(target !== 'sprites'){
                Ui.resetHover();
                App.ClickForEvent = true;
                App.CurrentGraph.SpritesEdditor = true;
                App.CurrentGraph.CurrentSprite = target;
                if(target === 'rectangle'){
                    App.ClickForEvent = true;
                }
                if(target === 'market-profile'){
                    App.ClickForEvent = true;
                }
                if(target === 'remove_all'){
                    App.CurrentGraph.removeAllSprites();
                }
                else {
                    this.addHelpBar(App.CurrentGraph.CurrentSprite, true);
                }
            }
        }
    },
    
    changeVisualSettings: function(e){
        Ui.parentModal.classList.toggle('hide_modal');
        Ui.resetHover();
        e.stopPropagation();
    },
    
    changeTimeframe: function(e){
        Ui.resetHover();
        Data.Request.onXHRChanged();
        if(Ui.lastPressedBtn.timeframe !== null){
            Ui.lastPressedBtn.timeframe.classList.remove('selected');
        }
        
        Ui.clearSprites();
        App.CurrentGraph.IsStartValueNotReceiced = true;
        e.target.classList.add('selected');
        App.changeTimeframeSettings(e.target);
        Ui.clearCountnerForFootprintGraph();
        App.CurrentGraph.FlagForStartPrice = true;
        Data.LeftFootprintTs = 0;
        App.CurrentGraph.GraphSettings.START_OX_POINT = 2*App.CurrentGraph.GraphSettings.FIXED_TIME_STEP;
        App.CurrentGraph.FlagForStartPriceF = true;
        
        App.CurrentGraph.GraphSettings.setTimeFrame();
        Ui.setCurrentInstrBlock();
        App.CurrentGraph.removeAllSprites();
        App.CurrentGraph.recursiveRender();
    },
    
    changeDelta: function(e){
        Ui.resetHover();
        Data.Request.onXHRChanged();
        if(Ui.lastPressedBtn.delta !== null){
            Ui.lastPressedBtn.delta.classList.remove('selected');
        }
        App.CurrentGraph.VisibleCandles.splice(0, App.CurrentGraph.VisibleCandles.length);
        Ui.clearSprites();
        App.CurrentGraph.IsDeltaIndicatorCreate = false;
        e.target.classList.add('selected');
        Ui.lastPressedBtn.delta = e.target;
        
        Ui.clearCountnerForDeltaGraph();
        
        App.CurrentGraph.FlagForStartPrice = true;
        App.CurrentGraph.GraphSettings.START_OX_POINT = 2*App.CurrentGraph.GraphSettings.FIXED_TIME_STEP;
        App.changeDeltaSettings(e.target);
        App.CurrentGraph.GraphSettings.setDelta();
        Ui.setCurrentInstrBlock();
        App.CurrentGraph.removeAllSprites();
        
        App.CurrentGraph.createMainSprite();
        
        App.CurrentGraph.recursiveRender();
    },
    
    enableSupervisor: function() {
        var inp = document.querySelector('.menu-item__checkbox.supervisor'),
            checked = inp.checked,
            transform = {};
            
        checked = !checked;
        inp.checked = checked;
        
        Ui.supervisorOption.classList.toggle("selected");
        App.Supervisor = checked;
    },
    
    changeInstrument: function(e){
        Ui.resetHover();
        Data.Request.onXHRChanged();
        
        Ui.clearSprites();
        App.CurrentGraph.IsStartValueNotReceiced = true;
        
        console.log(App.LastInstr, e)
        if(Ui.lastPressedBtn.instrument !== null){
            Ui.lastPressedBtn.instrument.classList.remove('selected');
        }
        if(App.LastInstr !== null){
            App.LastInstr.classList.remove('selected');
        }
        App.LastInstr = e.target;
        
        if(App.CurrentGraph.CurType === 'footprint'){
            Ui.clearCountnerForFootprintGraph();
        }
        else if(App.CurrentGraph.CurType === 'delta'){
            Ui.clearCountnerForDeltaGraph();
        }
        
        Data.Cache.Candles.splice(0, Data.Cache.Candles.length);
        App.CurrentGraph.CandleSprite.splice(0, App.CurrentGraph.CandleSprite.length);
        if(App.CurrentGraph.CurType === 'ordertape'){
            App.CurrentGraph.GraphSettings.START_OX_POINT = Data.RightOrderCandle.id - App.CurrentGraph.FirstIdOrder;
            App.CurrentGraph.GraphSettings.setStartPointOnNull();
        }
        App.CurrentGraph.GraphSettings.START_OX_POINT = 2*App.CurrentGraph.GraphSettings.FIXED_TIME_STEP;
        e.target.classList.add('selected');
        App.CurrentGraph.FlagForStartPrice = true;
        App.CurrentGraph.FlagForStartPriceF = true;
        Data.LeftFootprintTs = 0;
        App.changeInstrument(e.target);
        App.CurrentGraph.GraphSettings.setInstrument();
        Ui.setCurrentInstrBlock();
        App.CurrentGraph.recursiveRender();
    },
    
    changeGraphType: function(e){
        Ui.resetHover();
        clearTimeout(Graph.Timer);
        
        Ui.clearSprites();
        
        if(App.CurrentGraph.CurType === 'footprint'){
            Ui.clearCountnerForFootprintGraph();
        }
        else if(App.CurrentGraph.CurType === 'delta'){
            Ui.clearCountnerForDeltaGraph();
        }
        Data.Request.onXHRChanged();
        
        App.CurrentGraph.FlagForStartPrice = true;
        if(e.target.innerText === 'DELTA') {
            Ui.MarketProf.classList.remove('hide_modal');
            Ui.FormInput.Main.classList.add('hide_modal');
            Ui.typeOfGraphStruct.footprint.classList.add("hide_modal");
            Ui.typeOfGraphStruct.deltaGraph.classList.remove('hide_modal');
            Ui.typeOfGraphStruct.footprintBtn.classList.remove('selected');
            Ui.typeOfGraphStruct.deltaGraphBtn.classList.add('selected');
            Ui.typeOfGraphStruct.orderBtn.classList.remove('selected');
            Ui.indicatorsBtn.classList.remove('hide_modal');         
            
        }
        else if(e.target.innerText === 'FOOTPRINT') {
            Ui.MarketProf.classList.remove('hide_modal');
            Ui.FormInput.Main.classList.add('hide_modal');
            Ui.typeOfGraphStruct.footprint.classList.remove("hide_modal");
            Ui.typeOfGraphStruct.deltaGraph.classList.add('hide_modal');
            Ui.typeOfGraphStruct.footprintBtn.classList.add('selected');
            Ui.typeOfGraphStruct.deltaGraphBtn.classList.remove('selected');
            Ui.typeOfGraphStruct.orderBtn.classList.remove('selected');
            Ui.indicatorsBtn.classList.remove('hide_modal');    
            if(Ui.lastPressedBtn.timeframe !== null){
                Ui.lastPressedBtn.timeframe.classList.remove('selected');
                Ui.lastPressedBtn.timeframe = document.getElementById('M1');
                Ui.lastPressedBtn.timeframe.classList.add('selected');
                
            }      
        }
        else if(e.target.innerText === 'ORDER TAPE') {
            Ui.MarketProf.classList.add('hide_modal');
            Ui.FormInput.Main.classList.remove('hide_modal');
            Ui.typeOfGraphStruct.footprint.classList.add("hide_modal");
            Ui.typeOfGraphStruct.deltaGraph.classList.add('hide_modal');
            Ui.typeOfGraphStruct.footprintBtn.classList.remove('selected');
            Ui.typeOfGraphStruct.deltaGraphBtn.classList.remove('selected');
            Ui.typeOfGraphStruct.orderBtn.classList.add('selected');
            Ui.indicatorsBtn.classList.add('hide_modal');                
        }
        App.init(e.target.innerText, App.CurrentGraph.INSTRUMENT);
    },
    
    clearSprites: function() {
        var cg = App.CurrentGraph;
        
        cg.Indicators.splice(0, cg.Indicators.length);
        cg.IsVolumeIndicatorCreate = false;
        cg.IsOrderIndicatorCreate = false;
        cg.IsDeltaIndicatorCreate = false;
        cg.VisibleCandles = cg.VisibleCandles.splice(0, cg.VisibleCandles.length);
        cg.Sprites.splice(0, cg.Sprites.length);
        cg.DaySprites.splice(0, cg.DaySprites.length);
        cg.Days.splice(0, cg.Days.length);
    },
    
    clearCountnerForDeltaGraph: function(){
        Data.RightDeltaCandle.ts = -1;
        Data.RightDeltaCandle.index = -9;
        Data.LeftDeltaCandle.ts = -1;
        Data.LeftDeltaCandle.index = -9;
    },
    
    clearCountnerForFootprintGraph: function(){
        Data.RightFootprintCandle.ts = -1;
        Data.RightFootprintCandle.index = -9;
        Data.LeftFootprintCandle.ts = -1;
        Data.LeftFootprintCandle.index = -9;
    },
    
    onModal: function(e){
        Ui.parentModal.classList.add('hide_modal');
    },
    
    onIndicators: function(e) {
        App.CurrentGraph.createIndicator(e.target.innerText);    
    },
    
    updateVisualSettings: function() {
        App.FootprintVisualSettings.setVisualSettings({
            DIR_PLUS: Ui.visualSettingsBtns.colorPlusFootprint.value,
            DIR_PLUS_LIGHT: App.CurrentGraph.VisualSettings.hexToRGBA(Ui.visualSettingsBtns.colorPlusFootprint.value),//"#A8FFBF",
            DIR_0: "#BBB",
            DIR_MINUS: Ui.visualSettingsBtns.colorMinusFootprint.value,
            DIR_MINUS_LIGHT: App.CurrentGraph.VisualSettings.hexToRGBA(Ui.visualSettingsBtns.colorMinusFootprint.value),//"#FF9EAC",
            DIR_CANDLE_OUTLINE: Ui.visualSettingsBtns.colorCandleOutlineFootprint.value,
            DIR_BG: Ui.visualSettingsBtns.colorBGFootprint.value,
            DIR_GRID: Ui.visualSettingsBtns.colorGridFootprint.value,
            DIR_TEXT:  Ui.visualSettingsBtns.colorTextFootprint.value,
            DIR_SPRITES: Ui.visualSettingsBtns.colorSpritesFootprint.value,
            DIR_TIME_FILL: Ui.visualSettingsBtns.colorTimeFillFootprint.value,
            DIR_TIME_TEXT: Ui.visualSettingsBtns.colorTimeTextFootprint.value,
            DIR_PRICE_FILL: Ui.visualSettingsBtns.colorPriceFillFootprint.value,
            DIR_PRICE_TEXT: Ui.visualSettingsBtns.colorPriceTextFootprint.value,
            DIR_INDICATOR_TEXT: Ui.visualSettingsBtns.colorIndicatorTextFootprint.value,
            DIR_INDICATOR_PRICE_FILL: Ui.visualSettingsBtns.colorIndicatorPriceFillFootprint.value,
            DIR_INDICATOR_CLOSE_BTN: Ui.visualSettingsBtns.colorIndicatorCloseBtnFootprint.value,
            DIR_INDICATOR_FILL: Ui.visualSettingsBtns.colorIndicatorFillFootprint.value,
            
            DIR_VERTICAL_LINE_END_DAY: Ui.visualSettingsBtns.colorEndOfDay.value,
            DIR_VERTICAL_LINE_END_MONTH: Ui.visualSettingsBtns.colorEndOfMonth.value,
            DIR_VERTICAL_LINE_LAST_PRICE: Ui.visualSettingsBtns.colorLastPrice.value
        });
        
        
        App.DeltaVisualSettings.setVisualSettings({
            DIR_PLUS: Ui.visualSettingsBtns.colorPlusDelta.value,
            DIR_PLUS_LIGHT: App.CurrentGraph.VisualSettings.hexToRGBA(Ui.visualSettingsBtns.colorPlusDelta.value),//"#A8FFBF",
            DIR_0: "#BBB",
            DIR_MINUS: Ui.visualSettingsBtns.colorMinusDelta.value,
            DIR_MINUS_LIGHT: App.CurrentGraph.VisualSettings.hexToRGBA(Ui.visualSettingsBtns.colorMinusDelta.value),//"#FF9EAC",
            DIR_CANDLE_OUTLINE: Ui.visualSettingsBtns.colorCandleOutlineDelta.value,
            DIR_BG: Ui.visualSettingsBtns.colorBGDelta.value,
            DIR_GRID: Ui.visualSettingsBtns.colorGridDelta.value,
            DIR_TEXT:  Ui.visualSettingsBtns.colorTextDelta.value,
            DIR_SPRITES: Ui.visualSettingsBtns.colorSpritesDelta.value,
            DIR_TIME_FILL: Ui.visualSettingsBtns.colorTimeFillDelta.value,
            DIR_TIME_TEXT: Ui.visualSettingsBtns.colorTimeTextDelta.value,
            DIR_PRICE_FILL: Ui.visualSettingsBtns.colorPriceFillDelta.value,
            DIR_PRICE_TEXT: Ui.visualSettingsBtns.colorPriceTextDelta.value,
            DIR_INDICATOR_TEXT: Ui.visualSettingsBtns.colorIndicatorTextDelta.value,
            DIR_INDICATOR_PRICE_FILL: Ui.visualSettingsBtns.colorIndicatorPriceFillDelta.value,
            DIR_INDICATOR_CLOSE_BTN: Ui.visualSettingsBtns.colorIndicatorCloseBtnDelta.value,
            DIR_INDICATOR_FILL: Ui.visualSettingsBtns.colorIndicatorFillDelta.value,
            
            DIR_VERTICAL_LINE_END_DAY: Ui.visualSettingsBtns.colorEndOfDay.value,
            DIR_VERTICAL_LINE_END_MONTH: Ui.visualSettingsBtns.colorEndOfMonth.value,
            DIR_VERTICAL_LINE_LAST_PRICE: Ui.visualSettingsBtns.colorLastPrice.value
        });
        
        App.OrderVisualSettings.setVisualSettings({
            DIR_PLUS: Ui.visualSettingsBtns.colorPlusOrder.value,
            DIR_PLUS_LIGHT: App.CurrentGraph.VisualSettings.hexToRGBA(Ui.visualSettingsBtns.colorPlusOrder.value),//"#A8FFBF",
            DIR_0: "#BBB",
            DIR_MINUS: Ui.visualSettingsBtns.colorMinusOrder.value,
            DIR_MINUS_LIGHT: App.CurrentGraph.VisualSettings.hexToRGBA(Ui.visualSettingsBtns.colorMinusOrder.value),//"#FF9EAC",
            DIR_CANDLE_OUTLINE: Ui.visualSettingsBtns.colorCandleOutlineOrder.value,
            DIR_BG: Ui.visualSettingsBtns.colorBGOrder.value,
            DIR_GRID: Ui.visualSettingsBtns.colorGridOrder.value,
            DIR_TEXT:  Ui.visualSettingsBtns.colorTextOrder.value,
            DIR_SPRITES: Ui.visualSettingsBtns.colorSpritesOrder.value,
            DIR_TIME_FILL: Ui.visualSettingsBtns.colorTimeFillOrder.value,
            DIR_TIME_TEXT: Ui.visualSettingsBtns.colorTimeTextOrder.value,
            DIR_PRICE_FILL: Ui.visualSettingsBtns.colorPriceFillOrder.value,
            DIR_PRICE_TEXT: Ui.visualSettingsBtns.colorPriceTextOrder.value,
            
            DIR_VERTICAL_LINE_END_DAY: Ui.visualSettingsBtns.colorEndOfDay.value,
            DIR_VERTICAL_LINE_END_MONTH: Ui.visualSettingsBtns.colorEndOfMonth.value,
            DIR_VERTICAL_LINE_LAST_PRICE: Ui.visualSettingsBtns.colorLastPrice.value
        });
    },
    
    onVisualSettingsModal: function(e){
        switch(e.target.id){
            case 'default':
                Ui.getVisualSettingsDefault();
                break;
            case 'ok': 
               Ui.updateVisualSettings();
                
                Data.LocalStorage.save("DeltaVisualSettings", App.DeltaVisualSettings);
                Data.LocalStorage.save("FootprintVisualSettings", App.FootprintVisualSettings);
                Data.LocalStorage.save("OrderVisualSettings", App.OrderVisualSettings);

                Ui.parentModal.classList.toggle('hide_modal');
                App.CurrentGraph.recursiveRender();
                
                break;
            case 'cansel':
                Ui.setVisualSettingsColor();
                Ui.parentModal.classList.toggle('hide_modal');
                break;
        }
        e.stopPropagation();
    },
    
    setVisualSettingsColor: function(){
        try{
            currentDeltaVisualSettings = Data.LocalStorage.get("DeltaVisualSettings");
            currentFootprintVisualSettings = Data.LocalStorage.get("FootprintVisualSettings");
            currentOrderVisualSettings = Data.LocalStorage.get("OrderVisualSettings");
            
            if (currentDeltaVisualSettings && currentFootprintVisualSettings && currentOrderVisualSettings) {
                Ui.visualSettingsBtns.colorSpritesFootprint.value = currentFootprintVisualSettings.DIR_SPRITES;
                Ui.visualSettingsBtns.colorCandleOutlineFootprint.value = currentFootprintVisualSettings.DIR_CANDLE_OUTLINE;
                Ui.visualSettingsBtns.colorPlusFootprint.value = currentFootprintVisualSettings.DIR_PLUS;
                Ui.visualSettingsBtns.colorMinusFootprint.value = currentFootprintVisualSettings.DIR_MINUS;
                Ui.visualSettingsBtns.colorBGFootprint.value = currentFootprintVisualSettings.DIR_BG;
                Ui.visualSettingsBtns.colorGridFootprint.value = currentFootprintVisualSettings.DIR_GRID;
                Ui.visualSettingsBtns.colorTextFootprint.value = currentFootprintVisualSettings.DIR_TEXT;
                Ui.visualSettingsBtns.colorTimeFillFootprint.value = currentFootprintVisualSettings.DIR_TIME_FILL;
                Ui.visualSettingsBtns.colorTimeTextFootprint.value = currentFootprintVisualSettings.DIR_TIME_TEXT;
                Ui.visualSettingsBtns.colorPriceFillFootprint.value = currentFootprintVisualSettings.DIR_PRICE_FILL;
                Ui.visualSettingsBtns.colorPriceTextFootprint.value = currentFootprintVisualSettings.DIR_PRICE_TEXT;
                Ui.visualSettingsBtns.colorIndicatorTextFootprint.value = currentFootprintVisualSettings.DIR_INDICATOR_TEXT;
                Ui.visualSettingsBtns.colorIndicatorPriceFillFootprint.value = currentFootprintVisualSettings.DIR_INDICATOR_PRICE_FILL;
                Ui.visualSettingsBtns.colorIndicatorCloseBtnFootprint.value = currentFootprintVisualSettings.DIR_INDICATOR_CLOSE_BTN;
                Ui.visualSettingsBtns.colorIndicatorFillFootprint.value = currentFootprintVisualSettings.DIR_INDICATOR_FILL;
            
                Ui.visualSettingsBtns.colorSpritesDelta.value = currentDeltaVisualSettings.DIR_SPRITES;
                Ui.visualSettingsBtns.colorCandleOutlineDelta.value = currentDeltaVisualSettings.DIR_CANDLE_OUTLINE;
                Ui.visualSettingsBtns.colorPlusDelta.value = currentDeltaVisualSettings.DIR_PLUS;
                Ui.visualSettingsBtns.colorMinusDelta.value = currentDeltaVisualSettings.DIR_MINUS;
                Ui.visualSettingsBtns.colorBGDelta.value = currentDeltaVisualSettings.DIR_BG;
                Ui.visualSettingsBtns.colorGridDelta.value = currentDeltaVisualSettings.DIR_GRID;
                Ui.visualSettingsBtns.colorTextDelta.value = currentDeltaVisualSettings.DIR_TEXT;
                Ui.visualSettingsBtns.colorTimeFillDelta.value = currentDeltaVisualSettings.DIR_TIME_FILL;
                Ui.visualSettingsBtns.colorTimeTextDelta.value = currentDeltaVisualSettings.DIR_TIME_TEXT;
                Ui.visualSettingsBtns.colorPriceFillDelta.value = currentDeltaVisualSettings.DIR_PRICE_FILL;
                Ui.visualSettingsBtns.colorPriceTextDelta.value = currentDeltaVisualSettings.DIR_PRICE_TEXT;
                Ui.visualSettingsBtns.colorIndicatorTextDelta.value = currentDeltaVisualSettings.DIR_INDICATOR_TEXT;
                Ui.visualSettingsBtns.colorIndicatorPriceFillDelta.value = currentDeltaVisualSettings.DIR_INDICATOR_PRICE_FILL;
                Ui.visualSettingsBtns.colorIndicatorCloseBtnDelta.value = currentDeltaVisualSettings.DIR_INDICATOR_CLOSE_BTN;
                Ui.visualSettingsBtns.colorIndicatorFillDelta.value = currentDeltaVisualSettings.DIR_INDICATOR_FILL;
                
                Ui.visualSettingsBtns.colorSpritesOrder.value = currentOrderVisualSettings.DIR_SPRITES;
                Ui.visualSettingsBtns.colorCandleOutlineOrder.value = currentOrderVisualSettings.DIR_CANDLE_OUTLINE;
                Ui.visualSettingsBtns.colorPlusOrder.value = currentOrderVisualSettings.DIR_PLUS;
                Ui.visualSettingsBtns.colorMinusOrder.value = currentOrderVisualSettings.DIR_MINUS;
                Ui.visualSettingsBtns.colorBGOrder.value = currentOrderVisualSettings.DIR_BG;
                Ui.visualSettingsBtns.colorGridOrder.value = currentOrderVisualSettings.DIR_GRID;
                Ui.visualSettingsBtns.colorTextOrder.value = currentOrderVisualSettings.DIR_TEXT;
                Ui.visualSettingsBtns.colorTimeFillOrder.value = currentOrderVisualSettings.DIR_TIME_FILL;
                Ui.visualSettingsBtns.colorTimeTextOrder.value = currentOrderVisualSettings.DIR_TIME_TEXT;
                Ui.visualSettingsBtns.colorPriceFillOrder.value = currentOrderVisualSettings.DIR_PRICE_FILL;
                Ui.visualSettingsBtns.colorPriceTextOrder.value = currentOrderVisualSettings.DIR_PRICE_TEXT;
                
                Ui.visualSettingsBtns.colorEndOfDay.value = currentFootprintVisualSettings.DIR_VERTICAL_LINE_END_DAY;
                Ui.visualSettingsBtns.colorEndOfMonth.value = currentFootprintVisualSettings.DIR_VERTICAL_LINE_END_MONTH;
                Ui.visualSettingsBtns.colorLastPrice.value = currentFootprintVisualSettings.DIR_VERTICAL_LINE_LAST_PRICE;
               
                this.updateVisualSettings();
                
            } else {
                this.getVisualSettingsDefault();
            }
        }
        catch(err){
            console.error(err);
        }
    },
    
    getVisualSettingsDefault: function(){
        
        Ui.visualSettingsBtns.colorEndOfDay.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_VERTICAL_LINE_END_DAY;
        Ui.visualSettingsBtns.colorEndOfMonth.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_VERTICAL_LINE_END_MONTH;
        Ui.visualSettingsBtns.colorLastPrice.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_VERTICAL_LINE_LAST_PRICE;
        
        Ui.visualSettingsBtns.colorSpritesFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_SPRITES;
        Ui.visualSettingsBtns.colorCandleOutlineFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_CANDLE_OUTLINE;
        Ui.visualSettingsBtns.colorPlusFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_PLUS;
        Ui.visualSettingsBtns.colorMinusFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_MINUS;
        Ui.visualSettingsBtns.colorBGFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_BG;
        Ui.visualSettingsBtns.colorGridFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_GRID;
        Ui.visualSettingsBtns.colorTextFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_TEXT;
        Ui.visualSettingsBtns.colorTimeFillFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_TIME_FILL;
        Ui.visualSettingsBtns.colorTimeTextFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_TIME_TEXT;
        Ui.visualSettingsBtns.colorPriceFillFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_PRICE_FILL;
        Ui.visualSettingsBtns.colorPriceTextFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_PRICE_TEXT;
        Ui.visualSettingsBtns.colorIndicatorTextFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_TEXT;
        Ui.visualSettingsBtns.colorIndicatorPriceFillFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_PRICE_FILL;
        Ui.visualSettingsBtns.colorIndicatorCloseBtnFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_CLOSE_BTN;
        Ui.visualSettingsBtns.colorIndicatorFillFootprint.value = App.FootprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_FILL;
        
        App.FootprintVisualSettings.setVisualSettings();
        
        Ui.visualSettingsBtns.colorSpritesDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_SPRITES;
        Ui.visualSettingsBtns.colorCandleOutlineDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_CANDLE_OUTLINE;
        Ui.visualSettingsBtns.colorPlusDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_PLUS;
        Ui.visualSettingsBtns.colorMinusDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_MINUS;
        Ui.visualSettingsBtns.colorBGDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_BG;
        Ui.visualSettingsBtns.colorGridDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_GRID;
        Ui.visualSettingsBtns.colorTextDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_TEXT;
        Ui.visualSettingsBtns.colorTimeFillDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_TIME_FILL;
        Ui.visualSettingsBtns.colorTimeTextDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_TIME_TEXT;
        Ui.visualSettingsBtns.colorPriceFillDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_PRICE_FILL;
        Ui.visualSettingsBtns.colorPriceTextDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_PRICE_TEXT;
        Ui.visualSettingsBtns.colorIndicatorTextDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_TEXT;
        Ui.visualSettingsBtns.colorIndicatorPriceFillDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_PRICE_FILL;
        Ui.visualSettingsBtns.colorIndicatorCloseBtnDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_CLOSE_BTN;
        Ui.visualSettingsBtns.colorIndicatorFillDelta.value = App.DeltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_FILL;
        
        App.DeltaVisualSettings.setVisualSettings();
        
        Ui.visualSettingsBtns.colorSpritesOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_SPRITES;
        Ui.visualSettingsBtns.colorCandleOutlineOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_CANDLE_OUTLINE;
        Ui.visualSettingsBtns.colorPlusOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_PLUS;
        Ui.visualSettingsBtns.colorMinusOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_MINUS;
        Ui.visualSettingsBtns.colorBGOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_BG;
        Ui.visualSettingsBtns.colorGridOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_GRID;
        Ui.visualSettingsBtns.colorTextOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_TEXT;
        Ui.visualSettingsBtns.colorTimeFillOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_TIME_FILL;
        Ui.visualSettingsBtns.colorTimeTextOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_TIME_TEXT;
        Ui.visualSettingsBtns.colorPriceFillOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_PRICE_FILL;
        Ui.visualSettingsBtns.colorPriceTextOrder.value = App.OrderVisualSettings.defaultVisualSettings.DIR_PRICE_TEXT;
        
        App.OrderVisualSettings.setVisualSettings();
    },
    
    onMenu: function(e){
        Ui.parentModal.classList.add('hide_modal');
        
        if (e.target.id != App.BtnZoomIn.id && e.target.id != App.BtnZoomOut.id && e.target.id != Ui.supervisorOption.id) {
            // console.log(e.target.id)
            Ui.menu.classList.toggle('active');
        }
    },
    
    onGraph: function() {
        Ui.menu.classList.remove('active');
    },
    
    onAbout: function(){
        Ui.resetHover();
        
    },
    
    resetHover: function(){
        Ui.menu.classList.add('hide_modal');
        setTimeout(function(){
             Ui.menu.classList.remove('hide_modal');
        }, 200);
    },
    
    setCurrentInstrBlock: function() {
        var type = (App.CurrentGraph.type === 'FOOTPRINT') ? App.CurrentGraph.TIMEFRAME.val : App.CurrentGraph.DELTA;
        if(App.CurrentGraph.type === 'ORDER TAPE'){
            this.CurrentInstrBlock.innerText = 'BWScharts: ' + App.CurrentGraph.INSTRUMENT;
        }
        else{
            this.CurrentInstrBlock.innerText = 'BWScharts: ' + App.CurrentGraph.INSTRUMENT + '-' + type;
        }
    }
};