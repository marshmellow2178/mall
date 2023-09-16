<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%

request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<ProductInfo> productList = (List<ProductInfo>)request.getAttribute("productList");
List<ArtistCode> bigList = (List<ArtistCode>)request.getAttribute("bigList");
List<ArtistProduct> smallList = (List<ArtistProduct>)request.getAttribute("smallList");

int cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize();
int bsize = pageInfo.getBsize();
int rcnt = pageInfo.getRcnt();
int pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();

String ac = request.getParameter("ac");
if(ac==null){ ac = ""; } 
String ap = request.getParameter("ap");
if(ap==null){ ap = ""; } 
String orderby = request.getParameter("orderby");
if(orderby==null){ orderby = ""; } 
String key = request.getParameter("key");
if(key==null){ key = ""; } 
else{ key = key.trim().toLowerCase(); }
String schtype = request.getParameter("schtype");
if(schtype==null){ schtype = ""; } 
System.out.println("ac = "+ac+" ap = "+ap);
String tmp = ""; //쿼리스트링
tmp="&ac="+ac+"&ap="+ap+
"&orderby="+orderby+"&key="+key+"&schtype="+schtype;	
/*
페이지 정보
PageInfo
-현재 페이지: cpage
-페이지당 상품개수: psize
-페이징영역에 표시될 페이지수: bsize
-현재 로드된 레코드(상품)개수: rcnt
-전체 페이지 개수: pcnt
-시작 페이지: spage

쿼리 스트링
-대분류: ac
-소뷴류: ap
-orderby: 정렬조건  
-a: 기본값(등록역순) b: 판매량 c: 낮은가격순 d: 높은가격 
-keyword: 검색어
-schtype: 검색조건(전체: n, 아티스트: a, 상품: p)

상품정보
productInfo 상품정보
bigList 상품 대분류(아티스트)
smallList 상품 소분류

*/

%>
<style>
main{max-width: 100%;
    margin: 0 auto;
    position: relative;
    top: 220px;
}
.header-sch > select {
padding:0;
}
</style>
<main>
	<div class="wrapper">
		<div class="menu">
			<%for(int i = 0;i<smallList.size();i++){ 
				ArtistProduct small = smallList.get(i);
				ap=small.getAp_id();
				System.out.println("ap="+ap);
			%>
				<a href = "productlist?ap=<%=ap%>"><%=small.getAp_name() %></a>
			<%} %>
		</div>
		<%ap = request.getParameter("ap"); %>		
		<form name = "schForm">
			<%if(ac!=null&&!ac.equals("")) {%>
			<input type = "hidden" name = "ac" value = "<%=ac %>">
			<%} %>
			<%if(ap!=null&&!ap.equals("")) {%>
			<input type = "hidden" name = "ap" value = "<%=ap %>">
			<%} %>
			
			<select name = "orderby">
				<option value = "a" <%if(orderby!=null && orderby.equals("a")){%> selected = "selected" <%} %>>최신순</option>
				<option value = "b" <%if(orderby!=null && orderby.equals("b")){%> selected = "selected" <%} %>>인기순</option>
				<option value = "c" <%if(orderby!=null && orderby.equals("c")){%> selected = "selected" <%} %>>낮은가격순</option>
				<option value = "d" <%if(orderby!=null && orderby.equals("d")){%> selected = "selected" <%} %>>높은가격순</option>
			</select>
		
			<select name = "schtype">
				<option value = "n" <%if(schtype!=null && schtype.equals("n")){%> selected = "selected" <%} %>>전체</option>
				<option value = "a" <%if(schtype!=null && schtype.equals("a")){%> selected = "selected" <%} %>>아티스트</option>
				<option value = "p" <%if(schtype!=null && schtype.equals("p")){%> selected = "selected" <%} %>>상품명</option>
			</select>
			
			<input type = "search" name = "key" value = "<%=key %>" class= "search">
			
			<input type = "submit" class = "button" value = "검색">
			<button onclick = "init();" class = "button">초기화</button>
		</form>
		
		<script>
			function init(){
				let schForm = document.schForm;
				if(schForm.ac!=null){ schForm.ac.value = ''; }
				if(schForm.ap!=null){ schForm.ap.value = ''; }
				schForm.orderby.value = '';
				schForm.schtype.value = '';
				schForm.key.value = '';
			}
		</script>
		
		
		<%if(productList.size()==0){%>
		<p>검색 결과가 없습니다</p>
		<%}else{%>
		
		<ul class="product_list">
		
		<%
		ProductInfo pi = null;
		
		for(int i = 0;i<productList.size();i++){
			pi = productList.get(i);
			int realPrice = pi.getPi_price();
			if(pi.getPi_dc()>0){
				realPrice = realPrice * (100-pi.getPi_dc())/100;
			}
		%>
			<li>
		<%
		char special = pi.getPi_special().charAt(0);
		//db명세서 보고 수정
		if(special == 'n'){
			out.print("<p class='new'>new</p>");
		}
		else if(special == 'h'){
			out.print("<p class='hot'>hot</p>");
		}
		else if(special == 'm'){
			out.print("<p class='md'>md추천</p>");
		}
		%>
			<figure>
				<a href="productview?piid=<%=pi.getPi_id()%>">
				<img src="<%="img/product_img/"+pi.getPi_img1()%>">
				</a>
			</figure>
			<div>
				<p>
					<span class="pdt_name"><%=pi.getPi_name() %></span><br> 
					<span><%=pi.getAc_name() %></span><br>
					<span><%=realPrice %>원 &nbsp;&nbsp;
					<%if(pi.getPi_dc()>0) {%><%=pi.getPi_dc()%>%할인<%} %>
					</span><br>
				</p>
				<a href="cart_view?piid=<%=pi.getPi_id()%>"><i class="bi bi-cart"></i></a>
			</div> 
		</li>
	
	<% }%>
			
		</ul>
	
		<div class="paging">
		<%
		
		if(cpage!=1){
			out.println("<a href='productlist?cpage=1"+tmp+"'>처음</a>");
		}else{ 
			out.println("<p>처음</p>");
		}
		
		if(cpage>1){
			out.println("<a href='productlist?cpage="+(cpage-1)+tmp+"'>이전</a>");
		}else{ 
			out.println("<p>이전</p>");
		}
		
		for(int i = 1; i<=pcnt;i++){
			if(cpage == i){
				out.println("<p>"+i+"</p>");
			}else{
				out.println("<a href = 'productlist?cpage="+i+tmp+"'>"+i+"</a>");
			}
		}
		
		if(cpage<pcnt){
			out.println("<a href='productlist?cpage="+(cpage+1)+tmp+"'>다음</a>");
		}else{ 
			out.println("<p>다음</p>");
		}
		
		if(cpage!=pcnt){
			out.println("<a href='productlist?cpage="+pcnt+tmp+"'>마지막</a>");
		}else{ 
			out.println("<p>마지막</p>");
		}
		%>
	
		</div>
	<% }%>
	</div>
</main>
<style>

<%@include file="../css/init.css"%>
<%@include file="../css/common.css"%>

.menu {
	display: flex;
	flex-wrap: wrap;
	margin: 30px 0;
	width: 100%;
	text-align: center;
	justify-content: space-between;
}
form{
	width: 100%;
}
.menu a, form select{
	border: 1px solid black;
	padding: 10px;
	width: 10%;
	min-width: 120px;
}
form .search{
	width: 30%;
	border: 1px solid black;
	padding: 10px;
	min-width: 120px;
	margin-left: 20px;
}
.product_list {
	width: 100%;
	display: flex;
	flex-wrap: wrap;
	margin: 20px 0;
}

.product_list li {
	width: 25%;
	padding: 10px;
	display: flex;
	flex-wrap: wrap;
	position: relative;
	min-width: 250px;
}
.product_list div{
	width: 100%;
	padding: 5px;
	display: flex;
	flex-wrap: wrap;
}
.product_list li div p{
	width: 80%;
}
.bi-cart{
	font-size: 40px;
}

.pdt_name {
	font-size: 18px;
}

.new {
	width: 50px;
	font-size: 20px;
	text-align: center;
	position: absolute;
	left: 10px;
	top: 10px;
	background-color: yellow;
}

.hot {
	width: 50px;
	font-size: 20px;
	text-align: center;
	position: absolute;
	left: 10px;
	top: 10px;
	background-color: red;
	color: white;
}

.md {
	width: 50px;
	font-size: 20px;
	text-align: center;
	position: absolute;
	left: 10px;
	top: 10px;
	background-color: blue;
	color: white;
}

.paging {
	width: 100%;
}
.paging a, .paging p{
	display: inline-block;
	 width: 50px;
}
</style>

<%@include file="../_inc/inc_foot.jsp"%>