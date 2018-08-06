window.Content={
    init: function(){
       
        _.Templates.add("templateFolder");
        _.Templates.add("templateItem");
        _.Templates.add("Page")
        _.Templates.add("ThemeOption");
        _.Templates.add("TemplateOption")
        
        if(Object.keys(Content.routes).indexOf(location.hash)<0){
            location.hash = "#pages";
        }
        window.onhashchange = Content.route;
        Content.route()
        
    }
    
    ,route: function(){
        var hash = location.hash;
        var route = Content.routes[hash];
        if(!route){
            location.hash = "#templates";
            return;
        }
        
        for(var i in Content.routes){
            Content.routes[i].container().display("none");
        }
        route.container().display("block");
        route.handler()
        
    }
    
    ,routes:{
        "#templates":{
            container: function(){return _.$("#templates");}
            ,handler: function(){Content.Templates.init()}
        }
        ,"#pages":{
            container: function(){return _.$("#pageSection");}
            ,handler: function(){Content.Pages.init()}
        }
    }
};
_.core(Content.init);