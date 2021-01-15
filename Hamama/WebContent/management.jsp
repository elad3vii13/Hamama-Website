<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hamama</title>

<style>
body {
	overflow: hidden;
    font-family: $font-family;
    font-size: $font-size;
    background-size: 200% 100% !important;
    animation: move 10s ease infinite;
    transform: translate3d(0, 0, 0);
    background: linear-gradient(45deg, #03d3fc 10%, #a347ff 90%);
    height: 100vh
}

button {
    margin:30px auto;
    display:block;
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
<header style="text-align: center; margin-top: 60px; font-size: 60px; color: white; font-weight: bold; text-align: center; margin-left: 190px; margin-right: 190px; font-weight: bold; color: white; font-size: 70px; text-shadow: 0 1px 0 #ccc, 0 2px 0 #c9c9c9, 0 3px 0 #bbb, 0 4px 0 #b9b9b9, 0 5px 0 #aaa, 0 6px 1px rgba(0,0,0,.1),0 0 5px rgba(0,0,0,.1),0 1px 3px rgba(0,0,0,.3),0 3px 5px rgba(0,0,0,.2),0 5px 10px rgba(0,0,0,.25),0 10px 10px rgba(0,0,0,.2),0 20px 20px rgba(0,0,0,.15);">תפריט מנהל</header>
<button style="box-shadow: 0 5px 6px -4px rgba(0,0,0,0.22), 0 10px 13px -4px rgba(0,0,0,0.34), inset 0 30px 30px 0 rgba(255,255,255,0.35), inset 0 -30px 30px 0 rgba(0,0,0,0.10); margin-top: 100px; font: 30px;" onclick="location.href='http://localhost:8080/registration.jsp'">רשום משתמש חדש</button>
</body>
</html>