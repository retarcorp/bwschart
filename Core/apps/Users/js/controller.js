var Users = {
    init: function(){
        _.Templates.add("User");
        Users.List.init()
        Users.Create.init()
        Users.Editor.init()
        
        Users.ContextMenu = RCore.ContextMenu.create("UserContext",{
            "Редактировать":Users.List.onContextEdit
            ,"Удалить":Users.List.onRemove
        });
        
    }
    
    ,ContextMenu: null
    
    ,api:{
        
        GetUsers:function(f){
            RCore.execApi("modules/list.php","GET",{}, f);
        }
        
        ,Create: function(d,f){
            RCore.execApi("modules/create.php","POST",d,f);
        }
        
        ,GetUser: function(d,f){
            RCore.execApi("modules/user.php","GET",d,f);
        }
        
        ,DeleteUser: function(d,f){
            RCore.execApi("modules/delete.php","POST",d,f);
        }
        
        ,UpdateUser: function(d,f){
            RCore.execApi("modules/user.php","POST",d,f);
        }
    }
    
    ,Create:{
        
        init: function(){
            _.$("#add").click(Users.Create.open);
            _.$("#addUser").submit(this.onCreate);
        }
        ,open: function(){
            _.$(".actions>form").display("none");
            _.$("#addUser").display("block");
        }
        
        ,close: function(){
             _.$("#addUser").display("none");
        }
        
        ,onCreate: function(e){
            e.preventDefault();
            var s = {
                login: _.$("#add-login").val
                ,password: _.$("#add-password").val
                ,role: _.$("#add-role").val
                ,description: _.$("#add-description").val
            }
            
            Users.Create.do(s);
        }
        
        ,do: function(s){
            Users.api.Create(s, function(d){
                if(d.status=="OK"){
                    RCore.Dialogs.alert(d.data);
                    Users.Create.close();
                    Users.List.reload()
                }else{
                    RCore.Dialogs.alert(d.message);
                }
                
            })
        }
        
        
    }
    
    ,List: {
        init: function(){
            this.reload();
        }
        
        ,reload: function(){
            Users.api.GetUsers(function(d){
                for (var i in d){
                    d[i].c_role = (function(r){
                        switch(r*1){
                            case 1: return "guest";
                            case 2: return "moderator";
                            case 3: return "admin";
                        }
                    })(d[i].role)
                    d[i].role_title = (function(r){
                        switch(r*1){
                            case 1: return "Гость";
                            case 2: return "Модератор";
                            case 3: return "Администратор";
                        }
                    })(d[i].role)
                }
                _.$("#users").fromTemplate("User",d);
                Users.ContextMenu.addTarget(_.$("#users li"))
                _.$("#users li").click(Users.List.onOpen);
            })
        }
        
        ,onOpen: function(){
            var id = _.$(this).data("id")*1
            Users.Editor.open(id);
        }
        
        ,onContextEdit: function(el){
            var id = el.data("id")*1
            Users.Editor.open(id);
        }
        
        ,onRemove: function(el){
            var id = el.data("id");
            
            var onDelete = function(s){
                Users.api.DeleteUser(s, function(d){
                    
                    if(d.status == "ERROR"){
                        RCore.Dialogs.alert(d.message);
                        return
                    }
                    if(d.status=="OK"){
                        RCore.Dialogs.alert("Пользователь удален успешно!");
                        el.remove()
                    }
                    if(d.status=="PASSWORD_REQUIRED"){
                        RCore.Dialogs.prompt("Введите пароль пользователя для удаления: ",function(pw){
                            onDelete({id: id, password: pw});
                        },null,"","Удаление пользователя");
                    }
                });
            }
            RCore.Dialogs.confirm("Вы действительно хотите удалить пользователя? Это действие невозможно будет отменить!", function(){
                onDelete({id: id});
            }, null, "Удаление пользователя");
            
        }
    }
    
    ,Editor: {
        init: function(){
            _.$("#user-save").click(this.onSave);
        }
        
        ,Current: 0
        
        ,open: function(id){
            Users.api.GetUser({id: id}, function(d){
                if(d.status.toUpperCase()=="ERROR"){
                    RCore.Dialogs.alert(d.message);
                   
                    return;
                }else{
                    
                    var data = d.data;
                    _.$("#user-login").val = data.login;
                    _.$("#user-old-password").val="" ;
                    _.$("#user-new-password").val="" 
                    _.$("#user-role").val=data.role;
                    _.$("#user-info").val=data.info;
                    Users.Editor.show();
                    Users.Editor.Current = id;
                }
            })
        }
        
        ,onSave: function(){
            var id = Users.Editor.Current;
            var s = {
                id: id
                ,login: _.$("#user-login").val
                ,oldPassword: _.$("#user-old-password").val
                ,password:  _.$("#user-new-password").val
                ,role: _.$("#user-role").val
                ,info:  _.$("#user-info").val
            }
            Users.api.UpdateUser(s, function(d){
                if(d.status=="OK"){
                    RCore.Dialogs.alert("Данные пользователя успешно перезаписаны");
                    Users.List.reload();
                    Users.Editor.hide();
                }else{
                    RCore.Dialogs.alert(d.message);
                }
            })
        }
        
        ,show: function(){
             _.$(".actions>form").display("none");
            _.$("#editor").display("block");
        }
        
        ,hide: function(){
            _.$("#editor").display("none");
        }
    }
};
_.core(Users.init)