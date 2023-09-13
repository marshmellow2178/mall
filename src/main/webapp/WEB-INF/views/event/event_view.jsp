<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
EventDto el = (EventDto)request.getAttribute("el");

int beidx = el.getIdx();

String schtype= request.getParameter("schtype");
String keyword= request.getParameter("keyword");
String args = "";
if(schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("") )
{
   args += "&schtype=" + schtype + "&keyword=" + keyword;
}

String status = "진행중";
if(el.getStatus().equals("a")) status = "진행중";
else if(el.getStatus().equals("b")) status = "대기중";
else if(el.getStatus().equals("c")) status = "마감임박";	
else if(el.getStatus().equals("d")) status = "종료";

%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<article>
    	<h2><%=el.getTitle()%></h2>
		<figure><img src = "img/<%=el.getImg2()%>"></figure>
    </article>
    <a href = "event_list" class = "ctgr">이벤트홈</a>
</main>

<%@include file="../_inc/inc_foot.jsp"%>