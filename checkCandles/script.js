window.onload = function() {
    Test.init();
};

Test = {
    
    xhr: null,
    
    resMas: [],
    
    InstrMas: ['6E', '6B', '6J','6S','6A','6N','6C','GC','CL'],
    
    TFMas: ['M1', 'M5', 'M10', 'M15', 'M30', 'H1', 'H4', 'D1'],

    Instrument: {
        EUR: '6E',
        GBR: '6B',
        JPY: '6J',
        CHF: '6S',
        AUD: '6A',
        NZD: '6N',
        CAD: '6C',
        GOLD: 'GC',
        OIL: 'CL',
    },
    
    TF: {
      M1: 'M1',
      M5: 'M5',
      M10: 'M10',
      M15: 'M15',
      M30: 'M30',
      H1: 'H1',
      H4: 'H4',
      D1: 'D1',
    },
    
    init: function() {
        // for(var i = 0; i < 9; i++) {
        //     for(var j = 0; j < 8; j++) {
        //         var tf = this.TFMas[j],
        //             instr = this.InstrMas[i];
        //         var url = "/api/candles/cached/?instrument=" + instr + '&timeframe=' + tf;
        //         this.get(url, instr, tf);
        //     }
        // }
        var i = 0, j = 0;
        // console.log(i, j)
        var t = this;
        var tf = this.TFMas[j],
            instr = this.InstrMas[i];
        var url = "/api/candles/cached/?instrument=" + instr + '&timeframe=' + tf;
        this.get(url, instr, tf, function() {
            t.getdata(0, 1);
        });
        
    },
    
    getdata: function(i, j) {
        // console.log(i, j)
        
        console.log(i,j);
        
        var t = this;
        if(j == 8) {
            i++;
            j = 0;
        }
        if(i < 9){
            var tf = t.TFMas[j],
                instr = t.InstrMas[i];
            var url = "/api/candles/cached/?instrument=" + instr + '&timeframe=' + tf;
            t.get(url, instr, tf, function() {
                t.getdata(i, ++j);
                
            });
        }
    },
    
    get: function(url, instr, tf, f) {
        this.xhr = new XMLHttpRequest();
        var xhr = this.xhr;
        xhr.open('GET', url);
        xhr.send();
        var t = this;
        xhr.onload = function () {
            if (xhr.status === 200) {
                // f();
                t.parse(xhr.response, instr, tf, f);
            } else {
                alert( xhr.status + ': ' + xhr.statusText );
            }
        };
        xhr.onerror = function () {
            alert( xhr.status + ': ' + xhr.statusText );
        };
    },
    
    parse: function(resp, instr, tf, f) {
        var arrId = [];
        var arrTs = [];
        resp = resp.slice(5, resp.length);
        var arr = resp.split('\n');
        var l = arr.length;
        for(var i = 0; i < l; i++){ 
            var el = arr[i].split(',');
            // console.log(el);
            if(el[0].length !== 0){
                arrId.push(el[0]);
                arrTs.push(el[1]);
            }
        }
        var res = new Result(instr, tf, arrId, arrTs);
        
        //console.log(res);
        this.resMas.push(res);
        this.show(res, f);
        
        
    },
    
    show: function(res, f) {
        var l = res.arrayId.length,
            csvList = "",
            csvArr = "";
        
        var tsv = 1 * Timeframe.getTimeframe(res.Timeframe).ts / 1000;
        document.body.innerText += 'Instrument = ' + res.Instrument + ' :: ';
        document.body.innerText += ' Timeframe = ' + res.Timeframe + ' :: ' + tsv + '\n';
        document.body.innerText += ' start = ' + res.arrayTs[0] + ' :: ' + 'last = ' + res.arrayTs[l-1] + '\n';
        var str = '';
        // for(var i = 0; i < l - 1; i++){
        //     var p = 1 * res.arrayTs[i],
        //         c = 1 * res.arrayTs[i+1];
        //     if((c - p) !== tsv) {
        //         // str += '\n' + res.arrayId[i] + ', ' + res.arrayTs[i] + ', ' + (c-p) + '-\n';
        //         var pr = p + tsv,
        //             cr = c - tsv;
                    
        //         while(pr <= cr) {
        //             pr *= 1;
        //             str += pr + '\n'
        //             pr +=  tsv;
        //         }
        //         // str += '\n';
        //         // str += res.arrayId[i+1] + ', ' + res.arrayTs[i+1] + ', ' + (c-p) + '-\n';
        //     }
        // }
        //console.log(f);
        
        //var out = res.arrayTs.join(','+res.Instrument+','+res.Timeframe+'\n') + "," + res.Instrument + "," + res.Timeframe + '\n';
        // var buf = 0,
        //     k = 0;
        
        // console.log()
        var arrList = '';

        for (let i = 1; i<= l-1; i++) {
            
            arrList += res.arrayTs[i-1] + ',' +  res.Instrument + ',' + res.Timeframe + '\n';
            
            if (parseInt(res.arrayTs[i]) - tsv != parseInt(res.arrayTs[i-1])) {
                
                buf = parseInt(res.arrayTs[i-1]) + tsv;
                csvList += buf + '\n'; // + ',' +  res.Instrument + ',' + res.Timeframe + '\n' ;
                
                while (buf + tsv < parseInt(res.arrayTs[i])) {
                    buf += tsv;
                    csvList += buf + '\n'; // + ',' +  res.Instrument + ',' + res.Timeframe + '\n' ;
                }
                
            }
        }

        
        
        console.log(csvList, tsv)
        
        //console.log(out);
        document.body.innerText += str + '_______________________________\n\n';
        
        f();
    },
    
    send: function(){
        
    }
};

var Result = function(instrument, timeframe, arrId, arrTs){
    this.Instrument = instrument;
    this.Timeframe = timeframe;
    this.arrayId = arrId;
    this.arrayTs = arrTs;
};

Result.prototype.constructor = Result;

var Timeframe = {
    getTimeframe: function(timeframe) {
        var reg = /\D+/ig,
            width = 120,
            value = timeframe,
            timePerSec = 0,
            timePerPX = 0;
        timeframe = timeframe.replace(reg, '');
        
        var isMin = 60 * 1000,
            isHour = 60 * isMin,
            isDay = 24 * isHour;
        
        switch(value[0]) {
            case 'M': timePerSec = isMin; break;
            case 'H': timePerSec = isHour; break;
            case 'D': timePerSec = isDay; break;
        }
        
        timePerSec *= timeframe;
        timePerPX = timePerSec / width;
        
        var ret = {
            val: value,
            ts: timePerSec,
            timePerPx: timePerPX
        };
        return ret;
    }
};








