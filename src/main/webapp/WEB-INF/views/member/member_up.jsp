<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
	List<Domain> domainList = (List<Domain>)request.getAttribute("domainList");
%>
<link rel = "stylesheet" href = "css/common.css">

<script>
</script>
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
	<div class = "content">
	<form action = "member_proc_up" method = "post">
		<table>
	    	<caption>회원정보 수정</caption>
	    	<tr>
	    		<th>ID</th>
	    		<td><input type = "text" name = "id" maxlength = "20" value = "<%=loginInfo.getId() %>"></td>
	    	</tr>
	    	<tr>
	    		<th>이메일</th>
	    		<td>
		    		<input type = "text" name = "email" maxlength = "20" value = "<%=loginInfo.getEmail() %>"> @ 
					<select name = "domain">
						<%for(int i = 0;i<domainList.size();i++){
							Domain d= domainList.get(i);
						%>
							<option value = "<%=d.getId() %>" <%if(loginInfo.getDomain().equals(d.getId())){ %> selected = "selected" <%} %>><%= d.getId() %></option>
						<%} %>
					</select>
	    		</td>
	    	</tr>
	    	<tr>
		    	<th>연락처</th>
		    	<td>
		    		<input type = "text" value = "010" disabled>
					<input type = "number" name = "phone" maxlength = 8 placeholder = "<%=loginInfo.getPhone()%>">
		    	</td>
	    	</tr>
	    	<tr>
	    	<th rowspan = 2>주소</th>
	    	<td><input type = "text" name = "addr1" maxlength = 50 value = "<%=loginInfo.getAddr1() %>"></td></tr>
	    	<tr><td><input type = "text" name = "addr2" maxlength = 50 value = "<%=loginInfo.getAddr2() %>"></td></tr>
	    </table>
		<input type = "submit" value = "정보수정" class = "ctgr">
	</form>
	</div>
</main>