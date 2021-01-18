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

.buttonStyle {
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
<body>
<%@ include file="header.jsp" %>
<% 
	if(!ctx.isLoggedIn()){
		ctx.insertAlertDlg("You are not allowed to access this page, you are forwarded to the home page", "home.jsp");
	}
%>

<div class="upperDiv" style="height: 30%; width: 95%; border-radius: 20px; background-color: white; margin: 20px auto; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">

<!-- FROM DATE -->
<header style="float: right; margin-top: 30px; margin-right: 30px;">מתאריך:</header>
<input type="datetime-local" id="fromValue" name="from" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>
      
<!-- TO DATE --> 
<header style="float: left; margin-top: 30px; margin-right: 30px;">עד תאריך:</header>
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

<button class="buttonStyle" style="margin-bottom: 10px;" onclick="addGraph()">הוסף גרף</button>
</div>
 
<div style="height: 56%; width: 95%; border-radius: 20px; background-color: white; margin: auto; position: fixed; left: 50%; transform: translateX(-50%); box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">

<div id="chartContainer" style="margin:30px; position: relative; top: 10%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</div>
</body>
<script>

function addGraph(){
	
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	var sensor = document.getElementById("sensor").value;
	
	var result = 'http://localhost:8080/mobile?cmd=measure&sid=' + sensor + '&from=' + fromUnix + '&to=' + toUnix;    
   
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
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
</script>
</html>