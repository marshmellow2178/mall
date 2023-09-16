<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
List<OrderCart> cartList = (List<OrderCart>)request.getAttribute("cartList");
%>
<script>
function chkAll(all)  {
	// 전체선택 선택취소 함수	
		 var chk= document.formCart.chk;
		 for(var i =0; i<chk.length; i++){
			 chk[i].checked = all.checked;
		 }
}

function cartDel(ocidx){
// 장바구니내 특정 상품을 삭제하는 함수	
	if(confirm("정말 삭제하시겠습니까?")){
	// cart_proc_del로 매핑 CartProcDelCtrl
		$.ajax({
		 	type : "POST",
		 	url : "cart_proc_del",
		 	data : {"ocidx" : ocidx},
		 	success : function(chkRs){
		 		if(chkRs ==0){	// 장바구니내 상품 직접삭제 실패시
					alert("상품 삭제에 실패했습니다.\n다시 시도해 보세요.");
		 			return;
		 		}else{			// 장바구니내 상품 직접삭제 성공시
		 			location.reload();
		 		}
		 	}
		 });	
	}
}

function cartUp(ocidx,opt,cnt){
// 장바구니내 특정 상품의 옵션 및 수량을 변경하는 함수	
// opt : 변경될 옵션의 값 , cnt : 변경될 수량의 값
// opt가 0이면 수량변경 , cnt가 0이면 옵션변경
	$.ajax({
	 	type : "POST",
	 	url : "cart_proc_up",
	 	data : {"ocidx" : ocidx , "opt" : opt, "cnt" : cnt},
		success : function(chkRs){
	 	if(chkRs ==0){	// 장바구니내 상품 변경 실패시
			alert("상품 변경에 실패했습니다.\n다시 시도해 보세요.");
	 			return;
	 		}
	 	location.reload();
	 	}
	 });		
}
function setCnt(chk,ocidx){
	var frm = document.formCart;
	var cnt = parseInt(eval("frm.cnt" + ocidx +".value"));// eval안에 있는 문자열을 명령어로 바꿔줌
	if(chk=="+" && cnt < 99){ 
		cartUp(ocidx,0,cnt+1)
	}else if(chk=="-" && cnt>1) {
		cartUp(ocidx,0,cnt-1)
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
</script>
<style>
 <%@include file="../css/common.css" %>
<%@include file="../mypage/mypage.css"%>
.cartpdt{width: 100%;vertical-align:center; }
.cartpdt{display: flex;    align-items: center; border: 1px solid #6255f6 ;margin-bottom: 10px;}

.all{margin-bottom: 10px;}
img {width: 7em; height: 6em;}
.pay{ text-align: right;}
main{max-width: 100%;
    margin: 0 auto;
    position: relative;
    top: 220px;
}
.cart{    display: flex;
    justify-content: space-around;
}
.wrapper{
	margin: 0 auto;
	width:1200px;
}
.button{
	margin: 0 auto;
}
</style>
  <main>
    <div class="wrapper" >
        <h3>마이페이지 > 장바구니</h3>
		<div class = "cart">
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
        
            <form name="formCart" action="order_form" method="post">
                <input type = "hidden" name="chk"value="">
                <input type = "hidden" name ="kind" value="c">
                <div class ="all">
                    <input type = "checkbox" name ="all" id="all" onclick="chkAll(this);" checked="checked"/>
                    <label for = "all">전체 선택</label>
                </div>
                <%
                if(cartList.size()>0){// 장바구니에 담긴 상품이 있을 경우
        			int total =0; // 총 구매 가격의 누적값을 저장할 변수
        			int dc = 0;
        			int delivery =0;
        			int	pay=0;
        			for(int i=0; i<cartList.size();i++){
        				OrderCart oc = cartList.get(i);
        				// ArrayList 안의 정보를 뺴내기 위해 제네릭으로선언한OrderCart형 인스턴스 oc생성
        				int ocidx = oc.getOc_idx();
        				int price = oc.getPi_price() * oc.getOc_cnt(); 
        				if(oc.getPi_dc()>0){
        					price = oc.getPi_price() * (100-oc.getPi_dc())/100 *oc.getOc_cnt();  

        				}	
        		%>
                <div class = "cartpdt "> <!-- 장바구니 상품-->
                    <div><input type = "checkbox" name="chk"value="<%=ocidx%>" checked="checked" /></div>
                    <a class="img" href = "#"><img src="<%="img/product_img/"+oc.getPi_img1()%>"></a> 
                    <div>
                        <a href="#"></a>
                        <div>
                        	<span>수량 </span>                           
                         	<input type="button" value="-" onclick="setCnt(this.value,<%=ocidx%>);"/>
                            <input type="text" name ="cnt<%=ocidx %>" id="cnt" style="width:20px" text-align="center" value="<%=oc.getOc_cnt() %>" readonly="readonly"/>
                            <input type="button" value="+" onclick="setCnt(this.value,<%=ocidx%>);"/>
               <%
				ArrayList<ProductStock> stockList = oc.getStockList();
				ProductStock ps=null;
				ps = stockList.get(0);
				if(stockList.size() > 0 && ps.getPs_am_name().equals("")){%>
					<div>재고량  : <%=ps.getPs_stock() %></div>
				<%}else if(stockList.size() > 0 && !ps.getPs_am_name().equals("")){%>
				<select name="amname" onchange="cartUp(<%=ocidx%>,this.value,0)">
					<%for(int j=0; j<stockList.size(); j++){
						ps =stockList.get(j);
						System.out.println(ps.getPs_am_name());
						String txt = ps.getPs_am_name() + " (재고량 : "+ps.getPs_stock()+"개)";
						String selected="";
						if(ps.getPs_idx() == oc.getPs_idx()){
							selected = " selected='selected' ";
						}
						if(ps.getPs_stock()>0){// 재고량이 있을 경우에만 보여줌
						
				%>
                    <option value="<%=ps.getPs_idx() %>" <%=selected %>><%=txt %></option>
                            
                <%	}
				}
					%></select>
				
				<%} %>
                        </div>
                        
                    </div>   
                </div>
              
                <%
                total+=price;
	                if(oc.getPi_dc()>0){
	                	dc=total*(oc.getPi_dc())/100 *oc.getOc_cnt(); 
	                }
                }
                %>
               
                <div class="pay" >
                   
                    <%if (total<50000){ 
                    delivery = 5000;	
                    pay= total+delivery;
                   	 
                    %> 
                    <p>합계 :<%=total %> </p>
                    <p>할인금액 :<%=dc %> </p>
                    
                    <p>배송비 :<%=delivery %>원 </p>
                    <input type="hidden" name="delivery" value="<%=delivery %>">
                    <p>총 가격 :<%=pay%> </p>
                    <%}else{
                    	delivery = 0;
                     pay= total+delivery;
                    %>
                    
                    <p>합계 :<%=total %> </p>
                    <p>할인금액 :<%=dc %> </p>
                    <p>배송비 :<%=delivery %>원 </p>
                    <input type="hidden" name="delivery" value="<%=delivery %>">
                    <p>총 가격 : <%=pay%> </p>
                   <%} %> 
                </div>
                 <p align="center" style=" font-size: 1.3em;" class="button">
					<input type="button" value="선택한 상품 삭제" onclick="chkDel();" /> 
					<input type="button" value="선택한 상품 구매" onclick="chkBuy();" /> 
					<input type="button" value="전체 상품 구매" onclick="allBuy();" />
				</p>
               
                <%
                System.out.println(dc); 
                }else{
                	out.println("<tr><td align = 'center'> 장바구니에 상품이 없습니다.</td></tr>	</table>");
                }
                %>
            </form>
        	</div>
        </div>
    </div>
</main>




<%@include file="../_inc/inc_foot.jsp"%>