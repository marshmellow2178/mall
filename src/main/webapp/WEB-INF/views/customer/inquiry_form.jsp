<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<link rel = "stylesheet" href = "css/common.css">
<style>
#title{
	width: 73%;
}
#content{
	width: 80%;
	height: 60vh;
}
</style>
<main>
<%@include file="../_inc/inc_customer.jsp"%>
    
    <form class="submit" action = "inquiry_proc_in" method="post">
        <div class = title>
        	<select name = "ctgr">
        		<option value = "">분류 선택</option>
        		<option value = "a">환불/취소</option>
        		<option value = "b">배송/반품</option>
        		<option value = "c">기타</option>
        	</select>
            <input type="text" name="title" id = "title" placeholder="제목" required>
        </div>
        <textarea name = "content" id = "content" required></textarea>
        <div>
			<input type = "button" onclick = "location.href ='inquiry_list';" value = "목록으로">
            <input type="reset" value="초기화">
            <input type="submit" value="제출">
        </div>
    </form>
</main>
<%@include file="../_inc/inc_foot.jsp"%>