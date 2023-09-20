<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
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
<%@include file="../_inc/inc_customer.jsp"%>

<div class = "schtype">
    <p>검색 결과: <%=rcnt %>개</p>
    <form class = "search">
        <select name = "ctgr" onchange = form.submit();>
        	<option value = "" <%if(ctgr.equals("")){%> selected = "selected" <%} %>><%=Code_List.getNoticeCtgr("") %></option>
            <option value = "n" <%if(ctgr.equals("n")){%> selected = "selected" <%} %>><%=Code_List.getNoticeCtgr("n") %></option>
            <option value = "a" <%if(ctgr.equals("a")){%> selected = "selected" <%} %>><%=Code_List.getNoticeCtgr("a") %></option>
        </select>
        <input type = "search" name = "key" value = "<%=key%>">
        <input type = "submit" value = "검색">
    </form>
</div>

<table class = "list">
    <tr>
        <th width = 15%>분류</th>
        <th>제목</th>
        <th  width = 15%>작성자</th>
        <th  width = 15%>등록일</th>
    </tr>
    <%if(noticeList.size()>0){ 
		for(int i = 0;i<noticeList.size();i++){ 
		Notice nd = noticeList.get(i);%>
	    <tr>
	    	<td><%="["+Code_List.getNoticeCtgr(nd.getCtgr())+"]"%></td>
	        <td><a href = "notice_view?idx=<%=nd.getIdx()%>"><%=nd.getTitle() %></a></td>
	        <td><%=nd.getAdminid() %>
	        <td><%=GoodsUtil.boardDateFormat(nd.getDate()) %></td>
	    </tr>
		<%} 
	}else{%>
		<tr><td  colspan = 4>검색 결과가 없습니다</td></tr>
	<%} %>
</table>

<div class="paging">
    <%
	if(cpage!=1){
		out.println("<a href='notice_list?page=1"+tmp+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='notice_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'notice_list?page="+i+tmp+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='notice_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='notice_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>

</main>
<%@include file="../_inc/inc_foot.jsp"%>