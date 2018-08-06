var Graph = {
    requestInProcess: false,
    
    timer: null, //флаг состояния отправки запроса для обновления последней цены
};

var VisualSettings = function(){
    this.DIR_PLUS = this.defaultVisualSettings.DIR_PLUS;
    this.DIR_PLUS_LIGHT = this.defaultVisualSettings.DIR_PLUS_LIGHT;
    this.DIR_0 = this.defaultVisualSettings.DIR_0;
    this.DIR_INDICATOR_TEXT = this.defaultVisualSettings.DIR_INDICATOR_TEXT;
    this.DIR_INDICATOR_PRICE_FILL = this.defaultVisualSettings.DIR_INDICATOR_PRICE_FILL;
    this.DIR_INDICATOR_CLOSE_BTN = this.defaultVisualSettings.DIR_INDICATOR_CLOSE_BTN;
    this.DIR_INDICATOR_FILL = this.defaultVisualSettings.DIR_INDICATOR_FILL;
    
    this.DIR_VERTICAL_LINE_END_DAY = this.defaultVisualSettings.DIR_VERTICAL_LINE_END_DAY;
    this.DIR_VERTICAL_LINE_END_MONTH = this.defaultVisualSettings.DIR_VERTICAL_LINE_END_MONTH;
    this.DIR_VERTICAL_LINE_LAST_PRICE = this.defaultVisualSettings.DIR_VERTICAL_LINE_LAST_PRICE;
    
    this.DIR_TIME_FILL = this.defaultVisualSettings.DIR_TIME_FILL;
    this.DIR_TIME_TEXT = this.defaultVisualSettings.DIR_TIME_TEXT;
    this.DIR_PRICE_FILL = this.defaultVisualSettings.DIR_PRICE_FILL;
    this.DIR_PRICE_TEXT = this.defaultVisualSettings.DIR_PRICE_TEXT;
    this.DIR_MINUS = this.defaultVisualSettings.DIR_MINUS;
    this.DIR_MINUS_LIGHT = this.defaultVisualSettings.DIR_MINUS_LIGHT;
    this.DIR_CANDLE_OUTLINE = this.defaultVisualSettings.DIR_CANDLE_OUTLINE;
    this.DIR_BG = this.defaultVisualSettings.DIR_BG;
    this.DIR_GRID = this.defaultVisualSettings.DIR_GRID;
    this.DIR_TEXT = this.defaultVisualSettings.DIR_TEXT;
    this.DIR_SPRITES = this.defaultVisualSettings.DIR_SPRITES;
};

VisualSettings.prototype = {
    constructor: VisualSettings,
    
    defaultVisualSettings: {
        DIR_PLUS: "#00FA43",
        DIR_0: "#999",
        DIR_INDICATOR_TEXT: "#000000",
        DIR_INDICATOR_PRICE_FILL: "#FFFFFF",
        DIR_INDICATOR_CLOSE_BTN: "#000000",
        DIR_INDICATOR_FILL: "#FFFFFF",
        
        DIR_VERTICAL_LINE_END_DAY: "#99AA00",
        DIR_VERTICAL_LINE_END_MONTH: "#FFAA00",
        DIR_VERTICAL_LINE_LAST_PRICE: "#888888",
        
        DIR_TIME_FILL: "#FFFFFF",
        DIR_TIME_TEXT: "#000000",
        DIR_PRICE_FILL: "#FFFFFF",
        DIR_PRICE_TEXT: "#000000",
        DIR_PLUS_LIGHT: "#A8FFBF",
        DIR_MINUS: "#EF0629",
        DIR_MINUS_LIGHT: "#FF9EAC",
        DIR_CANDLE_OUTLINE: "#666666",
        DIR_BG: "#FFFFFF",
        DIR_GRID: "#e3e3e3",
        DIR_TEXT: "#000000",
        DIR_SPRITES: "#000000"
    },
    
    setVisualSettings: function(plus, minus, candle_outline, background, grid, text, sprites){
       if(arguments.length == 0) {
            for (key in this.defaultVisualSettings) {
                this[key] = this.defaultVisualSettings[key];
            }
        }
        
        else if (arguments.length == 1) {
            for (key in arguments[0]) {
                this[key] = arguments[0][key];
            }
            
        } else {
            this.DIR_PLUS = plus;
            this.DIR_PLUS_LIGHT = /*this.RGBAToHex(*/this.hexToRGBA(plus)/*, 'p')*/;
            this.DIR_0 = "#BBB";
            this.DIR_MINUS = minus;
            this.DIR_MINUS_LIGHT = /*this.RGBAToHex(*/this.hexToRGBA(minus)/*, 'm')*/;
            this.DIR_CANDLE_OUTLINE = candle_outline;
            this.DIR_BG = background;
            this.DIR_GRID = grid;
            this.DIR_TEXT = text;
            this.DIR_SPRITES = sprites;
        }
    },
    
    hexToRGBA: function(color){
        var red = parseInt(color.substring(1, 3), 16);
        var green = parseInt(color.substring(3, 5), 16);
        var blue = parseInt(color.substring(5), 16);
        var max = 255;
        var opasity = 0.5;
        
        red = Math.ceil((1 - opasity) * max + opasity * red);
        green = Math.ceil((1 - opasity) * max + opasity * green);
        blue = Math.ceil((1 - opasity) * max + opasity * blue);
                
        var rgb = 'rgb(' + red + ', ' + green + ', ' + blue + ')';
        return rgb;
    },
    
    trim: function(str) {
        return str.replace(/^\s+|\s+$/gm,'');
    }
}