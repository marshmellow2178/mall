<%@page import="java.awt.PointerInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>

<%request.setCharacterEncoding("utf-8");
List<Point> pointList = (List<Point>)request.getAttribute("pointList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int pointtotal = loginInfo.getPoint();
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();
%>
<link rel = "stylesheet" href = "css/common.css">
<style>
th:nth-of-type(1){
	width: 15%;
}
th:nth-of-type(2){
	width: 15%;
}
th:nth-of-type(4){
	width: 20%;
}
tr td:nth-of-type(2){
	text-align: right;
}
tr td:nth-of-type(3){
	text-align: left;
}
</style>
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
	<div class = content>
	<%if(pointList.size()>0){ %>
    <table>
    	<tr>
        	<th>구분</th>
            <th>포인트</th>
            <th>내역</th>
            <th>일자</th>
       	</tr>
	<%   
	Point mp = null;
    for (int i=0;i<pointList.size();i++){   
    	mp = pointList.get(i); 
    	String ctgr = "사용";
    	if(mp.getPoint()>0) { ctgr = "적립"; }
	%>
		<tr>
			<td><%=ctgr %></td>
            <td><%=Math.abs(mp.getPoint()) %></td>
            <td><%=mp.getDesc() %></td>
            <td><%=GoodsUtil.getDateFormat(mp.getDate())%></td>
	    </tr>
    <%}%>
    	<tr><td colspan = 4>내 포인트 : <%=loginInfo.getPoint()%></td></tr>
    </table>
    
    <div class="paging">
	<% 
	if(cpage!=1){
		out.println("<a href='point_list?page=1"+"'>처음</a>");
	}else{ 
		out.println("<p>처음</p>");
	}
	
	if(cpage>1){
		out.println("<a href='point_list?page="+(cpage-1)+"'>이전</a>");
	}else{ 
		out.println("<p>이전</p>");
	}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){
			out.println("<p><b>"+i+"</b></p>");
		}else{
			out.println("<a href = 'point_list?page="+i+"'>"+i+"</a>");
		}
	}
	
	if(cpage<pcnt){
		out.println("<a href='point_list?page="+(cpage+1)+"'>다음</a>");
	}else{ 
		out.println("<p>다음</p>");
	}
	
	if(cpage!=pcnt){
		out.println("<a href='point_list?page="+pcnt+"'>마지막</a>");
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