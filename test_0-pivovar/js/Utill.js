var Utill = function() {
    this.fetchCandle = false;
    
    this.utillLocal = {
        fetchFlag: document.querySelector('.utill__checkbox'),
        timeToJump: document.querySelector('.utill__input-text'),
        btnJump: document.querySelector('.utill__button.jumpTo'),
        btnQuite: document.querySelector('.utill__button.quite')
    };
    
    this.utillLocal.fetchFlag.addEventListener('change', this.changeUtill);
    this.utillLocal.btnJump.addEventListener('click', this.jumpTo);
}

Utill.prototype = {
    findCandle: function(type) {
        var rez = null;
        
        switch (type) {
            case 'delta':
                rez = this.findDeltaCandle();
                break;
            case 'footprint':
                rez = this.findFootprintCandle();
                break;
            default: 
                console.log('Invalid graph type.');
                return null;
        }
        
        return rez;
    },
    
    findDeltaCandle: function() {
        var gs = App.CurrentGraph.GraphSettings,
            gp = App.CurrentGraph,
            tsX = gp.cordForVerticalLine,
            ret = null;
        
        Data.Cache.Candles.forEach( function(elem) {
            
            if (gp.IsZoomBorderCrossing || gp.IS_TIME_ZOOM_BORDER) {
                if (Math.round(tsX/gs.FIXED_TIME_STEP) == elem.index) {
                    ret = elem;
                    elem.time = gs.tsToTime(elem.startTS);
                    console.info("Time: %s", gs.tsToTime(elem.startTS), "Candle: ", elem);
                    return;
                }
                
            } else {
                if (tsX/gs.FIXED_TIME_STEP - 0.5 == elem.index) {
                    ret = elem;
                    elem.time = gs.tsToTime(elem.startTS);
                    console.info("Time: %s", gs.tsToTime(elem.startTS), "Candle: ", elem);
                    return;
                }
            }
        });
        
        return ret;
    },
    
    findFootprintCandle: function() {
        var gs = App.CurrentGraph.GraphSettings,
            gp = App.CurrentGraph,
            tsX = gp.cordForVerticalLine,
            pow = gp.TIMEFRAME.ts,
            ret = null;
            
            Data.Cache.Candles.forEach( function(elem) {
                if (gp.IsZoomBorderCrossing || gp.IS_TIME_ZOOM_BORDER) {
                    if (elem.from == Math.round(tsX/pow)*pow) {
                        ret = elem;
                        elem.time = gs.tsToTime(elem.from);
                        console.info("Time: %s", gs.tsToTime(elem.from), "Candle: ", elem);
                        return;
                    }
                        
                } else {
                    if (elem.from == Math.round(tsX/pow)*pow - pow) {
                        ret =  elem;
                        elem.time = gs.tsToTime(elem.from);
                        console.info("Time: %s", gs.tsToTime(elem.from), "Candle: ", elem);
                        return;
                    }
                }
            });
  
        return ret;
    },
    
    changeUtill: function() {
        App.utill.fetchCandle = this.checked;  
    },
    
    jumpTo: function() {
        var val = App.utill.utillLocal.timeToJump.value,
            type = App.CurrentGraph.type,
            gs = App.CurrentGraph.GraphSettings,
            time = "",
            day = "",
            hours = 0,
            minutes = 0,
            seconds = 0,
            days = 0,
            months = 0,
            years = 0,
            fullDate = "",
            rez = "";
        
        if (type = 'footprint') {
            if (val.length) {
                if (val.indexOf('/') != -1) {
                    time = val.slice(0, val.indexOf('/'));
                    date = val.slice(val.indexOf('/') + 1); 
                    
                    fullDate = date+"T"+time;
                    
                    gs.START_TS = new Date(fullDate).getTime();
                    
                    console.log(new Date(fullDate), fullDate);
                } else {
                    var date = new Date(),
                        adderM = (date.getMonth() < 11) ? "0" : "",
                        adderD = (date.getDate() < 10) ? "0" : "";
                    
                    fullDate = `${date.getFullYear()}-${adderM}${date.getMonth()+1}-${adderD}${date.getDate()}T${val}`;
                    
                    console.log(new Date(fullDate).getTime())
                    
                    gs.START_TS = new Date(fullDate).getTime();
                    
                    console.log(new Date(fullDate).getTime());
                }
                
            } else {
                console.warn('Empty field!');
            }
        }
            
        
    }
    
}