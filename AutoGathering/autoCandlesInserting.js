var App = {
    
    instruments: ['6A','6B','6C','6E','6J','6N','6S','CL','GC'],
    timeframes: ["M1", "M2", "M5", "M10", "M15", "M30", "H1", "H4", "D1"]
    ,tfSecsCorrespondence: [60, 120, 300, 600, 900, 1200, 1800, 3600, 14400, 86400] // timeframes in secs
    ,tfAmountCorrespondence: [720, 360, 144, 72, 48, 36, 24, 12, 3, 1] // half day for all instruments, except the last one
    
    ,startTS: null
    ,endTS: null
    ,from: null
    
    ,startGathering: function(){
        App.makeRequest( App.getFirstInstrument(), App.getFirstTimeframe() );
    }
    
    ,getFirstInstrument: function(){
        return App.instruments[0];
    }
    
    ,getNextInstrument: function(instrument){
        var index = App.instruments.indexOf(instrument);
        return App.instruments[++index];
    }
    
    ,getFirstTimeframe: function(){
        return App.timeframes[0];
    }
    
    ,getNextTimeframe: function(tf){
        var index = App.timeframes.indexOf(tf);
        return App.timeframes[++index];
    }
    
    ,makeRequest: function(instrument, timeframe){
        var index = App.timeframes.indexOf(timeframe);
        var secs = App.tfSecsCorrespondence[index];
        var amount = App.tfAmountCorrespondence[index];
        
        if(App.endTS === null){
            var now = Date.now();
            App.endTS = Math.floor(now / 1000);
            App.from = (new Date("2018-02-13 00:00:00")).getTime() / 1000; 
        }else{
            App.endTS = App.startTS;
        }
        
        App.startTS = App.endTS - secs * amount;
        
        if(App.startTS >= App.from){
            var path = "/api/candles/?" + 
                    "start=" + App.startTS + 
                    "&end=" + App.endTS + 
                    "&timeframe=" + timeframe 
                    + "&instrument=" + instrument;
                    
            App.get(path, function(data){
                // console.log(data)
                setTimeout(function(){
                    App.makeRequest(instrument, timeframe);
                    // var ended = Date.now();
                    // if( (ended - started) / 1000 > 5 ){
                    //     console.warn(`The request lasted more than 5 seconds. Catched hole in instrument ${instrument} and timeframe ${timeframe} for interval ${started} - ${ended}.`);
                    // }
                }, 300);
            });
        }else{
            var nextTF = App.getNextTimeframe(timeframe);
            console.log("End of gathering candles for instrument " + instrument + " and timeframe " + timeframe);
            
            if(nextTF){
                App.endTS = null;
                App.makeRequest(instrument, nextTF);
            }else{
                var nextInstrument = App.getNextInstrument(instrument);
                
                if(nextInstrument){
                    var first = App.getFirstTimeframe();
                    App.makeRequest(nextInstrument, first);
                }else{
                    console.warn("End of gathering");
                }
            }
            
        }
    }
    
    ,get: function(path, f){
        var xhr = new XMLHttpRequest();
        xhr.open("GET", path, true);
        xhr.onload = function(){
            f(this.responseText);
        }
        
        if( xhr.getResponseHeader('BWSCache') == "False" ){
            console.log("Catched not cached interval")
        }
        
        xhr.onerror = function(e){
            console.error(e);
        }
        
        xhr.send(null);
    }
    
}

App.startGathering();
