<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
EventDto el = (EventDto)request.getAttribute("el");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<article>
    	<h2><%=el.getTitle()%></h2>
	    <div class = "content">
			<figure><img src = "img/event_img/<%=el.getImg2()%>"></figure>
			<%if(el.getType().equals("a")) {%>
			<a href = "event_attendance" class = "ctgr">바로가기</a>
			<%} %>
		</div>
    </article>
    <a href = "event_list" class = "ctgr">이벤트홈</a>
</main>

<%@include file="../_inc/inc_foot.jsp"%>