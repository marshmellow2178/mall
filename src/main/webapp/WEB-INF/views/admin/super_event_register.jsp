<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_event_register_proc" method="post" enctype="multipart/form-data">
	<input type = "hidden" name = idx value = "0">
	<h3>제목</h3>
	<p><input type = "text" maxlength = 20 required name = "title"></p>
	<h3>내용</h3>
	<p><input type = "file" name = "img1"></p>
	<p><input type = "file" name = "img2"></p>
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