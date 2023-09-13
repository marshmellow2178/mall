<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
List<Artist> artistList = (List<Artist>)request.getAttribute("artistList");
List<Type> typeList = (List<Type>)request.getAttribute("typeList");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_product_update_proc" method="post" enctype="multipart/form-data">
	<input type = "hidden" name = idx value = "<%=pi.getIdx()%>">
	<table>
	<tr>
	<th>상품명</th>
	<td>
	<input type = "text" maxlength = 20 required name = "name" value = <%=pi.getName() %>>
	</td>
	</tr>
	
	<tr>
	<th>상품이미지</th>
	<td>
	<figure><img src = "img/product_img/<%=pi.getImg() %>"></figure>
	<input type="file" value = "이미지 수정" name = "img" multiple>
	</td>
	</tr>
	
	<tr>
	<th>상세이미지</th>
	<td>
	<figure><img src = "img/product_img/<%=pi.getDesc() %>"></figure>
	<input type="file" value = "이미지 수정" name = "desc" multiple></td>
	</tr>
	
	<tr>
	<th>아티스트</th>
	<td>
	<select name = "artist">
	<option value = "">선택하세요</option>
	<%for(int i = 0;i<artistList.size();i++){ 
	Artist a = artistList.get(i);%>
	<option value = "<%=a.getName() %>"
	<%if(pi.getArtist().equals(a.getName())){ %>selected = "selected"<%} %>
	><%=a.getName() %></option><%} %>
	</select>
	</td>
	</tr>
	
	<tr>
	<th>종류</th>
	<td>
	<select name = "type">
	<option value = "">선택하세요</option>
	<%for(int i = 0;i<typeList.size();i++){ 
	Type a = typeList.get(i);%>
	<option value = "<%=a.getName() %>"
	<%if(pi.getType().equals(a.getName())) {%> selected = "selected" <%} %>
	><%=a.getName() %></option>
	<%} %>
	</select>
	</td>
	</tr>
	
	<tr>
	<th>가격</th>
	<td><input type = "number" required name = "price" value = <%=pi.getPrice() %>></td>
	</tr>
	
	<tr>
	<th>할인율</th>
	<td><input type = "number" required max = 100 min = 0 name = "dc" value = <%=pi.getDc() %>>%</td>
	</tr>
	
	<tr>
	<th>재고량</th>
	<td><input type = "number" required min = 0 name = "stock" value = <%=pi.getStock() %>></td>
	</tr>
	
	<tr>
	<th>상태</th>
	<td>
	<input type = "radio" name = "isview" id = "y" value = "y"
	<%if(pi.getIsview().equals("y")){ %> checked = "checked"<%} %>>
	<label for = "y">판매</label>
	<input type = "radio" name = "isview" id = "n" value = "n"
	<%if(pi.getIsview().equals("n")){ %> checked = "checked"<%} %>>
	<label for = "n">판매중지</label>
	</td>
	</tr>
	</table>
	
	<input type = "submit" value = "수정">
	</form>
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