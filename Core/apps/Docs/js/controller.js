var Docs = {
    
    init: function(){
        Docs.List.load(0);  
        _.Templates.add("Item");
        
        Docs.DocContext = RCore.ContextMenu.create("DocContext",{
            "Переименовать": Docs.List.Doc.onRename
            ,"Редактировать": Docs.List.Doc.onEdit
            ,"Удалить": Docs.List.Doc.onDelete
        })
        
        Docs.FolderContext = RCore.ContextMenu.create("FolderContext",{
            "Переименовать":Docs.List.Folder.onRename
            ,"Удалить":Docs.List.Folder.onDelete
        })
        Docs.Viewer.init();
    }
    
    ,DocContext: null
    ,FolderContext: null
    
    ,api:{
        List: function(d,f){
            RCore.execApi("modules/list.php","GET",d,f);
        }
        ,CreateDoc: function(d,f){
            RCore.execApi("modules/createDoc.php","POST",d,f);
        }
        ,CreateFolder: function(d,f){
            RCore.execApi("modules/createFolder.php","POST",d,f);
        }
        ,Rename: function(d,f){
            RCore.execApi("modules/rename.php","POST",d,f);
        }
        ,Delete: function(d,f){
            RCore.execApi("modules/delete.php","GET",d,f);
        }
        ,SaveContent: function(d,f){
            RCore.execApi("modules/content.php","POST",d,f);
        }

    }
    
    ,List:{
        
        load: function(id){
            Docs.api.List({parent: id}, function(d){
                
                for(var i in d){
                    var e = d[i];
                    if(e.type == 1){
                        d[i].type="folder";
                    }
                    if(e.type==0){
                        d[i].type="doc";
                    }

                }
                _.$("aside ul[data-parent='"+id+"']").fromTemplate("Item",d);
                
                Docs.DocContext.addTarget(_.$("aside ul[data-parent='"+id+"']>.doc"));
                Docs.FolderContext.addTarget(_.$("aside ul[data-parent='"+id+"']>.folder"));
                
                Docs.List.setOpened(id);
                Docs.List.reinit();
            })
        }
        
        ,setOpened(id){
            _.$("aside li[data-id='"+id+"']").data("active",1);
        }
        
        ,reinit: function(){
            _.$("aside .addFile").unevent("click", this.onAddDoc)
            _.$("aside .addFile").event("click", this.onAddDoc)
            
            _.$("aside .addFolder").unevent("click", this.onAddFolder)
            _.$("aside .addFolder").event("click", this.onAddFolder)
            
            _.$("aside li .clickable").unevent("click",this.onOpenItem)
            _.$("aside li .clickable").event("click",this.onOpenItem)
        }
        
        ,onAddDoc: function(){
            var id = _.$(this).data("parent");
            Docs.List.addDoc(id*1);
        }
        
        ,addDoc: function(id){
            RCore.Dialogs.prompt("Введите название новой статьи: ",function(name){
                
                Docs.api.CreateDoc({parent: id, title: name}, function(d){
                    Docs.List.load(id);
                })
                
            }, null, "", "Создание справочной статьи")
        }
        
        ,onAddFolder: function(){
            var id = _.$(this).data("parent");
            Docs.List.addFolder(id*1);
        }
        
        ,addFolder: function(id){
            RCore.Dialogs.prompt("Введите название новой папки: ",function(name){
                
                Docs.api.CreateFolder({parent: id, title: name}, function(d){
                    Docs.List.load(id);
                })
                
            }, null, "", "Создание папки");
        }
        
        ,onOpenItem: function(e){
            var id = _.$(this).parent().data("id");
            var type = _.$(this).parent().data("type");
            
            switch(type){
                case "doc":{
                    Docs.Viewer.show(id)
                    break;    
                }
                case "folder":{
                    Docs.List.load(id);       
                    break;
                }
                
            }
        }
        
        ,Doc:{
            onRename: function(el){
                var id = el.data("id");
                RCore.Dialogs.prompt("Введите новое название статьи: ",function(name){
                    Docs.api.Rename({id: id, name: name}, function(d){
                        _.$(el.find(".clickable h4")[0]).HTML(name).attr("title", name)
                    })
                }, null, _.$(el.find(".clickable h4")[0]).text(), "Переименование статьи");
            }
            
            ,onEdit:  function(el){
                Docs.Viewer.edit(el.data("id"));
            }
            
            ,onDelete: function(el){
                var id = el.data("id");
                RCore.Dialogs.confirm("Вы действительно хотите удалить статью? Это действие нельзя будет обратить!",function(){
                    Docs.api.Delete({id:id}, function(d){
                        el.remove()
                    })
                }, null, "Удаление статьи")
            }
        }
        
        ,Folder:{
            onRename: function(el){
                var id = el.data("id");
                RCore.Dialogs.prompt("Введите новое название папки: ",function(name){
                    Docs.api.Rename({id: id, name: name}, function(d){
                        _.$(el.find(".clickable h4")[0]).HTML(name).attr("title", name)
                    })
                }, null, _.$(el.find(".clickable h4")[0]).text(), "Переименование папки");
            }
            
            ,onDelete: function(el){
                var id = el.data("id");
                RCore.Dialogs.confirm("Вы действительно хотите удалить папку? Это действие нельзя будет обратить!",function(){
                    Docs.api.Delete({id:id}, function(d){
                        el.remove();
                    })
                }, null, "Удаление папки")
            }
        }
        
    }
    
    ,Viewer:{
            
        
        init: function(){
            Docs.Viewer.DocContent = RCore.Fields.RichEdit.create(_.$("#ckeditor"));
            // Docs.Viewer.CodeEditor = RCore.Fields.CodeEditor.create(_.$("#CodeEditor"),"html");
            
            
            
            _.$("#editor #save").click(Docs.Viewer.onSave)
            // _.$("#editor #insertCode").click(Docs.Viewer.onInsertCode)
            
            // _.$("#codeLang").change(Docs.Viewer.onChangeCodeLang);
            // _.$("#cancelCode").click(Docs.Viewer.onCancelCode);
            // _.$("#applyCode").click(Docs.Viewer.onApplyCode);
        }
        
        // ,CodeEditor: null
        // ,onInsertCode: function(){
        //     var val =  Docs.Viewer.DocContent.getCKInstance().getSelection().getSelectedText();
        //     _.$("#codePopup").display("block");
        //      Docs.Viewer.CodeEditor.setContent(val);
            
        // }
        // ,onChangeCodeLang: function(e){

        //     var lang = this.value;
        //     Docs.Viewer.CodeEditor.editor.getSession().setMode("ace/mode/"+lang)
        // }
        // ,onCancelCode: function(){
            
        //     _.$("#codePopup").display("none");
        // }
        
        // ,onApplyCode: function(){
        //     _.$("#codePopup").display("none");
        //     var html = ;
            
        //     Docs.Viewer.DocContent.getCKInstance().insertHTML("<div>"+html"</div>");
        // }
        
        ,onSave: function(){
            var s = {
                id: Docs.Viewer.CurrentDoc
                ,content: Docs.Viewer.DocContent.getContent()
            }
            Docs.api.SaveContent(s, function(){
                RCore.Dialogs.alert("Статья успешно сохранена!");
            })
        }
        
        ,resizeEditor: function(){
            var ht = _.$("#cke_1_top")[0].getBoundingClientRect().height;
            var hb = _.$("#cke_1_bottom")[0].getBoundingClientRect().height;
            var hh = _.$("#editor .toolbar")[0].getBoundingClientRect().height;
            var h = innerHeight - ht - hb - hh-2;
            _.$("#cke_1_contents").style("height",h+"px")
        }
        
        ,edit: function(id){
            this.CurrentDoc = id;
            _.$("#doc>*").display("none")
            _.$("#doc>form").display("block")
            
            _.$("aside li").removeClass("current")
            _.$("aside li[data-id='"+id+"']").addClass("current")
            
            _.new("div").get("modules/content.php",{id: id}, function(r){
                Docs.Viewer.DocContent.setContent(r);
                Docs.Viewer.resizeEditor();
            })
        }
        
        ,DocContent: null
        ,CurrentDoc: 0
        
        ,show: function(id){
            this.CurrentDoc = id;
            _.$("#doc>*").display("none")
            
            
            _.$("#content #container").get("modules/content.php",{id:id}, function(r){
                _.$("#doc>article").display("block")
                _.$("aside li").removeClass("current")
                _.$("aside li[data-id='"+id+"']").addClass("current")
                _.$("#content #title").HTML(_.$("aside li[data-id='"+id+"']>.clickable h4").text());
            })
        }
        
        ,close: function(){
            _.$("aside li").removeClass("current")
        }
    }
}
_.core(Docs.init)