<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
Artist a = (Artist)request.getAttribute("artist");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_artist_update_proc" method="post">
	<input type = "hidden" name = idx value = "<%=a.getIdx()%>">
	<h3>아티스트명</h3>
	<p><input type = "text" maxlength = 20 required name = "name" value = "<%=a.getName()%>"></p>
	<p><input type = "submit" value = "수정"></p>
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