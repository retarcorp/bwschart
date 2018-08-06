var FM = {
    
    Data:{
        
    }
    
    ,Stack:[""]
    
    ,Api:{
        
        exec: function(method, path, data, c){
            method = method.toUpperCase();
            var xhr = new XMLHttpRequest();
            var callback = function(r){
                var d = [];
                try{
                    d = JSON.parse(r);
                    
                }catch(e){
                    RCore.Dialogs.alert(r);
                    return;
                    //throw e;
                }
                c(d);
            }
            
            switch(method){
                case "DELETE":
                case "GET":{
                    path+="?";
                    for(var key in data){
                        path+=encodeURIComponent(key)+"="+encodeURIComponent(data[key])+"&";
                    }
                    xhr.open(method, path, true);
                    xhr.onload = function(){
                        callback(xhr.responseText);
                    }
                    xhr.send(null);
                    break;
                }
                case "PUT":
                case "POST":{
                    if(data instanceof FormData){
                        var fd = data;
                    }else{
                        var fd = new FormData();
                        for(var key in data){
                            fd.append(key,data[key]);
                        }
                    }
                    xhr.open(method,path,true);
                    xhr.onload = function(){
                        callback(xhr.responseText);
                    }
                    xhr.send(fd)
                    break;
                }
                
            }
            
            
        }
        
        ,GetItemList: function(p,f){
            FM.Api.exec("GET","modules/files/",{path:p},f)
        }
        
        ,RenameFolder: function(s,f){
            FM.Api.exec("POST","modules/folders/rename.php",s,f);
        }
        
        ,RenameFile: function(s,f){
            FM.Api.exec("POST","modules/files/rename.php",s,f);
        }
        
        ,Archivate: function(s,f){
            FM.Api.exec("POST","modules/zip/archive.php",s,f);
        }
        
        ,RemoveFile: function(s,f){
            FM.Api.exec("DELETE","modules/files/delete.php",s,f)
        }
        
        ,RemoveFolder: function(s,f){
            FM.Api.exec("DELETE","modules/folders/delete.php",s,f)
        }
        
        ,CreateFile: function(name, f){
            FM.Api.exec("POST","modules/files/create.php",{path: name}, f)
        }
        
        ,CreateFolder: function(name, f){
            FM.Api.exec("POST","modules/folders/create.php",{path: name}, f)
        }
        
        ,GetProperties: function(s,f){
            FM.Api.exec("GET","modules/properties.php",s, f)
        }
        
        ,Copy: function(s,f){
            FM.Api.exec("GET","modules/copy.php",s, f)
        }
        
        ,Cut: function(s,f){
            FM.Api.exec("GET","modules/cut.php",s, f)
        }
        
        ,Extract: function(s,f){
            FM.Api.exec("GET","modules/zip/extract.php",s,f);
        }
        
        ,UploadFiles: function(s,f){
            var fd = new FormData();
            for(var i=0; i<s.files.length; i++){
                fd.append("file-"+i,s.files[i]);
            }
            console.log(s);
            fd.append("path",s.path);
            window.fd = fd;
            console.log(fd)
            FM.Api.exec("POST","modules/files/upload.php",fd,f);
            
        }
        
        ,FileContent: function(p,f){
            FM.Api.exec("GET","modules/files/content.php",{path: p}, f)
        }
        
        ,SaveContent: function(s,f){
            FM.Api.exec("POST","modules/files/content.php",s,f)
        }
    }
    
    ,init: function(){
        _.Templates.add("asideItem")
        _.Templates.add("contentItem");
        _.Templates.add("folderProperties")
        _.Templates.add("fileProperties");
        _.Templates.add("pathItem")
        FM.Aside.init();
        FM.Content.init();
        FM.Toolbar.init();
    }
    
    ,Buffer:{
        action: "none"
        ,item: null
    }
    
    ,ContextMenu: {
        init: function(){
            _.$("#elements li").unevent("contextmenu",FM.ContextMenu.onItemContext)
            _.$("#elements li").contextmenu(FM.ContextMenu.onItemContext)
            
            _.$("#elements").unevent("contextmenu",FM.ContextMenu.onGeneralContext)
            _.$("#elements").contextmenu(FM.ContextMenu.onGeneralContext)
            
            _.$("body").unevent("click",FM.ContextMenu.close);
            _.$("body").click(FM.ContextMenu.close);
        }
        
        ,Target: null
        
        
        ,onItemContext: function(e){
            e.stopPropagation();
            e.preventDefault();
            var s = {
                role: _.$(this).data('role'),
                path: _.$(this).data('path'),
                name: _.$(this).find("span").text(),
                ext: _.$(this).find("span").data("ext").toLowerCase()
                
            }
            FM.ContextMenu.Target = s;
            var coords = {x: e.clientX, y: e.clientY};
            FM.ContextMenu.openFor(s,coords);
        }
        
        ,onGeneralContext: function(e){
            var coords  = {x: e.clientX, y:e.clientY};
            FM.ContextMenu.openGeneral(coords)
            e.preventDefault();
            e.stopPropagation()
        }
        
        ,openFor: function(data,coords){
            FM.ContextMenu.close();
            
            _.$("#itemContextMenu li, #itemContextMenu ul").display("block");
            switch(data.role){
                case "file": {
                    
                    switch(data.ext){
                        case "zip":
                            _.$("#itemContextMenu").find(".archivate").display("none");
                            _.$("#itemContextMenu .extract-to-folder span").HTML(data.name.split(".zip").join(""));
                            
                            break;
                        default:
                            _.$("#itemContextMenu").find(".folder").display("none"); 
                            break;
                    }
                    
                    break;
                }
                case "folder":  {
                    _.$("#itemContextMenu").find(".edit, .extract-here, .extract-to-folder, .extract-to, .download").display("none"); 
                    
                    break;
                }
            }
            _.$("#itemContextMenu").display("block");
            FM.ContextMenu.put(_.$("#itemContextMenu"), coords);
            
            _.$("#itemContextMenu li").unevent("click",FM.ContextMenu.onSelectFile)
            _.$("#itemContextMenu li").click(FM.ContextMenu.onSelectFile)
           
        }
        
        ,openGeneral: function(coords){
            FM.ContextMenu.close();
            _.$("#generalContextMenu").display("block");
            FM.ContextMenu.put(_.$("#generalContextMenu"), coords);
            _.$("#generalContextMenu li").removeClass("inactive");
            
            if(FM.Buffer.item==null){
                _.$("#generalContextMenu li.paste").addClass("inactive");
            }
            
            _.$("#generalContextMenu li").unevent("click",FM.ContextMenu.onSelectGeneral)
            _.$("#generalContextMenu li").click(FM.ContextMenu.onSelectGeneral)
          
        }
        
        ,put: function(el, coords){
            var rect = el[0].getBoundingClientRect();
            var w = rect.width;
            var h = rect.height;
            
            var left = coords.x;
            var top = coords.y;
            
            if(coords.x+w >= innerWidth){
                left = coords.x - w;
            }
            
            if(coords.y+h>=innerHeight){
                top = coords.y - h;
            }
            
            el.style({top: top+"px", left: left+"px"});
        }
        
        ,onSelectFile: function(e){
            e.stopPropagation();
            FM.ContextMenu.close();
            var cl = _.$(this).attr("class");
            var item = FM.ContextMenu.Target;
            switch(cl){
                case "edit": FM.ContextMenu.FileMenu.onEdit(item); break;
                case "rename": FM.ContextMenu.FileMenu.onRename(item); break;
                case "copy": FM.ContextMenu.FileMenu.onCopy(item); break;
                case "cut": FM.ContextMenu.FileMenu.onCut(item); break;
                case "delete": FM.ContextMenu.FileMenu.onDelete(item); break;
                case "archivate": FM.ContextMenu.FileMenu.onArchivate(item); break;
                case "extract-here": FM.ContextMenu.FileMenu.onExtractHere(item); break;
                case "extract-to-folder": FM.ContextMenu.FileMenu.onExtractToFolder(item); break;
                case "extract-to": FM.ContextMenu.FileMenu.onExtractTo(item); break;
                case "download": FM.ContextMenu.FileMenu.onDownload(item); break;
                case "properties": FM.ContextMenu.FileMenu.onProperties(item); break;
            }
        }
        
        ,onSelectGeneral: function(e){
            e.stopPropagation();
            FM.ContextMenu.close();
            var cl = _.$(this).attr("class");
            
            switch(cl){
                case "view-Signs": FM.ContextMenu.GeneralMenu.onViewSigns(); break;
                case "view-List": FM.ContextMenu.GeneralMenu.onViewList(); break;
                case "view-Table": FM.ContextMenu.GeneralMenu.onViewTable(); break;
                case "createFile": FM.ContextMenu.GeneralMenu.onCreateFile(); break;
                case "createFolder": FM.ContextMenu.GeneralMenu.onCreateFolder(); break;
                case "paste": FM.ContextMenu.GeneralMenu.onPaste(); break;
                case "properties": FM.ContextMenu.GeneralMenu.onProperties({path:FM.Content.getCurrentDir(), role: "folder"}); break;
            }
        }
        
        ,close: function(){
            _.$(".context").display("none");
        }
        
        ,FileMenu:{
            onEdit: function(s){
                RCore.Dialogs.alert(s.path);
            }
            
            ,onRename: function(s){
                if(s.role=="folder"){
                    RCore.Dialogs.prompt("Введите новое название папки", function(name){
                        s.newName=name;
                        FM.Api.RenameFolder(s, function(d){
                            if(d.status=="ERROR"){
                                RCore.Dialogs.alert(d.message);
                                return;
                            }
                            if(d.status=="OK"){
                                FM.Content.refresh();
                            }
                            console.log(d.status, d.status=="ERROR");
                            //console.log(d);
                        })
                        
                    }, null, s.name,"Переименование папки");
                }
                if(s.role=="file"){
                    RCore.Dialogs.prompt("Введите новое название файла", function(name){
                        s.newName=name;
                        FM.Api.RenameFile(s, function(d){
                            if(d.status=="ERROR"){
                                RCore.Dialogs.alert(d.message);
                                return;
                            }
                            if(d.status=="OK"){
                                FM.Content.refresh();
                            }
                            console.log(d.status, d.status=="ERROR");
                        })
                    }, null, s.name,"Переименование файла");
                }
                
            }
            
            ,onCopy: function(s){
                FM.Buffer.action="copy";
                FM.Buffer.item=s;
            }
            
            ,onCut: function(s){
                FM.Buffer.action="cut";
                FM.Buffer.item=s;
            }
            
            ,onDelete: function(s){
                if(s.role=="file"){
                    RCore.Dialogs.confirm("Вы действительно хотите удалить файл "+s.name+"?", function(){
                        FM.Api.RemoveFile(s, function(d){
                           FM.Content.refresh(); 
                           
                        });
                    },null,"Подтвердите удаление файла");
                }
                if(s.role=="folder"){
                    RCore.Dialogs.confirm("Вы действительно хотите удалить папку "+s.name+"?", function(){
                        FM.Api.RemoveFolder(s, function(d){
                           FM.Content.refresh(); 
                        });
                    },null,"Подтвердите удаление папки");
                }
            }
            
            ,onArchivate: function(s){
                FM.Api.Archivate(s,function(d){
                    console.log(d);
                    FM.Content.refresh();
                });
            }
            
            ,onExtractHere: function(s){
                FM.Api.Extract(s, function(d){
                    FM.Content.refresh();
                })
            }
            
            ,onExtractToFolder: function(s){
                s.createFolder = 1;
                FM.Api.Extract(s, function(d){
                    FM.Content.refresh();
                })
            }
            
            ,onExtractTo: function(s){
                RCore.Dialogs.prompt("Введите название папки, куда будет распаковано содержимое архива:",function(folder){
                    s.target = folder;
                    FM.Api.Extract(s, function(d){
                        FM.Content.refresh();
                    })
                }, null,null,"Распаковка архива");
            }
            
            ,onDownload: function(s){
                window.open("modules/files/download.php?path="+encodeURIComponent(s.path));
            }
            
            ,onProperties: function(s){
                FM.Api.GetProperties(s, function(r){
                    if(s.role=="folder"){
                        var div = _.new("div");
                        r.size = RCore.Size.getSizeString(r.size);
                        div.fromTemplate("folderProperties",[r]);
                        RCore.Dialogs.alert(div.HTML(),null,"Свойства папки "+r.name);
                    }
                    if(s.role=="file"){
                        var div = _.new("div");
                        r.size = RCore.Size.getSizeString(r.size);
                        r.accessed = RCore.Date.getAgeString(new Date(r.accessed*1000))+" ("+RCore.Date.getDateString(new Date(r.accessed*1000))+")";
                        r.modified = RCore.Date.getAgeString(new Date(r.modified*1000))+" ("+RCore.Date.getDateString(new Date(r.modified*1000))+")";;
                        div.fromTemplate("fileProperties",[r]);
                        RCore.Dialogs.alert(div.HTML(),null,"Свойства файла "+r.name);
                    }
                })
            }
        }
        
        ,GeneralMenu:{
            onViewSigns: function(){
                
            }
            
            ,onViewList: function(){
                
            }
            
            ,onViewTable: function(){
                
            }
            
            ,onCreateFile: function(){
                RCore.Dialogs.prompt("Введите имя нового файла:", function(name){
                    name = FM.Content.getCurrentDir()+name;
                    
                    FM.Api.CreateFile(name, function(d){
                        if(d.status=="ERROR"){
                            RCore.Dialogs.alert(d.message);
                        }
                        FM.Content.refresh();
                    })
                },null,null,"Создание файла");
            }
            
            ,onCreateFolder: function(){
                RCore.Dialogs.prompt("Введите имя новой папки:", function(name){
                    name = FM.Content.getCurrentDir()+name;
                    
                    FM.Api.CreateFolder(name, function(d){
                        if(d.status=="ERROR"){
                            RCore.Dialogs.alert(d.message);
                        }
                        FM.Content.refresh();
                    })
                },null,null,"Создание файла");
            }
            
            ,onPaste: function(){
                if(FM.Buffer.item==null) return;
                
                FM.Buffer.item.target = FM.Content.getCurrentDir();
                if(FM.Buffer.action=="copy"){
                    FM.Api.Copy(FM.Buffer.item, function(d){
                       FM.Content.refresh(); 
                    });
                }
                
                if(FM.Buffer.action=="cut"){
                    FM.Api.Cut(FM.Buffer.item, function(d){
                       FM.Content.refresh(); 
                    });
                }
                
                FM.Buffer.item=null;
            }
            
            ,onProperties: function(s){
                FM.Api.GetProperties(s, function(r){
                    var div = _.new("div");
                    r.size = RCore.Size.getSizeString(r.size);
                    div.fromTemplate("folderProperties",[r]);
                    RCore.Dialogs.alert(div.HTML(),null,"Свойства папки "+r.name);
                })
            }
        }
    }
    
    ,Toolbar:{
        
        Path:{
            build: function(){
                var folder = FM.Content.getCurrentDir();
                if(folder.charAt(folder.length-1)=="/") folder=folder.substr(0, folder.length-1);
                var path= [];
                var curr = folder;
                while(curr!=""){
                    path.push(curr);
                    curr = _.$("#fileTree [data-path='"+curr+"']").parent(1).data("path");
                }
                
                path = path.map(function(e){
                    return {path : e, name: e.split("/").reduce(function(p,c){if(c.trim()) return c; return p;},"Корень")}
                });
                path.push({path:"",name:"Корень"});
                path.sort(function(){return 1;})
                _.$("#toolbar #path").fromTemplate("pathItem", path);
                _.$("#toolbar #path li").click(FM.Toolbar.Path.onClick)
                
            }
            
            ,onClick: function(e){
                FM.open(_.$(this).data("path"));
            }
        }
        
        ,init: function(){
            _.$("#goUp").click(FM.Toolbar.onUp);
            _.$("#goBack").click(FM.Toolbar.onBack);
            _.$('#newFile').click(FM.ContextMenu.GeneralMenu.onCreateFile)
            _.$("#newFolder").click(FM.ContextMenu.GeneralMenu.onCreateFolder)
            _.$("#openEditor").click(FM.Toolbar.onOpenEditor)
        }
        
        ,onOpenEditor: function(){
            FM.Editor.show();
        }
        
        ,onUp: function(){
            var els = _.$("#toolbar #path li");
            if(els.length<2) return;
            els[els.length-2].click();
            
            delete els;
        }
        
        ,onBack: function(e){
            if(FM.Stack.length>=2){
                FM.Stack.pop();
                var toOpen = FM.Stack.pop();
                var path = toOpen;
                if(_.$("#fileTree li[data-path='"+path+"']").length==0){
                    var dir = path.split("/");
                    var l = dir.length-1;
                    do{
                        tmp = dir.slice(0,l);
                        var p = _.$("#fileTree li[data-path='"+tmp.join("/")+"']").length==0;
                        l--;
                        if(l<0) return;
                    }while(p);
                    //console.log(tmp, l);
                    var seq=[];
                    for(; l<dir.length; l++){
                        seq.push(dir.slice(0,l).join("/"));
                    }
                    seq =seq.reverse();
                    seq.unshift(toOpen);
                    var xopen = function(seq){
                        if(seq.length==0) return; //FM.open(toOpen);
                        var path = seq.pop();
                        
                        FM.open(path, function(d){
                            xopen(seq);
                        })
                        
                    }
                    xopen(seq);
                    
                }else{
                    FM.open(path);
                }
            }
        }
        
    }
    
    ,open: function(path, f ){
        _.$("#spinner").display("block")
        FM.Api.GetItemList(path,function(d){
            FM.Aside.onLoadItems(path,d)
            FM.Content.onLoadItems(path,d)
            
            if(typeof f == "function"){
                f(path, d);
            }
            _.$("#spinner").display("none")
            
        })
    }
    
    ,Aside: {
        init: function(){
            FM.open("")
        }
        
        ,onLoadItems: function(path,data){
            //console.log(data);
            _.$("#fileTree ul[data-path='"+path+"']").fromTemplate("asideItem",data);
            FM.Aside.setHandlers();
        }
        
        ,setHandlers: function(){
            _.$("#fileTree li span").unevent("click",FM.Aside.onClickItem);
            _.$("#fileTree li span").click(FM.Aside.onClickItem);
        }
        
        ,onClickItem: function(){
            var s = {
                path: _.$(this).parent().data("path"),
                role: _.$(this).parent().data("role"),
                name: _.$(this).text()
            }
            //console.log(s);
            if(s.role=="folder"){
                FM.open(s.path);
                
            }
            if(s.role=="file"){
                FM.Content.openFile(s.path);
            }
        }
        
    }
    
    
    ,Content: {
        init: function(){
            FM.open("") 
            FM.ContextMenu.init();
            
            FM.Content.Drag.init()
            
        }
        
        ,Drag:{
            init: function(){
                _.$("#elements").event("dragover", FM.Content.Drag.onDragOver);
                _.$("#elements").event("dragenter", FM.Content.Drag.onDragEnter);
                _.$("#elements").event("dragleave", FM.Content.Drag.onDragLeave);
                _.$("#elements").event("drop", FM.Content.Drag.onDrop);
            }
            
            ,onDragOver: function(e){
                e.preventDefault()
            }
            
            ,onDragEnter: function(e){
                _.$("#elements").addClass("drag")
            }
            
            ,onDragLeave: function(e){
                _.$("#elements").removeClass("drag")
            }
            
            ,Dialog: null
            ,MAX_AMOUNT: 30
            ,MAX_SIZE: 100*1024*1024
            ,onDrop: function(e){
                e.preventDefault();
                FM.Content.Drag.onDragLeave();
                var files = e.dataTransfer.files;
                console.log(files);
                
                var len = files.length;
                var size = Array.prototype.slice.apply(files,[0]).reduce(function(p,c){return p+c.size},0)
                console.log(len, size)
                
                if(len>FM.Content.Drag.MAX_AMOUNT){
                    RCore.Dialogs.alert("Нельзя загрузить более "+FM.Content.Drag.MAX_AMOUNT+" файлов одновременно!");
                    return;
                }
                if(size>FM.Content.Drag.MAX_SIZE){
                    RCore.Dialogs.alert("Нельзя загрузить более "+RCore.Size.getSizeString(FM.Content.Drag.MAX_SIZE)+" единовременно!");
                    return;
                }
                
                var dialog = RCore.Dialogs.process("Загрузка данных на сервер. Пожалуйста, подождите.<br/>Файлов: "+len+", общий размер: "+RCore.Size.getSizeString(size),null);
                FM.Content.Drag.Dialog = dialog;
                
                FM.Api.UploadFiles({files:files, path: FM.Content.getCurrentDir()}, function(d){
                    dialog.remove();
                    FM.Content.refresh();
                })
            }
        }
        
        
        ,getCurrentDir: function(){
            return _.$("#elements>ul").data("path")+"/";
        }
        
        ,onLoadItems: function(path, data){
            
            if(FM.Stack[FM.Stack.length-1]!=path){
                FM.Stack.push(path);
            }
            
            _.$("#content #elements ul").data("path",path);
            _.$("#content #elements ul").fromTemplate("contentItem",data);
            FM.Toolbar.Path.build();
            FM.Content.setHandlers();
        }
        
        ,setHandlers: function(){
            FM.ContextMenu.init();
            _.$("#elements li").unevent("click",FM.Content.onClickItem);
            _.$("#elements li").click(FM.Content.onClickItem);
        }
        
        ,onClickItem: function(){
            var s = {
                path: _.$(this).data("path"),
                role: _.$(this).data("role"),
                name: _.$(this).find("span").text()
            }
            //console.log(s);
            if(s.role=="folder"){
                FM.open(s.path);
            }
            
            if(s.role=="file"){
                FM.Content.openFile(s.path);
            }
        }
        
        ,refresh: function(){
            var path = _.$("#elements>ul").data("path");
            FM.open(path)
        }
        
        ,openFile: function(path){
            FM.Editor.open(path);
        }
        
    }

}
_.core(FM.init)