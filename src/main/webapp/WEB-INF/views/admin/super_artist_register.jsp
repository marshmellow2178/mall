<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_artist_register_proc" method="post">
	<input type = "hidden" name = idx value = "0">
	<h3>아티스트명</h3>
	<p><input type = "text" maxlength = 20 required name = "name"></p>
	<p><input type = "submit" value = "등록"></p>
	</form>
</main>
</body>
</html>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>