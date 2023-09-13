<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<Notice> noticeList = (List<Notice>)request.getAttribute("noticeList");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();	

String ctgr = request.getParameter("ctgr");
if(ctgr == null) { ctgr = ""; }
String key = request.getParameter("key");
if(key==null){ key = ""; } 
String tmp = "&ctgr="+ctgr+"&key="+key;
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
<%@include file="../_inc/inc_admin_customer.jsp"%>

<div class = "schtype">
    <p>검색 결과: <%=rcnt %>개</p>
    <form class = "search">
        <select name = "ctgr">
            <option value = "">분류 선택</option>
        		<option value = "<%=Code_List.ALERT%>"
        		<%if(ctgr.equals(Code_List.ALERT)){ %> selected = "selected"<%} %>>주의</option>
        		<option value = "<%=Code_List.ANNOUNCCE%>"
        		<%if(ctgr.equals(Code_List.ANNOUNCCE)){ %> selected = "selected"<%} %>>발표</option>
        		<option value = "<%=Code_List.NOTICE%>"
        		<%if(ctgr.equals(Code_List.NOTICE)){ %> selected = "selected"<%} %>>알림</option>
        </select>
        <input type = "search" name = "key" value = "<%=key%>">
        <input type = "button" onclick = "init();" value = "초기화">
        <input type = "submit" value = "검색">
    </form>
</div>

<%if(noticeList.size()>0){ %>
<table class = "list">
    <tr>
        <th  width = "15%">분류</th>
        <th>제목</th>
        <th width = "15%">등록일</th>
    </tr>
	<%for(int i = 0;i<noticeList.size();i++){ 
		Notice nd = noticeList.get(i);
	%>
    <tr>
    	<td><%="["+nd.getCtgr()+"]"%></td>
        <td><a href = "super_notice_update?idx=<%=nd.getIdx()%>"><%=nd.getTitle() %></a></td>
        <td><%=GoodsUtil.boardDateFormat(nd.getDate()) %></td>
    </tr>
	<%} %>
</table>

<div class="paging">
    <%
	if(cpage!=1){
		out.println("<a href='super_notice_list?page=1"+tmp+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='super_notice_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'super_notice_list?page="+i+tmp+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='super_notice_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='super_notice_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>
<%}else{ %>
	<p>검색결과가 없습니다</p>
<%}%>
<a href = "super_notice_register" class = "ctgr">공지 등록</a>
</main>
<style>
main{
	width: 45%;
	margin: 0 auto;
}
</style>
<script>
function init(){
	$('select').val("");
	$('input[name=key]').val("");
}
</script>
<%@include file="../_inc/inc_foot.jsp"%>