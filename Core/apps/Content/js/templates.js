Content.Templates = {
    init: function(){
        
        this.Folders.init();
        this.Form.init();
        
        Content.Templates.FolderContextMenu = RCore.ContextMenu.create("folderContext",{
            "Переименовать":function(el){Content.Templates.Folders.onRename(el);}
            ,"Удалить":function(el){Content.Templates.Folders.onDelete(el);}
        });
        
        Content.Templates.ItemContextMenu = RCore.ContextMenu.create("itemContext",{
            "Редактировать": function(el){Content.Templates.Pages.onEdit(el);}
            ,"Переименовать": function(el){Content.Templates.Pages.onRename(el);}
            ,"Удалить":function(el){Content.Templates.Pages.onDelete(el);}
        });
    }
    
    ,FolderContextMenu: null
    ,ItemContextMenu: null
    ,api:{
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
        
        ,GetFolders: function(f){
            this.exec("modules/folders/list.php","GET",{},f);
        }
        ,CreateFolder: function(name, f){
            this.exec("modules/folders/create.php","POST",{name: name},f);
        }
        
        ,RenameTheme: function(s,f){
            this.exec("modules/folders/rename.php","POST",s,f);
        }
        
        ,DeleteTheme: function(s,f){
            this.exec("modules/folders/delete.php","GET",s,f);
        }
        
        ,GetPages: function(s,f){
            this.exec("modules/templates/list.php","GET",s,f);
        }
        
        ,CreateTemplate: function(s,f){
            this.exec("modules/templates/create.php","POST",s,f);
        }
        
        ,RenameTemplate: function(s,f){
            this.exec("modules/templates/rename.php","POST",s,f);
        }
        
        ,DeleteTemplate: function(s,f){
            this.exec("modules/templates/delete.php","GET",s,f);
        }
        
        ,GetContent: function(s,f){
            this.exec("modules/templates/content.php","GET",s,f);
        }
        
        ,PutContent: function(s,f){
            this.exec("modules/templates/content.php","POST",s,f);
        }
    }
    
    ,Folders:{
        
        list:[]
        ,getByTitle: function(name){
            return this.list.filter(function(e){
                return e.title == name;
            })[0];
        }
        ,getById: function(id){
            return this.list.filter(function(e){
                return e.id == id;
            })[0];
        }
        
        ,init: function(){
            _.$("#createFolder").unevent("click",this.onCreate);
            _.$("#createFolder").event("click",this.onCreate);
            this.load();
        }
        
        ,onCreate: function(){
            RCore.Dialogs.prompt("Введите название новой темы:",function(name){
                Content.Templates.Folders.create(name,function(){
                    Content.Templates.Folders.load();
                });
            },null,"Новая тема","Создание темы");
        }
        
        ,create: function(name, f){
            Content.Templates.api.CreateFolder(name, function(d){
                
                f(d);
            });
        }
        
        ,load: function(){
            Content.Templates.api.GetFolders(function(d){
                Content.Templates.Folders.list = d;
                _.$("#templates ul").fromTemplate("templateFolder",d);
                _.$("#templates ul>li>span").forEach(function(e){
                    Content.Templates.FolderContextMenu.addTarget(e);
                });
                _.$("#templates ul>li>span").click(Content.Templates.Folders.onClick);
                _.$("#templates ul>li .createTemplate").click(Content.Templates.Folders.onClickCreate);
            });
        }
        
        ,onRename: function(el){
            el = el.parent();
            var f = Content.Templates.Folders.getById(el.data("id"));
            RCore.Dialogs.prompt("Введите новое название темы:",function(name){
                Content.Templates.api.RenameTheme({id: f.id, name: name}, function(d){
                    _.$(el.find("span")[0]).HTML(name);
                });
            },null,f.title,"Переименование темы");
        }
        
        ,onDelete: function(el){
            el = el.parent();
            var f = Content.Templates.Folders.getById(el.data("id"));
            RCore.Dialogs.confirm("Вы действительно хотите удалить тему "+f.title+"?",function(){
                Content.Templates.api.DeleteTheme({id:f.id}, function(d){
                    el.remove();
                });
            },null,"Удаление темы");
        }
        
        ,onClick: function(e){
            var t = this.parentNode;
            var el = _.$(t);
            if(t.classList.contains("opened")){
                t.classList.remove("opened");
            }else{
                Content.Templates.Pages.load(el.data("id"),function(){
                    t.classList.add("opened");    
                });
                
            }
        }
        
        ,onClickCreate: function(e){
            
            
            var id = _.$(this).data("id");
            RCore.Dialogs.prompt("Введите название нового шаблона:",function(name){
                
                
                Content.Templates.Pages.create(name, id);
            },null,"Новый шаблон","Создание шаблона");  
        }
        
    }
    
    
    ,Pages:{
        
        load: function(id, f){
            Content.Templates.api.GetPages({id: id},function(d){
              
                _.$("ul>li[data-id='"+id+"'] ol").fromTemplate("templateItem",d);
                Content.Templates.ItemContextMenu.addTarget(_.$("ul>li[data-id='"+id+"'] ol li span"));
                _.$("ul>li[data-id='"+id+"'] ol li span").click(function(e){
                    Content.Templates.Pages.onEdit(_.$(this));
                });
                if(typeof f == "function") f();
                
            });
            
        }
        
        ,create: function(name, parent){
            Content.Templates.api.CreateTemplate({parent:parent, name: name}, function(){
                Content.Templates.Pages.load(parent);
            })
        }
        
        ,onEdit: function(el){
            var id = el.parent().data("id")*1;
            Content.Templates.Form.open(id);
        }
        
        ,onRename: function(el){
            var id = el.parent().data("id");
            var name = el.text();
            RCore.Dialogs.prompt("Введите новое название шаблона:",function(nn){
                Content.Templates.api.RenameTemplate({id: id, name: nn}, function(d){
                    el.HTML(nn);
                });
            },null,name,"Переименование шаблона");
        }
        
        ,onDelete: function(el){
            var id = el.parent().data("id");
            RCore.Dialogs.confirm("Вы действительно хотите удалить шаблон "+el.HTML()+"?",function(){
                Content.Templates.api.DeleteTemplate({id:id}, function(d){
                    el.parent().remove()
                })
                
            },null,"Удаление шаблона")
        }
    }
    
    ,Form:{
        
        Current: 0
        ,init: function(){
            _.$("#editForm #save").click(Content.Templates.Form.onSave);
            _.$("#editForm .content").find(".head, .body").display("none")
            _.$("#toBody").click(function(){
                _.$("#editForm .content").find(".head, .body").display("none")
                _.$("#editForm .content .body").display("block");
                _.$("#toBody,#toHead").removeClass("active");
                _.$(this).addClass("active");
            })
            
            _.$("#toHead").click(function(){
                _.$("#editForm .content").find(".head, .body").display("none")
                _.$("#editForm .content .head").display("block");
                _.$("#toBody,#toHead").removeClass("active");
                _.$(this).addClass("active");
            })
            
            this.HeadEditor =  RCore.Fields.CodeEditor.create(_.$("#head"),"html");
            this.BodyEditor =  RCore.Fields.CodeEditor.create(_.$("#body"),"html");
            
            var h = innerHeight-40-20-15-15-10-10-48;
            this.HeadEditor.oninit = function(){
                this.setHeight(h);
            }
            this.BodyEditor.oninit = function(){
                this.setHeight(h);
            }
        }
        ,HeadEditor: null
        ,open: function(id){
            Content.Templates.api.GetContent({id:id}, function(d){
                console.log(d);
                Content.Templates.Form.Current = id;
                _.$("#editForm #title").val = d.title;
                _.$("#editForm #head").val = d.head;
                _.$("#editForm #body").val = d.body;
                
                Content.Templates.Form.HeadEditor.setContent(d.head);
                Content.Templates.Form.BodyEditor.setContent(d.body);
                
                _.$("#editForm").display("block")
                
            })
        }
        
        ,onSave: function(e){
            Content.Templates.Form.save()
        }
        
        ,save: function(){
            var s = {
                title: _.$("#editForm #title").val
                ,head: this.HeadEditor.getContent()
                ,body: this.BodyEditor.getContent()
                ,id: Content.Templates.Form.Current
            }
            console.log(s);
            Content.Templates.api.PutContent(s, function(d){
                _.$('.templates ol li[data-id="'+s.id+'"] span').HTML(s.title);
                RCore.Dialogs.alert("Сохранено успешно!");
            })
        }
    }
}