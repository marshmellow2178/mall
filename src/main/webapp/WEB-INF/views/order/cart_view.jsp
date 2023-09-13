<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<OrderCartDto> cartList = (List<OrderCartDto>)request.getAttribute("cartList");
// 장바구니 화면에서 보여줄 상품목록을 받아옴
%>  

<script>
function chkAll(all)  {
	// 전체선택 선택취소 함수	
	 var chk= document.formCart.chk;
	 for(var i =0; i<chk.length; i++){
		 chk[i].checked = all.checked;
	 }
	 getTotalPrice();
}

function chkOne(value){
	if(!$(value).is(':checked')){
		$('#all').prop('checked', false);
	}
	else{
		let temp = true;
		$('.chk').each(function(idx){
			if(!$('.chk:eq('+(idx)+')').is(':checked')){
				temp = false;
				return;
			}
		});
		$('#all').prop('checked', temp);	
	}
	getTotalPrice();
}

function cartDel(ocidx){
// 장바구니내 특정 상품을 삭제하는 함수	
	if(confirm("정말 삭제하시겠습니까?")){
	// cart_proc_del로 매핑 CartProcDelCtrl
		$.ajax({
		 	type : "POST",
		 	url : "cart_proc_del",
		 	data : {
	 			"ocidx" : ocidx
	 		},
		 	success : function(){
		 		location.reload();
		 	}
		});	
	}
}

function cartUp(ocidx,cnt){
	$.ajax({
	 	type : "POST",
	 	url : "cart_proc_up",
 		data : {
 			"ocidx" : ocidx,
 			"cnt" : cnt
 		},
	 	success : function(){
	 		location.reload();
	 	}
	 });		
}
function setCnt(chk,ocidx){
	var frm = document.formCart;
	var cnt = parseInt(eval("frm.cnt" + ocidx +".value"));// eval안에 있는 문자열을 명령어로 바꿔줌
	if(chk=="+" && cnt < 99){ 
		cartUp(ocidx,cnt+1)
	}else if(chk=="-" && cnt>1) {
		cartUp(ocidx,cnt-1)
	}	
}
function getSelectedValues(){
// 체크박스들 중 선택된 체크박스들의 값들을 쉼표로 구분하여 문자열로 리턴하는 함수
	var chk= document.formCart.chk;	
	var idxs = ""; // chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수
	for (var i =1; i<chk.length; i++){
		if(chk[i].checked) idxs+=","+chk[i].value;
	}
	return idxs.substring(1);
}

function chkDel(){
// 사용자가 선택한 상품(들)을 삭제시키는 함수
	var ocidx =getSelectedValues();
	// 선택한 oc_idx 값들이 쉼표를 기준으로 '1,2,3,4' 문자열로 저장됨
	if(ocidx=="") 	alert("삭제할 성품을 선택하세요"); 
	else			cartDel(ocidx);
}

function chkBuy(){
// 사용자가 선택한 상품(들)을 구해하는 함수
	var ocidx =getSelectedValues();	
	if(ocidx=="") 	alert("구매할 상품을 선택하세요"); 
	else			document.formCart.submit();
}

function getTotalPrice(){
	let chk = $('input[name=chk]');
	let total = 0;
	let delivery = <%=Code_List.DELIVERY%>;
	
	for(let i = 1;i<chk.length;i++){
		if($('input[name=chk]:eq('+i+')').prop('checked')){
			total += parseInt($('#price'+i).html());
		}
	}
	if(total>50000){ 
		delivery = 0;
	}
	$('#price').html(total);
	$('#deliver').html(delivery);
	$('#total').html(total + delivery);
}

$(window).load(function(){
	getTotalPrice();
}); 
</script>
<link rel = "stylesheet" href = "css/common.css">
<style>
	.list{
		position: relative;
	}
	#delivery{
		width: 30%;
		text-align: right;
		position: absolute;
		right: 20px;
	}
</style>
<main>
	<%@include file = "../_inc/inc_mypage.jsp" %>

	<%if(cartList.size()>0){%>
	<div class = "content">
	<form name="formCart" action="order_form" method="post">
		<input type = "hidden" name="chk" value="">
	    <input type = "hidden" name ="kind" value="c">
	    <table class = "list">
	    <tr>
	    	<th>
	    	<input type = "checkbox" name ="all" id="all" onclick="chkAll(this);" checked="checked"/>
	        </th>
	        <th>이미지</th>
	        <th>상품명</th>
	        <th>아티스트</th>
	        <th>수량</th>
	        <th>가격</th>
	    </tr>
   		<%for(int i=0; i<cartList.size();i++){
			OrderCartDto ocd = cartList.get(i);
			int ocidx = ocd.getIdx();
			int price = ocd.getRealprice() * ocd.getCnt();
   		%>
        <tr> <!-- 장바구니 상품-->
        	<td>
        	<input type = "checkbox" name="chk" class = "chk" value="<%=ocidx%>" checked="checked" onclick = "chkOne(this);">
            </td>
            <td>
            <figure><a href = "product_view?piid=<%=ocd.getPi_id()%>"><img src="img/product_img/<%=ocd.getPi_img()%>"></a></figure>
   			</td>
   			<td><p class = "title"><%=ocd.getPi_name() %></p></td>
   			<td><%=ocd.getArtist_name() %></td>
   			<td>
			<input type="button" value="-" onclick="setCnt(this.value,<%=ocidx%>);"/>
            <input type="number" name ="cnt<%=ocidx %>" value="<%=ocd.getCnt() %>" readonly>
            <input type="button" value="+" onclick="setCnt(this.value,<%=ocidx%>);"/>
			</td>
			<td><p id = "price<%=i+1%>"><%=price%></p></td>
		</tr>
		<%}%>
		
	    <tr>
	    	<td>상품 가격</td>
	    	<td id = price colspan = 6></td>
	    </tr>
	    
	    <tr>
	    	<td>배송비</td>
			<td id = deliver colspan = 6></td>      
	     </tr>
	     
	     <tr>
	     	<td>총 가격</td>
	     	<td id = total colspan = 6></td>
	     </tr>
	    </table>
	    <input type="button" value="삭제" onclick="chkDel();" /> 
		<input type="button" value="구매" onclick="chkBuy();" /> 
	</form>
	</div>
	<%}else{out.println("<p>장바구니에 상품이 없습니다<p>"); } %>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>
