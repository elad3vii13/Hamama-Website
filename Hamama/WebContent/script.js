var dictionary;
var resultArray;

function getUpdatedSensorList() {
	var x = document.getElementById("sensor");  
	var result = 'HttpHandler?cmd=sensors';    
	dictionary = new Map();
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
           if (xmlhttp.status == 200) { // The HTTP 200 OK success status response code indicates that the request has succeeded. 
               
        	   var sensorsJson = JSON.parse(xmlhttp.responseText);
           	   for(i in sensorsJson){
             	  var option = document.createElement("option");
            	  option.text = sensorsJson[i].displayName;
            	  option.value = parseInt(i) +1;
            	  x.add(option);

            	  dictionary.set(parseInt(sensorsJson[i].id, 10), sensorsJson[i].displayName.toString());
           	   }	
           }
        }
    }

    xmlhttp.open("GET", result.toString(), true);
    xmlhttp.send();
}

function addGraph(){
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	var sensor = document.getElementById("sensor").value;
	
	var result = 'HttpHandler?cmd=measure&sid=' + sensor + '&from=' + fromUnix + '&to=' + toUnix;    
   
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
           if(xmlhttp.status == 500) alert("There are no data, for the selected sensor ...")
           if (xmlhttp.status == 200) { // The HTTP 200 OK success status response code indicates that the request has succeeded. 
              
               var result = JSON.parse(xmlhttp.responseText);
               var resultJson = JSON.parse(result.measures);
               
               var timeArr = [];
               var valueArr = [];
               var dps = []; // dataPoints array
               
               for (i in resultJson) {
                 	 timeArr.push(resultJson[i].time);
                 	 valueArr.push(resultJson[i].value);
               }
                              
               var chart = new CanvasJS.Chart("chartContainer", 
           	   {
            	   zoomEnabled: true,
            	   animationEnabled: true,
            	   
            	   axisX: {
               	    title: "Dates"
               	  },
               	  axisY: {
               	    title: "Values"
               	  },
               	  data: [{
               	    type: "line",
               	    dataPoints: dps
               	  }]
               	});
               
               for (var i = dps.length; i < timeArr.length; i++)
                   dps.push({
                     x: new Date(timeArr[i]),
                     y: valueArr[i]
                   });
               
               //parseDataPoints();
               chart.options.data[0].dataPoints = dps;
               chart.render();
           }
        }
    };

    xmlhttp.open("GET", result.toString(), true);
    xmlhttp.send();
}

function getHistory(){
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	
	var sensor = document.getElementById("sensor").value;
	var priority = document.getElementById("priority").value;
	
	if(sensor==0 && priority!=0) {
    	var result = 'HttpHandler?cmd=log&from=' + fromUnix + '&to=' + toUnix + '&priority=' + priority;    
	}
	else if(sensor!=0 && priority==0) {
    	var result = 'HttpHandler?cmd=log&from=' + fromUnix + '&to=' + toUnix + '&sid=' + sensor;    
	}
	else if(sensor!=0 && priority!=0) {
	    var result = 'HttpHandler?cmd=log&sid=' + sensor + '&from=' + fromUnix + '&to=' + toUnix + '&priority=' + priority;  
	}
	else if(sensor==0 && priority==0){
		var result = 'HttpHandler?cmd=log&from=' + fromUnix + '&to=' + toUnix;  
	}
    	
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
           if(xmlhttp.responseText == '[]') alert("There are no data, for those settings ...")
           if (xmlhttp.status == 200) { // The HTTP 200 OK success status response code indicates that the request has succeeded. 
     	   	        	   
               resultArray = JSON.parse(xmlhttp.responseText);
               fillTable(resultArray);
           }
        }
    };

	    xmlhttp.open("GET", result.toString(), true);
	    xmlhttp.send();   
}

function fillTable(resultArray){
	  var string_final = "";
	  string_final += "<tr><th class=table-header><button onclick=sortBySensors()>חיישן</button></th>";
	  string_final += "<th class=table-header>הערה</th>";
	  string_final += "<th class=table-header><button onclick=sortByPriority()>עדיפות</button></th>";
	  string_final += "<th class=table-header><button onclick=sortByTime()>תאריך</button></th></tr>";
	
	   for (i in resultArray) {
		   string_final += "<tr>";
	   		
	   	   var sensorName = dictionary.get(resultArray[i].sid);
	
	       string_final += "<td>" + sensorName + "</td>";
	       string_final += "<td>" + resultArray[i].message + "</td>";
	
	       switch(resultArray[i].priority) {
	       		case "info": 
	       		string_final += '<td><img style="width: 100px; height: 100px;" src="images/info.png"></td>';
	       		break;
	
	       		case "warning": 
	       		string_final += '<td><img style="width: 100px; height: 100px;" src="images/warning.png"></td>';
	       		break;
	
	       		case "error": 
	       		string_final += '<td><img style="width: 100px; height: 100px;" src="images/error.png"></td>';
	       		break;
	       }
	
		const date = new Date(parseInt(resultArray[i].time));
		string_final += "<td>" + date.toLocaleDateString("en-US") + "</td>";	
		string_final += "</tr>";
		document.getElementById("Board").innerHTML = string_final;
	}
}

function sortBySensors(){
	 // alert("SENSORS");
   resultArray.sort((a,b) => {
    if(a.sid > b.sid) {
      return 1;
    } else {
      return -1;
    }
   })

   fillTable(resultArray);
}

function sortByTime(){
	 //alert("TIME");
      resultArray.sort((a,b) => {
    if(a.time < b.time) {
      return 1;
    } else {
      return -1;
    }
   })

   fillTable(resultArray);
}

function sortByPriority(){
	//alert("PRIORITY");
     resultArray.sort((a,b) => {
    if(a.priority > b.priority) {
      return 1;
    } else {
      return -1;
    }
   })

   fillTable(resultArray);
}
