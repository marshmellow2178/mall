<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<OrderInfo> orderlist = (List<OrderInfo>)request.getAttribute("orderlist");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt= pageInfo.getRcnt();
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
    <%@include file = "../_inc/inc_mypage.jsp" %>
    <div class = "content">
	<%if(orderlist.size()>0){%>
	<table>
	<tr>
		<th>주문일</th>
		<th>결제금액</th>
		<th>상태</th>
	</tr>
    <%for(int i=0;i<orderlist.size();i++){	
    	OrderInfo ol = orderlist.get(i);
    	String status = "";
    	if(ol.getStatus()==null || ol.getStatus().equals("n")){ status = "배송중"; }
    	else if(ol.getStatus().equals("c")){ status = "배송완료"; }
    	else { status = "결제완료"; }
    %>
    <tr>
    	<td><a href = "order_detail?oiidx=<%=ol.getIdx()%>"><%=GoodsUtil.getDateFormat(ol.getDate())%></a></td>
    	<td><%=ol.getPay() %></td>
    	<td><%=ol.getStatus() %></td>
	</tr>
    <%} %>
	</table>
	
	<div class="paging">
	<%
	if(cpage!=1){
		out.println("<a href='order_list?page=1'>처음</a>");
	}else{ 
		out.println("<p>처음</p>");
	}
	
	if(cpage>1){
		out.println("<a href='order_list?page="+(cpage-1)+"'>이전</a>");
	}else{ 
		out.println("<p>이전</p>");
	}
	
	for(int i = spage; i<=pcnt && i<spage+bsize ;i++){
		if(cpage == i){
			out.println("<p><b>"+i+"</b></p>");
		}else{
			out.println("<a href = 'order_list?page="+i+"'>"+i+"</a>");
		}
	}
	
	if(cpage<pcnt){
		out.println("<a href='order_list?page="+(cpage+1)+"'>다음</a>");
	}else{ 
		out.println("<p>다음</p>");
	}
	
	if(cpage!=pcnt){
		out.println("<a href='order_list?page="+pcnt+"'>마지막</a>");
	}else{ 
		out.println("<p>마지막</p>");
	}
	%>
	</div>
	<%}else{ %>
		<p>주문내역이 없습니다</p>
	<%} %>
	</div>
</main>
<%@ include file="../_inc/inc_foot.jsp"%>