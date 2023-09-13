 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class = menu>
    <p class = "ctgr active">내 정보</p>
    <a href="my_page" class = "ctgr">내정보</a>
    <a class = "ctgr" href="change_pw_form">비밀번호변경</a>
    <p class = "ctgr active">주문정보</p>
    <a class = "ctgr" href="cart_view">장바구니</a>
    <a class = "ctgr" href="order_list">주문내역</a>
    <p class = "ctgr active">포인트</p>
    <a class = "ctgr" href="point_list">포인트내역</a>
    <p class = "ctgr active">기타</p> 
    <a class = "ctgr" href="inquiry_list">문의내역</a>
    <a class = "ctgr" href="member_out">회원탈퇴</a>
</div>
<style>
main{
	display: flex;
	flex-wrap: wrap;
}
.menu{ 
    text-align: center;
    width: 15%;
    margin-right: 50px;
}
.menu p, .menu a{
	border-top: none;
	width: 100%;
}
.content{
	width: 70%;
}
</style>