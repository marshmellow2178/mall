<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<link rel = "stylesheet" href = "css/common.css">
<style>
</style>

<main>
<%@include file = "../_inc/inc_mypage.jsp" %>
	<div>
    	<form action="member_proc_del" method="POST" class="submit">
    		<div>
    		회원 탈퇴시 모든 포인트가 소멸되며, 6개월간 같은 정보로 재가입이 불가능합니다
    		정말로 탈퇴하시겠습니까?
    		</div>
        	<div>
            	<p>비밀번호 입력</p>
                <input type="password" id="upw" name="upw" required />
            </div>
            <input type="submit" class="button" value="입력" /> 
         </form>
     </div>
</main>