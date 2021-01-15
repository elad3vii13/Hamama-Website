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
<header style="text-align: center; margin-top: 50px; font-size: 60px; color: white; font-weight: bold;">תפריט מנהל</header>
<button style="margin-top: 100px; font: 30px;" onclick="location.href='http://localhost:8080/registration.jsp'">רשום משתמש חדש</button>
</body>
</html>