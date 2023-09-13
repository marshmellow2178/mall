<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
Inquiry dto = (Inquiry)request.getAttribute("id");
List<InquiryAnswer> aList = (List<InquiryAnswer>)request.getAttribute("aList");

int beidx = dto.getIdx();

String schtype= request.getParameter("schtype");
String keyword= request.getParameter("keyword");
String args = "";
if(schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("") )
{
   args += "&schtype=" + schtype + "&keyword=" + keyword;
}
String isend = "";
if(dto.getIsend()==null || !dto.getIsend().equals("y")){ isend = "대기중"; }
else{ isend = "처리완료"; }
%>
<link rel = "stylesheet" href = "css/common.css">
<style>
.title{
	display: flex;
	padding: 20px 0;
}
.title p{
	padding: 0 20px;
}
</style>
<main>
	<article>
    	<h2><%="["+dto.getCtgr()+"]"+dto.getTitle()%></h2>
    	<div class = title>
    		<p><%=dto.getMiid() %></p>
    		<p><%=isend %></p>
    		<p><%=GoodsUtil.boardDateFormat(dto.getDate()) %></p>
    	</div>
		<textarea readonly><%=dto.getContent().trim()%></textarea>
		<%if(aList.size()>0){
			for(int i=0;i<aList.size();i++){%>
			<textarea><%=aList.get(i).getComment() %></textarea>
			<%}
		} %>
    </article>
    <a href = "inquiry_list" class = "ctgr">목록으로</a>
</main>

<%@include file="../_inc/inc_foot.jsp"%>