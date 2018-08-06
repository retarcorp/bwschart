<?php
    require_once $_SERVER['DOCUMENT_ROOT']."/modules/auth.php";
?>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta name=viewport content="width=device-width, initial-scale=1">
    <title>is:BWScharts</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/App.js?v=4"></script>
    <script src="js/Data.js?v=4"></script>
    <!--<script src="js/Graph.js?v=3"></script>-->
    <script src="js/Ui.js?v=4"></script>
    <script src="js/Chart.js?v=4"></script>
    <script src="js/Sprites.js?v=4"></script>
    <script src="js/Indicator.js?v=4"></script>
    <script src="js/Order.js?v=4"></script>
    <script src="js/Delta.js?v=4"></script>
    <script src='js/Footprint.js?v=4'></script>
    <script src='js/Core/retarcore.js?v=4'></script>
    <script src='js/VisualSettings.js?v=4'></script>
    <!--<script src='js/Core/CandleFixer.js?v=4'></script>-->
</head>
<body>
    
<div class="menu-settings back">
<ul class="menu top">
    <li class="menu-item background-icon params">
    </li>
    <li class="menu-item background-icon clock">
    </li>
    <li class="menu-item background-icon clock hide_modal">
    </li>
    <li class="menu-item background-icon tools">
    </li>
    <li class="menu-item background-icon eye">
    </li>
    <li class="menu-item background-icon note">
    </li>
    <!--<li class="menu-item background-icon info">-->
    <!--</li>-->
    <!--<li class="menu-item background-icon exit">
    </li>-->
</ul>
<ul class="menu bottom">
    <li class="menu-item background-icon plus">
    </li>
    <li class="menu-item background-icon minus">
    </li>
</ul>
</div>

<div class="menu-settings" id='menu-settings'>
<ul class="menu top">
    <li class="menu-item background-icon params">
        <p class="menu-text">Выбор инструмента</p>
        <ul class="inner-menu" id="instrument">
            <li class="selected" id="EUR">6E</li>
            <li>6B</li>
            <li>6J</li>
            <li>6S</li>
            <li>6A</li>
            <li>6N</li>
            <li>6C</li>
            <li>GC</li>
            <li>CL</li>
        </ul>
    </li>
    <li class="menu-item background-icon clock" id="footprint">
        <p class="menu-text">Выбор таймфрейма</p>
        <ul class="inner-menu" id="timeframe">
            <li class="selected" id="M1">M1</li>
            <li>M5</li>
            <li>M10</li>
            <li>M15</li>
            <li>M30</li>
            <li>H1</li>
            <li>H4</li>
            <li>D1</li>
        </ul>
    </li>
    <li class="menu-item background-icon clock hide_modal" id='deltaGraph'>
        <p class='menu-text'>Выбор дельта</p>
        <ul class='inner-menu' id='delta'>
            <li class='selected' id='hundred'>100</li>
            <li>300</li>
            <li>500</li>
            <li>1000</li>
        </ul>
    </li>
    <li class="menu-item background-icon tools">
        <p class="menu-text">Выбор типа графика</p>
        <ul class="inner-menu" id="tools">
            <li class="selected" id="FOOTPRINT">FOOTPRINT</li>
            <li id="DELTA">DELTA</li>
            <li id="ORDERTAPE">ORDER TAPE</li>
        </ul>
    </li>
    <li class="menu-item background-icon eye" id="visual_settings">
       <p class="menu-text">Визуальные настройки</p>
    </li>
    <li class="menu-item background-icon note" id="sprites">
        <p class="menu-text">Графические элементы</p>
        <ul class="inner-menu" id="graphical_elem">
            <li id="horizontal-line">Горизонтальная линия</li>
            <li id="vertical-line">Вертикальная линия</li>
            <li id="rectangle">Прямоугольник</li>
            <li id="market-profile">Профиль рынка</li>
            <!--li class="use" id="move">Переместить</li-->
            <li class="use" id="remove">Удалить</li>
            <li class="use" id="remove_all">Очистить всё</li>
        </ul>
    </li>
    <li class="menu-item background-icon info" id="indicators">
        <p class="menu-text">Индикаторы</p>
        <ul class="inner-menu" id="indcator-elems">
            <li id="volume">Volume</li>
            <li id="Delta">Delta</li>
        </ul>
    </li>
    <li class="menu-item background-icon watch" id="supervisor">
        <p class="menu-text">Автослежение</p>
        <input class="menu-item__checkbox supervisor" type="checkbox">
    </li>
    <li class="menu-item background-icon exit" id="exit">
        <a href="logout"><p class="menu-text">Выход</p></a>
    </li>
    <!--<li class="menu-item background-icon info">-->
    <!--    <p class="menu-text" id='about'>О программе</p>-->
    <!--</li>-->
</ul>
<ul class="menu bottom">
    <li class="menu-item background-icon plus" id="zoom-in">
        <p class="menu-text">Увеличить</p>
    </li>
    <li class="menu-item background-icon minus" id="zoom-out">
        <p class="menu-text">Уменьшить</p>
    </li>
</ul>
</div>

<div class="graph">
    <canvas id="cnv" height="100px" width="100px"></canvas>
</div>
<div class="parent_modal hide_modal" id="parent_modal">
    <div class="visual_settings_menu"  id="visual_settings-modal">
            <div class="container__info">
                <div class="container__info_item">
                    <div class="menu_info">
                    Визуальные настройки
                    </div>
                </div>
            </div>
            <div class="container__param">
                
                <p>Общие настройки</p>
                
                <div class="container__item">
                    <div class="text_box">Цвет линии конца дня</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-end-of-day'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет линии конца месяца</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-end-of-month'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет линии последней цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-last-price'></div>
                </div>
                
                <p>Footprint</p>
                
                <div class="container__item">
                    <div class="text_box">Цвет обводки элементов свечи</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-candle-outline-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет графических элементов</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-sprites-footprint'></div>
                </div>
                <!--div class="container__item">
                    <div class="text_box">Цвет положительной свечи (main)</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-plus'></div>
                </div-->
                <div class="container__item">
                    <div class="text_box">Цвет положительной свечи</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-plus-footprint'></div>
                </div>
                <!--div class="container__item">
                    <div class="text_box">Цвет отрицательной свечи (main)</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-minus'></div>
                </div-->
                <div class="container__item">
                    <div class="text_box">Цвет отрицательной свечи</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-minus-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-background-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет сетки</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-grid-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-text-footprint'></div>
                </div>
                
                <!--NEW-->
                <div class="container__item">
                    <div class="text_box">Фон шкалы времени</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-time_fill-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста времени</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-time_text-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Фон шкалы цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-price_fill-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-price_text-footprint'></div>
                </div>
                
                <div class="container__item">
                    <div class="text_box">Цвет текста индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator_text-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона шкалы цены индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator-price_fill-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет кнопки закрытия индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator-close-btn-footprint'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator_fill-footprint'></div>
                </div>
                <!--NEW-->
                
                
                <br>
                
                <p>Delta</p>

                <div class="container__item">
                    <div class="text_box">Цвет обводки элементов свечи</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-candle-outline-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет графических элементов</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-sprites-delta'></div>
                </div>
                <!--div class="container__item">
                    <div class="text_box">Цвет положительной свечи (main)</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-plus'></div>
                </div-->
                <div class="container__item">
                    <div class="text_box">Цвет положительной свечи</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-plus-delta'></div>
                </div>
                <!--div class="container__item">
                    <div class="text_box">Цвет отрицательной свечи (main)</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-minus'></div>
                </div-->
                <div class="container__item">
                    <div class="text_box">Цвет отрицательной свечи</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-minus-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-background-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет сетки</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-grid-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-text-delta'></div>
                </div>
                
                <!--NEW-->
                <div class="container__item">
                    <div class="text_box">Фон шкалы времени</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-time_fill-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста времени</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-time_text-delta'></div>
                </div>
                
                <div class="container__item">
                    <div class="text_box">Фон шкалы цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-price_fill-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-price_text-delta'></div>
                </div>
                
                <div class="container__item">
                    <div class="text_box">Цвет текста индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator_text-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона шкалы цены индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator-price_fill-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет кнопки закрытия индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator-close-btn-delta'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона индикатора</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-indicator_fill-delta'></div>
                </div>
                <!--NEW-->
                
                <br>
                
                <p>Order tape</p>

                <div class="container__item hide_modal">
                    <div class="text_box">Цвет обводки столбика</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-candle-outline-order'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет графических элементов</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-sprites-order'></div>
                </div>
                <!--div class="container__item">
                    <div class="text_box">Цвет положительной свечи (main)</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-plus'></div>
                </div-->
                <div class="container__item">
                    <div class="text_box">Цвет положительного столбика</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-plus-order'></div>
                </div>
                <!--div class="container__item">
                    <div class="text_box">Цвет отрицательной свечи (main)</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-minus'></div>
                </div-->
                <div class="container__item">
                    <div class="text_box">Цвет отрицательного столбика</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-minus-order'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет фона</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-background-order'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет сетки</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-grid-order'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-text-order'></div>
                </div>
                
                <!--NEW-->
                <div class="container__item">
                    <div class="text_box">Фон шкалы времени</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-time_fill-order'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста времени</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-time_text-order'></div>
                </div>
                
                <div class="container__item">
                    <div class="text_box">Фон шкалы цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-price_fill-order'></div>
                </div>
                <div class="container__item">
                    <div class="text_box">Цвет текста цены</div>
                    <div class="color_box"><input class="input-color" type="color" id='color-price_text-order'></div>
                </div>
                
                
            </div>
            <div class="container__aftertabs">
                <div class="button">
                    <div class="left-btn">
                        <div class="default-btn btn" id='default'>По умолчанию</div>
                    </div>
                    <div class="right-btn">
                        <div class="ok-btn btn" id='ok'>Ок</div>
                        <div class="cancel-btn btn" id="cansel">Отмена</div>
                    </div>
                </div>
            </div>
    </div>
</div>

<div id="current-instr" class="current-instr">
    BWScharts:
</div>

<div class='parent_modal hide_modal' id='aboutModal'></div>

<div class="help_bar" id="help_bar">
    <div class="help_bar_text hide_modal" id="help_text">
        
    </div>
    <!--<div class="btn" id="close">-->
        
    <!--</div>-->
    <!--<div class="btn" id="do_not_show_againe">-->
        
    <!--</div>-->
</div>

<div class="cls"></div>

<div id="helpler" class="helpler hide_modal"></div>

<div id='gifbox' class='load-gif'>
    <img height="20px" id='loadgif' src="/icon/load.gif">
</div>


<div id="form-imput" class="order-form hide_modal">
    от <input min="0" id="form-imput-one" value='0' class="form-imput" type="number"> до <input min="0" id="form-imput-two" value='0' class="form-imput" type="number"> <div id="form-btn" class="form-btn">принять</div>
</div>

<!-- BEGIN JIVOSITE CODE {literal} -->
<!-- <script type='text/javascript'>
(function(){ var widget_id = 'L7yI0KSIcx';var d=document;var w=window;function l(){
var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);}if(d.readyState=='complete'){l();}else{if(w.attachEvent){w.attachEvent('onload',l);}else{w.addEventListener('load',l,false);}}})();</script> -->
<!-- {/literal} END JIVOSITE CODE 
 -->

</body>
</html>
