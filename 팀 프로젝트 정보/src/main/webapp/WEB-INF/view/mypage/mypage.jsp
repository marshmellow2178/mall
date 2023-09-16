<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>

<%
request.setCharacterEncoding("utf-8");
MemberAddr memberAddr = (MemberAddr)request.getAttribute("maList");
boolean isChk = false;
if(loginInfo != null && memberAddr != null)	isChk = true;
%>
<script>
if(isChk == false){
	alert('비정상적인 접근입니다.');
	location.href='http://localhost:8086/goods/index.jsp';
}
</script>
<%
if(loginInfo == null){
	out.println("<script>");
	out.println("alert('로그인 후 이용해주세요.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}

String uid = loginInfo.getMi_id();
String name = loginInfo.getMi_name();
String nickname = loginInfo.getMi_nickname();
int point = loginInfo.getMi_point();
int coupon = loginInfo.getMi_couponcount();
String email = loginInfo.getMi_email();
String phone = loginInfo.getMi_phone();
String birth = loginInfo.getMi_birth();

String rname = memberAddr.getMa_rname();
String zip = memberAddr.getMa_zip();
String addr1 = memberAddr.getMa_addr1();
String addr2 = memberAddr.getMa_addr2();
String basic = memberAddr.getMa_basic();
String midate = memberAddr.getMa_date();
%>
<%=loginInfo.getMi_name() %>
<style>
 <%@include file="../css/common.css" %>
<%@include file="./mypage.css"%>
.wrapper{
	width:1200px; 
	
	margin: 0 auto;
}
 main { max-width: 100%;
    margin: 0 auto;
    position: relative;
    top: 220px; }
        .content li{
            display: flex;
            flex-wrap: wrap;
        }
        .content li > p{
            width: 30%;
            padding: 10px;
        }
        .content li > span{
            width: 70%;
            padding: 10px;
        }
.main{
	display:flex;
	justify-content: space-around;
	
}
.bnt{
	text-align:center;
	margin: 0 auto;
}
.button{
	
}
</style>
<main>
    <div class="wrapper">
        <h3>마이페이지 > 내정보</h3>
		<div class="main">
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
	        <ul class="content">
	            <li><p>이름</p><span><%=name %></span></li>
	            <li><p>ID</p><span><%=uid %></span></li>
	            <li><p>닉네임</p><span><%=nickname %></span></li>
	            <li><p>보유 포인트</p><span><%=point %></span></li>
	            <li><p>보유 쿠폰</p><span><%=coupon %></span></li>
	            <li><p>이메일</p><span><%=email %></span></li>
	            <li><p>연락처</p><span><%=phone %></span></li>
	            <li><p>주소</p><span><%=addr1 %></span>
	                <p>상세주소</p><span><%=addr2 %></span>
	            </li>
	            <li><p>생년월일</p><span><%=birth %></span></li>
	        </ul>
	    </div>    
        <div class="btn">
                <a href="member_form"><button class="button">내 정보 수정</button></a>
        </div>
    </div>
</body>
</main>
</html>