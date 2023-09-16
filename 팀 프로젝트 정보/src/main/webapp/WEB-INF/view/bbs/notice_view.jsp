<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
NoticeInfo nv =  (NoticeInfo)request.getAttribute("noticeView");
%>

<style>
<%@include file="../css/init.css" %>

main{max-width: 100%;
    margin: 0 auto;
    position: relative;
    top: 220px;
}
a{text-decoration: none;}
.notice_main{
width : 1200px;
margin: 0 auto;
}
.menu {
	width : 500px;
	display: flex;
	margin: 0 auto;
	justify-content: space-around;
}
.notice{
	margin: 0 auto;
	width :1000px;
}
.notice_view{
	width :100%;
}
.table{
	width :100%;	
}
.num{
	margin: 0 auto;
}
</style>  
<main>
	<div class= "notice_main">
		<h2></h2>
		<div  class="menu">
			<div>
				<a href = "notice">공지사항</a>
			</div>	
			<div>
				<a href = "faq">FAQ</a>
			</div>
			<div>
				<a href = "mantoman">1대1문의</a>			
			</div>
		</div>
		<div class= "notice">
			<h3>공지사항</h3>
			<div class="notice_view">
			<table width="700" cellpadding="5">
				<tr>
					<th>작성자</th>
					<td width="15%"><%=nv.getAi_name() %></td>
					<th>조회수</th>
					<td width="10%"><%=nv.getBn_read() %></td>
					<th>작성일</th>
					<td width="*"><%=nv.getBn_date() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="5"><%=nv.getBn_title() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5"><%=nv.getBn_content().replaceAll("\r\n","<br/>") %></td>
				</tr>
			</table>
			</div> 
			<div>
				<a href ="notice?cpage=<%=pageInfo.getCpage()%>">
					<input type="button" value="이전 ">
				</a>
			</div>
		</div>
	</div>
</main>


<%@include file="../_inc/inc_foot.jsp"%>