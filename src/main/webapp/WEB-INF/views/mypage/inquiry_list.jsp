<%@page import="java.awt.PointerInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>

<%request.setCharacterEncoding("utf-8");
List<Inquiry> iList = (List<Inquiry>)request.getAttribute("iList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();
%>
<link rel = "stylesheet" href = "css/common.css">
<style>
table th, table td{
	text-align: center;
}
th:nth-of-type(1){
	width: 30%;
}
th:nth-of-type(3){
	width: 15%;
}
th:nth-of-type(4){
	width: 15%;
}
tr td:nth-of-type(2){
	text-align: left;
}
</style>
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
	<div class = "content">
	<%if(iList.size()>0){ %>
    <table>
    	<tr>
            <th>분류</th>
            <th>제목</th>
            <th>날짜</th>
            <th>상태</th>
       	</tr>
	<%   
	Inquiry dto = null;
    for (int i=0;i<iList.size();i++){   
    	dto = iList.get(i); 
    	String isend = "";
    	if(dto.getIsend()==null || !dto.getIsend().equals("y")){ isend = "대기중"; }
    	else{ isend = "처리완료"; }
	%>
		<tr>
			<td><%="["+Code_List.getQuestionCtgr(dto.getCtgr())+"]"%></td>
            <td><a href = "inquiry_view?idx=<%=dto.getIdx()%>"><%=dto.getTitle()%></a></td>
            <td><%=GoodsUtil.boardDateFormat(dto.getDate())%></td>
            <td><%=isend%></td>
	    </tr>
    <%}%>
    </table>
    <a class = "ctgr" href = "inquiry_form">문의하기</a>
    
    <div class="paging">
	<% 
	if(cpage!=1){
		out.println("<a href='inquiry_list?page=1"+"'>처음</a>");
	}else{ 
		out.println("<p>처음</p>");
	}
	
	if(cpage>1){
		out.println("<a href='inquiry_list?page="+(cpage-1)+"'>이전</a>");
	}else{ 
		out.println("<p>이전</p>");
	}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){
			out.println("<p><b>"+i+"</b></p>");
		}else{
			out.println("<a href = 'inquiry_list?page="+i+"'>"+i+"</a>");
		}
	}
	
	if(cpage<pcnt){
		out.println("<a href='inquiry_list?page="+(cpage+1)+"'>다음</a>");
	}else{ 
		out.println("<p>다음</p>");
	}
	
	if(cpage!=pcnt){
		out.println("<a href='inquiry_list?page="+pcnt+"'>마지막</a>");
	}else{ 
		out.println("<p>마지막</p>");
	}
	%>
	</div>
	<%}else{ %>
	<p>내역이 없습니다</p>
	<%} %>
	</div>
</main>
<%@ include file="../_inc/inc_foot.jsp"%>