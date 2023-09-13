<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getHeader("referer");
if(url==null){
	url = request.getParameter("url");
}else{
	url = url.substring(url.lastIndexOf('/')+1);
}
%>
<link rel = "stylesheet" href = "css/common.css">
<style>
main{
	width: 30%;
	margin: 0 auto;
	text-align: center;
}
.submit input{
	width: 80%;
	height: 50px;
	padding: 5px;
}
#remember{
	display: none;
}
.unable a{
	width: 30%;
	padding: 20px 0;
}
</style>
<main>
	<form class = "submit" action="login_proc" method="post">
		<div>
			<input type="hidden" name="url" value="<%=url %>" />
	        <input type="text" name="uid" value="test1" />
	        <input type="password" name="pwd" value="1234"/>
		</div>
	    <div>
	    	<input type="submit" value="로그인">
	    </div>
    </form>
    <div class = "unable">
	    <a href="member_form_in">회원가입</a>
    </div>
</main>