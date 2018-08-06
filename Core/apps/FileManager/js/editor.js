FM.Editor = {
    
    init: function(){
        _.Templates.add('EditorTab');
        _.Templates.add('EditorElement');
        window.onbeforeunload=FM.Editor.onUnload;

    }
    
    ,onUnload: function(e){
        for(var path in FM.Editor.Files){if(FM.Editor.Files[path].unsaved) 
            return "Имеются несохраненные изменения. Вы действительно хотите покинуть редактор?";
        }
    }
    
    
    ,Files:[]
    ,Editors:[]
    ,Current: ""
    
    ,open: function(path){
        
        if(typeof FM.Editor.Files[path] == "undefined"){
            FM.Editor.openTab(path);
            
        }else{
            FM.Editor.Tabs.focus(path);
            FM.Editor.show();
        }
        
    }
    
    ,openTab: function(path){
        FM.Api.FileContent(path,function(d){
            var content = d.data;
            FM.Editor.Tabs.create(path,content);
            FM.Editor.show();
        })
    }
    
    
    ,Tabs:{
        create: function(path,content){
            var tab = _.new("div");
            var name = path.split("/");
            name = name[name.length-1];
            var ext = name.split(".");
            ext = ext[ext.length-1];
            
            tab.fromTemplate("EditorTab",[{path:path, name: name, ext: ext}]);
            var li = tab.find("li")[0];
            _.$("#editor-tabs ul")[0].appendChild(li);
            _.$(li).click(FM.Editor.Tabs.onClickTab);
            _.$(li).find(".closeTab").click(FM.Editor.Tabs.onCloseTab);
            
            //delete tab;
            
            var elem = _.new("div");
            elem.fromTemplate("EditorElement",[{path: path, content: content}]);
            elem.find(".ace")[0].textContent = elem.find(".ace").HTML();
            var li = elem.find("li")[0];
            _.$("#editor-elements ul")[0].appendChild(li);
            var container = _.$(li).find(".ace")[0];
            
            var id = "editor-"+Math.round(Math.random()*10000000);
            container.id = id;
            container.style.height = innerHeight-30+"px";
            
            FM.Editor.Editors[path] = ace.edit(id);
            var editor = FM.Editor.Editors[path];
            FM.Editor.buildEditor(editor, name, content, path)
            FM.Editor.Files[path]={
                name: name
                ,path: path
                ,unsaved: false
            };
            FM.Editor.Tabs.focus(path);
            
            delete elem;
        }
        
        ,focus: function(path){
            if(typeof path=="number"){
                path = Object.keys(FM.Editor.Files)[path];
                
            }
            if(path==undefined) return;
            
            _.$("#editor-elements li").display("none")
            _.$("#editor-elements li[data-path='"+path+"']").display("block");
            _.$("#editor-tabs li").removeClass("active");
            _.$("#editor-tabs li[data-path='"+path+"']").addClass("active");
            
            FM.Editor.Current = path;
            FM.Editor.Editors[path].focus();
        }
        
        ,onClickTab: function(e){
            FM.Editor.Tabs.focus(_.$(this).data("path"))
           // console.log(this)
        }
        
        ,onCloseTab: function(e){
            e.stopPropagation();
            var path = _.$(this).parent().data("path");
           FM.Editor.Tabs.closeTab(path);
        }
        
        ,closeTab: function(path){
             var el = FM.Editor.Files[path];
            if(el.unsaved){
                RCore.Dialogs.confirm("Вы уверены, что хотите закрыть вкладку? Последние изменения не были сохранены!",function(){
                    FM.Editor.Tabs.remove(path);
                },function(){
                    FM.Editor.Editors[path].focus();
                });
            }else{
                FM.Editor.Tabs.remove(path);
            }
        }
        ,remove: function(path){
            _.$("#editor li[data-path='"+path+"']").remove();
            var i = Object.keys(FM.Editor.Files).indexOf(path);
            delete FM.Editor.Files[path];
            delete FM.Editor.Editors[path];
            if(i==0){
                i+=1;
            }if(i==Object.keys(FM.Editor.Files).length){
                i-=1;
            }
            
            if(Object.keys(FM.Editor.Files).length==0){
                FM.Editor.hide();
            }else{
                FM.Editor.Tabs.focus(i);
            }
        }
    }
    
    ,buildEditor: function(editor, name, content, path){
        editor.$blockScrolling = Infinity;
        editor.setTheme("ace/theme/textmate");
        var ext = name.split(".");
        ext = ext[ext.length-1];
        switch(ext){
			case "php": mode = "php";	break;
			case "js": mode = "javascript";	break;
			case "html": mode = "html"; break;
			case "json": mode = "json"; break;
			case "sql": mode = "mysql"; break;
			case "css": mode = "css"; break;
			default: mode = "text"; break;
		}
		
        editor.setValue(content);
        editor.getSession().setMode("ace/mode/"+mode);
        editor.clearSelection()
        editor.getSession().setUseWrapMode(true);
        
        
        editor.commands.addCommand({
			name: 'Close',
			bindKey: {win: 'Esc',  mac: 'Esc'},
			exec: function(editor) {
    	        FM.Editor.hide();
			},
			readOnly: false 
		});

		editor.commands.addCommand({
			name: 'Save',
			bindKey: {win: 'Ctrl+S',  mac: 'Command+S'},
			exec: function(editor) {
    			var content = editor.getValue();
				var path = FM.Editor.Current;
				FM.Editor.Save(path,content);
			},
			readOnly: false 
		});
		
		editor.commands.addCommand({
			name: 'Close Tab',
			bindKey: {win: 'Alt+W',  mac: 'Alt+W'},
			exec: function(editor) {
    			
				var path = FM.Editor.Current;
				FM.Editor.Tabs.closeTab(path);
			},
			readOnly: false 
		});
		
		for(var i=1; i<=9; i++){
		    (function(i){
    		   	editor.commands.addCommand({
        			name: 'Focus Tab '+i,
        			bindKey: {win: 'Alt+'+i,  mac: 'Alt+'+i},
        			exec: function(editor) {
        				FM.Editor.Tabs.focus(i-1);
        			},
        			readOnly: false 
        		}); 
		    })(i)
		}
	
		
		editor.on("change", function(e) {
            
            FM.Editor.unsave(path);
        })
    }
    
    ,unsave: function(path){
        FM.Editor.Files[path].unsaved = true;
        _.$("#editor-tabs li[data-path='"+path+"']").addClass("unsaved")
    }
    
    ,Save: function(path, content){
        FM.Api.SaveContent({path: path, content: content},function(d){
            if(d.status=="ERROR"){
                RCore.Dialogs.alert(d.message);
            }else{
                _.$("#editor-tabs li[data-path='"+path+"']").removeClass("unsaved")
                FM.Editor.Files[path].unsaved=false;
            } 
            
        });  
    }
    
    ,show: function(){
        if(Object.keys(FM.Editor.Files)==0) return;
        _.$("#editor").display("block");
    }
    
    ,hide: function(){
        _.$("#editor").display("none");
    }
    
}
_.core(FM.Editor.init)