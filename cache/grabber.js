var Grabber = {

	Instruments: ['6A','6B','6C','6E','6J','6N','6S','CL','GC']
	,Timeframes: ["M1", "M2", "M5", "M10", "M15", "M30", "H1", "H4", "D1"]
	,Deltas: [100, 300, 500, 1000]

	,url: `/AutoDeltaCaching/`
	,Log: []
	,MAX_LOG_LENGTH: 500
	,log: function(log){
		this.Log.unshift(log);
		if(this.Log.length > this.MAX_LOG_LENGTH){
			this.Log.pop();
		}
		document.getElementById("log").value = this.Log.reduce((p,c)=>`${p}\n${c}`,``);
	}

	,deltaCache(delta){
		
		var promise = new Promise(function(resolve, reject){
			var xhr = new XMLHttpRequest;
			xhr.open("GET", `/AutoDeltaCaching/?delta=${delta}`);
			xhr.onload = (r)=>resolve(xhr.responseText);
			xhr.send();
		})
		return promise;
	}
	
	,startDeltaCache: async function(){
		while(true){
			var d1 = Date.now();
			for(let delta of Grabber.Deltas){
				Grabber.log(await this.deltaCache(delta));
			}
			Grabber.log(`Time estimated for Delta iteration=${Date.now() - d1}ms`);
		}
	}

	,timeframeCache: function (tf){
		var promise = new Promise(function(resolve, reject){
			var xhr = new XMLHttpRequest;
			xhr.open("GET", `/AutoFootprintCaching/?timeframe=${tf}`);
			xhr.onload = (r)=>resolve(xhr.responseText);
			xhr.send();
		})
		return promise;
	}

	,startTimeframeCache: async function(){

		// Grabber.Timeframes.forEach(async function(tf){
		// 	while(true){
		// 		Grabber.log(await Grabber.timeframeCache(tf));
		// 	}
		// })

		while(true){

			var d1 = Date.now();
			// var promises = Grabber.Timeframes.map(t=>Grabber.timeframeCache(t));

			
			
			for(let tf of Grabber.Timeframes){
				Grabber.log(await this.timeframeCache(tf));
			}
			Grabber.log(`Time estimated for Footprint iteration=${Date.now() - d1}ms`);
		}
	}

	,start: function(){
		
		this.startDeltaCache().then(
			(d)=>null,
			(err)=>console.error(err)
		);

		this.startTimeframeCache().then(d=>null,err=>console.error(err))

	}
}
Grabber.start();