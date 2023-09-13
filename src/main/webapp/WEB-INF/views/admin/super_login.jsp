<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_login_proc" method = "POST">
		<input type = "text" name = "id" maxlength = 20 placeholder = "ID" value = "admin01" required>
		<input type = "password" name = "pw" maxlength = 20 placeholder = "PW" value = 1234 required>
		<input type = "submit" value = "로그인" class = "ctgr">
	</form>
</main>

</body>
</html>
<style>
main{
	width: 20%;
	margin: 0 auto;
}
input{
	width: 100%;
	padding: 20px 10px;
	height: 50px;
}
</style>