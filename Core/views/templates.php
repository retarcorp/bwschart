<template id='AlertDialog'>
    <div class='AlertDialog Dialog'>
        <div class='wrap'>
            <h3 class='title'>{{title}}</h3>
            <div class='content'>
                <div>{{content}}</div>
                
                <div class='DialogButtons'>
                    <input type='button' class='OkButton popupButton' value='ОК'/>
                </div>
            </div>
        </div>
    </div>
</template>

<template id='PromptDialog'>
    <div class='PromptDialog Dialog'>
        <div class='wrap'>
            <h3 class='title'>{{title}}</h3>
            <div class='content'>
                <div>{{content}}</div>
                <div class='input'><input type='text' value='' id='PromptInput'/></div>
                <div class='DialogButtons'>
                    <input type='button' class='OkButton popupButton' value='ОК'/>
                    <input type='button' class='CancelButton popupButton' value='Отмена'/>
                </div>
            </div>
        </div>
    </div>
</template>

<template id='ConfirmDialog'>
    <div class='ConfirmDialog Dialog'>
        <div class='wrap'>
            <h3 class='title'>{{title}}</h3>
            <div class='content'>
                <div>{{content}}</div>
                <div class='DialogButtons'>
                    <input type='button' class='OkButton popupButton' value='ОК'/>
                    <input type='button' class='CancelButton popupButton' value='Отмена'/>
                </div>
            </div>
        </div>
    </div>
</template>

<template id='ProcessDialog'>
    <div class='ProcessDialog Dialog'>
        <div class='wrap'>
            <h3 class='title'>{{title}}</h3>
            <div class='content'>
                <div class='c'>
                    <div id='DialogSpinner'><i></i></div>
                    <div class='cc'>{{content}}</div>
                </div>
                <div class='DialogButtons'>
                    <input type='button' class='CancelButton popupButton' value='Отмена'/>
                </div>
            </div>
        </div>
    </div>
</template>

<template id='ProgressDialog'>
    <div class='ProgressDialog Dialog'>
        <div class='wrap'>
            <h3 class='title'>{{title}}</h3>
            <div class='content'>
                <div>{{content}}</div>
                <div id='ProgressBar'>
                    <div class='progress'><div class='bar'></div></div>
                    <div class='annotation'><span id='ProgressBarValue'></span>/<span id='ProgressBarMax'></span></div>
                </div>
                <div class='DialogButtons'>
                    <input type='button' class='CancelButton popupButton' value='Отмена'/>
                </div>
            </div>
        </div>
    </div>
</template>

<template id="MultipleChoiceDialog">
    <div class='MultipleChoiceDialog Dialog'>
        <div class='wrap'>
            <h3 class='title'>{{title}}</h3>
            <div class='content'>
                <div class='choices'>
                    <ul class='Scrollable'>
                        
                    </ul>
                </div>
                <div class='DialogButtons'>
                    <input type='button' class='OkButton popupButton' value='Ок'/>
                    <input type='button' class='CancelButton popupButton' value='Отмена'/>
                </div>
            </div>
        </div>
    </div>
</template>

<template id='MultipleChoiceDialogVariant'>
    <li>
        <label>
            <input type='checkbox' {{checked}}/>
            <span>{{title}}</span>
        </label>
    </li>
</template>

<template id='ContextMenu'>
    <div class='ContextMenu Scrollable'>
        <div class='wrap'>
            <ul class='items'>
                
            </ul>
        </div>
    </div>
</template>

<template id='ContextMenuItem'>
    <li data-i='{{i}}'>
        <span>{{title}}</span>
    </li>
</template>