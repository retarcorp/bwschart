var App = {
    
    init: function(){
        App.List.init();
        App.List.reload();
        _.$("template").forEach(function(e){
            _.Templates.add(e.id);
        },true)
        
        App.Context1 = RCore.ContextMenu.create("Context1", {
            "Редактировать": App.List.onEdit
            ,"Дублировать":App.List.onDuplicate
            ,"Копировать": App.List.onCopy
            ,"Вырезать": App.List.onCut
            ,"Вставить до": App.List.onPasteBefore
            ,"Вставить после": App.List.onPasteAfter
            ,"Обменять с..": App.List.onSwapInit
            ,"Обменять с этим": App.List.onSwapFinish
            ,"Удалить": App.List.onDelete
        })
        App.Context1.onbeforeopen = App.List.onBeforeContext
        App.Context1.set(4,{disabled: true});
        App.Context1.set(5,{disabled: true});
        App.Context1.set(7,{disabled: true});
    }
    
    , countLicensesLenght: function(d) { //add
        var list = document.getElementById('lvl1').getElementsByTagName('li');
        var all = 0, act = 0;
        d.forEach(function(elem, i){
            all += 1;
            if((new Date(elem.expire).getTime()) > Date.now()){
                act += 1;
                list[i].classList.add('activeLicenses');
            }
            else {
                list[i].classList.add('noActiveLicenses');
            }
        });
        var block = document.getElementById('licensesCount'); 
        // block.innerText = 'Всего: ' + all + '. ' + 'Активных: ' + act + '.';
        block.innerText = all + '(' + act + ')';
    }
    ,Data: {}
    ,Context1: null
    ,api:{
        GetItems: function(f){
            RCore.execApi("modules/list.php","GET",{level: 0},function(d){
                f(d)
            })
        }
        
        ,SaveContent: function(d,f){
            RCore.execApi("modules/save.php","POST",d,f);
        }
        
        ,CreateItem: function(d,f){
            RCore.execApi("modules/create.php","POST",d,f)
        }
        
        ,DeleteItem: function(d,f){
            RCore.execApi("modules/delete.php","POST",d,f)
        }
        
        ,SwapItems: function(d,f){
            RCore.execApi("modules/swap.php","POST",d,f)
        }
        
        ,PasteBefore: function(d,f){
            RCore.execApi("modules/paste.php","POST",d,f);
        }
    }
    
    ,List:{
        
        init: function(){
            _.$("#createItem").click(this.onCreate);    
        }
        
        ,onBeforeContext: function(){
             App.Context1.set(4,{disabled: true});
            App.Context1.set(5,{disabled: true});
            App.Context1.set(7,{disabled: true});
            
            if(App.List.Buffer.action == "copy" || App.List.Buffer.action == "cut"){
                App.Context1.set(4,{disabled: false});
                App.Context1.set(5,{disabled: false});
            }
            
            if(App.List.Buffer.action == "swap" ){
                App.Context1.set(7,{disabled: false});
            }
        }
        
        ,onCreate: function(e){
            App.api.CreateItem({id: 0, level: 0},function(d){
                App.List.reload()
            })
        }
        
        ,reload: function(){
            App.api.GetItems(App.List.build)
            if(App.List.Buffer.action == "cut"){
                App.Form.hide();
            }
            App.List.Buffer.action="none";
        }
        
        ,build: function(d){
            _.$("#lvl1").fromTemplate("Level1",d);
            App.Context1.addTarget(_.$("#lvl1 li"))
            _.$("#lvl1 li").click(App.List.onClick)
            _.$("#lvl1 li[data-id='"+App.Form.CurrentItem+"']").addClass('active')
            
            App.countLicensesLenght(d);
        }
        
        ,onClick: function(ev){
            var id = _.$(this).data('id')*1;
            App.Form.open(id, 0);
        }
        
        ,onEdit: function(el){
            var id = el.data("id")*1;
            App.Form.open(id, 0);
        }
        
        ,onDelete: function(el){
            var id = el.data("id")*1;
            RCore.Dialogs.confirm("Вы действительно хотите удалить этот элемент и все вложенные в него элементы? Это действие нельзя будет отменить.", function(){
                App.api.DeleteItem({id: id, level: 0}, function(d){
                    if(id==App.Form.CurrentItem){
                        App.Form.hide();
                    }
                    _.$("#lvl1 li[data-id='"+id+"']").remove()
                    if(App.List.Buffer.subject == id){
                        App.List.Buffer.action = "none";
                        
                    }
                })
            },null,"Удаление элемента");
            
            App.List.reload(); // add
        }
        
        ,Buffer:{
            subject: null
            ,action: "none"
            ,object: null
        }
        
        ,onCopy: function(el){
            var id = el.data("id");
            App.List.Buffer.subject = id;
            App.List.Buffer.action = "copy";
        }
        
        ,onCut: function(el){
            var id = el.data("id");
            App.List.Buffer.subject = id;
            App.List.Buffer.action = "cut";
        }
        
        ,onSwapInit: function(el){
            var id = el.data("id");
            App.List.Buffer.subject = id;
            App.List.Buffer.action = "swap";
        }
        
        ,onSwapFinish: function(el){
            var id = el.data("id");
            App.List.Buffer.object = id;
            App.api.SwapItems({id:id, target: App.List.Buffer.subject, level: 0}, function(d){
                App.List.reload();
            })
        }
        
        ,onPasteBefore: function(el){
            var before = el.data("id");
            App.List.Buffer.object = before;
            App.api.PasteBefore({id: App.List.Buffer.subject, before: before, level: 0, action: App.List.Buffer.action}, function(d){
                App.List.reload();
            })
        }
        
        ,onPasteAfter: function(el){
            var after = el.data("id");
            App.List.Buffer.object = after;
            App.api.PasteBefore({id: App.List.Buffer.subject, after: after, level: 0, action: App.List.Buffer.action}, function(d){
                App.List.reload();
            })
        }
        
        ,onDuplicate: function(el){
            var id = el.data("id");
            App.List.Buffer.object = id;
            App.List.Buffer.action = "copy";
             App.api.PasteBefore({id: id, before: id, level: 0, action: App.List.Buffer.action}, function(d){
                App.List.reload();
            })
        }
        
        
    }
    
    ,Form:{
        
        CurrentItem: 0
        ,CurrentLevel: 0
        ,open: function(id, level){
            this.CurrentItem = id;
            this.CurrentLevel = level;
            _.$("#lvl1 li").removeClass('active')
            _.$("#lvl1 li[data-id='"+App.Form.CurrentItem+"']").addClass('active')
            this.load(id, level)
        }
        
        ,show: function(){
            _.$("#editForm").display("block");
        }
        
        ,hide: function(){
            _.$("#editForm").display("none");
        }
        
        ,load: function(id, level){
            _.$("#editForm #fields").get("modules/form.php",{id: id, level: level}, function(e){
                App.Form.init();
            });
        }
        
        ,CKFields : {}
        ,init: function(){
            this.CKFields = {};
            var imgFields = _.$("#editForm [data-type='image']");
            var textFields = _.$("#editForm [data-type='text']");
            var stringFields = _.$("#editForm [data-type='string']");
            var contentFields = _.$("#editForm [data-type='ctext']");
            var numFields = _.$("#editForm [data-type='int'], #editForm [data-type='float']");
            var boolFields = _.$("#editForm [data-type='bool'");
            
            this.initImageFields(imgFields);
            this.initTextFields(textFields);
            this.initContentFields(contentFields);
            App.Form.show()
            
            _.$("#save").unevent("click",this.onSave);
            _.$("#save").click(this.onSave);
            
        }
        
        ,initImageFields: function(els){
            
            els.forEach(function(el){
                _.cImager.replace({input:"field-"+el.data("name"), folder: App.Data.ImagerFolder})
            })
        }
        
        ,onClickImageField: function(e){
            
            var name = _.$(this).parent().data("name");
            RCore.Dialogs.alert(name)
        }
        
        ,initTextFields: function(els){
            
            els.forEach(function(e){
                e.find("textarea").val = e.find("xmp").HTML();
            })
        }
        
        ,initContentFields: function(els){
            els.forEach(function(e){
                e.find("div").HTML(e.find("xmp").HTML());
                App.Form.CKFields[e.data("name")] = RCore.Fields.RichEdit.create(e.find("div"));
            })
        }
        
        ,onSave: function(){
            var s = {};
            _.$("#fields [data-name]").forEach(function(e){
                switch(e.data("type")){
                    case "string":
                    case "int":
                    case "float":
                        s[e.data("name")] = e.find("input").val
                        break;
                    case "bool":
                        s[e.data("name")] = e.find("input[type='checkbox']")[0].checked ? 1 : 0
                        break;
                    case "text":
                        s[e.data("name")] = e.find("textarea").val
                        break;
                    case "image":
                        s[e.data("name")] = e.find("input").val
                        break;
                    case "ctext":
                        s[e.data("name")] = App.Form.CKFields[e.data("name")].getContent()
                        break;
                    default:
                         s[e.data("name")] = e.find("input, textarea").val
                        break;
                }
            })
            s.id = App.Form.CurrentItem;
            s.level =App.Form.CurrentLevel;
            
            console.log(s);
            
            App.api.SaveContent(s,function(r){
                RCore.Dialogs.alert("Сохранено успешно!");
                App.List.reload();
            })
        }
    }
}

_.core(App.init)