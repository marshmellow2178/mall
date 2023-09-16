<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
OrderInfo oi = (OrderInfo)request.getAttribute("orderInfo");
String oiid= request.getParameter("oiid");
%>
<style>
main{    
	max-width: 100%;
	margin: 0 auto;
	position: relative;
	top: 220px;
	
}
.textbox{
border: 1px solid black;
width: 600px;
margin: 0 auto;
padding: 50px;
}
.headtext{
margin-bottom: 5px;
}
.memberinfo{
margin-bottom: 5px;
}
.orderinfo{
margin-bottom: 15px;
}
</style>
<main>
	<form class="textbox">
		<div class="headtext">
			<h2> 주문 완료 </h2>
			<p>구매해 주셔서 감사합니다.</p>
		</div>
		<div class= "memberinfo">
			<p><%=loginInfo.getMi_name() %>님 구매해 주셔서 감사합니다</p>
		</div>
		<div class = "orderinfo">
			<p>고객님이 주문하신 주문번호는</p>
			<p><%=oiid %>입니다</p>
			<p>주문내역 확인은 마이페이지의<br/>
			“주문배송내역” 에서 하실 수 있습니다</p>
		</div>
		<div>
		
		<input type="button" value="이전" onclick="" ><input type="button" value="주문내역확인" onclick="location.href='order_detail?oiid=<%=oiid%>'" ></div>
	</form>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>

