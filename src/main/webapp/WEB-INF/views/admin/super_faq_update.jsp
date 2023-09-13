<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
Faq f = (Faq)request.getAttribute("faq");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "faq_proc_up" method="post">
	<input type = "hidden" name = "idx" value = "<%=f.getIdx() %>">
	<p>분류</p>
	<select name = "ctgr">
		<option value = "">분류 선택</option>
        <option value = "<%=Code_List.MEMBER%>"
        <%if(f.getCtgr().equals(Code_List.MEMBER)) {%> selected = "selected" <%} %>>회원</option>
        <option value = "<%=Code_List.PRODUCT%>"
        <%if(f.getCtgr().equals(Code_List.PRODUCT)) {%> selected = "selected" <%} %>>구매/취소/환불</option>
        <option value = "<%=Code_List.ORDER%>"
        <%if(f.getCtgr().equals(Code_List.ORDER)) {%> selected = "selected" <%} %>>주문/배송/반품</option>
	</select>
	<p>질문</p>
	<textarea name = "title" required><%=f.getTitle() %></textarea>
	<p>내용</p>
	<textarea name = "content" required><%=f.getAnswer() %></textarea>
	<input type = "submit" value = "수정">
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