<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
OrderInfo oi = (OrderInfo)request.getAttribute("oi");
List<OrderDetail> odList = (List<OrderDetail>)request.getAttribute("odList");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_order_update_proc" method="post">
	<input type = "hidden" name = "idx" value = "<%=oi.getIdx() %>">
	<table>
		<caption>주문자 정보</caption>
		<tr><th width = 15%>주문자</th><td><%=oi.getName()%></td></tr>
		<tr><th rowspan = 2>배송지</th><td><%=oi.getAddr1() %></td></tr>
		<tr><td><%=oi.getAddr2() %></td></tr>
		<tr><th>연락처</th><td><%=oi.getPhone()%></td></tr>
		<tr><th>주문일</th><td><%=GoodsUtil.getDateFormat(oi.getDate()) %></td></tr>
		<tr>
		<th>주문상태</th>
		<td>
			<select name = status>
			<option value = "<%=Code_List.PAID%>"
			<%if(oi.getStatus().equals(Code_List.PAID)){ %>selected = "selected"<%} %>>결제 완료</option>
			<option value = "<%=Code_List.START %>"
			<%if(oi.getStatus().equals(Code_List.START)){ %>selected = "selected"<%} %>>배송중</option>
			<option value = "<%=Code_List.COMPLETE%>"
			<%if(oi.getStatus().equals(Code_List.COMPLETE)){ %>selected = "selected"<%} %>>배송 완료</option>
			</select>
		</td>
	</table>
	<table>
		<caption>상품 목록</caption>
		<tr>
			<th>이미지</th>
			<th>상품명</th>
			<th>수량</th>
		</tr>
		<%for(int i=0; i<odList.size();i++){ 
        	OrderDetail od = odList.get(i);
        %>
        <tr>
        	<td><figure><img src="img/product_img/<%=od.getImg()%>"></figure></td>
        	<td><%=od.getProduct() %></td>
        	<td><%=od.getCnt() %> 개</td>
        </tr>
        <%} %>
	</table>
	<input type = submit value = "수정완료">
	<a href = "super_order_list">목록으로</a>
	</form>
</main>
</body>
</html>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>