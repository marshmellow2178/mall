<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "vo.*" %>    
<%! //공용 메소드영역
public String getUserRequest(String req){
	return req.trim().replace("<", "&lt").replace("'", "''");
}
%>
<% 
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null)	isLogin = true;
// 로그인 여부를 판단할 변수 isLogin 생성
%>

<%
request.setCharacterEncoding("utf-8");
MemberAddr memberAddr = (MemberAddr)request.getAttribute("maList");
boolean isChk = false;
if(loginInfo != null && memberAddr != null)	isChk = true;
%>

<script>
if(isChk == false){
	alert('비정상적인 접근입니다.');
	location.href='http://localhost:8086/goods/index.jsp';
}
</script>
<%
if(loginInfo == null){
	out.println("<script>");
	out.println("alert('로그인 후 이용해주세요.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}


%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.pschk{
	margin:0 auto;
	border:1px solid black ;
	width: 400px ;
	margin-top: 300px;
	height: 100px;
	text-align: center;
}
form {
margin :38px 0 ;
}
</style>
</head>
<body>

<div class = "pschk">
	<form name="mypage" action="mypage" method="post">
		<label id="mi_pw">비밀번호 : </label> <input type="password" name="mi_pw"
			id="mi_pw" maxlength="20"  /><input type="submit" value="확인" />
	</form>
</div>

</body>
</html>