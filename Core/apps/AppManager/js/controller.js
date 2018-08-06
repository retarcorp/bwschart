window.AppManager = {
    init: function(){
        _.Templates.init()
        AppManager.Routes.init();
        AppManager.Shop.init()
    }
    
    ,routes:{
        "#shop":{
            container: function(){return _.$("#shop");}
            ,handler: function(){return AppManager.Shop.onOpen}
        }
        
        ,"#installed":{
            container: function(){return _.$("#installed");}
            ,handler: function(){return AppManager.Installed.onOpen}
        }
        
        ,"#install":{
            container: function(){return _.$("#install");}
            ,handler: function(){return AppManager.Install.onOpen}
        }
        
    }
    
    ,Routes: {
        init: function(){
            
            
            this.onTab();
            window.onhashchange = this.onTab;
        }
        
        ,onTab: function(){
            var hash = location.hash;
            for(var h in AppManager.routes){
                if(h==hash){
                    var e = AppManager.routes[h];
                    _.$("#container>section").display("none");
                    e.container().display("block");
                    _.$("#tabs a").removeClass("active");
                    _.$("#tabs a[href='"+h+"']").addClass("active");
                    e.handler()();
                    return;
                }
            }
            location.hash= "#shop";
        }
    }
    
    ,Shop:{
        init: function(){
            AppManager.Shop.loadApps();
            
        }
        
        ,api:{
            LoadApps: function(f){
                RCore.execApi("modules/shop/apps.php","GET",{},f);
                
            }
        }
        ,Apps: []
        
        
        
        ,loadApps: function(){
            AppManager.Shop.api.LoadApps(function(d){
                AppManager.Shop.Apps = d;
                AppManager.Shop.buildList(AppManager.Shop.extractApps(d));
                AppManager.Shop.buildFilter(d);
                AppManager.Shop.Search.init();
            });    
        }
        
        ,buildFilter: function(d){
            _.$("#shop-category").fromTemplate("ShopCategory",d);
        }
        
        ,extractApps: function(d){
            var apps = [];
            AppManager.Shop.Apps.forEach(function(e){
                e.apps.forEach(function(a){
                    apps.push({
                        id: a.id
                        ,title: a.title
                        ,tags: a.tags
                        ,description: a.description
                        ,image: a.image_url
                        ,published_at: RCore.Date.getAgeString(new Date(a.version.published_at))
                        ,size: RCore.Size.getSizeString(a.version.size)
                        ,installs: a.version.installs
                        ,version: a.version.code
                        ,category: e.id
                        ,price: a.price
                        ,published_date: new Date(a.version.published_at)
                        ,size_b: a.version.size
                        ,action: a.installed==1 ? "open" : "install"
                        ,name: a.name
                    })
                })
            })
            return apps;
        }
        ,buildList: function(apps){
            _.$("#app-list").fromTemplate("Application", apps);
            _.$("#app-list [data-action='open']").val="Открыть";
            _.$("#app-list [data-action='install']").click(this.onInstall)
            _.$("#app-list [data-action='open']").click(AppManager.Shop.onOpenApp)
        }
        
        ,onInstall: function(e){
            var id = _.$(this).parent(3).data("id");
            window.open("install/?app="+id);
        }
        
        ,onOpenApp: function(e){
            
            var name = _.$(this).parent(3).data("name");
            window.open("open/?app="+name);
        }
        
        ,Search: {
            init: function(){
                _.$("#shop-search-name").event("input", this.onSearchInput);
                _.$("#shop-category input").event("change", this.onSearchInput);
                _.$("input[name='shop-sort'] ").event("change", this.onSearchInput);
                var cats = [];
                _.$("#shop-free-only").click(this.onSearchInput)
                _.$("#shop-category input").forEach(function(e){cats.push(e.val)})
                AppManager.Shop.Search.Config.cats = cats;
            }
            
            ,onSearchInput: function(e){
                AppManager.Shop.Search.Config.query = _.$("#shop-search-name")[0].value;
                var cats = [];
                _.$("#shop-category input:checked").forEach(function(e){cats.push(e.val)})
                AppManager.Shop.Search.Config.cats = cats;
                AppManager.Shop.Search.Config.freeOnly = _.$("#shop-free-only")[0].checked
                AppManager.Shop.Search.Config.sort = _.$("[name='shop-sort']:checked")[0].value
                
                AppManager.Shop.Search.exec();
                
            }
            
            ,SORT_POPULAR: "popular"
            ,SORT_LATEST: "latest"
            ,SORT_OLDEST: "oldest"
            ,SORT_SMALLEST: "smallest"
            ,SORT_BIGGEST: "biggest"
            
            ,Config:{
                query: ""
                ,cats:[]
                ,freeOnly: false
                ,sort: "popular"
            }
            
            ,exec: function(){
                var d=AppManager.Shop.extractApps(AppManager.Shop.Apps);
                var c = AppManager.Shop.Search.Config;
                var res = d.filter(function(e){
                    if(c.query.trim()){
                        var q = c.query.trim();
                        if(e.title.toLowerCase().indexOf(q.toLowerCase()) == -1){
                            return false;
                        }
                    }
                    
                    // Check of categories
                    var f = false;
                    c.cats.forEach(function(cat){
                        if(cat == e.category){
                            f = true;
                            return;
                        }
                    })
                    if(!f){
                        return false;
                    }
                    if(c.freeOnly){
                        if(e.price*1 !== 0 ){
                            return false;
                        }
                    }
                    
                    return true;
                })
                
                res.sort(function(a,b){
                    switch(c.sort){
                        case AppManager.Shop.Search.SORT_POPULAR:
                            return -a.installs*1 + b.installs*1;
                        case AppManager.Shop.Search.SORT_LATEST:
                            return a.published_date - b.published_date
                        case AppManager.Shop.Search.SORT_OLDEST:
                            return b.published_date - a.published_date
                        case AppManager.Shop.Search.SORT_SMALLEST:
                            return a.size_b*1 - b.size_b*1
                        case AppManager.Shop.Search.SORT_BIGGEST:
                            return b.size_b*1 - a.size_b*1
                    }
                })
                
                AppManager.Shop.buildList(res);
            }
        }
        
        ,onOpen: function(){
            // When opening a section
        }
    }
    
    ,Installed:{
        init: function(){
            
        }
        
        ,onOpen: function(){
            
        }
    }
    
    ,Install: {
        init: function(){
            
        }
        
        ,onOpen: function(){
            
        }
    }
};

_.core(AppManager.init)