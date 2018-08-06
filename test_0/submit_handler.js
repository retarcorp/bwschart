_.core (function () {
    
    _.$("form .sms").display("none")
    _.$("form").submit(function(e){
        
        e.preventDefault();
        
        var data = {
            login: _.$("#login").val,
            password: _.$("#password").val
        };
        
        _.postJSON("/api/users/", data, function(d){
            _.$(".sms").display("block");
            _.$(".creds").display("none");
            
            var phone = d.phone.replace(d.phone.substr(3,6),"******");
            _.$(".sms .status b").HTML(phone)
        },function(d){
            console.log(d);
            _.$(".error_message").HTML(d);
        },function(){});
        
    });
    
    _.$("#final").click(function(e){
        e.preventDefault();
        var data = {
            sms: _.$("#sms-code").val
        }
        _.postJSON("/api/users/sms/",data,function(d){
            location.href = d.redirect;
        },function(m){
            _.$(".sms .error_message").HTML(m);
        }, function(r){
            
        })
    })
	

});

var Login = {
    currentStatus: 0
    ,Status:{
        None: 0
        ,SmsPending: 1
        ,Ok: 2
    }
}