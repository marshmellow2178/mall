<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<OrderCart> cartList = (List<OrderCart>)request.getAttribute("pdtList");
List<MemberAddr> addrList = (List<MemberAddr>)request.getAttribute("addrList");
//ArrayList<Coupon> couponList = (ArrayList<Coupon>)request.getAttribute("couponList");
MemberAddr ma = null;
	LocalDate today = LocalDate.now();   // 오늘 날짜
	int cyear = today.getYear();
	int cmonth = today.getMonthValue();
	int cday = today.getDayOfMonth();
	int last = today.lengthOfMonth();

	String[] arrDomain = {"naver.com", "daum.net", "nate.com", "gmail.com"};
	String oiname = "",oirname="",oiphone="", oizip = "", oiaddr1 = "", oiaddr2 = "";
%>
<link href="/goods/order/mypage.css" rel="stylesheet">
<style>
#upoint { text-align:right; }

main{    
	max-width: 700px;
	margin: 0 auto;
	position: relative;
	top: 220px;
}
img{
    width: 150px;
}
</style>

<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' ('+ extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("sample6_extraAddress").value = extraAddr;
	
				} else {
					document.getElementById("sample6_extraAddress").value = '';
				}
				
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('ma_zip').value = data.zonecode;
				document.getElementById('ma_addr1').value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById('ma_addr2').focus();
				$('#ma_addr2').prop("readonly", false);
			}
		}).open();
	}
	function chkBuy(){
		// 사용자가 선택한 상품(들)을 구해하는 함수
			document.oderinfo.submit();
		}

	function usePoint() {
		var frm = document.oderinfo;
		var tpoint = <%=loginInfo.getMi_point()%>;
		var upoint = frm.upoint.value;
		if (upoint > tpoint) {
			alert("보유포인트보다 높습니다");
			frm.upoint.value = 0;
		}
	}

	function chPoint() {
		var frm = document.oderinfo;
		var tpoint = <%=loginInfo.getMi_point()%>;
		var upoint = parseInt(frm.upoint.value);
		var hdctotal = parseInt(frm.dctotal.value); // DB로 보내는 총할인
		var hrealprice = parseInt(frm.realprice.value);// DB로 보내는 결제가
		if (upoint > tpoint) {
			alert("보유포인트보다 높습니다");
			frm.upoint.value = 0;
		} else {
			var dctotal = parseInt($("#dctotal").text());
			var delivery = parseInt($("#delivery").text());
			var realprice = parseInt($("#realprice").text());
			$("#dctotal").text(dctotal + upoint);
			$("#realprice").text(realprice - upoint);
			hdctotal = hdctotal+upoint;
			hrealprice = hrealprice-upoint;
			console.log(hdctotal);
			console.log(hrealprice);
		}
	}
</script>
<%
for(int i = 0;i < addrList.size(); i++){
		ma = addrList.get(i);
	if(ma.getMa_basic().equals("y")){ // 기본 주소 이면
		oiname = ma.getMa_name(); oirname=ma.getMa_rname();
		oiphone	= ma.getMa_phone();
		oizip = ma.getMa_zip();
		oiaddr1= ma.getMa_addr1(); oiaddr2 = ma.getMa_addr2();
	}
	String val ="", txt="";
	
	val = ma.getMa_name() + "|"+ ma.getMa_rname() + "|" + ma.getMa_phone() + "|"+ ma.getMa_zip() +"|"+ma.getMa_addr1()+"|"+ma.getMa_addr2();
	txt = "["+ma.getMa_name()+"]"+ma.getMa_addr1()+ " " + ma.getMa_addr2(); 
}
%>


<main>
   <h3 style="margin-bottom: 7px  "> 상품 결제 </h3>
   <div>
	    <div style="margin-bottom: 10px  ">
	    	<p>주문자 정보</p>
	    	<p>주문자 : <%=ma.getMa_name() %>	</p>
	    	<p>연락처 : <%=ma.getMa_phone() %>	</p>
	    	
	    </div>
		<div class="wrapper">
			<h3>배송정보</h3>
			<form class="form" name="oderinfo" id="oderinfo" action="order_proc_in"  method="POST" >
			
				<div>
					<ul>
						<li>
							<p>이름</p> <input type="text" name="oi_name" id="oi_name" maxlength="20" placeholder="성+이름" autocomplete="off" value="<%=ma.getMa_name() %>" >
						</li>
						<li>
							<p>연락처</p> 
						<%
						String[] arr= oiphone.split("-");
						%> 
						<select name="p1" >
							<option <% if (arr[0].equals("010")) {%> selected="selected" <%} %>>010</option>
							<option <% if (arr[0].equals("011")) {%> selected="selected"<%} %>>011</option>
							<option <% if (arr[0].equals("016")) {%> selected="selected"<%} %>>016</option>
							<option <% if (arr[0].equals("019")) {%> selected="selected"<%} %>>019</option>
						</select>- 
							<input type="text" name="p2" size="4" maxlength="4" value="<%=arr[1] %>"  onkeyup="onlyNumber();" />-
							<input type="text" name="p3" size="4" maxlength="4" value="<%=arr[2] %>"  onkeyup="onlyNumber();" />
						</li>
						
				
						<li class="addrFinder">
							<p>주소</p>
							<input type="text" id="ma_zip" name="ma_zip" placeholder="우편번호" value="<%=ma.getMa_zip()%>"  readonly />
							<input type="text" id="ma_addr1" name="ma_addr1" placeholder="주소"value="<%=ma.getMa_addr1()%>" readonly />
							<input type="button"onclick="sample6_execDaumPostcode()" value="우편번호 찾기" />
							<input type="text" id="sample6_extraAddress" placeholder="" readonly><br />
							<p><input type="hidden" /></p>
							<input type="text" id="ma_addr2" name="ma_addr2" placeholder="상세주소"value="<%=ma.getMa_addr2()%>" maxlength="20" style="width:250px;" readonly />
							
						</li>
					</ul>
				</div>
				<div>
					<div>
						<p>요청사항</p>
						<select name="oi_memo">
							<option value="a" selected="selected">현관 문앞으로</option>
							<option value="b">관리소에</option>
							<option value="c">도착시 전화주세요</option>
							<option value="d">없음</option>
						</select>
						<div><input type="text" name="oi_memo_in"></div>
					</div>
				</div>
				<div>
					<h2>결제</h2>
					<p style="width: 800px;">
						<input type="radio" name="oi_payment" value="a" id="payA" />
						<lable for="payA">카드결제</lable>
						&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="radio" name="oi_payment" value="b" id="payB" />
						<lable for="payB">휴대폰 결제</lable>
						&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="radio" name="oi_payment" value="c" id="payC" />
						<lable for="payC">무통장입금</lable>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="oi_payment" value="d" id="payD" />
						<lable for="payD">문화상품권</lable>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</p>
				</div>
				<div>
					<div>
						<p> 보유 포인트 : <%=loginInfo.getMi_point()%>  </p>
						<input name="oi_upoint" type ="text" value="0" id="upoint" onkeyup="usePoint();" onblur="chPoint()"/>
					</div>	
					<div>
						<div>
						<%
						int price =0; // 상품 가격 
						int realprice =0; // 최종가격 
						int dc = 0; // 할인가격
						int dctotal=0; // 할인 총가격
						String ocidxs = "";
						%>
							<p>구매 목록</p>
							<%
							for(int i=0; i<cartList.size();i++){ 
								OrderCart oc = cartList.get(i);
								ocidxs += ","+oc.getOc_idx();
								price = oc.getPi_price()*oc.getOc_cnt();
								if(oc.getPi_dc()>0){
									price = oc.getPi_price()*oc.getOc_cnt() * (100-oc.getPi_dc())/100 ;
									dc = oc.getPi_price()*oc.getPi_dc()/100  ;
									dctotal+=dc*oc.getOc_cnt();
									realprice-=dctotal;
								}
								realprice +=price; 
							%>
							<div>
								<p><%=oc.getPi_name() %></p>
								<div style=" display: flex;  align-items: center;">
									<img src="img/product_img/<%=oc.getPi_img1()%>"/>
									<div  >
										<p>개수 : <%=oc.getOc_cnt() %></p>
										<%if (oc.getPi_dc()>0){ %>
										<input type="hidden" name="cnt" value="<%=oc.getOc_cnt() %>" />
										<input type="hidden" name="piid" value="<%=oc.getPi_id() %>" />
										<%if(!oc.getPs_am_name().equals("")) %><p>옵션 : <%=oc.getPs_am_name() %> </p>
										<p>할인 : <%=dc %></p>
										<%} %>
										<p>가격 : <%=price %></p>
									</div>
								</div>
							</div>
							<%} %>
							<div >
							<%
							int deli = 0;
							if(realprice<50000) {
								realprice=realprice+5000;
								deli = 5000;
							}
							%>
							<div>최종 할인 : <span id="dctotal"><%=dctotal %></span></div>
							<div>배달비 : <span id="delivery"><%=deli %></span></div>
							<div>총가격 : <span id="realprice"><%=realprice %></span></div>
							</div>
							
							<input type="hidden" name="ocidxs" value="<%=ocidxs %>" />
							<input type="hidden" value="<%=request.getParameter("kind") %>" name="kind"/>
							<input type="hidden" value="<%=price%>" name="price"/>
							<input type="hidden" value="<%=dc%>" name="dc"/>
							<input type="hidden" value="<%=dctotal%>" name="dctotal"/>
							<input type="hidden" value="<%=realprice%>" name="realprice" >
						</div>
					</div>
					<input type="button" value="결제하기" onclick="chkBuy();" />
				</div>
			</form>
		</div>
	</div>   
</main>
<%@include file = "../_inc/inc_foot.jsp" %>