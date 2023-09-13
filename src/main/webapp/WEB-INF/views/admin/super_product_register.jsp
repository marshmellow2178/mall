<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
List<Artist> artistList = (List<Artist>)request.getAttribute("artistList");
List<Type> typeList = (List<Type>)request.getAttribute("typeList");
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<form action = "super_product_proc" method="post" enctype="multipart/form-data">
	<input type = "hidden" name = idx value = "0">
	<table>
	<tr>
	<th>상품명</th>
	<td>
	<input type = "text" maxlength = 20 required name = "name">
	</td>
	</tr>
	
	<tr>
	<th>상품이미지</th>
	<td>
	<input type="file" value = "이미지 추가" name = "img" required multiple>
	</td>
	</tr>
	
	<tr>
	<th>상세이미지</th>
	<td><input type="file" value = "이미지 추가" name = "desc" required multiple></td>
	</tr>
	
	<tr>
	<th>아티스트</th>
	<td>
	<select name = "artist">
	<option value = "">선택하세요</option>
	<%for(int i = 0;i<artistList.size();i++){ 
	Artist a = artistList.get(i);%>
	<option value = "<%=a.getName() %>"><%=a.getName() %></option>
	<%} %>
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
	<option value = "<%=a.getName() %>"><%=a.getName() %></option>
	<%} %>
	</select>
	</td>
	</tr>
	
	<tr>
	<th>가격</th>
	<td><input type = "number" required name = "price" value = 10000></td>
	</tr>
	
	<tr>
	<th>할인율</th>
	<td><input type = "number" required max = 100 min = 0 name = "dc" value = 0>%</td>
	</tr>
	
	<tr>
	<th>재고량</th>
	<td><input type = "number" required min = 0 name = "stock" value = 200></td>
	</tr>
	
	<tr>
	<th>상태</th>
	<td>
	<input type = "radio" name = "isview" id = "y" value = "y" checked = "checked">
	<label for = "y">판매</label>
	<input type = "radio" name = "isview" id = "n" value = "n">
	<label for = "n">판매중지</label>
	</td>
	</tr>
	</table>
	
	<input type = "submit" value = "등록">
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