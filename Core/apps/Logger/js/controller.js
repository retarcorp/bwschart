var Logger= {
    init: function(){
        _.Templates.add("log")
        Logger.getPage(0,null, function(d){
            Logger.Table.create(d);
        });
        window.onscroll = Logger.onScroll
        Logger.getLocalParams()
        Logger.Toolbar.init()
    }
    
    ,ALL : "all"
    ,WARNING: "warn"
    ,SAFETY_WARN: "safety_warn"
    ,ERROR: "error"
    
    ,LOGS_PER_PAGE: 100
    ,CurrentPage: 1
    ,CurrentLevel: "all"
    ,CurrentApps: "all"
    
    ,getLocalParams: function(){
        if(localStorage.CurrentLevel){
            Logger.CurrentLevel = localStorage.CurrentLevel;
            Logger.Table.showByLevel()
            _.$("#logLevel").val=Logger.CurrentLevel;
        }
    }
    ,getPage: function(from, amo, f){
        if(!amo) amo = Logger.LOGS_PER_PAGE;
        _.new("div").get("reports.php",{from: from, amo: amo}, function(t){
            f(JSON.parse(t));
        })
    }
    
    ,getTill: function(till, level, f){
        _.new("div").get("reports.php",{till: till, level: level}, function(t){
            f(JSON.parse(t));
        })
    }
    
    ,Subjects:{
        getAll: function(){
            var r = {};
            _.$("#list td.reason").forEach(function(e,i){
                r[e.text()]=1; 
            });
            return Object.keys(r);
        }
        
        ,getInUse: function(){
            if(Logger.CurrentApps == "all"){
                return Logger.Subjects.getAll();
            }
            return Logger.CurrentApps
        }
        
        ,setInUse: function(val){
            Logger.CurrentApps = val;
            Logger.Table.hideUnused();
        }
    }
    
    ,Table: {
        create: function(d){
            _.$("#list").fromTemplate("log",d);
            this.hideUnused()
        }
        
        ,append: function(d){
            var tb = _.new("tbody");
            tb.fromTemplate("log",d);
            _.$("#list").appendHTML(tb.HTML());
            this.hideUnused()
        }
        
        ,showByLevel: function(){
            _.$("#list").attr("class","");
            _.$("#list").addClass(Logger.CurrentLevel)
        }
        
        ,hideUnused: function(){
            var subjects = Logger.Subjects.getInUse();
            _.$("#list td.reason").forEach(function(e,i){
                if(subjects.indexOf(e.text())<0){
                    e.parent().style("display","none");
                }else{
                    e.parent().display("table-row");
                }
            });
        }
    }
    
    ,Toolbar:{
        init: function(){
            _.$("#logLevel").event("change",this.onChangeLevel)
            _.$("#logApps").click(this.onSelectApps);
            
        }
        
        ,onSelectApps: function(){
            var apps = Logger.Subjects.getAll();
            var selected = Logger.Subjects.getInUse();
            RCore.Dialogs.multipleChoice(apps,selected,function(selected){
                Logger.Subjects.setInUse(selected)
            },null,"Выберите субъекты отчетов для отображения")
        }
        
        ,onChangeLevel: function(){
            Logger.CurrentLevel = this.value;
            window.localStorage.CurrentLevel = Logger.CurrentLevel;
             Logger.Table.showByLevel()
        }
    }
    
    ,LOADING: false
    ,onScroll: function(e){
        if(Logger.LOADING) return;
        var rect = _.$("#spinner")[0].getBoundingClientRect();
        if(rect.top < innerHeight){
            var id = _.last("#list tr").data("id");
            Logger.LOADING = true;
            Logger.getPage(id, null, function(d){
                
                Logger.Table.append(d);
                if(d.length==0){
                    _.$("#spinner").HTML("<p>Всего "+_.$("#list tr").length+" отчетов.</p>");
                }
                Logger.LOADING = false;
            })
        }
    }
}
_.core(Logger.init)