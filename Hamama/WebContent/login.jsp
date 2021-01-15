<%@page import="com.sun.net.httpserver.HttpHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hamama</title>

<style>
$font-family:   "Roboto";
$font-size:     14px;
$color-primary: #ABA194;

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
overflow: hidden;
    font-family: $font-family;
    font-size: $font-size;
    background-size: 200% 100% !important;
    animation: move 10s ease infinite;
    transform: translate3d(0, 0, 0);
    background: linear-gradient(45deg, #49D49D 10%, #A2C7E5 90%);
    height: 100vh
}

.user {
    width: 90%;
    max-width: 340px;
    margin: 10vh auto;
}

.user__header {
    text-align: center;
    opacity: 0;
    transform: translate3d(0, 500px, 0);
    animation: arrive 500ms ease-in-out 0.7s forwards;
}

.user__title {
    font-size: $font-size;
    margin-bottom: -10px;
    font-weight: 500;
    color: white;
}

.form {
    margin-top: 40px;
    border-radius: 6px;
    overflow: hidden;
    opacity: 0;
    transform: translate3d(0, 500px, 0);
    animation: arrive 500ms ease-in-out 0.9s forwards;
}

.form--no {
    animation: NO 1s ease-in-out;
    opacity: 1;
    transform: translate3d(0, 0, 0);
}

.form__input {
    display: block;
    width: 100%;
    padding: 20px;
    font-family: $font-family;
    -webkit-appearance: none;
    border: 0;
    outline: 0;
    transition: 0.3s;
    
    &:focus {
        background: darken(#fff, 3%);
    }
}

.btn {
    display: block;
    width: 100%;
    padding: 20px;
    font-family: $font-family;
    -webkit-appearance: none;
    outline: 0;
    border: 0;
    color: white;
    background: #000000;
    transition: 0.3s;
}

@keyframes NO {
  from, to {
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
  }

  10%, 30%, 50%, 70%, 90% {
    -webkit-transform: translate3d(-10px, 0, 0);
    transform: translate3d(-10px, 0, 0);
  }

  20%, 40%, 60%, 80% {
    -webkit-transform: translate3d(10px, 0, 0);
    transform: translate3d(10px, 0, 0);
  }
}

@keyframes arrive {
    0% {
        opacity: 0;
        transform: translate3d(0, 50px, 0);
    }
    
    100% {
        opacity: 1;
        transform: translate3d(0, 0, 0);
    }
}

@keyframes move {
    0% {
        background-position: 0 0
    }
    50% {
        background-position: 100% 0
    }
    100% {
        background-position: 0 0
    }
}
</style>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="user">
    <header class="user__header">
        <img src="https://cdn.iconscout.com/icon/free/png-512/leaf-444-675813.png" alt=""  style="width: 100px; height: 100px"/>
        <h1 class="user__title" style=" text-shadow: 0 1px 0 #ccc,
               0 0 5px rgba(0,0,0,.1),
               0 1px 3px rgba(0,0,0,.3),
               0 3px 5px rgba(0,0,0,.2),
               0 5px 10px rgba(0,0,0,.25),
               0 10px 10px rgba(0,0,0,.2),
               0 20px 20px rgba(0,0,0,.15);">ברוכים הבאים לדף הרישום של החממה</h1>
    </header>
    <form class="form" method="post"><br>        		
        <div class="form__group"> 
        <input type="text" name="nickname" id="nickname" placeholder="Username" class="form__input" /></div>
        <div class="form__group">
        <input style="margin-top: 1px" type="password" placeholder="Password" class="form__input" name="password" id="password" /></div>
        <button class="btn" type="submit" formaction="HttpHandler?cmd=login" style="margin-top: 30px; border-radius: 50px; margin-top: 10px">Login</button>
    </form>
</div>

<script>
function approve(){
	window.alert("Thank you for registering");
}
</script>
</body>
</html>