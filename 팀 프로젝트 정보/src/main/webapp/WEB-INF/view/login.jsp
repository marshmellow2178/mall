<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.login{
	
	margin: 0 auto;
	margin-top : 300px;
	border: 1px solid black;
}
main {
text-align:center;
width: 400px;
margin: 0 auto;
}
p{
margin: 16px auto;
width: 260px;
text-align: left;
}
</style>
<body>
<main>
	<div class="login">
		<h2>로그인 </h2>
		<form method="post" action="login" >
			<p><label>아이디 :&nbsp;&nbsp;  <input type="text" name="mi_id" value="test1" /></label></p> 
			<p><label>비밀번호 : <input type="password" name="mi_pw" value="1234" /></label></p> 
			<input type="submit" value="로그인" />	
		</form>
	</div>
</main>
</body>
</html>