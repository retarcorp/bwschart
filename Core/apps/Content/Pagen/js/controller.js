var A = {

	Data:{
		listedContext: ""
		,page: 0
		,loader: "<div class='miniLoader'> <p> </p> </div>"
		,Atomic:{}
		,Restorable: []
	}
	
	,init: function(){
	    
		A.Data.field = _.$(_.$("#field")[0].contentWindow.document);
		A.grabRestorable();
		//A.Data.field.event("DOMSubtreeModified", A.onDOMModified);
		
// 		A.MObserver= new MutationObserver(A.onDOMModified);
// 		A.MObserver.observe(A.Data.field[0],{
// 		    at  tributes: true
// 		    ,childList: true
// 		    ,characterData: true 
// 		    ,subtree: true
// 		    ,attributeOldValue: true
// 		    ,characterDataOldValue: true
		    
// 		});
		
		A.ListedContext = RCore.ContextMenu.create("listedContext",{
		    "Копировать": A.Listed.onCopy
		    ,"Дублировать": A.Listed.onDuplicate
		    ,"Удалить": A.Listed.onDelete
		    ,"Вставить до": A.Listed.onPasteBefore
		    ,"Вставить после":A.Listed.onPasteAfter

		});
		A.ListedContext.set(3,{disabled:true});
		A.ListedContext.set(4,{disabled:true});
		
		A.enableEditing();
		A.Controls.init();
		A.Layout.hide();
	}
	
	,MObserver: null
	,onDOMModified: function(e){
	    
	}
	
	,Layout:{
		
		show: function(){
			_.$("#layout").display('block');
		}
		
		,hide: function(){
			_.$("#layout").display("none");
		}
	}
	
	,grabRestorable: function(){
	    A.Data.field.find("[restore]").forEach(function(e){
	        A.Data.Restorable.push(e[0].outerHTML);
	    })
	}
	
	,enableEditing: function(){

        // Переместил в самый верх, чтобы события атомарных тегов срабатывали до обнуления
        A.Atomic.init();
        
		A.Data.field.find("[atomic]").attr("contenteditable", "true").click(A.checkIfPropagateNeeded).click(A.null).change(A.null);
		_.new("style").attr("system","").HTML("[atomic]:hover{outline: 1px solid #df1298;} [listed]:hover{outline: 1px solid #13df98} .c_context_current{outline: 2px solid red!important} dynamic>*{opacity:0.2;} [current]{outline: 4px solid orange!important;} img[atomic]{cursor: pointer;} iframe[atomic]{-pointer-events:none;}[richedit]:hover{outline: 1px solid #8c4;}").appendTo(A.Data.field.find("body"));
		
		A.Data.field.find("dynamic").forEach(function(e){
			var path = e.HTML();
			if(path[0]!='/') path="/"+path;
			e.get(path,{}, function(){e.attr("href",path)})
		})
		
		A.Listed.Context.init();

		
	}
	
	,null: function(e){
		
		//По непонятной причине тут стояло stopImmediatePropagation - ?. Мешает открытию контекстных меню для ссылок!
		e.stopImmediatePropagation();
		
		e.preventDefault();
		A.Listed.Context.close()
	}
			
	
	,Atomic:{

		init: function(){
			this.Context.init();
		}
		
		,setCurrent: function(c){
			A.Data.field.find("[current]").removeAttribute("current");
			c.attr("current", "current");
		}
		
		,unsetCurrent: function(){
			A.Data.field.find("[current]").removeAttribute("current");
		}
		
		,Context:{
			
			init: function(){
				var t = this;
				this.unevent();
				
				A.Atomic.Img.init();
				A.Atomic.A.init();
				A.Atomic.Iframe.init();
				A.Atomic.RichEdit.init();
				
				A.Atomic.Context.close();
				
				A.Data.field.find("body, [atomic]").click(function(e){
					if(e.target.tagName=="A") return;
					if(e.target.tagName=="IMG") return;
					
					if(e.target.tagName!="IMG")
						A.Atomic.Context.close()
				})
			}
			
			,unevent: function(){
				var t = this;
				A.Atomic.Img.unevent();
			}
			
			,close: function(){
				_.$("#atomicContext>*").display("none");
				A.Atomic.unsetCurrent();
			}
			
			,open: function(c){
				
				A.Atomic.Context.close();
				if(c=="img"){
					_.$("#imgContext").display("block");
				}
				
				if(c=="a"){
					_.$("#aContext").display("block");
				
				}
			}
		}
		
		,RichEdit:{
			init: function(){
				A.Data.field.find("[richedit]").unevent("click",A.Atomic.RichEdit.onClick);
				A.Data.field.find("[richedit]").click(A.Atomic.RichEdit.onClick);
				
				CKEDITOR.replace("ckeditor"
					,{
						filebrowserUploadUrl: '/Core/apps/Imager/upload.php'
					});
				A.Data.editor = CKEDITOR.instances.ckeditor;
				
				_.$("#ckaccept").click(A.Atomic.RichEdit.accept);
				_.$("#popupContext>*").click(function(e){
					e.stopPropagation();
				})
				
				_.$("#popupContext").click(function(e){
					_.$(this).display("none");
				})
			}
			
			,onClick: function(e){
				A.Data.richEdited = _.$(this);					
				A.Data.editor.setData(_.$(this).HTML()); 
				_.$("#popupContext").display("block");
			}
			
			,accept: function(e){
				var html = A.Data.editor.getData();
				A.Data.richEdited.HTML(html);
				_.$("#popupContext").display("none");
			}
		}
		
		,Iframe:{
		
			init: function(){
				A.Data.field.find("iframe[atomic]").forEach(function(e){
					var s = e.size();
					e.removeAttribute("atomic").removeAttribute("contenteditable");
					e[0].outerHTML = "<textarea code style='width: "+s.width+"px; height: "+s.height+"px;'>"+e[0].outerHTML+"</textarea>";
				});
			}
			
			,onClick: function(e){
				e.preventDefault();
				alert();
			}
		}
		
		,A:{
			
			init: function(){
			    
			    this.unevent()
				A.Data.field.find('a[atomic]').click(A.Atomic.A.onClick)
				
				this.setHandler();	
			}
			
			,unevent: function(){
				A.Data.field.find('a[atomic]').unevent('click', A.Atomic.A.onClick)
			}
			
			,onClick: function(e){
			    console.log(1)
				e.stopPropagation();
				A.Data.Atomic.a = _.$(this);
				A.Atomic.Context.open("a");
				A.Atomic.A.open();
				A.Atomic.setCurrent(_.$(this));
				
			}
			
			,open: function(){
				_.$("#aHref").val = A.Data.Atomic.a.attr("href");
				_.$("#aTitle").val = A.Data.Atomic.a.attr("title");
				_.$("#aNofollow")[0].checked = A.Data.Atomic.a.attr("rel")=="nofollow" ? true : false;
				_.$("#aTargetblank")[0].checked = A.Data.Atomic.a.attr("target")=="_blank" ? true : false;
			}
			
			,setHandler: function(){
				_.$("#aSave").click(function(){
					A.Data.Atomic.a.attr("href", _.$("#aHref").val);
					A.Data.Atomic.a.attr("title", _.$("#aTitle").val);
					_.$("#aNofollow")[0].checked ? A.Data.Atomic.a.attr("rel","nofollow") : A.Data.Atomic.a.removeAttribute("rel");
					_.$("#aTargetblank")[0].checked ? A.Data.Atomic.a.attr("target","_blank") : A.Data.Atomic.a.removeAttribute("target");
					A.Atomic.Context.close();
				})
			}
			
		}
		
		,Img:{
			
			init: function(){
			    //this.unevent()
				A.Data.field.find('img[atomic]').event('click', A.Atomic.Img.onClick)
				this.setHandler();
			}
			
			,unevent: function(){
				A.Data.field.find('img[atomic]').unevent('click', A.Atomic.Img.onClick)
			}
			
			,onClick: function(e){
				
				A.Data.Atomic.img = _.$(this);
				A.Atomic.Context.open("img");
				A.Atomic.Img.open();
				A.Atomic.setCurrent(_.$(this));
				
			}
			
			,open: function(){
				_.$("#imgAlt").val = A.Data.Atomic.img.attr("alt");
			}
			
			,setHandler: function(){
				
				_.$("#imgSave").click(function(){
					
					var	alt=_.$("#imgAlt").val
					A.Data.Atomic.img.attr("alt", alt);
					
					if (_.$("#imgSrc").val){
						
						var d = _.new("div");
						_.$("#imgSave").val="Загружаем изображение...";
						d.fileUpload("imgSrc","/Core/apps/Imager/uploadImg.php",{},function(r){
							var url = r;
							A.Data.Atomic.img.attr("src", r);
						
							_.$("#imgSrc").val="";
							_.$("#imgSave").val="Сохранить";
							A.Atomic.Context.close();
						})
						d.remove();
					}
					
					else
						A.Atomic.Context.close();
				})
			}
			
		}
		
		
	}
	
	,Listed:{
	
		context: function(e){
			
			e.preventDefault();
			e.stopPropagation();
			A.Listed.Context.close()
			
// 			console.log(e);
// 			A.Data.listedContext.style({"top": e.screenY+(screen.availHeight-screen.height-50)+"px", "left": e.screenX+"px", "display": "block"});
		    
		    if(A.Data.bufferedListed){
		        A.ListedContext.set(3,{disabled: false});
		        A.ListedContext.set(4,{disabled: false});
		    }else{
		        A.ListedContext.set(3,{disabled: true});
		        A.ListedContext.set(4,{disabled: true});
		    }
		    A.ListedContext.open(this,e.clientX+40, e.clientY+40);
		    
		    
			A.Data.currentListed = this;
			_.$(A.Data.currentListed).addClass("c_context_current");
			
			A.Data.field.find("html").click(function(){
				A.Listed.Context.close()
			})
		}
		
		,onCopy: function(el){
		    A.Data.bufferedListed = A.Data.currentListed;
		    A.Listed.Context.close();
		}
		
		,onDelete: function(el){
		    A.Data.currentListed.remove();
		    A.Listed.Context.close();
		}
		
		,onDuplicate: function(el){
		    var c = A.Data.currentListed;
		    A.Listed.Context.close();
		    
		    var elem = c.nextSibling;
		    while(elem.nodeType == document.TEXT_NODE && elem!=null){
		        elem = elem.nextSibling;
		    }
		    var clone = c.cloneNode(true);
		    if(elem == null){
		        c.parentNode.appendChild(clone);
		    }else{
		        elem.parentNode.insertBefore(clone,elem);
		    }
		    A.Listed.Context.init();
		}
		
		,onPasteBefore: function(el){
		    var c = A.Data.currentListed;
		    A.Listed.Context.close();
		    
		    var clone = A.Data.bufferedListed.cloneNode(true);
		    c.parentNode.insertBefore(clone, c);
		    A.Listed.Context.init();
		}
		
		,onPasteAfter: function(el){
		    var c = A.Data.currentListed;
		    A.Listed.Context.close();
		    
		    var clone = A.Data.bufferedListed.cloneNode(true);
		    var elem = c.nextSibling;
		    while(elem.nodeType == document.TEXT_NODE && elem!=null){
		        elem = elem.nextSibling;
		    }
		    
		    if(elem == null){
		        c.parentNode.appendChild(clone);
		    }else{
		        elem.parentNode.insertBefore(clone,elem);
		    }

		    A.Listed.Context.init();
		}
		
		,Context:{
			init: function(){
			    A.Data.field.find('[listed]').event("contextmenu", A.Listed.context);
				A.Listed.Context.close()
			}
			
			
			
			,close: function(){

				if (A.Data.currentListed!==undefined) _.$(A.Data.currentListed).removeClass("c_context_current");
				A.Data.currentListed = undefined;
				A.ListedContext.close()
				
				
			}
		}
	}
	
	
	,Controls:{
		init: function(){
		
			A.Controls.Save.init();
			A.Controls.Settings.init();
			A.Controls.Close.init();
		}
		
		,Close: {
			init: function(){				
				_.$("#close").click(function(){ 
				    RCore.Dialogs.confirm("Вы действительно хотите закрыть страницу?",function(){
				        window.close();
				    },null,"Подтвердите закрытие редактора");
				});
			}
		}
		,Settings:{
			init: function(){
				_.$("#settings").click(A.Controls.Settings.onClick);
				_.$("#submit").click(function(){
					_.$("#mainContext").display("none");
				})
			}
			
			,onClick: function(){
				if(_.$("#mainContext").display()=="none") _.$("#mainContext").display("block");
					else _.$("#mainContext").display("none");
			}
		}
		
		,Save:{
			init: function(){
				_.$("#save").click(A.Controls.Save.onClick)
			}
			
			,onClick: function(){
				
				A.Atomic.unsetCurrent();
				A.Listed.Context.close()
				A.Data.field.find("textarea[code]").forEach(function(e){
					var div = _.new("div");
					var iframe = _.new("iframe").appendTo(div);
					
					div.HTML(e.val);
					console.log(div.HTML());
					div.find("iframe").attr("atomic","");
					e[0].outerHTML = div.HTML();	
				});
				
				A.Data.field.find("body").find("iframe").HTML(" ");
				A.Data.field.find("body").find("[empty]").HTML(" ");
				A.Data.field.find("body").find("[system]").remove();
				A.Data.field.find("body").find("[contenteditable]").removeAttribute("contenteditable");
				
				var i = 0;
				A.Data.field.find("body").find("[restore]").forEach(function(e){
				    if(A.Data.Restorable[i]){
    				    e[0].outerHTML = A.Data.Restorable[i++];
				    }
				})
				
				A.Data.field.find("dynamic").forEach(function(e){
					if(e.attr("href"))
						e[0].outerHTML="[@|"+e.attr("href").slice(1)+"|@]";
				})
				var s = A.Data.field[0].body.innerHTML;
				
				var b = _.new("body").HTML(s);
				//b.find("[atomic]").removeAttribute("atomic");
				//b.find("[listed]").removeAttribute("listed");
				//b.find("[empty]").removeAttribute("empty");
				b.find("[dynamic]").removeAttribute("dynamic");
				
				A.Save(s, b.HTML());
			}
		}
	}
	
	,Save: function(s,c){
	    
		var id = A.Data.page;
		A.Layout.show();
		
		var title = _.$("#title").val;
		var keywords = _.$("#keywords").val;
		var description= _.$("#description").val;
		
		 
		_.new("div").post("modules/save.php",{html: s, gen: c,  id: id, title: title, description: description, keywords: keywords}, function(r){
			if(!r) location.reload(); else{
			    RCore.Dialogs.alert(r);
			}
		})
	}
	

}

_.core(function(){
	//_.$(_.$("#field")[0]).event("load",A.init);
})