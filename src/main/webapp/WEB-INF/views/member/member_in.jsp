<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>

<%
	LocalDate today = LocalDate.now();   // 오늘 날짜
	int cyear = today.getYear();
	int cmonth = today.getMonthValue();
	int cday = today.getDayOfMonth();
	int last = today.lengthOfMonth();

	String[] arrDomain = {"naver.com", "daum.net", "nate.com", "gmail.com"};

%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js" ></script>
<script src="js/date_change.js"></script>

<link rel = "stylesheet" href = "css/common.css">

<script>
function sample6_execDaumPostcode() {
	new daum.Postcode(
		{
			oncomplete : function(data) {
					
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수
			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== ''
						&& /[동|로|가]$/g
								.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== ''
						&& data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName
							: data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' ('
							+ extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("sample6_extraAddress").value = extraAddr;

			} else {
				document.getElementById("sample6_extraAddress").value = '';
			}
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('ma_zip').value = data.zonecode;
			document.getElementById('ma_addr1').value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('ma_addr2').focus();
			$('#ma_addr2').prop("readonly", false);
			$('#addrChk').val('y');
		}
	}).open();
}

function submitAll(){
	if($('#idChk').val()=='n'){
		alert('아이디를 확인하세요');
		return;
	}
	if($('#nickChk').val()=='n'){
		alert('닉네임을 확인하세요');
		return;
	}
	if($('#pwdChk').val()=='n'){
		alert('비밀번호를 확인하세요');
		return;
	}
	if($('#phoneChk').val()=='n'){
		alert('전화번호를 확인하세요');
		return;
	}
	if($('#emailChk').val()=='n'){
		alert('이메일을 확인하세요');
		return;
	}
	if($('#addrChk').val()=='n'){
		alert('주소를 확인하세요');
		return;
	}
	if(!$('#useAgree').prop('checked')){
		alert('이용약관에 동의해주세요.');
	    return;
	}
	if(!$('#privacy').prop('checked')){
		alert('개인정보이용에 동의해주세요.');
	    return;
	}

    $('.form').attr("action", "member_proc_in");
	$('.form').attr("method", "POST");
	$('.form').submit();
};
	
	function putE3(){
		if ($("#e2").val() == "direct") {	// 선택 :'직접입력' 일 때
			$("#e3").val("");
			$("#e3").prop("readonly", false);
			$("#e3").focus();
		} else {								
			$("#e3").prop("readonly", true);
			$("#e3").val($("#e2").val());
		}
	};

	function chkNick(value){
		if(value.length<4 || value.length>20) { return; }
		
		msg(chkDup("nickname", value), "nick", "닉네임");
	}
	
	function chkId(value){
		if(value.length<4 || value.length>20) { return; }
		msg(chkDup("id", value), "id", "아이디");
	}
	
	function chkEmail(){
		let e1 = $('#e1').val();
		let e3 = $('#e3').val();

		// email 정규식
		let e1Reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])/i;
		let e3Reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if((e1.length<4 || e1.length>20) || !e1Reg.test(e1) || !e3Reg.test(e3)){
			alert("이메일 주소가 잘못되었습니다");
			$('#e1').focus();
			return;
		}else{
			$('#emailChk').val('y');
			$('#emailMsg').val('인증완료');
			$('#emailMsg').prop('disabled', true);
		}
	}
	
	function chkPwd(value){
		if(value.length<8 || value.length>20) { return; }
		// pw 정규식 : 특수문자,문자,숫자 포함 8~20자 이내
	    let pwReg = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	    if(pwReg.test(value)){
	    	msg('y', "pwd", "비밀번호");
	    }
	}

	function chkPhone(){
		let p1 = $('#p1').val();
		let p2 = $('#p2').val();
		let p3 = $('#p3').val();
		if(p1.length==3 && p2.length == 4 && p3.length == 4){
			$('#phoneChk').val('y');
			$('#phoneMsg').val('인증완료');
			$('#phoneMsg').prop('disabled', true);
		}else{
			alert("존재하지 않는 전화번호입니다");
			$('#p1').focus();
		}
	}
	
	function chkDup(type, value){
		let status = '';
		$.ajax({
			type : "POST", 
			url : "${pageContext.request.contextPath}/chkDup", 
			async : false,
			contentType: 'application/json',
			data : JSON.stringify({
				"type" : type,
				"data" : value
			}), 
			success : function(chkRs) {
				if (chkRs == 0) { status = 'y'; } 
				else { status = 'n'; }
			}
		});
		return status;
	}
	
	function msg(status, type1, type2){
		let typeChk = "#"+type1+"Chk";
		let typeMsg = "#"+type1+"Msg";
		let msg = "";
		if(status == 'n'){
			msg = "<span style='color: red;'>이미 사용중인 "+type2+"입니다.</span>";
		}else if(status == 'y'){
			msg = "<span style='color: blue;'>사용할 수 있는 "+type2+"입니다.</span>";
		}
		$(typeMsg).html(msg);
		$(typeChk).val(status);
	}

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
	//attr은 오류를 일으킨다
</script>

<main>
		<form class="form" name="frmJoin" id="frmJoin" method="POST" action = "member_proc_in">
			<!-- 중복체크용 hidden -->
			<input type="hidden" id="idChk" value="n" />
			<input type="hidden" id="nickChk" value="n" />
			<input type="hidden" id="emailChk" value="n" />
			<input type="hidden" id="pwdChk" value="n" />
			<input type="hidden" id="phoneChk" value="n" />
			<input type="hidden" id="addrChk" value="n" />
			<ul>
				<li>
					<p>이름</p> 
					<input type="text" name="mi_name" id="mi_name" minlength = "4" maxlength="20" required >
				</li>
				<li>
					<p>ID</p> 
					<input type="text" name="mi_id" id="mi_id" minlength = "4" maxlength="20" onkeyup="chkId(this.value);" placeholder="4 ~ 20자 이내" autocomplete="off" required>
					<span id="idMsg" style="font-size:5px;" >4에서 20자 사이로 입력하세요</span>
				</li>
				<li>
					<p>닉네임</p> 
					<input type="text" name="mi_nickname" id="mi_nickname" minlength = "4" maxlength="20" onkeyup="chkNick(this.value);" placeholder="2 ~ 20자 이내" autocomplete="off" required>
					<span id="nickMsg" style="font-size:5px;" >4에서 20자 사이로 입력하세요</span>
				</li>
				<li>
					<p>비밀번호</p> 
					<input type="password" name="mi_pw" id="mi_pw" minlength = "8" maxlength="20" placeholder="특수문자,숫자 포함 8~20자" autocomplete="off" required onkeyup = "chkPwd(this.value);">
					<span id="pwdMsg" style="font-size:5px;" >8에서 20자 사이의 영문, 숫자, 특수문자를 혼합해야 합니다</span>
				</li>
				<li>
					<p>이메일</p> 
					<input type="text" id="e1" name="e1" minlength = "4" maxlength = "20"> @ 
					<select name="e2" id="e2" onchange="putE3();" >
						<option value="">도메인 선택</option>
						<%for (int i = 0; i < arrDomain.length; i++) {%>
						<option value="<%=arrDomain[i]%>"><%=arrDomain[i]%></option>
						<%}%>
						<option value="direct">직접 입력</option>
					</select>
					<input type="text" name="e3" id="e3"  readonly>
					<input type="button" id = "emailMsg" onclick="chkEmail();" value="인증하기">
				</li>
				<li>
					<p>연락처</p> 
					<select name="p1" id = "p1">
						<option>010</option>
						<option>011</option>
						<option>016</option>
						<option>019</option>
					</select>- 
				<input type="number" name="p2" id = "p2" maxlength="4">-
				<input type="number" name="p3" id = "p3"  maxlength="4">
				<input type = "button" id = "phoneMsg" value = "인증하기" onclick = "chkPhone();">
				</li>
				<li class="addrFinder">
					<p>배송지 정보</p> 
					<input type = "button" value = "배송지 추가" onclick = "">
					<input type="hidden" name="ma_name" value=""> 
					<input type="hidden" name="ma_zip" value=""> 
					<input type="hidden" name="ma_addr1" value=""> 
					<input type="hidden" name="ma_addr2" value="">
				</li>
				<li class="addrFinder">
					<p>주소</p> 
					<input type="text" name="ma_name" placeholder = "주소지명"> 
					<input type="text" id="ma_addr1" name="ma_addr1" placeholder="주소" readonly /> 
					<input type="text" id="ma_zip" name="ma_zip" placeholder="우편번호" readonly /> 
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" />
					<input type="text" id="sample6_extraAddress" placeholder="" readonly>
				</li>
				<li class="addrFinder">
					<p></p> 
					<input type="text" id="ma_addr2" name="ma_addr2" placeholder="상세주소" maxlength="20" style="width: 250px;">
					<input type = "text" id = "ma_name" name = "ma_name">
					<input type = "radio" id = "ma_basic0" name = "ma_basic" checked = "checked">
					<label for = "ma_basic0">기본 배송지로 지정</label>
				</li>
				<li>
					<p>생년월일 : </p>
					<select name="by"  onchange="resetday(this.value, this.form.bm.value, this.form.bd);">
<% for (int i = 1930 ; i <= cyear ; i++) { %>
      <option value="<%=i %>" <% if (i == cyear) { %>selected="selected"<% } %>><%=i %></option>
<% } %>
   </select>년
   <select name="bm" 
   onchange="resetday(this.form.by.value, this.value, this.form.bd);">
<%
for (int i = 1 ; i <= 12 ; i++) {
   String bm = i + "";
   if (i < 10)   bm = "0" + i;
%>
   <option value="<%=bm %>" <% if (i == cmonth) { %>selected="selected"<% } %>><%=bm %></option>
<% } %>
   </select>월
   <select name="bd">
<%
for (int i = 1 ; i <= last ; i++) {
   String bd = i + "";
   if (i < 10)   bd = "0" + i;
%>
   <option <% if (i == cday) { %>selected="selected"<% } %>><%=bd %></option>
<% } %>
   </select>일
				</li>
				<li>
					<p>성별</p> 
					남자<input type="radio" name="mi_gender" value="남" checked>
					여자<input type="radio" name="mi_gender" value="여" >
				</li>
				<li>
					<p>이용약관</p>
					<span id="agreement" style="height:200px; overflow:scroll; overflow-x: hidden; text-align:start;">
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관 
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관 
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					이용약관 이용약관 이용약관 이용약관 / 이용약관 이용약관 이용약관 이용약관
					</span>
				</li>
				<li>
				<p></p>
					<input type="checkbox" name="agree" value="y" id="useAgree" onclick = "chkTerms();">
					<label for="useAgree">동의합니다.</label>
				</li>
				<li>
					<p>개인정보제공동의</p>
					<span id="agreement" style="height:200px; overflow:scroll; overflow-x: hidden; text-align:start;">
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의 
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					개인정보제공동의 개인정보제공동의 / 개인정보제공동의 개인정보제공동의
					</span>
				</li>
				<li>
				<p></p>
					<input type="checkbox" name="agree" value="y" id="privacy" onclick = "chkTerms();">
					<label for="privacy">동의합니다.</label>
				</li>
				<li>
				<p></p>
					<input name="agreeAll" id = "agreeAll" type="checkbox" onclick = "allTerms(this.checked);">
					<label for="agreeAll">전체동의</label>
				</li>
			</ul>

			<div>
				<input type = "reset" class="button"  value = "초기화" onclick = "confirm('정말 초기화하시겠습니까?');">
				<input onclick="submitAll();" type="button" value="가입">
			</div>
		</form>
</main>

