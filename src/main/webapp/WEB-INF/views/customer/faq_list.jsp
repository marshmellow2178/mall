<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
List<Faq> faqList = (List<Faq>)request.getAttribute("faqList");

int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage();
long rcnt = pageInfo.getRcnt();	

String ctgr = request.getParameter("ctgr");
if(ctgr == null) { ctgr = ""; }
String key = request.getParameter("key");
if(key == null) { key = ""; }
String tmp = "&ctgr="+ctgr+"&key="+key;
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
<%@include file="../_inc/inc_customer.jsp"%>

<div class = "schtype">
    <p>검색 결과: <%=rcnt %>개</p>
    <form class = "search">
        <select name = "ctgr">
            <option value = "" <%if(ctgr!=null && ctgr.equals("")){%> selected = "selected" <%} %>>전체</option>
            <option value = "m" <%if(ctgr!=null && ctgr.equals("m")){%> selected = "selected" <%} %>>회원</option>
            <option value = "e" <%if(ctgr!=null && ctgr.equals("e")){%> selected = "selected" <%} %>>쿠폰/혜택/이벤트</option>
            <option value = "o" <%if(ctgr!=null && ctgr.equals("o")){%> selected = "selected" <%} %>>주문/결제</option>
            <option value = "s" <%if(ctgr!=null && ctgr.equals("s")){%> selected = "selected" <%} %>>배송</option>
            <option value = "c" <%if(ctgr!=null && ctgr.equals("c")){%> selected = "selected" <%} %>>취소/반품/교환</option>
        </select>
        <input type = "search" value = "<%=key%>">
        <input type = "submit" value = "검색">
    </form>
</div>
<%if(faqList.size()>0){ %>
<table class = "list">
	<%for(int i = 0;i<faqList.size();i++){ 
		Faq fd = faqList.get(i);
	%>
    <tr>
    	<th>Q</th>
    	<td><a href = "faq_view?idx=<%=fd.getIdx()%>"><%="["+fd.getCtgr()+"] "+fd.getTitle() %></a></td>
    </tr>
    <tr>
    	<th>A</th>
        <td><%=fd.getAnswer()%></td>
    </tr>
	<%} %>
</table>

<div class="paging">
    <%
	if(cpage!=1){
		out.println("<a href='faq_list?page=1"+tmp+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='faq_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'faq_list?page="+i+tmp+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='faq_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='faq_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>
<%}else{ %>
	<p>검색결과가 없습니다</p>
<%}%>
</main>
<%@include file="../_inc/inc_foot.jsp"%>