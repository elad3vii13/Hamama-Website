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
    background: linear-gradient(45deg, #06D5FA 10%, #A2C7E5 90%);
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

<div class="upperDiv" style="height: 40%; width: 95%; border-radius: 20px; background-color: white; margin: 20px auto; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">

<!-- FROM DATE -->
<header style="margin-top: 30px; margin-right: 30px;">מתאריך:</header>
<input type="datetime-local" id="fromValue" name="from" value="2021-01-1T19:30" style="width: 30%; margin-right: 30px"></input>
      
<!-- TO DATE --> 
<header style="margin-top: 10px; margin-right: 30px;">עד תאריך:</header>
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

<select name="priority" id="priority" style="width: 30%; margin-right: 30px; margin-top: 10px" dir="rtl"> 
    <option value="0">--בחר עדיפות--</option>
    <option value="error">תקלה</option>
    <option value="warning">אזהרה</option>
    <option value="info">ידיעה</option>
</select>

<button style="margin-bottom: 10px;" onclick="getHistory()">הוסף גרף</button>
</div>

<script>
function onLoadFunctions(){
	<% 
	if(!ctx.isLoggedIn())
	{
		%>
		alert("You are not allowed to be here!, Please Log-In");
		window.location.href = "http://localhost:8080/login.jsp";
		<% 
	}
	%>
}

function getHistory(){
	
	var from = document.getElementById("fromValue").value;
	var fromUnix = new Date(from).valueOf();
	
	var to = document.getElementById("toValue").value;
	var toUnix = new Date(to).valueOf();
	
	var sensor = document.getElementById("sensor").value;
	var priority = document.getElementById("priority").value;
    var result = "http://127.0.0.1:8080/mobile?cmd=log&sid=" + sensor + '&from=' + fromUnix + '&to=' + toUnix + '&priority=' + priority;    
}
</script>
</body>
</html>