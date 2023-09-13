<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<EventInfo> eventList = (List<EventInfo>)request.getAttribute("eventList");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();	

String status = "진행중";
%>
<link rel = "stylesheet" href = "css/common.css">
<style>

</style>
<main>
<%if(eventList.size() > 0){%>
	<ul>
	<%
	// 게시글 목록이 있으면
	for(int i = 0; i < eventList.size(); i++){
		EventInfo el = eventList.get(i);
		String lnk = "event_view?beidx=" + el.getIdx();
		if(el.getStatus().equals("a")) status = "진행중";
		else if(el.getStatus().equals("b")) status = "대기중";
		else if(el.getStatus().equals("c")) status = "마감임박";	
		else if(el.getStatus().equals("d")) status = "종료";
	%>
		<li onclick = "location.href = ('<%=lnk%>');">
			<figure><img src="img/event_img/<%=el.getImg1() %>"></figure>
            <h3><%=el.getTitle()%></h3> 
            <p><%=status%></p>
            <p>시작 <%=GoodsUtil.getDateFormat(el.getSdate()) %></p>
            <p>종료 <%=GoodsUtil.getDateFormat(el.getEdate()) %></p>
        </li>
	<%}%>    
	</ul>
	<div class="paging">
	<%
	if(cpage!=1){
		out.println("<a href='event_list?page=1"+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='event_list?page="+(cpage-1)+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = spage; i<=pcnt && i<spage+bsize ;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'event_list?page="+i+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='event_list?page="+(cpage+1)+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='event_list?page="+pcnt+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
	</div>

<%}else{%>
	<p>진행중인 이벤트가 없습니다</p>
<%}%>
</main>
<%@include file="../_inc/inc_foot.jsp"%>