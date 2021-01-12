<%@page import="logic.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.test {
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
<body>
<%@ include file="header.jsp" %>

<div class="test" style="height: 30%; width: 95%; border-radius: 20px; background-color: white; margin: 20px auto; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">

<header style="margin-top: 30px; margin-right: 30px;">מתאריך:</header>
<input type="datetime-local" id="fromValue"
       name="from" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>
       
       <header style="margin-top: 30px; margin-right: 30px;">עד תאריך:</header>
<input type="datetime-local" id="toValue"
       name="to" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>

<p id="demo">asdasdasd</p>

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

function checkUserHosting() {
    return fetch("http://localhost:8080/mobile?cmd=measure&sid=1&from=0&to=1000000000000")
        .then((response) => { 
            return response.json().then((data) => {
                console.log(data);
                return data;
            }).catch((err) => {
                console.log(err);
            }) 
        });
}

function addGraph(){	
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	var sensor = document.getElementById("sensor").value;
	
    var result = "http://127.0.0.1:8080/mobile?cmd=measure&sid=" + sensor + '&from=' + fromUnix + '&to=' + toUnix;    
    //alert(result);
    //var dateJson = checkUserHosting();
    alert(JSON.stringify(checkUserHosting()));
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