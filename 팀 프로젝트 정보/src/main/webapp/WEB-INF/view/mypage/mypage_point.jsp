<%@page import="java.awt.PointerInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp"%>
<link href="../css/common.css" rel="stylesheet">
<link href="/mypage.css" rel="stylesheet">
<%request.setCharacterEncoding("utf-8");
String schargs="",args="";
List<PointInfo> pointList = (List<PointInfo>)request.getAttribute("pointList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
PointInfo pointtotal = (PointInfo)request.getAttribute("pointtotal");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
int ptotal = pointtotal.getPtotal(); 
args = "&cpage=" + cpage;
%>
<link href="../css/mypage.css" rel="stylesheet">
<link href="../mypage/mypage.css" rel="stylesheet">
<style>
<style>
<!--<%@include file="../css/common.css" %>
<%@include file="../mypage/mypage.css"%>
-->main{    
	max-width: 1200px;
	margin: 0 auto;
	position: relative;
	top: 220px;
}
.point{
	display: flex;
	justify-content: space-around; 
}
.content{
max-width:1200px;
}
.num{
margin: 0 auto;
}
.pointlist{
	width:100%;
	border: 1px solid #6255f6;
	margin-bottom: 10px;
	text-align: center;
}

</style>
<main>
	<div class="wrapper">
		<h3>마이페이지 > 포인트 내역</h3>
		<div class = "point">
			<div class="menu">
	                  <p>내 정보</p>
	            <a href="mypage">내정보</a>
	           <a href="change_pw_form">비밀번호변경</a>
	           <p>주문정보</p>
	           <a href="cart_view">장바구니</a>
	           <a href="order_list?cpage=1">주문내역</a>
	           <p>포인트/쿠폰</p>
	           <a href="point_list">포인트내역</a>
	           <a href="coupon_list">쿠폰함</a>
	           <p>기타</p>
	           <a href="mantoman_list.html">문의내역</a>
	           <a href="member_out_form.html">회원탈퇴</a>
        	</div>
			<div class="content">
				<h3>포인트내역</h3> 
				<div>
					<table class="pointlist" >
						<tr>
							<th>번호</th>
							<th>포인트</th>
							<th>내역</th>
							<th>일자</th>
						</tr>
<%	
		PointInfo mp = null;
int totalp = 0;
int spoint =0;
int upoint=0;
		int num= rcnt -(psize*(cpage-1));
			for (int i=0;i<pointList.size();i++){	
				mp = pointList.get(i); 
			
			
				%>
						<tr class >
							<td><%=num %></td>
							<%if (!mp.getMp_su().equals("s")) {%>
							<td><%=mp.getMp_point()*-1  %></td>
							<% 
								
							}else if (!mp.getMp_su().equals("u")) {%>
							<td><%=mp.getMp_point() %></td><%}
								upoint+=mp.getMp_point() ;
							
								
							%>
						
							<td><%=mp.getMp_desc() %></td>
							<td><%=mp.getMp_date() %></td>
						</tr>
				
			<%num--; totalp+=spoint+upoint; }%>
					</table>
					<p>내 포인트 : <%=pointtotal.getPtotal() %></p>
				</div>
			</div>
		</div>
		<table cellpadding="5" class="num">
				<tr>
					<td>
						<% if (rcnt>0) { // 게시글이 있으면 - 페이징 영역을 보여줌
			  		String lnk = "point_list?cpage=";
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
</main>
<%@ include file="../_inc/inc_foot.jsp"%>