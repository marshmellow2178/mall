<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<OrderCartDto> pdtList = (List<OrderCartDto>)request.getAttribute("ocdList");
String kind = request.getParameter("kind");
%>
<link rel = "stylesheet" href = "css/common.css">
<style>
	#pointalert{
		font-size: 12px;
		color: red;
	}
</style>
<script>
	function useAll(){
		let all = <%=loginInfo.getPoint()%>;
		$('#upoint').val(all);
		chkPoint(all);
	}
	function chkPoint(value){
		let pay = parseInt($('#init').val());
		$("#total").html(pay);
		if(value > <%=loginInfo.getPoint()%>){
			$('#pointalert').html("보유포인트가 부족합니다");
			$('input[name=upoint]').val(0);
		}else if(value > pay/2){
			$('#pointalert').html("상품가격의 절반을 초과할 수 없습니다");
			$('input[name=upoint]').val(0);
		}else{
			$('#pointalert').html("");
			let pay = parseInt($('#total').html());
			let point = $('input[name=upoint]').val();
			$('#pay').val(pay-point);
			$("#total").html(pay-point);
			$('#spoint').val(Math.floor($('#pay').val()/100));
		}
	}
</script>

<main>
	 <form action="order_proc_in"  method="POST" >
	 	<input type = "hidden" name = "miid" value = "<%=loginInfo.getId()%>">
	 	<input type = "hidden" name = "ocidx" value = "0">
	 	<input type="hidden" name="cnt" value="0">
		<input type="hidden" name="piid" value="">
	 <table>
	 	<caption>배송지 정보</caption>
	 	<tr>
	 		<th>주문자</th>
	 		<td><input type = "text" name = "name" value = "<%=loginInfo.getName() %>"></td>
	 	<tr>
	 	
	 	<tr>
	 		<th>연락처</th>
	 		<td>
	 			<input type = "number" value = "010" disabled>
	 			<input type = "number" name = phone value = "<%=loginInfo.getPhone() %>" maxlength = 8>
	 		<td>
	 	</tr>
	 	<tr>
	 		<th rowspan = 2>주소</th>
	 		<td><input type = text name = addr1 value = "<%=loginInfo.getAddr1() %>"></td>
	 	</tr>
	 	<tr>
	 		<td><input type = text name = addr2 value = "<%=loginInfo.getAddr2() %>"></td>
	 	<tr>

	 	<tr>
	 		<th>결제수단</th>
	 		<td>
	 		<input type="radio" name="payment" value="a" id="payA" checked/>
			<label for="payA">카드결제</label>
			<input type="radio" name="payment" value="b" id="payB" />
			<label for="payB">휴대폰 결제</label>
			<input type="radio" name="payment" value="c" id="payC" />
			<label for="payC">무통장입금</label>
			<input type="radio" name="payment" value="d" id="payD" />
			<label for="payD">문화상품권</label>
			</td>
		</tr>
		
		<tr>
			<th>포인트</th>
			<td>
				<p>보유 포인트 : <%=loginInfo.getPoint()%> <span id = "pointalert"></span></p>
				<input name="upoint" type ="number" value="0" id="upoint" onchange = "chkPoint(this.value);">
				<input type = "button" value = "전량 사용" onclick = "useAll();">
			</td>
		</tr>
		
	 </table>
		
	<table>
		<caption>상품정보</caption>
		
		<tr>
			<th>이미지</th>
	        <th>상품명</th>
	        <th>아티스트</th>
	        <th>수량</th>
	        <th>가격</th>
	    <tr>
	    <%
		int total =0; // 최종가격 
		for(int i=0; i<pdtList.size();i++){ 
			OrderCartDto ocd = pdtList.get(i);
			total += ocd.getRealprice() * ocd.getCnt();
		%>
		</tr>
		 <tr>
		<td>
		<input type = "hidden" name = "ocidx" value = "<%=ocd.getIdx()%>">
		<input type="hidden" name="cnt" value="<%=ocd.getCnt()%>" >
		<input type="hidden" name="piid" value="<%=ocd.getPi_id()%>" >
		<figure><img src = "img/product_img/<%=ocd.getPi_img()%>"></figure>
		</td>
		<td><%=ocd.getPi_name() %></td>
		<td><%=ocd.getArtist_name() %></td>
		<td><%=ocd.getCnt() %></td>
		<td><%=ocd.getRealprice() %></td>
		</tr>
		<%} 
		int deliver = Code_List.DELIVERY;
		if(total>Code_List.FREE_DELIVER){ deliver = 0; }
		%>
		
		
		<tr>
	    	<td>상품 가격</td>
	    	<td colspan = 6 id = price><%=total %></td>
	    </tr>
	    
	    <tr>
	    	<td>배송비</td>
			<td colspan = 6 id = deliver><%=deliver %></td>      
	     </tr>
	     
	     <tr>
	     	<td>총 가격</td>
	     	<td colspan = 6 id = total><%=total+deliver %></td>
	     </tr>
		
	</table>				
		<input type = "hidden" value = "<%=total+deliver %>" id = init>
		<input type="hidden" value="<%=request.getParameter("kind") %>" name="kind">
		<input type="hidden" value="<%=total+deliver %>" name="pay" id = "pay">
		<input type = "hidden" name = "spoint" id = "spoint" value = "<%=(total+deliver)/100 %>">
		<input type="button" value="취소" onclick = "history.back();">
		<input type="submit" value="결제">
	</form>
</main>
<%@include file = "../_inc/inc_foot.jsp" %>