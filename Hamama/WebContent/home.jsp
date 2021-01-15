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
body {
	overflow: hidden;
  	clear: both;
    font-family: $font-family;
    font-size: $font-size;
    background-size: 200% 100% !important;
    animation: move 10s ease infinite;
    transform: translate3d(0, 0, 0);
    background: linear-gradient(45deg, #49D49D 10%, #A2C7E5 90%);
    height: 100vh
}
   
</style>
<meta charset="UTF-8">
<title>Hamama</title>
</head>
<body>
<%@ include file="header.jsp" %>

<img style="float: left; width: 30%; height: 96%;" alt="sd" src="images/bg1.jpg">
<div style="float:right; width: 60%">
<header style="margin-top: 30px; text-align: center; margin-left: 190px; margin-right: 190px; font-weight: bold; color: white; font-size: 70px; text-shadow: 0 1px 0 #ccc, 0 2px 0 #c9c9c9, 0 3px 0 #bbb, 0 4px 0 #b9b9b9, 0 5px 0 #aaa, 0 6px 1px rgba(0,0,0,.1),0 0 5px rgba(0,0,0,.1),0 1px 3px rgba(0,0,0,.3),0 3px 5px rgba(0,0,0,.2),0 5px 10px rgba(0,0,0,.25),0 10px 10px rgba(0,0,0,.2),0 20px 20px rgba(0,0,0,.15);">
ברוכים הבאים למסך הבית של אתר החממה
</header>	

<p style="margin: 70px; color: white; font-size: 40px; text-shadow: 2px 1px 1px #000000;">באתר האינטרנט של החממה ניתן לצפות בנתוני מדידות החיישנים שנמצאים בחממה בצורת גרף קווי.
בנוסף ניתן לראות את היסטוריית התקלות שנמצאו בחיישנים בצורה סלקטיבית באמצעות הגדרת טווח תאריכים.</p></div>
</body>
</html>