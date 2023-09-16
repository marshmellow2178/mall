<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");

List<EventInfo> eventList = (List<EventInfo>)request.getAttribute("eventList");


String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");

String schargs = "", args = "";			// schargs = 검색조건용
if(schtype != null && !schtype.equals("") && keyword != null && !keyword.equals(""))
{
	// 검색조건(schargs)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
}



String status = "진행중";
%>
<style>
<%@include file="../css/init.css" %>
<%@include file="../css/common.css" %>

main { transform: translateY(300px); }
.wrapper{
    text-align : center;
}
.event_list{
    display: flex;
    flex-wrap: wrap;
    padding : 0;
}
.event_list li{
    width: 45%;
    margin: 20px;
}
.event_list li figure{
    margin-bottom: 10px;
}
.event_list li figure img {
    width: 90%;
}

.span
{
	color : #333;
}

</style>
<main>

<%
if(eventList.size() > 0)
{
%>
<div class="wrapper">
	<ol class="event_list">
<%
	// 게시글 목록이 있으면
	for(int i = 0; i < eventList.size(); i++)
	{
		EventInfo el = eventList.get(i);
		
		String title = el.getBe_title();
		title = "<a href='event_view?beidx=" + el.getBe_idx() + args + "'>" + title + "</a>";
		System.out.println("title : " + title);
		if(el.getBe_status().equals("a")) status = "대기중";
		if(el.getBe_status().equals("c")) status = "마감임박";	
		if(el.getBe_status().equals("d")) status = "종료";
%>
		<li>
			<p><img src="img/event_img/<%=el.getBe_img1() %>"></p>
            <span>[<%=status%>]  <%=title %></span> 
            <p>기간 : <%=el.getBe_sdate().substring(0, 10) %> ~ <%=el.getBe_edate().substring(0, 10) %></p>
        </li>
<%
	}
%>    
	</ol>
</div> 

<%
}

else
{
	// 게시글 목록이 없으면
	out.print("<tr><td colspan='5' align='center'>");
	out.println("이벤트가 없습니다. </td></tr>");
}

%>

</main>




<%@include file="../_inc/inc_foot.jsp"%>