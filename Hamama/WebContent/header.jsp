<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/header.css">
<title>Insert title here</title>
<%@ include file="context.jsp" %>
</head>

<body class="top-menu">
<ul>
  <li><a href="home.jsp">בית</a></li>
  <% if (!ctx.isLoggedIn())
  		out.write("<li><a href='login.jsp'>כניסה</a></li>");
  	else
  		out.write("<li><a href='HttpHandler?cmd=logout'>יציאה</a></li>"); %>  
 
  <p style= "float: left; color: white; margin-left: 10px; margin-top: 10px">
	<% if(ctx.isLoggedIn())
		out.write(ctx.getCurrentUserName());
	else
		out.write("שלום אורח"); %></p>
	
	<% if (ctx.isLoggedIn()){
  		if(ctx.isManager()) {
 			out.write("<li><a href='management.jsp'>ניהול</a></li>");
 			out.write("<li><a href='logs.jsp'>היסטוריה</a></li>");
 		  	out.write("<li><a href='stats.jsp'>נתונים</a></li>");
  		}
  	} %>
  	
  <li><a href="about.jsp">אודות</a></li> 
</ul>
</body>
</html>