<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<link rel = "stylesheet" href = "css/common.css">
<style>
</style>

<main>
<%@include file = "../_inc/inc_mypage.jsp" %>
	<div>
    	<form action="pw_form" method="POST" class="submit">
        	<div>
            	<p>비밀번호 입력</p>
                <input type="password" id="upw" name="upw" required />
            </div>
            <input type="submit" class="button" value="입력" /> 
            </form>
     </div>
</main>
