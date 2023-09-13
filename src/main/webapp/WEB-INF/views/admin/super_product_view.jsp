<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<table>
	<tr>
	<th>상품명</th>
	<td><%=pi.getName() %></td>
	</tr>
	
	<tr>
	<th>상품이미지</th>
	<td>
	<figure><img src = "img/product_img/<%=pi.getImg() %>"></figure>
	</td>
	</tr>
	
	<tr>
	<th>상세이미지</th>
	<td><figure><img src = "img/product_img/<%=pi.getDesc() %>"></figure></td>
	</tr>
	
	<tr>
	<th>종류</th>
	<td><%=pi.getType() %></td>
	</tr>
	
	<tr>
	<th>아티스트</th>
	<td><%=pi.getArtist() %></td>
	</tr>
	
	<tr>
	<th>가격</th>
	<td><%=pi.getPrice() %></td>
	</tr>
	
	<tr>
	<th>할인율</th>
	<td><%=pi.getDc() %>%</td>
	</tr>
	
	<tr>
	<th>재고량</th>
	<td><%=pi.getStock() %></td>
	</tr>
	
	<tr>
	<th>판매량</th>
	<td><%=pi.getSale() %></td>
	</tr>
	
	<tr>
	<th>상태</th>
	<td>
	<%if(pi.getIsview()==null || !pi.getIsview().equals("n")){ %>
	판매중
	<%}else{ %>
	판매중지
	<%} %>
	</td>
	</tr>
	
	<tr>
	<th>등록일</th>
	<td><%=pi.getDate() %></td>
	</tr>
	</table>
	
	<a href = "super_product_update?piid=<%=pi.getIdx() %>" class = "ctgr">정보수정</a>
</main>
</body>
</html>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
th{
	width: 15%;
}
</style>