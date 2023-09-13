<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<Artist> artistList = (List<Artist>)request.getAttribute("artistList");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();	

String key = request.getParameter("key");
if(key == null) { key = ""; }
String tmp = "&key="+key;
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
<div class = "schtype">
    <p>검색 결과: <%=rcnt %>개</p>
    <form class = "search">
        <input type = "search" name = "key" value = "<%=key%>">
        <input type = "submit" value = "검색">
    </form>
</div>
<%if(artistList.size()>0){ %>
<table class = "list">
	<tr>
    <th width = "15%">번호</th>
    <th>이름</th>
    <th  width = "15%">수정</th>
    </tr>
	<%for(int i = 0;i<artistList.size();i++){ 
		Artist a = artistList.get(i);
	%>
    <tr>
    <td><%=a.getIdx() %></td>
    <td><%=a.getName() %></td>
    <td><a href = "super_artist_update?idx=<%=a.getIdx()%>" class = "ctgr">수정</a></td>
   	</tr>
	<%} %>
</table>

<div class="paging">
    <%
	if(cpage!=1){
		out.println("<a href='super_artist_list?page=1"+tmp+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='super_artist_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'super_artist_list?page="+i+tmp+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='super_artist_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='super_artist_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>
<%}else{ %>
	<p>검색결과가 없습니다</p>
<%}%>
<a href = "super_artist_register" class = "ctgr">등록</a>
</main>
<%@include file="../_inc/inc_foot.jsp"%>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>