<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
%>

<script>
function change(value){
	let form = document.buyForm;
	let cnt = parseInt(form.cnt.value);
	
	if(value == "+" && cnt<99){ form.cnt.value = cnt+1; }
	else if(value == "-" && cnt>1){ form.cnt.value = cnt-1; }
	
	let total = document.querySelector('#total');
	let totalprice = <%=pi.getRealprice()%> * form.cnt.value;
	total.innerHTML = totalprice;
}

function buy(value){
	if(!<%=isLogin%>){
		alert('로그인하세요');
		location.replace('login_form');
		return;
	}
	//상품아이디, 옵션, 수량정보를 들고 주어진 페이지로 이동
	let form = document.buyForm;
	
	if(value == 'c'){
		var cnt =form.cnt.value;
		$.ajax({
	 		type : "POST",
	 		url : "cart_proc_in",
	 		data : {
	 			"piid" : "<%=pi.getIdx()%>", 
	 			"cnt" : cnt	
	 		},
	 		success : function(){
	 			if(confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")){
	 				location.href = "cart_view";
	 			}
	 		}
	 	});
	}else if(value = "o"){
		buyForm.kind.value = 'o';
		form.action = "order_form";
		form.submit();
	}
}
</script>
<main>
	<div class = "product">
		<figure><img src="img/product_img/<%=pi.getImg()%>"></figure>
		<figure><figcaption>상품상세정보</figcaption>
		<img src="img/product_img/<%=pi.getDesc()%>"></figure>
	</div>
	
	<aside>
	<form name = "buyForm">
		<table>
		<tr>
		<th width = 25%>상품명</th>
		<td><p><%=pi.getName()%></p>
		<input type = "hidden" name = "piid" value = "<%=pi.getIdx()%>"></td>
		</tr>
		
		<tr>
		<th>아티스트</th>
		<td><%=pi.getArtist() %></td>
		</tr>
		
		<tr>
		<th>가격</th>
		<td><%=pi.getRealprice()%>원
		<%if(pi.getDc()>0){ %>
			<span class = "dc"><%=pi.getDc() %>%</span>
		<%} %>
		</td>
		</tr>
		
		<tr>
		<th>수량</th>
		<td>
		<input type= "button" onclick="change('-');" value = "-"> 
		<input type="number" readonly maxlength="2" value="1"  name = "cnt">
		<input type= "button" onclick="change('+');" value = "+">
		</td>
		</tr>
		
		<tr>
		<th>전체 가격</th>
		<td><span id = "total"><%=pi.getRealprice() %>원</span></td>
		</tr>
		</table>
		
		<div>
		<input type = "hidden" value = "" name = "kind">
		<input type="button" value="바로구매" onclick = "buy('o');"> 
		<input type="button" value="장바구니" onclick = "buy('c');">
		</div>
	</form>
	</aside>
</main>
<%@include file="../_inc/inc_foot.jsp"%>
<link rel = "stylesheet" href = "css/common.css">
<style>
main{
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}
.product{
	width: 40%;
}
aside{
	width: 40%;
	height: 100vh;
	position: sticky;
	top: 0px;
}
form{
	margin: 40px auto;
}
figcaption{
	font-weight: bold;
	text-align: center;
}
#piid{
	font-size: 12px;
	color: grey;
	padding: 0 10px;
}
#total{
	color: darkred;
}
input[type=number]{
	width: 50px;
}
</style>