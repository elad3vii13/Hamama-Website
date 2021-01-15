<%@page import="logic.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hamama</title>

<style>
.upperDiv {
margin-top: 10px;
  justify-content: space-between;
  flex-direction: column;
  display: flex;
}

body {
    font-family: $font-family;
    font-size: $font-size;
    background-size: 200% 100% !important;
    animation: move 10s ease infinite;
    transform: translate3d(0, 0, 0);
    background: linear-gradient(45deg, #49D49D 10%, #A2C7E5 90%);
    height: 100vh
}

select {
    font-size: .9rem;
    padding: 5px 15px;
}

button {
  text-align: center;
  background: -webkit-linear-gradient(right, #a6f77b, #2dbd6e);
  border: none;
  border-radius: 21px;
  box-shadow: 0px 1px 8px #24c64f;
  cursor: pointer;
  color: white;
  font-family: "Raleway SemiBold", sans-serif;
  height: 42.3px;
  margin: 0 auto;
  margin-top: 50px;
  transition: 0.25s;
  width: 350px;
}

</style>
</head>
<body onload="onLoadFunctions();">
<%@ include file="header.jsp" %>

<div class="upperDiv" style="height: 30%; width: 95%; border-radius: 20px; background-color: white; margin: 20px auto; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">

<!-- FROM DATE -->
<header style="margin-top: 30px; margin-right: 30px;">מתאריך:</header>
<input type="datetime-local" id="fromValue" name="from" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>
      
<!-- TO DATE --> 
<header style="margin-top: 30px; margin-right: 30px;">עד תאריך:</header>
<input type="datetime-local" id="toValue" name="to" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>

<select name="sensor" id="sensor" style="width: 30%; margin-right: 30px; margin-top: 10px" dir="rtl"> 
    <option value="0">--בחר חיישן--</option>
    <option value="1">מוליכות</option>
    <option value="2">חומציות</option>
    <option value="3">עריכות</option>
    <option value="4">טמפרטורה 1</option>
    <option value="5">טמפרטורה 2</option>
    <option value="6">טמפרטורה 3</option>
</select>

<button style="margin-bottom: 10px;" onclick="addGraph()">הוסף גרף</button>
</div>
 
<div style="height: 56%; width: 95%; border-radius: 20px; background-color: white; margin: auto; position: fixed; left: 50%; transform: translateX(-50%); box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">

<div id="chartContainer" style="margin:30px;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</div>
</body>
<script>

function onLoadFunctions(){
	<% 
	if(!ctx.isLoggedIn())
	{
		%>
		alert("You are not allowed to be here!, Please Log-In or create a new account");
		window.location.href = "http://localhost:8080/registration.jsp";
		<% 
	}
	%>
}

function addGraph(){
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	var sensor = document.getElementById("sensor").value;
	
    var result = 'http://localhost:8080/mobile?cmd=measure&sid=' + sensor + '&from=' + fromUnix + '&to=' + toUnix;    

    // GET THE DATA FROM THE URL
	/*
    var dataset;
    fetch('https://jsonplaceholder.typicode.com/todos/1')
      .then(response => response.json())
      .then(data => dataset = data) // this unnecessary
      .then(json => {
        //console.log(json);
        // continue and do something here
        //alert(JSON.stringify(json));
    });
    */
    
    /*
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
    	//console.log(this.responseText);
    	var result = this.responseText;
    	createDataPoints(result);
    };
    xhr.open('GET', result.toString());
    xhr.send()
    */

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
           if (xmlhttp.status == 200) {
               //alert(xmlhttp.responseText);
               //var Data = JSON.parse(xmlhttp.responseText);
               //alert(xmlhttp.responseText.id);
               //createDatePoints(Date);
               //alert(xmlhttp.responseText.id);
               console.log(xmlhttp.responseText);
               //console.log(JSON.parse(xmlhttp.responseText).measures);
               //var text = JSON.parse(xmlhttp.responseText);
           	   //console.log(xmlhttp.responseText.measures.time);
           	   
               /*
               var result = {"id":1,"name":"EC","units":"S/m","measures":"[{\"time\":0,\"sid\":0,\"value\":15.4},{\"time\":0,\"sid\":0,\"value\":15.4},{\"time\":0,\"sid\":0,\"value\":13.0},{\"time\":0,\"sid\":0,\"value\":13.0},{\"time\":0,\"sid\":0,\"value\":12.4},{\"time\":0,\"sid\":0,\"value\":12.4},{\"time\":0,\"sid\":0,\"value\":12.4565},{\"time\":12345,\"sid\":0,\"value\":5.4}]"};
               var myObj = JSON.parse(result.measures);
                       
               var timeArr = [];
               var valueArr = [];
               
               for (i in myObj) {
               	 timeArr.push(myObj[i].time);
               	 valueArr.push(myObj[i].value);
               }*/
               
               var result = JSON.parse(xmlhttp.responseText);
               var resultJson = JSON.parse(result.measures);
               
               timeArr = [];
               var valueArr = [];
               
               for (i in resultJson) {
                 	 timeArr.push(resultJson[i].time);
                 	 valueArr.push(resultJson[i].value);
               }
               
               var dps = []; //dataPoints.
               
               var chart = new CanvasJS.Chart("chartContainer", {
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
               
               addDataPoints();

             //Taking user input and adding it to dataPoint
               //document.getElementById("button").onclick = function(){
                 //timeArr.push(new Date(document.getElementById("dateValue").value));
                 //valueArr.push(Number(document.getElementById("yValue").value));
                 //Call your algorithm here
                 //addDataPoints();
               
               //alert(timeArr.toString() + " // " + valueArr.toString());
           }
        }
    };

    xmlhttp.open("GET", result.toString(), true);
    xmlhttp.send();
    
    
}


    /*
function createDataPoints(data){
	//myObj = {"id":1,"name":"EC","units":"S/m","measures":"[{\"time\":1605461248000,\"sid\":0,\"value\":1.0},{\"time\":1605561248000,\"sid\":0,\"value\":5.0},{\"time\":1606361248000,\"sid\":0,\"value\":4.0},{\"time\":1607361248000,\"sid\":0,\"value\":2.0},{\"time\":1608361248000,\"sid\":0,\"value\":7.8}]"};
	//console.log((myObj).measures);
	
	alert(data.id);
	
	/*
	Array value;
	Array time;
	
	var i =0;
	while(myObj.measures[i].time != null){
		value.
		time.
		i++;
	}
	
	
	
	
	
	
	//PARSE DP
	  for (var i = dps.length; i < dateArray.length; i++)
	    dps.push({
	      x: dateArray[i],
	      y: numberArray[i]
	    });

	//addDataPoints()
	  parseDataPoints();
	  chart.options.data[0].dataPoints = dps;
	  chart.render();

	addDataPoints();
	*/
  
</script>
</html>