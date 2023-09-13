<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_admin.jsp"%>
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
<%@include file="../_inc/inc_admin_customer.jsp"%>

<div class = "schtype">
    <p>검색 결과: <%=rcnt %>개</p>
    <form class = "search">
        <select name = "ctgr">
            <option value = "">분류 선택</option>
            <option value = "<%=Code_List.MEMBER%>"
            <%if(ctgr!=null && ctgr.equals(Code_List.MEMBER)) {%> selected = "selected"<%} %>>회원</option>
            <option value = "<%=Code_List.PRODUCT%>"
            <%if(ctgr!=null && ctgr.equals(Code_List.PRODUCT)) {%> selected = "selected"<%} %>>상품</option>
            <option value = "<%=Code_List.ORDER%>"
            <%if(ctgr!=null && ctgr.equals(Code_List.ORDER)) {%> selected = "selected"<%} %>>주문</option>
        </select>
        <input type = "search" name = "key" value = "<%=key%>">
        <input type = "button" value = "초기화" onclick = "init();">
        <input type = "submit" value = "검색">
    </form>
</div>
<%if(faqList.size()>0){ %>
<table class = "list">
	<%for(int i = 0;i<faqList.size();i++){ 
		Faq fd = faqList.get(i);
	%>
    <tr>
    	<th width = 15%>Q</th>
    	<td><a href = "super_faq_update?idx=<%=fd.getIdx()%>"><%="["+fd.getCtgr()+"] "+fd.getTitle() %></a></td>
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
		out.println("<a href='super_faq_list?page=1"+tmp+"'>처음</a>");
	}else{ out.println("<p>처음</p>");}
	
	if(cpage>1){
		out.println("<a href='super_faq_list?page="+(cpage-1)+tmp+"'>이전</a>");
	}else{ out.println("<p>이전</p>");}
	
	for(int i = 1; i<=pcnt;i++){
		if(cpage == i){out.println("<p><b>"+i+"</b></p>");}
		else{out.println("<a href = 'super_faq_list?page="+i+tmp+"'>"+i+"</a>");}
	}
	
	if(cpage<pcnt){
		out.println("<a href='super_faq_list?page="+(cpage+1)+tmp+"'>다음</a>");
	}else{out.println("<p>다음</p>");}
	
	if(cpage!=pcnt){
		out.println("<a href='super_faq_list?page="+pcnt+tmp+"'>마지막</a>");
	}else{ out.println("<p>마지막</p>");}
	%>
</div>
<%}else{ %>
	<p>검색결과가 없습니다</p>
<%}%>
<a href = "super_faq_register" class = "ctgr">FAQ 등록</a>
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