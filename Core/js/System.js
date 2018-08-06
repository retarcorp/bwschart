window.RCore = {
    
    init: function(){
        _.Templates.add("AlertDialog");   
        _.Templates.add("PromptDialog");
        _.Templates.add("ConfirmDialog");
        _.Templates.add("ProcessDialog");
        _.Templates.add("ProgressDialog");
        _.Templates.add("MultipleChoiceDialogVariant");
        _.Templates.add("MultipleChoiceDialog");
        
        _.Templates.add("ContextMenu")
        _.Templates.add("ContextMenuItem")
        
        RCore.ContextMenu.init()
    }
    
    ,Dialogs : {
        
        alert: function(content, onOk, title){
            
            if(!title){
                title="Сообщение системы";
            }
            var div = _.new("div")
            div.fromTemplate("AlertDialog",[{title:title, content:content}]);
            var el = _.$("*:focus")[0];
            if(el) el.blur();
            div.find(".OkButton")[0].focus();
            div = _.$(div[0].children[0]);
            document.body.appendChild(div[0]);
            
            var grabKeys = function(e){
                if(e.which == 13){
                    if(typeof onOk=='function'){
                        onOk();
                    }
                    removeAlert();
                    return;
                }
                if(e.which == 27){
                    removeAlert()
                }
                
            }
            window.addEventListener("keyup",grabKeys)
            var removeAlert = function(){
                window.removeEventListener("keyup",grabKeys)
                div.remove();
            }
            
            
            div.click(function(e){
                if(this==e.target){
                    removeAlert();
                }
            })
            
            div.find(".OkButton").click(function(e){
                if(typeof onOk=='function'){
                    onOk();
                }
                removeAlert();
            })
        }
        
        ,prompt: function(content, onOk, onCancel, def, title){
            if(!title){
                title="Сообщение системы";
            }
            
            var div = _.new("div")
            div.fromTemplate("PromptDialog",[{title:title, content:content}]);
            div = _.$(div[0].children[0]);
            document.body.appendChild(div[0]);
            
            var removeDialog = function(){
                window.removeEventListener("keyup",grabKeys)
                div.remove();
            }
            
            var grabKeys = function(e){
                
                if(e.which == 13){
                    if(typeof onOk=='function'){
                        onOk(_.$("#PromptInput").val);
                    }
                    removeDialog();
                    return;
                }
                if(e.which == 27){
                    if(typeof onCancel == "function"){
                        onCancel();
                    }
                    removeDialog()
                }
                
            }
            window.addEventListener("keyup",grabKeys)
           
            div.click(function(e){
                if(this==e.target){
                    if(typeof onCancel=="function") onCancel();
                    removeDialog();
                }
            })
            
            div.find(".OkButton").click(function(e){
                if(typeof onOk=='function'){
                    onOk(_.$("#PromptInput").val);
                }
                removeDialog();
            })
            
            div.find(".CancelButton").click(function(e){
                if(typeof onCancel=="function"){
                    onCancel()
                }
                removeDialog();
            })
            _.$("#PromptInput").keydown(function(e){
                if(e.which==13){
                    div.find(".OkButton")[0].click();
                }
            })
            if(def){
                _.$("#PromptInput").val = def;
            }
            _.$("#PromptInput")[0].select();
            
        }
        
        ,confirm: function(content, onOk, onCancel, title){
            if(!title){
                title="Подтвердите действие";
            }
            
            var div = _.new("div");
            div.fromTemplate("ConfirmDialog",[{title:title, content:content}]);
            div = _.$(div[0].children[0]);
            document.body.appendChild(div[0]);
            
            var removeDialog = function(){
                window.removeEventListener("keyup",grabKeys)
                div.remove();
            }
           
            var grabKeys = function(e){
                if(e.which == 13){
                    if(typeof onOk=='function'){
                        onOk();
                    }
                    removeDialog();
                    return;
                }
                if(e.which == 27){
                    if(typeof onCancel == "function"){
                        onCancel();
                    }
                    removeDialog()
                }
                
            }
            window.addEventListener("keyup",grabKeys)
            div.click(function(e){
                if(this==e.target){
                    if(typeof onCancel=="function") onCancel();
                    removeDialog();
                }
            })
            
            div.find(".OkButton").click(function(e){
                if(typeof onOk=='function'){
                    onOk();
                }
                removeDialog();
            })
            
            div.find(".CancelButton").click(function(e){
                if(typeof onCancel=="function"){
                    onCancel();
                }
                removeDialog();
            })
        }
        
        ,process: function(content, onCancel, title){
            
            var div = _.new("div");
            div.fromTemplate("ProcessDialog",[{content:content, title: title}]);
            
            div = _.$(div[0].children[0]);
            document.body.appendChild(div[0]);
            
            if(!title){
                div.find("h3").display("none");
            }
            if(typeof onCancel!="function"){
                div.find(".CancelButton").remove()
            }
            div.find(".CancelButton").click(function(e){
                if(typeof onCancel=="function"){
                    onCancel();
                }
            })
            div.click(function(e){
                if(this==e.target){
                    if(typeof onCancel=="function") onCancel();
                }
            })
            
            var removeDialog = function(){
                div.remove();
            };
            return {
                remove: removeDialog
            };
        }
        
        ,multipleChoice: function(elements, selected, onOk, onCancel, title){
            if(!title){
                title="Выберите несколько элементов";
            }
            var div = _.new("div")
            div.fromTemplate("MultipleChoiceDialog",[{title:title}]);
            div = _.$(div[0].children[0]);
            
            var data = elements.map(function(e){
                return {
                    title: e
                    ,checked: ""
                }
            })
            if(Array.isArray(selected)){
                selected.forEach(function(i){
                    try{
                        data[elements.indexOf(i)].checked = "checked";
                    }catch(e){
                        
                    }
                    
                })
            }
            div.find(".choices ul").fromTemplate("MultipleChoiceDialogVariant",data);
            
            
            document.body.appendChild(div[0]);
            var removeAlert = function(){
                div.remove();
            }
            
            div.click(function(e){
                if(this==e.target){
                    removeAlert();
                    if(typeof onCancel=="function"){
                        onCancel();
                    }
                }
            })
            
            div.find(".OkButton").click(function(e){
                if(typeof onOk=='function'){
                    var res = [];
                    div.find(".choices input[type='checkbox']").forEach(function(e,i){
                        if(e.checked){
                            res.push(elements[i]);
                        }
                    },true)
                    onOk(res);
                }
                removeAlert();
            })
            
            div.find(".CancelButton").click(function(e){
                if(typeof onCancel=='function'){
                    onCancel();
                }
                removeAlert();
            })
        }
    }
    
    ,ContextMenu: {
        
        instances: {}
        ,init: function(){
            _.$("body").click(this.closeAll).contextmenu(this.closeAll);    
        }
        
        ,create: function(name, args){
            var menu = new RCore.ContextMenu.Instance(args);
            this.instances[name] = menu;
            return menu;
        }
        
        ,closeAll: function(){
            for(var i in RCore.ContextMenu.instances){
                (function(e){
                    e.close();
                })(RCore.ContextMenu.instances[i])
            }
        }
        
        ,Instance: function(args){
            var i =0;
            this.args=[];
            for(var p in args){
                this.args[i] = {
                    i: i++
                    ,title: p
                    ,handler: args[p]
                    ,settings:{
                        hidden: false
                        ,disabled: false
                    }
                };
            }
            var div = _.new("div");
            div.fromTemplate("ContextMenu",[{}]);
            div = _.$(div[0].children[0]);
            div.find(".items",args).fromTemplate("ContextMenuItem",this.args);
            document.body.appendChild(div[0]);
            this.div = div;
            
            
            var t = this;
            this.target = null;
            this.targets= [];
            this.addTarget = function(el){
                this.targets.push(el);
                el.event("contextmenu", this.openMenu)
            }
            
            this.set = function(i,obj){
                this.args[i].settings.hidden = !!obj.hidden;
                this.args[i].settings.disabled = !!obj.disabled;
            }
            this.enableAll = function(){
                for(var i in this.args){
                    this.args[i].settings.disabled = false;
                }
            }
            this.showAll = function(){
                for(var i in this.args){
                    this.args[i].settings.hidden = false;
                }
            }
            this.onopen = function(){};
            this.onbeforeopen = function(){};
            this.recreate = function(){
                for(var i in this.args){
                    var s = this.args[i].settings;
                    
                    if(s.hidden){
                        _.$(this.div.find(" li")[i]).addClass("hidden")
                    }else{
                        _.$(this.div.find(" li")[i]).removeClass("hidden")
                    }
                    
                    if(s.disabled){
                        _.$(this.div.find(" li")[i]).addClass("disabled")
                    }else{
                        _.$(this.div.find(" li")[i]).removeClass("disabled")
                    }
                }
            }
            this.openMenu = function(e){
                
                e.stopPropagation()
                e.preventDefault();
                
                t.onbeforeopen(this);
                
                RCore.ContextMenu.closeAll()
                t.recreate();
                t.open(this, e.clientX, e.clientY)
                t.target = this;
                
                t.onopen(this);
            }
            this.onSelect = function(e){
                if(_.$(this).hasClass("disabled")){
                    e.preventDefault();
                    e.stopPropagation();
                    return;
                }
                var id = _.$(this).data("i")*1;
                t.args[id].handler(_.$(t.target));
                t.close()
            }
            this.div.find("li").click(this.onSelect);
            this.open = function(el,x,y){
                this.recreate();
                _.$(el).addClass("rcore-context-open");
                this.div.display("block");
                var rect = this.div[0].children[0].getBoundingClientRect();
                if(innerHeight < y+rect.height ){
                    y-=rect.height;
                }
                if(innerWidth< x+rect.width){
                    x-=rect.width
                }
                if(y<0){y=0;}
                if(x<0){x=0;}
                var h = rect.height;
                if(rect.height >= innerHeight){
                    h = innerHeight;
                }
                

                this.div.style({top: y+"px", left: x+"px", height: h+"px"})
            }
            this.close = function(){
                if(this.target){
                    _.$(this.target).removeClass("rcore-context-open");
                }
                
                this.div.display("none")
            }
            this.remove = function(){
                this.targets.forEach(function(e){
                    e.unevent("contextmenu",t.openMenu);
                    t.div.remove();
                    delete RCore.ContextMenu.instances[t.name];
                })
            }
            this.close()
        }
    }
    
    ,Fields:{
        
        CodeEditor:{
            create: function(el, mode){
                
                var instance = new RCore.Fields.CodeEditor.Instance(el, mode);;
                if(typeof ace == "undefined"){
                    var script = document.createElement("script");
                    script.src = "/Core/apps/FileManager/js/ace.js";
                    document.head.appendChild(script);
                    script.onload = function(){
                        instance.init();
                    }
                }else{
                    instance.init();
                }
                return instance;
                
            }
            
            ,Instance: function(el, mode){
                
                // User defined event handler
                this.oninit = function(){};
        
                var instance = this;
                this.init = function(){
                    var id = el.attr("id");
                    if(!id){
                        id = Math.floor(Math.random()*(1E+12));
                        el.attr("id",id);
                    }
                    
                    instance.container = el.parent(); 
                    instance.editor = ace.edit(id);
                   
                    
                    instance.editor.setValue(el.val ? el.val : el.HTML());
                    
                    instance.editor.$blockScrolling = Infinity;
                    instance.editor.setTheme("ace/theme/textmate");
                    instance.editor.clearSelection()
                    instance.editor.getSession().setUseWrapMode(true);
                    instance.editor.getSession().setMode("ace/mode/"+mode);
                    
                    instance.setContent = function(v){
                        this.editor.setValue(v);
                    }
                    
                    instance.getContent = function(v){
                         return this.editor.getValue();
                    }
                    
                    instance.setHeight = function(h){
                        
                        instance.container.find(".ace_editor").style("height",h+"px");
                    }
                    this.oninit();
                }
            }
        }
        
        ,RichEdit: {
            create: function(el){
                
                var instance = new this.Instance(el);
                if(typeof CKEDITOR == "undefined"){
                    var script = document.createElement("script");
                    script.src = "http://cdn.ckeditor.com/4.5.7/full/ckeditor.js";
                    document.head.appendChild(script);
                    script.onload = function(){
                        instance.init();
                    }
                    
                }else{
                    instance.init();
                }
                return instance;
            }
            
            ,Instance: function(el){
                
                
                var id = el[0].id;
                if(!id){
                    do{
                        id = "field"+Math.floor(Math.random()*10000000)
                    }while(_.$("#"+id).length);
                    el[0].id = id;
                }
                var html = el.HTML();
                
                this.init = function(){
                    
                    CKEDITOR.replace(id,{
                        filebrowserUploadUrl: "/Core/apps/Imager/upload.php"
                    })
                    CKEDITOR.instances[id].setData(html);
                }
                
                
                this.setContent = function(html){
                    CKEDITOR.instances[id].setData(html)
                }
                
                this.getContent = function(){
                    return CKEDITOR.instances[id].getData();
                }
                
                this.getCKInstance = function(){
                    return CKEDITOR.instances[id];
                }
                
            }
        }
    }
    
    
    ,Size: {
        
        getSizeString(bytes){
            
            if(bytes<1024){
                return bytes+" Байт";
            }
            
            var kbytes = bytes/1024;
            if(kbytes<1024){
                return kbytes.toFixed(2)+" КБайт";
            }
            
            var mbytes = kbytes/1024;
            return mbytes.toFixed(2)+" МБайт";
            
            
        }
    }
    
    ,execApi: function(p,m,d,f){
        var div = _.new("div");
        var callback = function(r){
            try{
                var d = JSON.parse(r);
            }catch(e){
                RCore.Dialogs.alert(r+"<br/>"+e.message);
                return;
            }
            f(d);
        };
        
        if(m.toUpperCase() == "POST"){
            div.post(p,d,callback);
        }else{
            div.get(p,d,callback);
        }
        delete div;
    }
    
    ,Date:{
        
        getAgeString(date){

            var now = new Date();
        	var diff = Math.round((now-date)/1000);
        	
        	if(diff<60){
        		return "только что";
        	}
        	
        	var mins = Math.floor(diff/60);
        	if(mins<60){
        		var l = mins%10;
        		var f = Math.floor(mins/10);
        		if(f==1){
        			return mins+" минут назад";
        		}
        		switch(l){
        			case 1:
        				return mins+" минуту назад";
        			case 2:
        			case 3:
        			case 4:
        				return mins+" минуты назад";
        			default:
        				return mins+" минут назад";
        		}
        	}
        	
        	var hours = Math.floor(mins/60);
        	if(hours<24){
        		var l = hours%10;
        		var f = Math.floor(hours/10);
        		if(f==1){
        			return hours+" часов назад";
        		}
        		switch(l){
        			case 1:
        					return hours+" час назад";
        			case 2:
        			case 3:
        			case 4:
        				return hours+" часа назад";
        			default:
        				return hours+" часов назад";
        		}
        	}
        	
        	var days = Math.floor(hours/24);
        	if(days<14){
        		switch(days){
        			case 1:
        				return days+" день назад";
        			case 2:
        			case 3:
        			case 4: 
        				return days+" дня назад";
        			default:
        				return days+" дней назад";
        		}
        		
        	}
        	
        	var weeks = Math.floor(days/7);
        	if(weeks<5){
        		switch(weeks){
        			case 2: return "две недели назад";
        			case 3: return "три недели назад";
        			case 4: return "четыре недели назад";
        		}
        	}
        	
        	var months = Math.floor(days/30);
        	if(months<4){
        		switch (months){
        			case 1: return "месяц назад";
        			case 2: return "два месяца назад";
        			case 3: return "три месяца назад";
        		}
        	}
        	
        	var years = Math.floor(days/365);
        	if(years<1){
        		return "несколько месяцев назад";
        	}else{
        		return "давно";
        	}
        }
        
        
        ,getDateString(date){
            var day = date.getDate(); day = day>9 ? day: "0"+day;
            var month = date.getMonth()+1; month =month>9 ? month : "0"+month;
            var hours = date.getHours(); hours = hours>9 ? hours : "0"+hours;
            var minutes = date.getMinutes(); minutes = minutes>9 ? minutes : "0"+minutes;
            var seconds = date.getSeconds(); seconds = seconds>9 ? seconds : "0"+seconds;
            
            return day+"."+month+"."+date.getFullYear()+" "+hours+":"+minutes+":"+seconds;
        }
        
        ,getSQLString(date){
            var day = date.getDate(); day = day>9 ? day: "0"+day;
            var month = date.getMonth()+1; month =month>9 ? month : "0"+month;
            var hours = date.getHours(); hours = hours>9 ? hours : "0"+hours;
            var minutes = date.getMinutes(); minutes = minutes>9 ? minutes : "0"+minutes;
            var seconds = date.getSeconds(); seconds = seconds>9 ? seconds : "0"+seconds;
            
            return date.getFullYear()+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
        }
    }
} 
_.core(RCore.init);