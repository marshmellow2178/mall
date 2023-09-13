<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "faq_proc_in" method="post">
	<p>분류</p>
	<select name = "ctgr">
		<option value = "">분류 선택</option>
        <option value = "<%=Code_List.MEMBER%>">회원</option>
        <option value = "<%=Code_List.PRODUCT%>">구매/취소/환불</option>
        <option value = "<%=Code_List.ORDER%>">주문/배송/반품</option>
	</select>
	<p>질문</p>
	<textarea name = "title" required></textarea>
	<p>내용</p>
	<textarea name = "content" required></textarea>
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
textarea{
	width: 100%;
	height: 30vh;
}
</style>