var Imager = {
    
    init: function(){
        _.Templates.add("Folder");
        _.Templates.add("Image")
        Imager.Folders.init()
        Imager.Images.init()
        Imager.FolderContext = RCore.ContextMenu.create("FolderContext",{
            "Открыть": Imager.Folders.onOpen
            ,"Переименовать": Imager.Folders.onRename
            ,"Удалить": Imager.Folders.onDelete
        });
        Imager.ImageContext = RCore.ContextMenu.create("ImageContext",{
           "Свойства": Imager.Images.onProperties
           ,"Скачать": Imager.Images.onDownload
           ,"Удалить":Imager.Images.onDelete
        });
    }
    
    ,ImageContext: null
    ,FolderContext: null
    
    ,api:{
        GetFolders: function(f){
            RCore.execApi("modules/folders/list.php","GET",{},f);
        }    
        
        ,CreateFolder: function(d,f){
            RCore.execApi("modules/folders/create.php","POST",d,f);
        }
        
        ,RenameFolder: function(d,f){
            RCore.execApi("modules/folders/rename.php","POST",d,f)
        }
        
        ,RemoveFolder: function(d,f){
            RCore.execApi("modules/folders/remove.php","POST",d,f);
        }
        
        ,GetImages: function(d,f){
            RCore.execApi("modules/images/list.php","GET",d,f)
        }
        
        ,ImageProperties: function(d,f){
            RCore.execApi("modules/images/properties.php","GET",d,f)
        }
        
        ,DeleteImage: function(d,f){
            RCore.execApi("modules/images/delete.php","POST",d,f)
        }
    }
    
    ,Folders:{
        init: function(){
            this.reload()
            _.$("#addFolder").click(Imager.Folders.onCreate);
        }
        
        ,reload: function(){
            Imager.api.GetFolders(Imager.Folders.buildList);
        }
        
        ,buildList: function(d){
            _.$("aside .folders").fromTemplate("Folder",d);
            _.$("aside .folders li").click(Imager.Folders.onClick)
            
            Imager.FolderContext.addTarget(_.$("aside .folders li"))
        }
        
        ,onClick: function(e){
            Imager.Folders.onOpen(_.$(this));
        }
        
        ,CurrentFolder: -1
        ,onOpen: function(el){
            Imager.Folders.CurrentFolder = el.data("id")*1;
            Imager.Images.open(this.CurrentFolder);
        }
        
        
        ,onCreate: function(e){
            RCore.Dialogs.prompt("Введите название новой папки",function(name){
                Imager.Folders.create(name);
            },null,"Новая папка","Создание папки хранилища");
        }
        
        ,create: function(name){
            Imager.api.CreateFolder({title:name}, this.reload);
            Imager.Images.close()
        }
        
        ,onRename: function(el){
            RCore.Dialogs.prompt("Введите новое название папки:",function(name){
                Imager.Folders.rename(el.data("id"),name);   
            },null, el.data("title"),"Переименование папки");
        }
        
        ,rename: function(id, title){
        
            Imager.api.RenameFolder({id: id, title: title}, function(){
                _.$("aside .folders li[data-id='"+id+"']").find("h3 span").HTML(title)
            })
            Imager.Images.close()
        }
        
        ,onDelete: function(el){
            RCore.Dialogs.confirm("Вы действительно хотите удалить папку?",function(){
                Imager.Folders.remove(el.data("id")*1);
            }, null, "Удаление папки");
        }
        
        ,remove: function(id){
            Imager.api.RemoveFolder({id: id}, function(d){
                _.$("aside .folders li[data-id='"+id+"']").remove()
            })
            Imager.Images.close()
        }
    }
    
    ,Images: {
        
        init: function(){
            _.$("#image").change(this.onSelectImage)
            _.$(".imageList").event("dragover",function(e){e.preventDefault()})
            _.$(".imageList").event("drop",this.onDrop)
            _.$(".imageList").event("dragenter",this.onDragEnter);
            _.$(".imageList").event("dragleave",this.onDragLeave);
            
        }
        
        ,onDrop: function(e){
            e.preventDefault();
            _.$(this).removeClass("drag");
            var files = e.dataTransfer.files;
            var toUpload = [];
            var unaccepted = 0;
            for(var i =0; i<files.length; i++){
                var c = Imager.Images.accepted(files[i]);
                if(!c){
                    unaccepted++;
                    continue;
                }
                toUpload.push(files[i]);
            }
            if(unaccepted!=0){
                RCore.Dialogs.alert("Не допущено к загрузке "+unaccepted+" файлов. Допускаются только файлы форматов JPEG, PNG, GIF, BMP.");
            }
            if(toUpload.length){
                var size = toUpload.reduce(function(p,c){return p+c.size},0);
                Imager.Images.UploadDialog = RCore.Dialogs.process("Загружаем изображения: "+toUpload.length+" ("+RCore.Size.getSizeString(size)+")");
                Imager.Images.upload(Imager.Folders.CurrentFolder, toUpload, function(){
                    Imager.Images.open(Imager.Folders.CurrentFolder)  
                    Imager.Images.UploadDialog.remove();
                });
            }
            
        }
        
        ,onDragEnter: function(e){
            _.$(this).addClass("drag");
        }
        
        ,onDragLeave: function(e){
            _.$(this).removeClass("drag");
        }
        
        ,onSelectImage: function(e){
            var img = this.files[0];
            if(Imager.Images.accepted(img)){
                
                Imager.Images.UploadDialog = RCore.Dialogs.process("Загружаем изображение "+img.name+"("+RCore.Size.getSizeString(img.size)+")");
                Imager.Images.upload(Imager.Folders.CurrentFolder,[img], function(d){
                    Imager.Images.UploadDialog.remove()
                    Imager.Images.open(Imager.Folders.CurrentFolder);
                });
            }else{
                RCore.Dialogs.alert("Выбранный файл не является изображением! Допустимые форматы: JPG, PNG, GIF, BMP");
            }
        }
        
        ,UploadDialog: null
        
        ,accepted: function(img){
            switch(img.type){
                case "image/png":
                case "image/jpeg":
                case "image/gif":
                case "image/bmp":
                    
                    break;
                default:
                
                    
                    return false;
                    break;
            }
            return true;
        }
        
        ,upload: function(id, images, f){
            var xhr = new XMLHttpRequest();
            xhr.open("POST","modules/images/upload.php");
            xhr.onload = function(){
                try{
                    var d = JSON.parse(xhr.responseText);
                }catch(e){
                    RCore.Dialogs.alert(xhr.responseText);
                    console.error(e,r);
                    return;
                }
                f(d);
            }
            var fd = new FormData();
            fd.append("id",id);
            for(var i in images){
                fd.append("image"+i,images[i]);
            }
            xhr.send(fd);
        }
        
        
        ,open: function(id){
            Imager.api.GetImages({id:id}, function(d){
                _.$("#imagesUL").fromTemplate("Image",d)
                Imager.ImageContext.addTarget(_.$("#imagesUL li"));
            })
            _.$(".imageList").display("block")
        }
        
        ,close: function(){
            _.$(".imageList").display("none")
        }
        
        ,onProperties: function(el){
            Imager.api.ImageProperties({id: el.data("id")}, function(d){
                RCore.Dialogs.alert("<p>Идентификатор: "+d.id+"</p><p>Путь к изображению: "+d.url+"</p><p>Название при загрузке: "+d.title+"</p><p>Размер: "+RCore.Size.getSizeString(d.size)+"</p>",null,"Свойства изображения #"+d.id);
            });
        }
        
        ,onDelete: function(el){
            RCore.Dialogs.confirm("Вы действительно хотите удалить изображение #"+el.data("id"),function(){
                Imager.api.DeleteImage({id:el.data("id")}, function(){
                    el.remove();
                })
            }, null, "Удаление изображения");   
        }
        
        ,onDownload: function(el){
            var id = el.data("id");
            window.open("modules/download.php?id="+id);
        }
    }
}

_.core(Imager.init)