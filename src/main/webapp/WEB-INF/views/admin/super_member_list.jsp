<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<MemberInfo> memberList = (List<MemberInfo>)request.getAttribute("memberList");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();	

String key = request.getParameter("key");
if(key==null){key = ""; }
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
<%if(memberList.size()>0){ %>
<table class = "list">
	<tr>
    <th>ID</th>
    <th>이름</th>
    <th>상태</th>
    </tr>
	<%for(int i = 0;i<memberList.size();i++){ 
		MemberInfo a = memberList.get(i);
	%>
    <tr>
    <td><a href = "super_member_update?idx=<%=a.getIdx()%>"><%=a.getId() %></a></td>
    <td><%=a.getName() %></td>
    <td><%=a.getStatus() %></td>
   	</tr>
	<%} %>
</table>

<div class="paging">
    <%
	if(cpage!=1){
		out.println("<a href='/super_member_list?page=1"+tmp+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='/super_member_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = '/super_member_list?page="+i+tmp+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='/super_member_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='/super_member_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>
<%}else{ %>
	<p>검색결과가 없습니다</p>
<%}%>
</main>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>