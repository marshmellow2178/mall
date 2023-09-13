<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<ProductInfo> productList = (List<ProductInfo>)request.getAttribute("productList");
List<Artist> artistList = (List<Artist>)request.getAttribute("artistList");
List<Type> typeList = (List<Type>)request.getAttribute("typeList");
int cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize();
int bsize = pageInfo.getBsize();
long rcnt = pageInfo.getRcnt();
int pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();

String artist = request.getParameter("artist");
if(artist==null){ artist = ""; } 
String type = request.getParameter("type");
if(type==null){ type = ""; } 
String sort = request.getParameter("sort");
if(sort==null){ sort = ""; } 
String key = request.getParameter("key");
if(key==null){ key = ""; } 
else{ key = key.trim().toLowerCase(); }

String tmp = "&type="+type+"&sort="+sort+"&artist="+artist+"&key="+key; 
%>

<link rel = "stylesheet" href = "css/common.css">
<main>

	<div class = "type">
	<%if(type.equals("")){ %>
	<a href = "product_list" class = "ctgr active">전체</a>
	<%}else{ %>
	<a href = "product_list" class = "ctgr">전체</a>
	<%} %>
		<%for(int i = 0;i<typeList.size();i++){ 
			Type t = typeList.get(i);
			String active = "";
			if(type.equals(t.getName())){
				active = " active";
			}
		%>
			<a href = "product_list?type=<%=t.getName()%>" class = "ctgr<%=active%>"><%=t.getName() %></a>
		<%} %>
	</div>
	
	<div class = "schtype">
	<p>검색 결과: <%=rcnt %>개</p>
	
	<form name = "schForm" id = "ctgrsch">
		<span>카테고리 내 검색</span>
		<%if(type!=null&&!type.equals("")) {%>
		<input type = "hidden" name = "type" value = "<%=type %>">
		<%} %>
		
		<select name = "sort">
			<option value = "date,DESC" <%if(sort!=null && sort.equals("date,DESC")){%> selected = "selected" <%} %>>최신순</option>
			<option value = "sale" <%if(sort!=null && sort.equals("sale")){%> selected = "selected" <%} %>>인기순</option>
			<option value = "price" <%if(sort!=null && sort.equals("price")){%> selected = "selected" <%} %>>낮은가격순</option>
			<option value = "price,DESC" <%if(sort!=null && sort.equals("price,DESC")){%> selected = "selected" <%} %>>높은가격순</option>
		</select>
		
		<select name = "artist">
			<option value = "">아티스트</option>
			<%for(int i = 0;i<artistList.size();i++) {
			Artist a = artistList.get(i);%>
			<option value = "<%=a.getName()%>"
			<%if(artist!=null && artist.equals(a.getName())){ %> selected = "selected" <%} %>
			><%=a.getName() %></option>
			<%} %>
		</select>
		
		<input type = "search" name = "key" value = "<%=key %>" class= "search">
		<input type = "button" onclick = "init();" value = "초기화">
		<input type = "submit" value = "검색">
	</form>
	</div>
	
	<%if(rcnt ==0){%>
	<p>검색 결과가 없습니다</p>
	<%}else{%>
	<ul>
	<%
	ProductInfo pi = null;
	
	for(int i = 0;i<productList.size();i++){
		pi = productList.get(i);
		String lnk = "product_view?piid="+pi.getIdx();
	%>
		<li onclick = "location.href = ('<%=lnk%>');">
		<figure>
			<img src="<%="img/product_img/"+pi.getImg()%>">
		</figure>
		<h3><%=pi.getName() %></h3>
		<p><%=pi.getArtist() %></p>
		<p><%=pi.getRealprice() %>원
		<span class = "dc"><%=pi.getDc() %>%</span></p>
	</li>

<% }%>
		
	</ul>

	<div class="paging">
	<%
	
	if(cpage!=1){
		out.println("<a href='product_list?page=1"+tmp+"'>처음</a>");
	}else{ 
		out.println("<p>처음</p>");
	}
	
	if(cpage>1){
		out.println("<a href='product_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ 
		out.println("<p>이전</p>");
	}
	
	for(int i = spage; i<=pcnt && i<= spage+bsize-1; i++){
		if(cpage == i){
			out.println("<p><b>"+i+"</b></p>");
		}else{
			out.println("<a href = 'product_list?page="+i+tmp+"'>"+i+"</a>");
		}
	}
	
	if(cpage<pcnt){
		out.println("<a href='product_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{ 
		out.println("<p>다음</p>");
	}
	
	if(cpage!=pcnt){
		out.println("<a href='product_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ 
		out.println("<p>마지막</p>");
	}
	%>

	</div>
<% }%>
</main>

<script>
function init(){
	$('#ctgrsch input[type=search]').val('');
	$('#ctgrsch select[name=sort]').val('date,DESC');
	$('#ctgrsch select[name=artist]').val('');
}
</script>

<%@include file="../_inc/inc_foot.jsp"%>