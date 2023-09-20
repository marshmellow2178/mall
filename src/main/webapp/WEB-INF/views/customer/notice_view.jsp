<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
Notice n = (Notice)request.getAttribute("notice");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<%@include file="../_inc/inc_customer.jsp"%>
	<article>
    	<h2><%=n.getTitle()%></h2>
		<div class = "content"><%=n.getContent() %></div>
    </article>
    <a href = "notice_list" class = "ctgr">목록으로</a>
</main>
<%@include file="../_inc/inc_foot.jsp"%>