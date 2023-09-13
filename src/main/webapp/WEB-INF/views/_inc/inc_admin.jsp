<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.example.demo.dto.*" %>
<%@ page import = "com.example.demo.entity.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "com.example.demo.global.*" %>
<%
AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
boolean isAdmin = false;
if (adminInfo != null)	isAdmin = true;
String url = request.getRequestURL().toString();
int last = url.lastIndexOf("/");
url = url.substring(last+1, url.length()-4);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js" ></script>
</head>
<header>
	<figure class = "logo">
	<a href = "super"><img src="img/logo.png"></a>
	</figure>
	<nav>
		<div>
		<h3>상품관리</h3>
		<a href="super_product_list">목록</a>
		<a href = "super_product_register">신규 등록</a>
		<a href = "super_artist_list">아티스트</a>
		</div>
		
		<div>
		<h3>이벤트</h3>
		<a href="super_event_list">목록</a>
		<a href = "super_event_register">신규 등록</a>
		</div>
		
		<div>
		<h3>회원관리</h3>
		<a href="super_member_list">회원</a>
		<a href = "super_order_list">주문</a>
		</div>
		
		<div>
		<h3>고객센터</h3>
		<a href="super_notice_list">공지</a>
		<a href = "super_faq_list">FAQ</a>
		<a href = "super_inquiry_list">문의</a>
		</div>
		
		<div>
		<h3>계정</h3>
		<%if(adminInfo==null) { %>
	    	<a href = "super">로그인</a>
	    <%}else{ %>
	    	<a href = "super_logout">로그아웃</a>
	    	<p><%=adminInfo.getId() %></p>
	    	<p id = "session_time"><%=GoodsUtil.secToMin(session.getMaxInactiveInterval())%></p>
	    <%} %>
		</div>
	</nav>
</header>
<script>
$(document).ready(function(){
	let time = <%=session.getMaxInactiveInterval()%>;
	setInterval(function(){
		let min = parseInt(time/60) + " : "+ (time%60);
		if(time==0){
			location.href = "super_logout";
		}
		$("#session_time").html(min);
		time--;
	}, 1000);
});

$(document).ready(function(){
	let url = "<%=url%>";
	let arr = $("header>nav>div>a").get();
	for(let i = 0;i<arr.length;i++){
		$("header>nav>div>a").eq(i).removeClass('active');
	}
	for(let i = 0;i<arr.length;i++){
		var href = arr[i].href;
		var last = href.lastIndexOf("/");
		if(url == arr[i].href.substring(last+1)){
			$("header>nav>div>a").eq(i).addClass('active');
		}
	}
});
</script>
<body>