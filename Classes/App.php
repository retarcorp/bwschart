<?php

namespace Classes;

class App{
    
    
    const TF_M1 = "M1";
    const TF_M2 = "M2";
    const TF_M5 = "M5";
    const TF_M10 = "M10";
    const TF_M15 = "M15";
    const TF_M30 = "M30";
    const TF_H1 = "H1";
    const TF_H4 = "H4";
    const TF_D1 = "D1";
    
    const INSTRUMENT_OIL = "OIL";
    
    const PRICE_STEP = 0.00005;
    
    # @Deprecated Use Tick::ASK Instead!
    const TICK_BUY = 1;
    const TICK_ASK = 1;

    # @Deprecated Use Tick::BID Instead!
    const TICK_SELL = 2;
    const TICK_BID = 2;

    public static $Timeframe = [
            "M1"=>1
            ,"M2"=>2
            ,"M5"=>5
            ,"M10"=>10
            ,"M15"=>15
            ,"M20"=>20
            ,"M30"=>30
            ,"H1"=>60
            ,"H4"=>240      //60*4
            ,"D1"=>1440     //60*24
        ];
    
}