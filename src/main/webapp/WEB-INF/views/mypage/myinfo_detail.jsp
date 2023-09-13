<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String uid = loginInfo.getId();
String name = loginInfo.getName();
int point = loginInfo.getPoint();
String email = loginInfo.getEmail()+"@"+loginInfo.getDomain();
String phone = loginInfo.getPhone();
%>
<link rel = "stylesheet" href = "css/common.css">
<style>
th{
	width: 15%;
}
</style>
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
	<div class = "content">
    <table>
    	<caption>회원정보</caption>
    	<tr><th>이름</th><td><%=name %></td></tr>
    	<tr><th>ID</th><td><%=uid %></td></tr>
    	<tr><th>이메일</th><td><%=email %></td></tr>
    	<tr><th>연락처</th><td>010<%=phone %></td></tr>
    	<tr><th>보유 포인트</th><td><%=point %></td></tr>
    	<tr><th rowspan = 2>주소</th><td><%=loginInfo.getAddr1()%></td></tr>
    	<tr><td><%=loginInfo.getAddr2()%></td></tr>
    	<tr><th>가입일</th><td><%=GoodsUtil.getDateFormat(loginInfo.getJoindate())%></td></tr>
    </table>
    <a href = "check_pw_form" class = "ctgr">정보수정</a>
    </div>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>