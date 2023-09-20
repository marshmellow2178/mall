<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<link rel = "stylesheet" href = "css/common.css">
<style>
input[type=text]{
	width: 73%;
}
</style>
<main>
<%@include file="../_inc/inc_customer.jsp"%>
    
    <form class="submit" action = "inquiry_proc_in" method="post">
        <div>
        	<select name = "ctgr">
        		<option value = "m">회원</option>
        		<option value = "p">상품</option>
        		<option value = "o">주문</option>
        	</select>
            <input type="text" name="title" placeholder="제목" required>
        </div>
        <textarea name = "content" id = "content" required></textarea>
        <div>
            <input type="reset" value="초기화">
            <input type="submit" value="제출">
        </div>
    </form>
</main>
<%@include file="../_inc/inc_foot.jsp"%>