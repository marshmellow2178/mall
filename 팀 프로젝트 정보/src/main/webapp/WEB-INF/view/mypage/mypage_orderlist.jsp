<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String schargs="",args="";
List<OrderInfo> orderList = (List<OrderInfo>)request.getAttribute("orderList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
System.out.println("rcnt ="+rcnt);
args = "&cpage=" + cpage;

%>

<style>
 <%@include file="../css/common.css" %>
<%@include file="../mypage/mypage.css"%>
main{    
	max-width: 100%;
	margin: 0 auto;
	position: relative;
	top: 220px;
}
.list{    
	display: flex;
    justify-content: space-around;
}
.orderpdt{
	display:flex;
	border: 1px solid #6255f6;
	margin-bottom: 10px;
}
.wrapper{
	margin: 0 auto;
	width:1200px;
}
.num{
	margin: 0 auto;
}
.orderpdt>a{
    width: 70px;
}
</style>
<main>
    <div class="wrapper">
        <h3>마이페이지 > 주문정보</h3>
		<div class="list">
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
        
            <div>
                <%
               
                if(orderList.size()>0){ // 주문내역이 있다면
                	int num= rcnt -(psize*(cpage-1));
                	for(int i=0;i<orderList.size();i++){	
                		OrderInfo ol = orderList.get(i);
                		String piname = ol.getOi_id();
                		String title= piname;
                		if(ol.getPi_name().length()>12) title = title.substring(0,12)+"...";
                		title = "<a href = 'order_detail?"+"oiid="+ol.getOi_id()+args+"'>"+title+""+"</a>";
                		
                		
                	%> 
            	<div class = "orderpdt" > <!-- 주문목록 -->
                 	<a href="order_detail?oiid=<%=ol.getOi_id()+args%>" class="img"><img src="img/product_img/<%=ol.getOd_img()%>"/></a> 
                    <div class="orderdt">
                    	<p> 주문일 : <%=ol.getOi_date() %> </p>	
                        <p>	상품명 : <%=title %></p>  
                        <div class="money">
                        <p> 가격<%=ol.getOi_pay() %> 원</p>
                        </div>
                    </div>   
                </div>
                <%
                	}
                }else{
                	
                
                %>
                <%} %>
            </div>
			<table cellpadding="5" class="num">
				<tr>
					<td>
						<% if (rcnt>0) { 
			  		String lnk = "order_list?cpage=";
			  		pcnt = rcnt / psize;
			  		if(rcnt% psize>0) pcnt++; // 전체 페이지 수(마지막 페이지 번호)
					if(cpage==1){
						out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;&nbsp;");
					}else{
						out.println("<a href = '" + lnk + 1 + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
						out.println("<a href = '" + lnk + (cpage-1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
					}
					spage = (cpage -1)/bsize*bsize+1; // 현재 블록에서의 시작 페이지 번호
			  		for(int i =1, j=spage; i<=bsize && j <=pcnt ; i++,j++){
			  		// i : 블록에서 보여줄 페이지의 개수많큼 루프를 돌릴 조건으로 사용되는 변수
			  		// j : 살제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함	
			  			if(cpage == j){
			  				out.println("&nbsp;<strong>"+j+"</strong>&nbsp;");
			  			}else{
			  				out.println("&nbsp;<a href='" + lnk + j +schargs + "'>");
			  				out.println(j+"</a>&nbsp;");
			  			}
			  		}
					if(cpage==pcnt){
						out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
					}else{
						out.println("<a href = '" + lnk + (cpage+1) + schargs + "'>&nbsp;&nbsp;[다음]</a>");
						out.println("<a href = '" + lnk + pcnt + schargs + "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
					}
			  	}
			  	%>
					</td>
				</tr>
			</table>
        </div>
    	</div>
    </div>
</main>
<%@ include file="../_inc/inc_foot.jsp"%>