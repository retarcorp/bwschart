var Ui = {
    
    parentModal: null,
    
    visualSettingsModal: null,
    
    visualSettingsBtn: null, //кнопка меню
    
    timeframeSettingsBtn: null,
    
    deltaSettingsBtn: null,
    
    instrumentBtn: null,
    
    graphTypeBtn: null,
    
    spritesBtn: null,
    
    indicatorsBtn: null,
    
    menu:null,
    
    innerMenu: null,
    
    helpler: null,
    
    visualSettingsBtns: null, //инпуты модального окна
    
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
        
        // this.clickEvent = new Event('touchstart');
        
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
            // console.warn(typeof target);
            // console.log((target === '' || target === 'sprites' || target === 'move'))
            if(target === '' || target === 'sprites' || target === 'move'){
                // console.log("Ошибка природы")
            }
            else {
                // console.error("Начинаем")
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
                    this.help_bar.text_box.innerText = (App.currentPlatform === 'PC') ? 'Для создания прямоугольника нажмите и потяните на графике с одного угла, до другого.' : 'Для создания прямоугольника кликните первый раз для установки первой точки грани прямоугольника и второй раз для установки диаметрально-противоположной точки грани.';
                    break;
                case 'market-profile':
                    this.help_bar.text_box.innerText = (App.currentPlatform === 'PC') ? 'Для создания прямоугольника нажмите и потяните на графике с одного угла, до другого.' : 'Для создания прямоугольника кликните первый раз для установки первой точки грани прямоугольника и второй раз для установки диаметрально-противоположной точки грани.';
                    break;
                case 'move': 
                    break;
                case 'remove': 
                    this.help_bar.text_box.innerText = 'Для удаления элемента кликните на него(удалится последний добавленный элемент в области клика).';
                    break;
            }
        }
        else {
            // console.error("Завершаем")
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
        App.CurrentGraph.GraphSettings.START_OX_POINT = Data.rightOrderCandle.id - App.CurrentGraph.FirstIdOrder;
        App.CurrentGraph.GraphSettings.setStartPointOnNull();
        
        Data.FlagForOrderChange = true;
        App.CurrentGraph.flagForStartPrice = true;
        
        App.CurrentGraph.recursiveRender();
    },
    
    drawSprite: function(target){
        if(Data.Cache.Candles.length !== 0){
        if(target !== 'sprites'){
            Ui.resetHover();
            App.clickForEvent = true;
            App.CurrentGraph.spritesEdditor = true; // = (!App.CurrentGraph.spritesEdditor) ? true : false;
            App.CurrentGraph.currentSprite = target;
            if(target === 'rectangle'){
                console.log(1)
                App.clickForEvent = true;
            }
            if(target === 'market-profile'){
                console.log(2)
                App.clickForEvent = true;
            }
            if(target === 'remove_all'){
                App.CurrentGraph.removeAllSprites();
            }
            else {
                this.addHelpBar(App.CurrentGraph.currentSprite, true);
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
        e.target.classList.add('selected');
        App.changeTimeframeSettings(e.target);
        App.CurrentGraph.flagForStartPrice = true;
        App.CurrentGraph.GraphSettings.setTimeFrame();
        App.CurrentGraph.GraphSettings.START_TS = Date.now() + App.CurrentGraph.GraphSettings.TIMEFRAME_TS - 7200000;
        Ui.setCurrentInstrBlock();
        App.CurrentGraph.removeAllSprites();
        App.CurrentGraph.recursiveRender();
    },
    
    enableSupervisor: function() {
        var inp = document.querySelector('.menu-item__checkbox.supervisor'),
            checked = inp.checked,
            transform = {};
            
        checked = !checked;
        inp.checked = checked;
        
        Ui.supervisorOption.classList.toggle("selected");
        
        App.supervisor = checked;
    },
    
    changeDelta: function(e){
        Ui.resetHover();
        Data.Request.onXHRChanged();
        if(Ui.lastPressedBtn.delta !== null){
            Ui.lastPressedBtn.delta.classList.remove('selected');
        }
        e.target.classList.add('selected');
        Ui.lastPressedBtn.delta = e.target;
        
        Ui.clearCountnerForDeltaGraph();
        
        App.CurrentGraph.flagForStartPrice = true;
        App.changeDeltaSettings(e.target);
        App.CurrentGraph.GraphSettings.setDelta();
        Ui.setCurrentInstrBlock();
        App.CurrentGraph.recursiveRender();
    },
    
    changeInstrument: function(e){
        Ui.resetHover();
        Data.Request.onXHRChanged();
        
        // Data.LastValue = null;
        App.CurrentGraph.IsStartValueNotReceiced = true;
        
        console.log(App.lastInstr, e)
        if(Ui.lastPressedBtn.instrument !== null){
            Ui.lastPressedBtn.instrument.classList.remove('selected');
        }
        if(App.lastInstr !== null){
            App.lastInstr.classList.remove('selected');
        }
        App.lastInstr = e.target;
        
        Ui.clearCountnerForDeltaGraph();
        
        //add
        Data.Cache.Candles.splice(0, Data.Cache.Candles.length);
        App.CurrentGraph.CandleSprite.splice(0, App.CurrentGraph.CandleSprite.length);
        if(App.CurrentGraph.CurType === 'ordertape'){
            App.CurrentGraph.GraphSettings.START_OX_POINT = Data.rightOrderCandle.id - App.CurrentGraph.FirstIdOrder;
            App.CurrentGraph.GraphSettings.setStartPointOnNull();
        }
        //endadd
        e.target.classList.add('selected');
        App.CurrentGraph.flagForStartPrice = true;
        App.changeInstrument(e.target);
        App.CurrentGraph.GraphSettings.setInstrument();
        Ui.setCurrentInstrBlock();
        App.CurrentGraph.recursiveRender();
    },
    
    changeGraphType: function(e){
        Ui.resetHover();
        App.CurrentGraph.Indicators.splice(0, App.CurrentGraph.Indicators.length);
        App.CurrentGraph.sprites.splice(0, App.CurrentGraph.sprites.length);
        
        Ui.clearCountnerForDeltaGraph();
        Data.Request.onXHRChanged();
        
        App.CurrentGraph.flagForStartPrice = true;
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
        console.log(e.target.innerText)
        App.init(e.target.innerText, App.CurrentGraph.INSTRUMENT);
    },
    
    clearCountnerForDeltaGraph: function(){
        Data.rightDeltaCandle.ts = -1;
        Data.rightDeltaCandle.index = -9;
        Data.leftDeltaCandle.ts = -1;
        Data.leftDeltaCandle.index = -9;
    },
    
    onModal: function(e){
        Ui.parentModal.classList.add('hide_modal');
    },
    
    onIndicators: function(e) {
        App.CurrentGraph.createIndicator(e.target.innerText);    
    },
    
    updateVisualSettings: function() {
        App.footprintVisualSettings.setVisualSettings({
            DIR_PLUS: Ui.visualSettingsBtns.colorPlusFootprint.value,
            DIR_PLUS_LIGHT: "#A8FFBF",
            DIR_0: "#BBB",
            DIR_MINUS: Ui.visualSettingsBtns.colorMinusFootprint.value,
            DIR_MINUS_LIGHT: "#FF9EAC",
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
        
        
        App.deltaVisualSettings.setVisualSettings({
            DIR_PLUS: Ui.visualSettingsBtns.colorPlusDelta.value,
            DIR_PLUS_LIGHT: "#A8FFBF",
            DIR_0: "#BBB",
            DIR_MINUS: Ui.visualSettingsBtns.colorMinusDelta.value,
            DIR_MINUS_LIGHT: "#FF9EAC",
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
        
        App.orderVisualSettings.setVisualSettings({
            DIR_PLUS: Ui.visualSettingsBtns.colorPlusOrder.value,
            DIR_PLUS_LIGHT: "#A8FFBF",
            DIR_0: "#BBB",
            DIR_MINUS: Ui.visualSettingsBtns.colorMinusOrder.value,
            DIR_MINUS_LIGHT: "#FF9EAC",
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
                // console.log(App.CurrentGraph.visualSettings.defaultVisualSettings);
                Ui.getVisualSettingsDefault();
                break;
            case 'ok': 
               Ui.updateVisualSettings();
                
                Data.LocalStorage.save("deltaVisualSettings", App.deltaVisualSettings);
                Data.LocalStorage.save("footprintVisualSettings", App.footprintVisualSettings);
                Data.LocalStorage.save("orderVisualSettings", App.orderVisualSettings);

                // console.log( App.CurrentGraph.visualSettings);
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
            currentDeltaVisualSettings = Data.LocalStorage.get("deltaVisualSettings");
            currentFootprintVisualSettings = Data.LocalStorage.get("footprintVisualSettings");
            currentOrderVisualSettings = Data.LocalStorage.get("orderVisualSettings");
            
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
        
        Ui.visualSettingsBtns.colorEndOfDay.value = App.footprintVisualSettings.defaultVisualSettings.DIR_VERTICAL_LINE_END_DAY;
        Ui.visualSettingsBtns.colorEndOfMonth.value = App.footprintVisualSettings.defaultVisualSettings.DIR_VERTICAL_LINE_END_MONTH;
        Ui.visualSettingsBtns.colorLastPrice.value = App.footprintVisualSettings.defaultVisualSettings.DIR_VERTICAL_LINE_LAST_PRICE;
        
        Ui.visualSettingsBtns.colorSpritesFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_SPRITES;
        Ui.visualSettingsBtns.colorCandleOutlineFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_CANDLE_OUTLINE;
        Ui.visualSettingsBtns.colorPlusFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_PLUS;
        Ui.visualSettingsBtns.colorMinusFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_MINUS;
        Ui.visualSettingsBtns.colorBGFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_BG;
        Ui.visualSettingsBtns.colorGridFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_GRID;
        Ui.visualSettingsBtns.colorTextFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_TEXT;
        Ui.visualSettingsBtns.colorTimeFillFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_TIME_FILL;
        Ui.visualSettingsBtns.colorTimeTextFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_TIME_TEXT;
        Ui.visualSettingsBtns.colorPriceFillFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_PRICE_FILL;
        Ui.visualSettingsBtns.colorPriceTextFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_PRICE_TEXT;
        Ui.visualSettingsBtns.colorIndicatorTextFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_TEXT;
        Ui.visualSettingsBtns.colorIndicatorPriceFillFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_PRICE_FILL;
        Ui.visualSettingsBtns.colorIndicatorCloseBtnFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_CLOSE_BTN;
        Ui.visualSettingsBtns.colorIndicatorFillFootprint.value = App.footprintVisualSettings.defaultVisualSettings.DIR_INDICATOR_FILL;
        
        App.footprintVisualSettings.setVisualSettings();
        
        Ui.visualSettingsBtns.colorSpritesDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_SPRITES;
        Ui.visualSettingsBtns.colorCandleOutlineDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_CANDLE_OUTLINE;
        Ui.visualSettingsBtns.colorPlusDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_PLUS;
        Ui.visualSettingsBtns.colorMinusDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_MINUS;
        Ui.visualSettingsBtns.colorBGDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_BG;
        Ui.visualSettingsBtns.colorGridDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_GRID;
        Ui.visualSettingsBtns.colorTextDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_TEXT;
        Ui.visualSettingsBtns.colorTimeFillDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_TIME_FILL;
        Ui.visualSettingsBtns.colorTimeTextDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_TIME_TEXT;
        Ui.visualSettingsBtns.colorPriceFillDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_PRICE_FILL;
        Ui.visualSettingsBtns.colorPriceTextDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_PRICE_TEXT;
        Ui.visualSettingsBtns.colorIndicatorTextDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_TEXT;
        Ui.visualSettingsBtns.colorIndicatorPriceFillDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_PRICE_FILL;
        Ui.visualSettingsBtns.colorIndicatorCloseBtnDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_CLOSE_BTN;
        Ui.visualSettingsBtns.colorIndicatorFillDelta.value = App.deltaVisualSettings.defaultVisualSettings.DIR_INDICATOR_FILL;
        
        App.deltaVisualSettings.setVisualSettings();
        
        Ui.visualSettingsBtns.colorSpritesOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_SPRITES;
        Ui.visualSettingsBtns.colorCandleOutlineOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_CANDLE_OUTLINE;
        Ui.visualSettingsBtns.colorPlusOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_PLUS;
        Ui.visualSettingsBtns.colorMinusOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_MINUS;
        Ui.visualSettingsBtns.colorBGOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_BG;
        Ui.visualSettingsBtns.colorGridOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_GRID;
        Ui.visualSettingsBtns.colorTextOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_TEXT;
        Ui.visualSettingsBtns.colorTimeFillOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_TIME_FILL;
        Ui.visualSettingsBtns.colorTimeTextOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_TIME_TEXT;
        Ui.visualSettingsBtns.colorPriceFillOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_PRICE_FILL;
        Ui.visualSettingsBtns.colorPriceTextOrder.value = App.orderVisualSettings.defaultVisualSettings.DIR_PRICE_TEXT;
        
        App.orderVisualSettings.setVisualSettings();
    },
    
    onMenu: function(e){
        Ui.parentModal.classList.add('hide_modal');
        
        if (e.target.id != App.btnZoomIn.id && e.target.id != App.btnZoomOut.id && e.target.id != Ui.supervisorOption.id) {
            console.log(e.target.id)
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
        // console.log('reset');
        Ui.menu.classList.add('hide_modal');
        setTimeout(function(){
             Ui.menu.classList.remove('hide_modal');
        }, 200);
        /*
        [].forEach.call(Ui.innerMenu, function(elem) {
            console.log(elem);
            elem.classList.add('hide');
        });
        setTimeout(function(){
            [].forEach.call(Ui.innerMenu, function(elem) {
                elem.classList.remove('hide');
            });
        }, 1000);*/
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