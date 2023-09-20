<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
	List<Domain> domainList = (List<Domain>)request.getAttribute("domainList");
%>

<link rel = "stylesheet" href = "css/common.css">

<script>
	function allTerms(value){
		$('#privacy').prop('checked', value);
		$('#useAgree').prop('checked', value);
	}
	
	function chkTerms(){
		let val1 = $('#privacy').is(":checked");
		let val2 = $('#useAgree').is(":checked");
		if(val1==true&&val2==true){ $('#agreeAll').prop('checked', true); }
		else{ $('#agreeAll').prop('checked', false); }
	}
</script>

<main>
	<form class="form" method="POST" action = "member_proc_in">
		<table>
			<caption>회원가입</caption>
			<tr>
				<th>이름</th> 
				<td><input type="text" name="name" maxlength="20" required pattern = "[^0-9]+"></td>
			</tr>
			<tr>
				<th>ID</th> 
				<td>
				<input type="text" name="id" pattern = "[A-Za-z0-9].{4,20}" required onkeyup = 'chkId(this.value);'>
				<span id="idMsg"> </span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th> 
				<td>
				<input type="password" name="pw" required pattern = "(?=.*\d)(?=.*[a-zA-Z]).{8,20}">
				<span>8에서 20자 사이의 영문, 숫자를 혼합해야 합니다</span>
				</td>
			</tr>
			<tr>
				<th>이메일</th> 
				<td>
				<input type="text" name="email" maxlength = "20" pattern = "[A-Za-z0-9]+" required> @ 
				<select name="domain">
					<%for (int i = 0; i < domainList.size(); i++) {%>
					<option value="<%=domainList.get(i).getId()%>"><%=domainList.get(i).getId()%></option>
					<%}%>
				</select>
				</td>
			</tr>
			<tr>
				<th>연락처</th> 
				<td>
				<span>010-</span>
				<input type="number" name="phone" pattern = "[0-9].{8,}" maxlength = 8 required>
				</td>
			</tr>
			<tr>
				<th rowspan = 2>주소</th> 
				<td><input type="text" name="addr1" placeholder="주소" maxlength="20" required> </td>
			</tr>
			<tr> 
				<td><input type="text" name="addr2" placeholder="상세주소" maxlength="20" required></td>
			</tr>
			<tr>
				<th rowspan = 3>약관동의</th>
				<td>
				<p>이용약관</p>
				<textarea disabled>
				이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관 
				이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관 
				이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
				</textarea>
				<input type="checkbox" value="y" id="useAgree" onclick = "chkTerms();" required>
				<label for="useAgree">동의합니다.</label>
				</td>
			</tr>
			<tr>
				<td>
				<p>개인정보 제3자 제공동의</p>
				<textarea disabled>
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의 
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
				개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
				</textarea>
				<input type="checkbox" name="agree" value="y" id="privacy" onclick = "chkTerms();">
				<label for="privacy">동의합니다.</label>
				</td>
			</tr>
			<tr>
			<td>
				<p>전체동의</p>
				<input type="checkbox" id = "agreeAll" value="y" onclick = "allTerms(this.checked);">
				<label for="agreeAll">동의합니다</label>
			</td>
			</tr>
		</table>
		<div>
			<input type = "reset" value = "초기화" onclick = "confirm('정말 초기화하시겠습니까?');">
			<input type="submit" value="가입">
		</div>
	</form>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>
