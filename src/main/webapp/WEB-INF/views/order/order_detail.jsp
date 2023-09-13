<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
OrderInfo oi = (OrderInfo)request.getAttribute("oi");
List<OrderDetail> dl = (List<OrderDetail>)request.getAttribute("dl");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>
	
	<div class = "content">
	<table>
		<caption>주문자 정보</caption>
		<tr><th width = 15%>주문자</th><td><%=oi.getName()%></td></tr>
		<tr><th rowspan = 2>배송지</th><td><%=oi.getAddr1() %></td></tr>
		<tr><td><%=oi.getAddr2() %></td></tr>
		<tr><th>연락처</th><td><%=oi.getPhone()%></td></tr>
		<tr><th>주문일</th><td><%=GoodsUtil.getDateFormat(oi.getDate()) %></td></tr>
	</table>

	<table>
		<caption>상품 목록</caption>
		<tr>
			<th>이미지</th>
			<th>상품명</th>
			<th>수량</th>
			<th>가격</th>
		</tr>
		<%for(int i=0; i<dl.size();i++){ 
        	OrderDetail od = dl.get(i);
        %>
        <tr>
        	<td><figure><img src="img/product_img/<%=od.getImg()%>"></figure></td>
        	<td><%=od.getProduct() %></td>
        	<td><%=od.getCnt() %> 개</td>
        	<td><%=od.getPrice() %> 원</td>
        </tr>
        <%} %>
        <tr><td colspan = 4>총 가격: <%=oi.getPay() %></td></tr>
	</table>
	</div>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>