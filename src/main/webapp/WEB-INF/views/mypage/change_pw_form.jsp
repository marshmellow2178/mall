<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
String uid = loginInfo.getId();
%>

<style>
.submit{
	width: 50%;
}
.submit input{
	width: 80%;
	height: 50px;
	padding: 5px;
}
</style>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
    <form action = "change_pw" class="submit" method="POST">
		<div>
			<p>기존비밀번호</p>
	        <input type="password" id="oldPwd" name="oldPwd" required>         
		</div>
		<div>
			<p>신규비밀번호</p>
            <input type="password" id="newPwd" name="newPwd" onkeyup="chkOldPwd(this.value); chkNewPwd();" required>
            <input type = "hidden" id = "chkPwd1" value = "0">
            <span id="msg1"></span>
		</div>
        <div>
        	<p>비밀번호 확인</p>
            <input type="password" id="rePwd" onkeyup="chkNewPwd()" required>
            <input type = "hidden" id = "chkPwd2" value = "0">
            <span id="msg2"></span>
        </div>	
        <input type="button" value="수정하기" id = "submit" onclick = "sub();" disabled>
    </form>
</main>
<script>
function chkOldPwd(newPwd){
	var oldPwd = $('#oldPwd').val();
	var newPwd = newPwd;
	if(oldPwd == newPwd){
		$("#msg1").html("<span style='color: red;'>기존 비밀번호와 같습니다</span>");
		$("#chkPwd1").val(0);
	}else{
		$("#msg1").html("");
		$("#chkPwd1").val(1);
	}
}

function chkNewPwd(){
	var rePwd = $('#rePwd').val();
	var newPwd = $('#newPwd').val();
	if(newPwd == rePwd){
		$("#msg2").html("<span style='color: blue;'>새 비밀번호와 일치합니다.</span>");
		$("#chkPwd2").val(1);
	} else {
		$("#msg2").html("");
		$("#chkPwd2").val(0);
	}
	
	if($("#chkPwd1").val() == 1 && $("#chkPwd2").val() == 1){
		$("#submit").attr("disabled", false);	
	}
}

function sub(){
	var oldPwd = $('#oldPwd').val();
	var newPwd = $('#newPwd').val();
	$.ajax({
 		type : "POST",
 		url : "change_pw",
 		contentType: 'application/json',
 		dataType: 'json',
 		data : JSON.stringify({
 			"miid" : "<%=loginInfo.getId()%>",
 			"oldPwd" : oldPwd,
 			"newPwd" : newPwd 
 		}),
 		success : function(chkRs){
 			if(chkRs == -1 ){
 				alert("로그인되어있지 않습니다");
 				location.replace('login_form');
 			}
 			else if(chkRs == 0 ){	
 				alert("기존 비밀번호가 틀렸습니다");
 				return;
 			}else{			
 				if(confirm("비밀번호가 변경되었습니다\n 다시 로그인하세요")){
 					location.replace('login_form');
 				}
 			}
 		}
 	});
}
</script>
<%@include file = "../_inc/inc_foot.jsp" %>