<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
Inquiry i = (Inquiry)request.getAttribute("inquiry");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_inquiry_proc" method="post">
	<input type = "hidden" name = "idx" value = "<%=i.getIdx() %>">
	<p>분류</p>
	<p><%=i.getCtgr() %></p>
	<p>질문</p>
	<p><%=i.getTitle() %></p>
	<p>내용</p>
	<p><%=i.getContent() %></p>
	<p>답변</p>
	<textarea name = "answer"></textarea>
	<input type = "submit" value = "답변 작성">
	</form>
</main>
</body>
</html>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
textarea{
	width: 100%;
	height: 30vh;
}
</style>