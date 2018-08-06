var Auth = {
    init: function(){
        _.$('#username')[0].focus()
        _.$("#login").submit(Auth.onSubmit);
    }
    
    ,onSubmit: function(e){
        e.preventDefault();
        var s = {login: _.$("#username").val, password:_.$("#password").val};
        
        _.new("div").post("./login.php",s, function(d){
           try{
               var d = JSON.parse(d);
               if(d.status=="OK"){
                    if(Auth.redirect){
                        location.href = Auth.redirect
                    }else{
                        location.href="/Core/";
                    }
                   
               }else{
                   RCore.Dialogs.alert(d.message);
               }
               
           } catch(e){
               RCore.Dialogs.alert(d);
           }
        });
        console.log(s);
    }
}
_.core(Auth.init);