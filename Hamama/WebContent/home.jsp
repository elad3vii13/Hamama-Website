<%@page import="java.net.URLConnection"%>
<%@page import= "java.net.*"%>
<%@page import= "java.io.*"%>
<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
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

 .footer{ 
       position: fixed;     
       text-align: center;    
       bottom: 0px; 
       width: 100%;
   } 
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>
<!-- <div class="content">
	<p style="text-align: center;">זה דף הנחיתה שלך, כאן אתה מציג מה האתר שלך עוסק בו ולמה כדאי להרשם אליו...</p>  
</div> -->



<button class="footer" onclick="getAllSensorsList()">לקבלת רשימת החיישנים המעודכנת יש ללחות כאן</button>
	<div id="container"></div>
	
</body>

<script>

function addHeaders(table, keys) {
	  var row = table.insertRow();
	  for( var i = 0; i < keys.length; i++ ) {
	    var cell = row.insertCell();
	    cell.appendChild(document.createTextNode(keys[i]));
	  }
	}

function getAllSensorsList(){
	
    var children = [{"id":1,"displayName":"מוליכות","name":"EC","units":"S/m"},{"id":2,"displayName":"חומציות","name":"PH","units":""},{"id":3,"displayName":"עכירות","name":"Turbidness","units":"NTU"},{"id":4,"displayName":"טמפרטורה 1","name":"temp1","units":"celsius"},{"id":5,"displayName":"טמפרטורה 2","name":"temp2","units":"celsius"},{"id":6,"displayName":"טמפרטורה 3","name":"temp3","units":"celsius"}];
    
    	var table = document.createElement('table');
    	for( var i = 0; i < children.length; i++ ) {

    	  var child = children[i];
    	  if(i === 0 ) {
    	    addHeaders(table, Object.keys(child));
    	  }
    	  var row = table.insertRow();
    	  Object.keys(child).forEach(function(k) {
    	    console.log(k);
    	    var cell = row.insertCell();
    	    cell.appendChild(document.createTextNode(child[k]));
    	  })
    	}

    	document.getElementById('container').appendChild(table);
}

window.onload = function () {
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		theme: "light2",
		title:{
			text: "Stats"
		},
		data: [{        
			type: "line",
	      	indexLabelFontSize: 16,
			dataPoints: [
				{ y: 450 },
				{ y: 414},
				{ y: 460 },
				{ y: 450 },
				{ y: 500 },
				{ y: 480 },
				{ y: 480 },
				{ y: 500 },
				{ y: 480 },
				{ y: 510 }
			]
		}]
	});
	chart.render();

	}
</script>

</html>