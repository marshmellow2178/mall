<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
OrderInfo oi = (OrderInfo)request.getAttribute("orderInfo");
ArrayList<OrderDetail> dl = oi.getDetailList();
%>
  <style>
   <%@include file="../css/common.css" %>
<%@include file="../mypage/mypage.css"%>
 .orderpdt{width: 100%; vertical-align:center; }
 .orderpdt{display: flex;    align-items: center; border: 1px solid #6255f6 ;}

 .all{margin-bottom: 10px;}
 img {width: 7em; height: 6em;}
 .money{display:flex;    justify-content: space-between; }
 .orderdt{width : 100%;  }
 .orderdt p {margin:1.2em 0;;}
 .orderdt span {width:7%;margin-bottom:1.2em ;}
 }
 
.wrapper{
	margin: 0 auto;
	width:1200px;
}
.button{
	margin: 0 auto;
}
.myorder{
 display: flex;
    justify-content: space-around;
}
main{    
	max-width: 100%;
	margin: 0 auto;
	position: relative;
	top: 220px;
}
.list{
display:flex;
}
.info{
    display: flex;
    flex-direction: column;
    margin-left: 5px;
}
.point{margin-bottom: 10px}
</style>

  <main>
    <div class="wrapper" style="
    width: 1200px;
    margin: 0 auto;">
        <h3>마이페이지 > 주문상세정보</h3>
		<div class= "myorder">
	       <div class="menu">
	           <p>내 정보</p>
	        <a href="mypage">내정보</a>
	           <a href="change_pw_form">비밀번호변경</a>
	           <p>주문정보</p>
	           <a href="cart_view">장바구니</a>
	           <a href="order_list?cpage=1">주문내역</a>
	           <p>포인트/쿠폰</p>
	           <a href="point_list?cpage=1">포인트내역</a>
	           <a href="coupon_list">쿠폰함</a>
	           <p>기타</p>
	           <a href="mantoman_list.html">문의내역</a>
	           <a href="member_out_form.html">회원탈퇴</a>
	       </div>
	       <div class="content">
	     	 	<div ><!-- 주문자 정보 -->
	     	 		<div>
	     	 			<span>주문자 : <%=oi.getOi_name() %></span>
	     	 		</div>
	     	 		<div>
	     	 			<span>배송지 : <%=oi.getOi_addr1() %> <%=oi.getOi_addr2() %></span>
	     	 		</div>
	     	 		<div>
	     	 			<span>전화번호 : <%=oi.getOi_phone() %></span>
	     	 		</div>
	     	 	</div>
		       	<div><!-- 주문 물품 정보 -->
		       	<%for(int i=0; i<dl.size();i++){ 
		       		OrderDetail od = dl.get(i);
		       	
		       	%>	
		       		<div class="list">
		       			<div>
		       				<img src="img/product_img/<%=od.getOd_img()%>">
		       			</div>
		       			<div class="info">
		       				<span>상품명 : <%=od.getOd_name() %> </span>
		       			<%if(!od.getOd_am_name().equals("")){ %>
		       				<span>옵션 : <%=od.getOd_am_name() %> </span>
		       			<%} %>
		       				<span>수량 : <%=od.getOd_cnt() %></span>
		       				<span>가격 : <%=od.getOd_price() %></span>
		       			</div>
		       		</div>
		       	<%} %>
			       	<div class="point">
			       	<%if(oi.getOi_upoint()>0){ %>
			       	
			       		<p>사용 포인트 :<%=oi.getOi_upoint() %></p>
			       		<%}%>
			       		<p>적립포인트 : <%=oi.getOi_spoint() %></p>
			       	 	<span>총가격 : <%=oi.getOi_pay() %></span>
			       	</div>
			       	
			       	<a href="order_list?cpage=<%=request.getParameter("cpage")%>"><input type="button" value="주문내역" ></a>
	     	 	
		       	</div>
	       	
	       	</div>
	       
       	</div>
    </div>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>