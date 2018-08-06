var SC = {
    init: function(){
        SC.Field.init();
        SC.List.init()
        _.Templates.add("queryTpl")
        
    }
    
    ,Field:{
        init: function(){
            _.$("#query").keydown(SC.Field.onKeyDown)
            _.$("#sendQuery").click(SC.Field.onSubmit)
        }
        
        ,onKeyDown: function(evt){
            evt = evt || window.event;
            var keyCode = evt.keyCode || evt.which || 0;
            if(keyCode == 9) {
                if(document.selection){
                    document.selection.createRange().duplicate().text = "	";
                }
                else if(this.setSelectionRange) {
                    var strFirst = this.value.substr(0, this.selectionStart);
                    var strLast  = this.value.substr(this.selectionEnd, this.value.length);
        
                    this.value = strFirst + "	" + strLast;
                    var cursor = strFirst.length + "	".length;
                    this.selectionStart = this.selectionEnd = cursor;
                }
                
                if(evt.preventDefault && evt.stopPropagation) {
                    evt.preventDefault();
                    evt.stopPropagation();
                }else {
                    evt.returnValue = false;
                    evt.cancelBubble = true;
                }
                return false;
            }
            if(keyCode==13 &&evt.ctrlKey==true){
                SC.Field.onSubmit()
            }
        }
        
        ,onSubmit: function(){
            var query = _.$("#query").val;
            SC.execQuery(query, function(){
                SC.onQueryExecuted(query);
            })
        }
    }
    
    
    ,execQuery: function(query, f){
        if(query.trim()){
            _.$("#result").post("execQuery.php",{query: query}, function(r){
                if(typeof f =="function") f();    
            })
        }else{
            RCore.Dialogs.alert("Задан пустой запрос!");
        }
    }
    
    ,onQueryExecuted: function(query){
        if(_.$("#query").val == query){
            _.$("#query").val = "";
        }
        if(_.first("#list ul li").text() == query) return;
        var tmp = _.new("div");
        tmp.fromTemplate("queryTpl",[{query:query, date: RCore.Date.getSQLString(new Date())}])
        var ul = _.$("#list ul")[0];
        if(ul.children.length){
            ul.insertBefore(tmp.find("li")[0],ul.children[0]);
        }else ul.appendChild(tmp.find("li")[0]);
        
        SC.List.reHandle();
    }
    
    ,List: {
        init: function(){
            _.new("div").get("queries.json",{},function(d){
                d = JSON.parse(d);
                console.log(d);
                
                _.$("#list ul").fromTemplate("queryTpl",d)
                _.$("#list ul").style({height: (function(){
                   return window.innerHeight -  _.$("#terminal")[0].getBoundingClientRect().height - 73;
                })()+"px"});
                SC.List.reHandle()
            })
            
        }
        
        ,reHandle: function(){
            _.$("#list ul li").forEach(function(e){
                e.textContent = e.innerHTML;
            },true)
        
            _.$("#list li").unevent("click", SC.List.onClick);
            _.$("#list li").unevent("dblclick", SC.List.onDblClick);
            
            _.$("#list li").event("click", SC.List.onClick);
            _.$("#list li").event("dblclick", SC.List.onDblClick);
        }
        
        ,onClick: function(e){
            var text= _.$(this).text();
            _.$("#query").val = text;
            _.$("#query")[0].focus()
        }
        
        ,onDblClick: function(e){
            var text=_.$(this).text();
            _.$("#query").val = text;
            _.$("#query")[0].focus()
            SC.execQuery(text,null);
        }
    }
}
_.core(SC.init);