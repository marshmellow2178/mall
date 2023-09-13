<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.example.demo.dto.*" %>
<%@ page import = "com.example.demo.entity.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "com.example.demo.global.*" %>
<%
MemberInfoDto loginInfo = (MemberInfoDto)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null)	isLogin = true;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js" ></script>
</head>
<header>
	<figure class = "logo"><a href = "index">
	<img src="img/logo.png"></a></figure>
    
	<nav>
		<a href="product_list"><b>PRODUCT</b></a>
		<a href="event_list"><b>EVENT</b></a>
		<a href="notice_list"><b>고객센터</b></a>
	    <a href = "my_page"><b>마이페이지</b></a>
	    <%if(loginInfo==null) { %>
	    	<a href = "login_form">로그인</a>
	    <%}else{ %>
	    	<a href = "logout">로그아웃</a>
	    <%} %>
	</nav>
</header>
<body>
