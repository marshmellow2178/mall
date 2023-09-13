<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<OrderInfo> infoList = (List<OrderInfo>)request.getAttribute("orderlist");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();	

%>
<link rel = "stylesheet" href = "css/common.css">
<main>
<%if(infoList.size()>0){ %>
<table class = "list">
	<tr>
    <th width = 20%>주문자</th>
    <th>주문일</th>
    <th width = 15%>상태</th>
    </tr>
	<%for(int i = 0;i<infoList.size();i++){ 
		OrderInfo info = infoList.get(i);
	%>
    <tr>
    <td><%=info.getMiid() %></td>
    <td><a href = "super_order_update?idx=<%=info.getIdx() %>"><%=info.getDate() %></a></td>
    <td><%=info.getStatus() %></td>
   	</tr>
	<%} %>
</table>

<div class="paging">
    <%
	if(cpage!=1){
		out.println("<a href='super_order_list?page=1'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='super_order_list?page="+(cpage-1)+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'super_order_list?page="+i+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='super_order_list?page="+(cpage+1)+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='super_order_list?page="+pcnt+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>
<%}else{ %>
	<p>검색결과가 없습니다</p>
<%}%>
</main>
<%@include file="../_inc/inc_foot.jsp"%>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>