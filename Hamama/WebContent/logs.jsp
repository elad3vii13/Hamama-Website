<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hamama</title>
<style>

.upperDiv {
  justify-content: space-between;
  flex-direction: column;
  display: flex;
  height: 40%;
  width: 95%;
  border-radius: 20px;
  background-color: white;
  margin: 30px auto;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

body {
    background-size: 200% 100% !important;
    animation: move 10s ease infinite;
    transform: translate3d(0, 0, 0);
    background: linear-gradient(45deg, #06D5FA 10%, #A2C7E5 90%);
    height: 100vh
}

select {
    font-size: .9rem;
    padding: 5px 15px;
}

.table-header {
	padding: 10px;
	text-align:center;
	color: white;
	background:#000;
}

th,td {
	background-color: white;
	padding: 20px;
    border: 1px solid black;
    text-align: center;
}

 table {
   box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.5);
   margin-top: 100px;
   margin: 0 auto;
   align="center";
   outline: 10px black;
   border-collapse: collapse;
   width: 50%;
   height: 100%; 
 }

button {
  background: -webkit-linear-gradient(right, #a6f77b, #2dbd6e);
  border: none;
  border-radius: 21px;
  box-shadow: 0px 1px 8px #24c64f;
  cursor: pointer;
  color: white;
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
<% if(!ctx.isLoggedIn())
		ctx.insertAlertDlg("You are not allowed to access this page, you are forwarded to the home page", "home.jsp");%>
		
<div class="upperDiv">
	<!-- FROM DATE -->
	<header style="margin-top: 30px; margin-right: 30px;">מתאריך:</header>
	<input type="datetime-local" id="fromValue" name="from" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>
	      
	<!-- TO DATE --> 
	<header style="margin-top: 10px; margin-right: 30px;">עד תאריך:</header>
	<input type="datetime-local" id="toValue" name="to" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>
	
	<select name="sensor" id="sensor" style="width: 30%; margin-right: 30px; margin-top: 10px" dir="rtl"> 
	    <option value="0">כל החיישנים</option>
	    <option value="1">מוליכות</option>
	    <option value="2">חומציות</option>
	    <option value="3">עריכות</option>
	    <option value="4">טמפרטורה 1</option>
	    <option value="5">טמפרטורה 2</option>
	    <option value="6">טמפרטורה 3</option>
	</select>
	
	<select name="priority" id="priority" style="width: 30%; margin-right: 30px; margin-top: 10px" dir="rtl"> 
	    <option value="0">--בחר עדיפות--</option>
	    <option value="error">תקלה</option>
	    <option value="warning">אזהרה</option>
	    <option value="info">ידיעה</option>
	</select>
	
	<button style="margin-bottom: 10px;" onclick="getHistory()">הוסף טבלה</button>
</div>

<div style="display:flex;justify-content:center;align-items:center; margin-top: 60px;">
	<table id="Board"></table>
</div>

<!-- SPACE AFTER THE TABLE --> 
<div style="height: 50px;">
 </div>

<script>
function getHistory(){
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	
	var sensor = document.getElementById("sensor").value;
	var priority = document.getElementById("priority").value;
	
	if(sensor==0) {
    	var result = 'http://localhost:8080/mobile?cmd=log&from=' + fromUnix + '&to=' + toUnix + '&priority=' + priority;    

	}
	else {
	    var result = 'http://localhost:8080/mobile?cmd=log&sid=' + sensor + '&from=' + fromUnix + '&to=' + toUnix + '&priority=' + priority;  
	}
    	
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {   // XMLHttpRequest.DONE == 4
           if (xmlhttp.status == 200) { // The HTTP 200 OK success status response code indicates that the request has succeeded. 
     	   	
        	   alert(alert());
        	   
               var result = JSON.parse(xmlhttp.responseText);
               // alert(result[0].message);

               var string_final = "";
              string_final += "<tr><th class=table-header>sid</th><th class=table-header>message</th><th class=table-header>priority</th><th class=table-header>time</th></tr>";
              
               for (i in result) {
            	   string_final += "<tr>";
            	   
            	   var sensorName;
            	   switch(result[i].sid) {
            	   case 1:
            		 sensorName = "מוליכות";
            	     break;
            	   case 2:
            		 sensorName = "חומציות";
            	     break;
            	   case 3:
            		 sensorName = "עריכות";
              	     break;
            	   case 4:
            		 sensorName = "טמפרטורה 1";
              	     break;
            	   case 5:
              		 sensorName = "טמפרטורה 2";
              	     break;
            	   case 6:
              		 sensorName = "טמפרטורה 3";
              	     break;
            	   default:
            	     sensorName = "?";
            	     break;
            	 }
            	   
                   string_final += "<td>" + sensorName + "</td>";
                   string_final += "<td>" + result[i].message + "</td>";
                   string_final += "<td>" + result[i].priority + "</td>";
                   string_final += "<td>" + result[i].time + "</td>";
            	   string_final += "</tr>";
               }
              document.getElementById("Board").innerHTML = string_final;
           }
        }
    };

    xmlhttp.open("GET", result.toString(), true);
    xmlhttp.send();   
}
</script>
</body>
</html>