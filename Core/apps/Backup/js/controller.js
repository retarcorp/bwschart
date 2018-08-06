var Backup = {
    
    init: function(){
        _.$("#createPoint").submit(Backup.Form.onCreate);
        _.Templates.add("Point");
        Backup.List.reload();
    }
    
    ,api:{
        CreatePoint: function(d,f){
            RCore.execApi("modules/create.php","POST",d,f)
        }
        
        ,List: function(f){
            RCore.execApi("Points/points.json","GET",{p:Math.random()},f)
        }
        
        ,DeletePoint: function(d,f){
            RCore.execApi("modules/delete.php","GET",d,f)
        }
    }
    
    ,List: {
        
        reload: function(){
            Backup.api.List(this.buildList)    
        }
        
        ,buildList: function(d){
            
            for(var i in d){
                var e = d[i];
                e.ts=e.created;
                e.created = RCore.Date.getAgeString(new Date(e.created))
                e.size = RCore.Size.getSizeString(e.size);
                e.contains = e.includes.split("");
                var c = [];
                if(e.contains[0]){
                    c.push("Файлы сайта")
                }
                if(e.contains[1]){
                    c.push("Дамп базы данных")
                }
                e.contains = c.join(", ");
                d[i]=e;
            }
            
            _.$("#points").fromTemplate("Point",d);
            _.$("#points li .delete").click(Backup.List.onDelete)
            _.$("#points li .download").click(Backup.List.onDownload)
            _.$("#points li .backup").click(Backup.List.onBackup)
        }
        
        ,onDelete: function(e){
            var ts = _.$(this).parent(2).data("created");
            
            RCore.Dialogs.confirm("Вы действительно хотите удалить эту точку? Восстановить ее впоследствии будет невозможно!",function(){
                Backup.api.DeletePoint({ts: ts}, function(d){
                    Backup.List.onDeleteDone(ts)
                })    
            }, null, "Удаление точки восстановления");
            
        }
        
        ,onDeleteDone: function(ts){
            _.$("#points li[data-created='"+ts+"']").remove();
        }
        
        ,onDownload: function(e){
            var ts = _.$(this).parent(2).data("created");
            window.open("modules/download.php?ts="+ts);
        }
        
        ,onBackup: function(e){
            var ts= _.$(this).parent(2).data("created");
            RCore.Dialogs.confirm("Вы действительно хотите откатить весь проект до состояния на "+ts+"? Все изменения, сделанные после этого момента, будут утеряны без возможности восстановления!",function(){
                location.href="restore.php?ts="+ts;
            },null,"Откат системы");
        }
    }
    ,Form:{
        
        onCreate: function(e){
            e.preventDefault();
            var s = {
                title: _.$("#title").val
                ,comment: _.$("#comment").val
                ,type: _.$("#type-backup")[0].checked ? "backup" : "project"
                ,"include-files": _.$("#include-files")[0].checked ? 1 : 0
                ,"include-mysql": _.$("#include-mysql")[0].checked ? 1 : 0
            }
            if(!s.title.trim()){
                RCore.Dialogs.confirm("Вы действительно хотите создать точку без названия? В дальнейшем узнать цель создания такой точки без имени будет невозможно!",function(){
                        Backup.Form.save(s)
                    },null,"Сохранение безымянной точки")
            }else{
                Backup.Form.save(s)
            }
        }
        
        ,SaveDialog: null
        ,save: function(s){
            Backup.Form.SaveDialog = RCore.Dialogs.process("Подождите, пожалуйста. Создание точки восстановления может занять какое-то время.",null,"Создание точки восстановления");
            Backup.api.CreatePoint(s, Backup.Form.onSaveDone);
        }
        
        ,onSaveDone: function(d){
            Backup.Form.SaveDialog.remove();
            RCore.Dialogs.alert("Точка восстановления создана успешно!");
            Backup.List.reload()
        }
    }
}
_.core(Backup.init);