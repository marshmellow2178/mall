<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
EventInfo ei = (EventInfo)request.getAttribute("event");
%>
<link rel = "stylesheet" href = "css/common.css">

<main>
	<table>
	<tr>
	<th width = 15%>제목</th>
	<td><%=ei.getTitle()%></td>
	</tr>
	
	<tr>
	<th>이미지</th>
	<td><figure><img src = "img/event_img/<%=ei.getImg1()%>"></figure></td>
	</tr>
	
	<tr>
	<th>상세이미지</th>
	<td><figure><img src = "img/event_img/<%=ei.getImg2()%>"></figure></td>
	</tr>
	
	<tr>
	<th>등록일</th>
	<td><%=ei.getDate() %></td>
	</tr>
	
	<tr>
	<th>시작일</th>
	<td><%=ei.getSdate() %></td>
	</tr>
	
	<tr>
	<th>종료일</th>
	<td><%=ei.getEdate() %></td>
	</tr>
	
	<tr>
	<th>상태</th>
	<td><%=ei.getStatus() %></td>
	</tr>

	</table>
    <a href = "super_event_update?idx=<%=ei.getIdx() %>" class = "ctgr">수정하기</a>
</main>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>
<%@include file="../_inc/inc_foot.jsp"%>