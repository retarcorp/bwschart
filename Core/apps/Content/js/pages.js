Content.Pages={
    
    api:{
        exec: function(p,m,d,f){
            var div = _.new("div");
            var callback = function(r){
                try{
                    var d = JSON.parse(r);
                    ;
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
        
        ,GetPages: function(d,f){
            return this.exec("modules/pages/list.php","GET",d,f);
        }
        
        ,CreatePage: function(d,f){
            return this.exec("modules/pages/create.php","POST",d,f);
        }
        
        ,DeletePage: function(d,f){
            return this.exec("modules/pages/delete.php","GET",d,f);
        }
        
        ,RenamePage: function(d,f){
            return this.exec("modules/pages/rename.php","POST",d,f);
        }
        
        ,GetContent: function(d,f){
            return this.exec("modules/pages/content.php","GET",d,f);
        }
        
        ,PutContent: function(d,f){
            return this.exec("modules/pages/content.php","POST",d,f);
        }
        
        ,PasteInside: function(d,f){
            return this.exec("modules/pages/pasteInside.php","POST",d,f)
        }
        
        ,PasteNear: function(d,f){
            return this.exec("modules/pages/pasteNear.php","POST",d,f)
        }
        
        ,LoadThemes: function(f){
            return this.exec("modules/loadThemes.php","GET",{},f)
        }
    }
    
    ,init: function(){
        Content.Pages.List.init();
        Content.Pages.Form.init();
        Content.Pages.PageContextMenu = RCore.ContextMenu.create("pageContext",{
           "Редактировать":Content.Pages.List.onEdit
           ,"Переименовать":Content.Pages.List.onRename
           ,"Копировать": Content.Pages.List.onCopy
           ,"Вырезать": Content.Pages.List.onCut
           ,"Вставить внутрь": Content.Pages.List.onPasteInside
           ,"Вставить до": Content.Pages.List.onPasteBefore
           ,"Вставить после": Content.Pages.List.onPasteAfter
           ,"Удалить": Content.Pages.List.onDelete
        });
        Content.Pages.PageContextMenu.onbeforeopen = (function(){
            this.enableAll();
            if(Content.Pages.Buffer.id==null) {
                this.set(4,{disabled:true});
                this.set(5,{disabled: true});
                this.set(6,{disabled: true});
            }
        })
        Content.Pages.Editors.BodyBefore = RCore.Fields.CodeEditor.create(_.$("#include_body_before"),"html");
        Content.Pages.Editors.BodyAfter = RCore.Fields.CodeEditor.create(_.$("#include_body_after"),"html");
        Content.Pages.Editors.HeadBefore = RCore.Fields.CodeEditor.create(_.$("#include_head_before"),"html");
        Content.Pages.Editors.HeadAfter= RCore.Fields.CodeEditor.create(_.$("#include_head_after"),"html");
        Content.Pages.Editors.PageAfter= RCore.Fields.CodeEditor.create(_.$("#include_page_after"),"html");
        Content.Pages.Editors.PageBefore= RCore.Fields.CodeEditor.create(_.$("#include_page_before"),"html");
    }
    
    ,Editors:{
        BodyBefore:null
        ,BodyAfter: null
        ,HeadBefore: null
        ,HeadAfter: null
        ,PageBefore: null
        ,PageAfter:null
    }
    ,Buffer:{id: null, action: null}
    ,PageContextMenu: null
    ,List: {
        init: function(){
            this.openListFor(0);
            this.initCreators()
            this.initItems()
        }
        
        ,initCreators: function(){
            _.$("#pages .addPage").unevent("click",this.onCreate)
            _.$("#pages .addPage").event("click",this.onCreate)
            
        }
        
        ,onCreate: function(e){
            var t = this;
            RCore.Dialogs.prompt("Введите название новой страницы",function(name){
                var parent = _.$(t).data("parent");
                Content.Pages.api.CreatePage({parent:parent, name: name}, function(d){
                    Content.Pages.List.openListFor(parent);
                })
            },null,"Новая страница","Создание страницы");
        }
        
        
        ,initItems: function(){
            _.$("#pages li>span").unevent("click",this.onOpen)
            _.$("#pages li>span").event("click",this.onOpen)

        }
        
        ,onOpen: function(e){
            Content.Pages.List.onEdit(_.$(this));
            var li = _.$(this).parent();
            li.addClass("active");
            Content.Pages.List.openListFor(li.data("id"));
            
        }
        
        ,openListFor: function(id){
            Content.Pages.api.GetPages({id:id}, function(d){
                
                _.$("#pages ul[data-id='"+id+"']").fromTemplate("Page",d);
                Content.Pages.PageContextMenu.addTarget(_.$("#pages ul[data-id='"+id+"'] li span"));
                Content.Pages.List.initCreators();
                Content.Pages.List.initItems()
            })
        }
        
        ,onDelete: function(span){
            RCore.Dialogs.confirm("Вы действительно хотите удалить страницу "+span.HTML()+" и все вложенные страницы?",function(){
                Content.Pages.api.DeletePage({id: span.parent().data("id")}, function(){
                    span.parent().remove()
                })
            }, null,"Удаление страницы");
        }
        
        ,onRename: function(span){
            RCore.Dialogs.prompt("Введите новый заголовок для страницы",function(name){
                Content.Pages.api.RenamePage({id:span.parent().data("id"), name: name}, function(){
                   span.HTML(name); 
                });
            },null,span.text(),"Переименование страницы")
        }
        
        ,onCopy: function(el){
            Content.Pages.Buffer.id = el.parent().data("id");
            Content.Pages.Buffer.action = "copy";
        }
        
        ,onCut: function(el){
            Content.Pages.Buffer.id = el.parent().data("id");
            Content.Pages.Buffer.action = "cut";
        }
        
        ,onPasteInside: function(el){
            var id = el.parent().data("id");
            Content.Pages.api.PasteInside({to: id, id: Content.Pages.Buffer.id, action: Content.Pages.Buffer.action}, function(d){
                if(d.status=="ERROR"){
                    RCore.Dialogs.alert(d.message);
                    return;
                }
                Content.Pages.List.openListFor(id);
                if(Content.Pages.Buffer.action == "cut"){
                    _.$("#pages li[data-id='"+Content.Pages.Buffer.id+"']").remove()
                }
                Content.Pages.Buffer = {id:null, action: null};
            });
        }
        
        ,onPasteBefore: function(el){
            var id = el.parent().data("id");
            Content.Pages.api.PasteNear({before: id, id: Content.Pages.Buffer.id, action: Content.Pages.Buffer.action}, function(d){
                if(d.status=="ERROR"){
                    RCore.Dialogs.alert(d.message);
                    return;
                }
                Content.Pages.List.openListFor(_.$("#pages li[data-id='"+id+"']").parent().data("id"));
                
                if(Content.Pages.Buffer.action == "cut"){
                    _.$("#pages li[data-id='"+Content.Pages.Buffer.id+"']").remove()
                }
                Content.Pages.Buffer = {id:null, action: null};
            });
        }
        
        ,onPasteAfter: function(el){
            var id = el.parent().data("id")
            Content.Pages.api.PasteNear({after: id, id: Content.Pages.Buffer.id, action: Content.Pages.Buffer.action}, function(d){
                if(d.status=="ERROR"){
                    RCore.Dialogs.alert(d.message);
                    return;
                }
                Content.Pages.List.openListFor(_.$("#pages li[data-id='"+id+"']").parent().data("id"));
                
                console.log({after: id, id: Content.Pages.Buffer.id, action: Content.Pages.Buffer.action});
                
                if(Content.Pages.Buffer.action == "cut"){
                    _.$("#pages li[data-id='"+Content.Pages.Buffer.id+"']").remove()
                }
                Content.Pages.Buffer = {id:null, action: null};
            });
        }
        
        ,onEdit: function(span){
            var id = span.parent().data("id");
            Content.Pages.api.GetContent({id: id}, function(d){
                Content.Pages.Form.open(id, d);
            })
        }
    }
    
    ,Form: {
        
        open: function(id, d){
            Content.Pages.Form.CurrentPage = id;
            Content.Pages.Form.CurrentURL = d.url;
            _.$("#pageTitle").val = d.title;
            _.$("#PageName").HTML(d.name);
            _.$("#url_pattern").val = d.url;
            _.$("#metakeys").val = d.metakeys;
            _.$("#metadescription").val = d.metadescription;
            var includes = JSON.parse(d.includes);
            Content.Pages.Editors.BodyBefore.setContent(includes.body_before || "");
            Content.Pages.Editors.BodyAfter.setContent(includes.body_after || "");
            Content.Pages.Editors.HeadBefore.setContent(includes.head_before || "");
            Content.Pages.Editors.HeadAfter.setContent(includes.head_after || "");
            Content.Pages.Editors.PageAfter.setContent(includes.page_after || "");
            Content.Pages.Editors.PageBefore.setContent(includes.page_before || "");
            
            _.$("#editPage").display("block")
            this.loadThemes(function(){
                Content.Pages.Form.setTemplate(d.template)
                Content.Pages.Form.Edited = false;
            })
        }
        
        ,Themes: []
        ,Edited: false
        ,loadThemes: function(f){
            Content.Pages.api.LoadThemes(function(d){
                Content.Pages.Form.Themes = d;
                f(d);
                _.$("#theme").fromTemplate("ThemeOption",d)
            });
        }
        
        ,setTemplate: function(id){
            var theme = null;
            Content.Pages.Form.Themes.forEach(function(e){
                e.templates.forEach(function(t){
                    if(t.id==id){
                        theme = e;
                    }
                })
            })
            
            if(theme){
                
                this.openTheme(theme.id);
                _.$("#template").val = id;
            }else{
                this.openTheme(Content.Pages.Form.Themes[0].id)
            }
        }
        
        ,openTheme: function(id){
            
            Content.Pages.Form.Themes.forEach(function(e){
                if(e.id==id){
                    _.$("#template").fromTemplate("TemplateOption",e.templates);
                    _.$("#template")[0].selected = true;
                }
            })
        }
        
        ,onSave: function(){
            var s = {
                title: _.$("#pageTitle").val
                ,url: _.$("#url_pattern").val
                ,metakeys: _.$("#metakeys").val
                ,metadesc: _.$("#metadescription").val
                ,template: _.$("#template").val
                ,bodyBefore: Content.Pages.Editors.BodyBefore.getContent()
                ,bodyAfter: Content.Pages.Editors.BodyAfter.getContent()
                ,headAfter: Content.Pages.Editors.HeadAfter.getContent()
                ,headBefore: Content.Pages.Editors.HeadBefore.getContent()
                ,pageAfter: Content.Pages.Editors.PageAfter.getContent()
                ,pageBefore: Content.Pages.Editors.PageBefore.getContent()
                ,id: Content.Pages.Form.CurrentPage
            }
            Content.Pages.api.PutContent(s, function(d){
                Content.Pages.Form.CurrentURL = s.url;
                RCore.Dialogs.alert("Сохранено успешно!");
            })
        }
        
        ,init: function(){
            _.$("#theme").change(function(){
                Content.Pages.Form.openTheme(this.value);
            })
            _.$("#savePage").click(this.onSave)
            _.$("#openPageLink").click(this.onOpenPageLink)
            _.$("#openPagen").click(this.onOpenEditorLink);
        }
        
        ,onOpenPageLink: function(e){
            window.open(Content.Pages.Form.CurrentURL);
        }
        
        ,onOpenEditorLink: function(e){
            window.open("/Core/apps/Content/Pagen/"+Content.Pages.Form.CurrentPage);    
        }
        
        ,CurrentPage: 0
        ,CurrentURL: ""
        
    }
}