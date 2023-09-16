<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
ArrayList<ProductStock> stockList = pi.getStockList();
/*
	옵션 없을때 처리: 멤버 이름만 비우기2(빈칸)
	stockList.size() = 1
	ps.getPs_am_name = "";

	품절: 선택불가
*/
		


int realPrice = pi.getPi_price();
if(pi.getPi_dc()>0){
	realPrice = realPrice * (100-pi.getPi_dc()) / 100;
}

%>

<script>
function change(value){
	let form = document.buyForm;
	let cnt = parseInt(form.cnt.value);
	
	if(value == "+" && cnt<99){ form.cnt.value = cnt+1; }
	else if(value == "-" && cnt>1){ form.cnt.value = cnt-1; }
	
	let total = document.querySelector('#total');
	let totalprice = <%=realPrice%> * form.cnt.value ;
	total.innerHTML = totalprice;
}

function buy(value){
	//상품아이디, 옵션, 수량정보를 들고 주어진 페이지로 이동
	//c = 이동하지 않고 메시지만, o = order_form
	let form = document.buyForm;
	if(form.psidx.value==-1){
		alert("옵션을 선택하세요");
		return;
	}
	//구매 클릭시 ?piid=pi_id&psidx=ps_idx&cnt=상품개수 쿼리스트링 자동으로 붙여서 각각 페이지로 보냄
	if(value == 'c'){
		var cnt =form.cnt.value;
		var psidx =form.psidx.value;
		$.ajax({
	 		type : "POST",
	 		url : "cart_proc_in",
	 		data : {"piid" : "<%=pi.getPi_id()%>", "psidx"  : psidx, "cnt" : cnt},
	 		success : function(chkRs){
	 			if(chkRs ==0){	// 장바구니 담기에 실패했을경우
					alert("장바구니 담기에 실패했습니다. \n다시 시도해 보세요.");
	 				return;
	 			}else{			// 장바구니 담기에 성공했을 경우
	 				if(confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")){
	 					location.href = "cart_view";
	 				}
	 			}
	 		}
	 	});
	}else if(value = "o"){
		form.action = "order_form";
		form.submit();
	}
}
</script>

<div class="wrapper">
	<div class="pdt_detail">
		<figure class="bImg">
			<img src="img//product_img/<%=pi.getPi_img1()%>">
		</figure>

		<ol>
			<li><img src="img/product_img/<%=pi.getPi_img1()%>"></li>
			<!-- <li><img src="/goods/product/product_img/<%=pi.getPi_img2()%>"></li>
			<li><img src="/goods/product/product_img/<%=pi.getPi_img3()%>"></li> -->
		</ol>

		<figure>
			<figcaption>상품상세정보</figcaption>
			<img src="img/product_img/<%=pi.getPi_desc()%>">
		</figure>
	</div>

	<div class="pdt_buy">
		<form class="form" name = "buyForm" method="post">
		<input type="hidden" name="kind" value="o" />
			<h3><%=pi.getPi_name()%></h3>
			<input type = "hidden" name = "piid" value = "<%=pi.getPi_id() %>">
			
			<ul>
				<li><p>가격</p>
					<span><%=realPrice%>원</span></li>
				<li><p>상품코드</p>
					
					<span><%=pi.getPi_id()%></span></li>
					
				<!-- 옵션 선택창과 항목은 옵션 있을 때만 나타남 -->
				<%if(stockList.size()>1 ) {%>
				<li>
					<p>옵션</p> 
					<select name = "psidx">
						<option value = "-1">옵션 선택</option>
					<%
					ProductStock ps = null;
					for(int i = 0;i<stockList.size();i++){ 
						ps = stockList.get(i);
					%>	
						<%if(ps.getPs_stock()>0 && !ps.getPs_am_name().equals("")){ %>
							<option value = <%=ps.getPs_idx() %>><%=ps.getPs_am_name()%></option>
						<%}else if(ps.getPs_stock()==0){ %>
							<option value = <%=ps.getPs_idx() %> disabled = "disabled"><%=ps.getPs_am_name()%>: 품절</option>
						<%} %>
					<%} //end for%>
					</select>
				</li>
				<%}else{%>
					<input type = "hidden" name = "psidx" value = "<%=stockList.get(0).getPs_idx() %>">
				<% }//end if%>
				
				<li><p>수량</p>
					<input type= "button" onclick="change('-');" class="sbtn" value = "-"> 
					<input type="number" readonly maxlength="2" value="1" class="num" name = "cnt">
					<input type= "button" onclick="change('+');" class="sbtn" value = "+">
				</li>
				<li>
					<p>전체가격</p>
					<span id = "total"><%=realPrice%></span>
				</li>
			</ul>

			<input type="button" value="바로구매" class="bbtn" onclick = "buy('o');"> 
			<input type="button" value="장바구니" class="bbtn" onclick = "buy('c');">
		</form>

	</div>
</div>

<style>
<%@ include file="../css/init.css"%>
<%@ include file="../css/common.css"%>
.pdt_detail {
	border: 1px solid black;
	width: 60%;
	padding: 20px;
	margin-top: 50px;
}

.pdt_detail .bImg {
	padding: 10px;
	text-align: center;
}

.pdt_detail .bImg>img {
	width: 50%;
}

.pdt_detail figure img {
	width: 100%;
}

.pdt_detail ol {
	padding: 0;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-evenly;
}

.pdt_detail ol li {
	width: 30%;
	padding: 10px;
	background-color: gray;
}

.pdt_detail ol li img {
	width: 100%;
}

.pdt_detail figcaption {
	font-weight: bold;
	font-size: 20px;
	text-align: center;
	padding: 10px;
}

.pdt_buy {
	border: 1px solid black;
	width: 30%;
	padding: 20px;
	position: fixed;
	right: 11%;
	top: 25%;
}

.sbtn {
	width: 20px;
	height: 20px;
	background-color: #6255F6;
	color: white;
	border: none;
	border-radius: 50px;
}

.bbtn {
	width: 45%;
	background-color: #6255F6;
	color: white;
	border: none;
	padding: 15px;
	border-radius: 50px;
}

.num {
	text-align: right;
	width: 50px;
}
.wrapper{
max-width: 100%;
    margin: 0 auto;
    position: relative;
    top: 220px;
}
</style>