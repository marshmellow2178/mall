<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
MemberInfo info = (MemberInfo)request.getAttribute("memberInfo");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_member_update_proc" method="post">
	<input type = "hidden" name = idx value = "<%=info.getIdx()%>">
	<table>
	<tr>
	<th width = 15%>ID</th>
	<td><input type = "text" maxlength = 20 required name = "id" value = "<%=info.getId()%>"></td>
	</tr>
	
	<tr>
	<th>포인트지급</th>
	<td><input type = "number" name = point value = 0></td>
	</tr>
	
	<tr>
	<th>상태변경</th>
	<td>
	<span><%=info.getStatus() %></span>
	<select name = "status">
		<option value = "n">정상</option>
		<option value = "d">탈퇴</option>
	</select>
	</td>
	</tr>
	</table>
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
</style>