var App = {

    CurrentPlatform: 0, // текущая платформа (PC or Mobile)
    
    TimezoneOffset: 0, // смещение временной зоны
    
    IsFirstLaunch: true, // флаг первого запуска приложения
    
    Supervisor: false, // флаг активации автоотслеживания
    
    // хранят визуальные настройки трех графиков
    DeltaVisualSettings: null, 
    FootprintVisualSettings: null,
    OrderVisualSettings: null,
    
    LastInstr: null, // последний использованный инструмент

    // данные для каждого инструмента
    Instrument: {
        EUR: {
            name: '6E',
            step: 0.00005,
            pricePerPx: 0.000002,
            rounding: 5
        },
        GBR: {
            name: '6B',
            step: 0.0001,
            pricePerPx: 0.000004,
            rounding: 4
        },
        JPY: {
            name: '6J',
            step: 0.0000005,
            pricePerPx: 0.00000002,
            rounding: 7
        },
        CHF: {
            name: '6S',
            step: 0.0001,
            pricePerPx: 0.000004,
            rounding: 4
        },
        AUD: {
            name: '6A',
            step: 0.0001,
            pricePerPx: 0.000004,
            rounding: 4
        },
        NZD: {
            name: '6N',
            step: 0.0001,
            pricePerPx: 0.000004,
            rounding: 4
        },
        CAD: {
            name: '6C',
            step: 0.00005,
            pricePerPx: 0.000002,
            rounding: 5
        },
        GOLD: {
            name: 'GC',
            step: 0.1,
            pricePerPx: 0.004,
            rounding: 1
        },
        OIL: {
            name: 'CL',
            step: 0.01,
            pricePerPx: 0.0004,
            rounding: 2
        }
    }, 
    
    // данные для каждого таймфрейма
    Timeframe: {
        M1: {
            val: 'M1',
            ts: 60000,
            timePerPx: 500
        },
        M5: {
            val: 'M5',
            ts: 300000,
            timePerPx: 2500
        },
        M10: {
            val: 'M10',
            ts: 600000,
            timePerPx: 5000
        },
        M15: {
            val: 'M15',
            ts: 900000,
            timePerPx: 7500
        },
        M30: {
            val: 'M30',
            ts: 1800000,
            timePerPx: 15000
        },
        H1: {
            val: 'H1',
            ts: 3600000,
            timePerPx: 30000
        },
        H4: {
            val: 'H4',
            ts: 14400000,
            timePerPx: 120000
        },
        D1:{
            val: 'D1',
            ts: 86400000,
            timePerPx: 720000
        }
    }, 
    
    // данные для каждой дельты
    Delta: {
        Hundred: {
            val: 100
        },
        
        ThreeHundred: {
            val: 300
        },
        
        FiveHundred: {
            val: 500
        },
        
        Thunded: {
            val: 1000
        }
    }, 
    
    // константы типов графика
    GraphType: { 
        FOOTPRINT: 'FOOTPRINT',
        DELTA: 'DELTA',
        ORDER: 'ORDER TAPE'
    }, 

    CurrentGraph: null, // объект текущего графика
    
    Canvas: null, // хранит DOM элемент холста
    
    // DOM элементы кнопок приблизить и отдалить
    BtnZoomIn: null,
    BtnZoomOut: null, 
    
    ClickForEvent: false, // флаг обработки действий на touchstart
    
    LoadGif: null, // хранит gif-картинку значка загрузки
    
    // изменяет инструмент на переданный
    changeInstrument: function(instrument){
        Ui.lastPressedBtn.instrument = instrument;
        switch(instrument.innerText){
            case App.Instrument.EUR.name: App.CurrentGraph.setInstrument(App.Instrument.EUR); break;
            case App.Instrument.GBR.name: App.CurrentGraph.setInstrument(App.Instrument.GBR); break;
            case App.Instrument.JPY.name: App.CurrentGraph.setInstrument(App.Instrument.JPY); break;
            case App.Instrument.CHF.name: App.CurrentGraph.setInstrument(App.Instrument.CHF); break;
            case App.Instrument.AUD.name: App.CurrentGraph.setInstrument(App.Instrument.AUD); break;
            case App.Instrument.NZD.name: App.CurrentGraph.setInstrument(App.Instrument.NZD); break;
            case App.Instrument.CAD.name: App.CurrentGraph.setInstrument(App.Instrument.CAD); break;
            case App.Instrument.GOLD.name: App.CurrentGraph.setInstrument(App.Instrument.GOLD); break;
            case App.Instrument.OIL.name: App.CurrentGraph.setInstrument(App.Instrument.OIL); break;
        }
    },
    
    // изменяет таймфрейм на переданный
    changeTimeframeSettings: function(timeframe){
        Ui.lastPressedBtn.timeframe = timeframe;
        switch(timeframe.innerText) {
            case App.Timeframe.M1.val: App.CurrentGraph.setTimeframe(App.Timeframe.M1); break;
            case App.Timeframe.M5.val: App.CurrentGraph.setTimeframe(App.Timeframe.M5); break;
            case App.Timeframe.M10.val: App.CurrentGraph.setTimeframe(App.Timeframe.M10); break;
            case App.Timeframe.M15.val: App.CurrentGraph.setTimeframe(App.Timeframe.M15); break;
            case App.Timeframe.M30.val: App.CurrentGraph.setTimeframe(App.Timeframe.M30); break;
            case App.Timeframe.H1.val: App.CurrentGraph.setTimeframe(App.Timeframe.H1); break;
            case App.Timeframe.H4.val: App.CurrentGraph.setTimeframe(App.Timeframe.H4); break;
            case App.Timeframe.D1.val: App.CurrentGraph.setTimeframe(App.Timeframe.D1); break;
        }
    }, 
    
    // изменяет дельту на переданную
    changeDeltaSettings: function(delta){
        switch(1 * delta.innerText){
            case App.Delta.Hundred.val : App.CurrentGraph.setDelta(App.Delta.Hundred.val); break;
            case App.Delta.ThreeHundred.val : App.CurrentGraph.setDelta(App.Delta.ThreeHundred.val); break;
            case App.Delta.FiveHundred.val : App.CurrentGraph.setDelta(App.Delta.FiveHundred.val); break;
            case App.Delta.Thunded.val : App.CurrentGraph.setDelta(App.Delta.Thunded.val); break;
        }
    },
    
    // изменяет последний использованный инструмент на переданный
    findLastUsedInstrument: function(instr){
        switch(instr){
            case App.Instrument.EUR.name: return App.Instrument.EUR;
            case App.Instrument.GBR.name: return App.Instrument.GBR;
            case App.Instrument.JPY.name: return App.Instrument.JPY;
            case App.Instrument.CHF.name: return App.Instrument.CHF;
            case App.Instrument.AUD.name: return App.Instrument.AUD;
            case App.Instrument.NZD.name: return App.Instrument.NZD;
            case App.Instrument.CAD.name: return App.Instrument.CAD;
            case App.Instrument.GOLD.name: return App.Instrument.GOLD;
            case App.Instrument.OIL.name: return App.Instrument.OIL;
        }
    },

    // инициализация приложения
    init: function(graphType, instrument){
        if(App.IsFirstLaunch){
            App.CurrentPlatform = (navigator.userAgent.indexOf('Mobile') > 0) ? 'Mobile' : 'PC';
            App.TimezoneOffset = new Date().getTimezoneOffset()*60000;
            App.LoadGif = document.getElementById('gifbox');
            App.BtnZoomIn = document.getElementById('zoom-in');
            App.BtnZoomOut = document.getElementById('zoom-out');
            App.FootprintVisualSettings = new VisualSettings();
            App.DeltaVisualSettings = new VisualSettings();
            App.OrderVisualSettings = new VisualSettings();
        }
        
        instrument = (instrument !== undefined) ? App.findLastUsedInstrument(instrument) : App.Instrument.EUR;
        Data.Request.onXHRChanged();
        
        if(App.GraphType.FOOTPRINT == graphType){
            App.CurrentGraph = new FootPrintGraph();
            App.CurrentGraph.setTimeframe(App.Timeframe.M1);
        }else if(App.GraphType.DELTA === graphType){
            App.CurrentGraph = new DeltaGraph();
            App.CurrentGraph.setDelta(App.Delta.Hundred.val);
        }else if(App.GraphType.ORDER === graphType) {
            App.CurrentGraph = new OrderTape();
        }
        
        App.CurrentGraph.setInstrument(instrument);
        this.Canvas = document.getElementsByTagName("canvas")[0];
        App.CurrentGraph.init(this.Canvas, function(){
             Ui.init();
        });
        if(App.IsFirstLaunch){
            this.addEventListeners();
            App.IsFirstLaunch = false;
        }
    },
    
    // добавляет обработчики событий на DOM элементы
    addEventListeners: function(){
        // изменение размеров рабочего пространства
        window.addEventListener('resize', function(){
            App.CurrentGraph.onResize();
        });
        
        // нажатие на клавишу клавиатуры
        window.addEventListener('keydown', function (e) {
            App.CurrentGraph.dragByButtons(e);
        });
        
        // нажатие на ЛКМ на холсте
        this.Canvas.addEventListener('mousedown', function (e) {
            if(App.CurrentPlatform === 'PC'){
                App.CurrentGraph.createSprite(e);
                App.CurrentGraph.onDown(e);
            }
            App.CurrentGraph.findAxes();
        });
        
        // отжатие клавиши ЛКМ на холсте
        this.Canvas.addEventListener('mouseup', function (e) {
            App.CurrentGraph.onUp(e);
        });
        
        // движение мыши на холсте
        this.Canvas.addEventListener('mousemove', function (e) {
            App.CurrentGraph.onMove(e);
        });
        
        // прокрутка колесом на холсте
        this.Canvas.addEventListener('wheel', function (e) {
            App.CurrentGraph.onZoom(e);
        });
        
        // нажатие на ЛКМ на кнопке приближения
        this.BtnZoomIn.addEventListener('mousedown', function (e) {
            App.CurrentGraph.zoomIn(4, {});
        });
        
        // нажатие на ЛКМ на кнопке отдаления
        this.BtnZoomOut.addEventListener('mousedown', function (e) {
            App.CurrentGraph.zoomOut(4, {});
            e.stopPropagation;
        });
        
        // нажатие пальцем на холст
        this.Canvas.addEventListener('touchstart', function(e){
            if(App.ClickForEvent){
                App.CurrentGraph.createSprite(e);
                this.ClickForEvent = false;
            }
            App.CurrentGraph.onDown(e);
        }.bind(App.CurrentGraph)); 
        
        // отжатие пальца от холст
        this.Canvas.addEventListener('touchend', function(e){
            App.CurrentGraph.onUp(e);
        }); 
        
        // движение пальцем по холсту
        this.Canvas.addEventListener('touchmove', function(e){
            App.CurrentGraph.onMove(e); 
        }); 
    }
};

// обработка события загрузки страницы с последуещей активацией приложения
window.onload = function(){
    try{
        // Test.init();
        App.init(App.GraphType.FOOTPRINT, '6E');
    }catch(e){
        console.error(e);
    }
}