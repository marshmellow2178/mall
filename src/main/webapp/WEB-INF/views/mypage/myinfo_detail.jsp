<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
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
    	<tr><th>이름</th><td><%=loginInfo.getName() %></td></tr>
    	<tr><th>ID</th><td><%=loginInfo.getId() %></td></tr>
    	<tr><th>이메일</th><td><%=loginInfo.getEmail()+"@"+loginInfo.getDomain() %></td></tr>
    	<tr><th>연락처</th><td>010<%=loginInfo.getPhone() %></td></tr>
    	<tr><th>보유 포인트</th><td><%=loginInfo.getPoint() %></td></tr>
    	<tr><th rowspan = 2>주소</th><td><%=loginInfo.getAddr1()%></td></tr>
    	<tr><td><%=loginInfo.getAddr2()%></td></tr>
    	<tr><th>가입일</th><td><%=GoodsUtil.getDateFormat(loginInfo.getJoindate())%></td></tr>
    </table>
    <a href = "check_pw_form" class = "ctgr">정보수정</a>
    </div>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>