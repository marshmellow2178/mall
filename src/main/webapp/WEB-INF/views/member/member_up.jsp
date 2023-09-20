<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
	List<Domain> domainList = (List<Domain>)request.getAttribute("domainList");
%>
<link rel = "stylesheet" href = "css/common.css">

<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
	<div class = "content">
	<form action = "member_proc_up" method = "post">
		<table>
	    	<caption>회원정보 수정</caption>
	    	<tr>
	    		<th>ID</th>
	    		<td>
	    		<input type="text" name="id" pattern = "[A-Za-z0-9].{4,20}" required onkeyup = 'chkId(this.value);' value = "<%=loginInfo.getId() %>">
				<span id="idMsg"> </span>
				</td>
	    	</tr>
	    	<tr>
	    		<th>이메일</th>
	    		<td>
		    		<input type = "text" name = "email" pattern = "[A-Za-z0-9]+" required value = "<%=loginInfo.getEmail() %>"> @ 
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
					<input type = "number" name = "phone" pattern = "[0-9].{8,}" maxlength = 8 value = "<%=loginInfo.getPhone()%>">
		    	</td>
	    	</tr>
	    	<tr>
	    	<th rowspan = 2>주소</th>
	    	<td><input type = "text" name = "addr1" maxlength = 20 required value = "<%=loginInfo.getAddr1() %>"></td></tr>
	    	<tr><td><input type = "text" name = "addr2" maxlength = 20 required value = "<%=loginInfo.getAddr2() %>"></td></tr>
	    	
	    	<tr>
	    		<th>약관</th>
	    		<td>
				<p>개인정보 제3자 제공동의</p>
				<textarea disabled>
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의 
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
				</textarea>
				<input type="checkbox" name="agree" value="y" id="privacy"
				<%if(loginInfo.getAgree().equals("y")){ %>
				checked = checked
				<%} %>>
				<label for="privacy">동의합니다</label>
				<input type="checkbox" name="agree" value="n" id="privacy"
				<%if(loginInfo.getAgree()!=null && loginInfo.getAgree().equals("n")){ %>
				checked = checked
				<%} %>>
				<label for="privacy">동의하지 않습니다</label>
				</td>
			</tr>
	    </table>
		<input type = "submit" value = "정보수정">
	</form>
	</div>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>