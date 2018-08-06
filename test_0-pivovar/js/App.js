var App = {

    currentPlatform: 0,
    
    TimezoneOffset: 0,
    
    IsFirstLaunch: true,

    supervisor: false,

    deltaVisualSettings: null,
    
    footprintVisualSettings: null,
    
    orderVisualSettings: null,

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
            rounding: 4
        }
    },
    
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
            timePerPx: 720000//540000
        }
    },
    
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
    
    GraphType: {
        FOOTPRINT: 'FOOTPRINT',
        DELTA: 'DELTA'
    },

    CurrentGraph: null,
    
    canvas: null,
    
    btnZoomIn: null,

    btnZoomOut: null, 
    
    clickForEvent: false,
    
    flag: true,
    
    LoadGif: null,
    
    changeInstrument: function(instrument){
        console.log('изменение инструмента');
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
    
    changeTimeframeSettings: function(timeframe){
        console.log('изменение таймфрейма');
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
    
    changeDeltaSettings: function(delta){
        console.log('изменение дельта');
        switch(1 * delta.innerText){
            case App.Delta.Hundred.val : App.CurrentGraph.setDelta(App.Delta.Hundred.val); break;
            case App.Delta.ThreeHundred.val : App.CurrentGraph.setDelta(App.Delta.ThreeHundred.val); break;
            case App.Delta.FiveHundred.val : App.CurrentGraph.setDelta(App.Delta.FiveHundred.val); break;
            case App.Delta.Thunded.val : App.CurrentGraph.setDelta(App.Delta.Thunded.val); break;
        }
    },
    
    findLastUsedInstrument: function(instr){
        console.warn(typeof(instr));
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

    init: function(graphType, instrument){
        if(App.IsFirstLaunch){
            App.currentPlatform = (navigator.userAgent.indexOf('Mobile') > 0) ? 'Mobile' : 'PC';
            App.TimezoneOffset = new Date().getTimezoneOffset()*60*1000;
            console.log('currentPlatform = ' + App.currentPlatform);
            console.log('currentTimezoneOffset = ' + App.TimezoneOffset + '(' + (App.TimezoneOffset/60/60/1000) + 'ч)')
            App.LoadGif = document.getElementById('gifbox');
            App.btnZoomIn = document.getElementById('zoom-in');
            App.btnZoomOut = document.getElementById('zoom-out');
            App.IsFirstLaunch = false;
            
            App.footprintVisualSettings = new VisualSettings();
            App.deltaVisualSettings = new VisualSettings();
            App.orderVisualSettings = new VisualSettings();
            
            App.utill = new Utill;
        }
        
        instrument = (instrument !== undefined) ? App.findLastUsedInstrument(instrument) : App.Instrument.EUR;
        console.log('insrument = ', instrument.name);
        console.log(graphType);
        Data.Request.onXHRChanged();
        
        if(App.GraphType.FOOTPRINT == graphType){
            App.CurrentGraph = new FootPrintGraph();
            App.CurrentGraph.setTimeframe(App.Timeframe.M1);
        }else{
            App.CurrentGraph = new DeltaGraph();
            App.CurrentGraph.setDelta(App.Delta.Hundred.val);
        }
        
        App.CurrentGraph.setInstrument(instrument);
        this.canvas = document.getElementsByTagName("canvas")[0];
        App.CurrentGraph.init(this.canvas, function(){
             Ui.init();
        });
        if(this.flag){
            this.addEventListeners();
            this.flag = false;
        }
    },
    
    addEventListeners: function(){
        window.addEventListener('resize', function(){
            App.CurrentGraph.onResize();
        }.bind(App.CurrentGraph));
        
        window.addEventListener('keydown', function (e) {
            App.CurrentGraph.dragByButtons(e);
        }.bind(App.CurrentGraph));
        
        this.canvas.addEventListener('mouseup', function (e) {
            App.CurrentGraph.onUp(e);
        }.bind(App.CurrentGraph));
        
        this.canvas.addEventListener('mousedown', function (e) {
            if(App.currentPlatform === 'PC'){
                App.CurrentGraph.createSprite(e);
                App.CurrentGraph.onDown(e);
            }
            App.CurrentGraph.findAxes();
        }.bind(App.CurrentGraph));
        
        this.canvas.addEventListener('mousemove', function (e) {
            App.CurrentGraph.onMove(e);
        }.bind(App.CurrentGraph));
        
        this.canvas.addEventListener('wheel', function (e) {
            App.CurrentGraph.onZoom(e);
        }.bind(App.CurrentGraph));
        
        this.btnZoomIn.addEventListener('mousedown', function (e) {
            App.CurrentGraph.zoomIn(4, {});
        }.bind(App.CurrentGraph));
        
        this.btnZoomOut.addEventListener('mousedown', function (e) {
            App.CurrentGraph.zoomOut(4, {});
        }.bind(App.CurrentGraph));
        
        this.canvas.addEventListener('touchstart', function(e){
            if(App.clickForEvent){
                App.CurrentGraph.createSprite(e);
                this.clickForEvent = false;
            }
            App.CurrentGraph.onDown(e);
        }.bind(App.CurrentGraph)); //тык пальцем по экрану
        
        this.canvas.addEventListener('touchend', function(e){
            App.CurrentGraph.onUp(e);
        }.bind(App.CurrentGraph)); //отрыв пальчика от экрана
        
        this.canvas.addEventListener('touchmove', function(e){
            App.CurrentGraph.onMove(e); 
        }.bind(App.CurrentGraph)); //движение пальчиком по экрану
    }
};

window.onload = function(){
    try{
        App.init(App.GraphType.FOOTPRINT);
    }catch(e){
        alert('init problem');
        console.error(e);
    }
}