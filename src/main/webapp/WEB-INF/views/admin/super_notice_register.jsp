<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
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
<%@include file="../_inc/inc_admin_customer.jsp"%>
    
    <form class="submit" action = "notice_proc_in" method="post">
        <div class = title>
        	<select name = "ctgr">
        		<option value = "">분류 선택</option>
        		<option value = "<%=Code_List.ALERT%>">주의</option>
        		<option value = "<%=Code_List.ANNOUNCCE%>">발표</option>
        		<option value = "<%=Code_List.NOTICE%>">알림</option>
        	</select>
            <input type="text" name="title" id = "title" placeholder="제목" required>
        </div>
        <textarea name = "content" id = "content" required></textarea>
        <div>
			<input type = "button" onclick = "location.href ='super_notice_list';" value = "목록으로">
            <input type="reset" value="초기화">
            <input type="submit" value="제출">
        </div>
    </form>
</main>
<%@include file="../_inc/inc_foot.jsp"%>