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
<script>
$(window).on("load", function(){
	$('.list tr:even').click(function(){
		$(this).next().addClass('active');
	});
	$('.list tr:odd').click(function(){
		$(this).removeClass('active');
	});
});
</script>
<style>
.list tr:nth-child(odd){
	border: none;
}
.list tr:nth-child(even){
	display:none;
}
.list tr:nth-child(even).active{
	display: revert;
    background-color: #ffdddd;
}
</style>
<main>
<%@include file="../_inc/inc_customer.jsp"%>

<div class = "schtype">
    <p>검색 결과: <%=rcnt %>개</p>
    <form class = "search">
        <select name = "ctgr" onchange = form.submit();>
            <option value = "" <%if(ctgr.equals("")){%> selected = "selected" <%} %>><%=Code_List.getQuestionCtgr("") %></option>
			<option value = "m" <%if(ctgr.equals("m")){%> selected = "selected" <%} %>><%=Code_List.getQuestionCtgr("m") %></option>
			<option value = "p" <%if(ctgr.equals("p")){%> selected = "selected" <%} %>><%=Code_List.getQuestionCtgr("p") %></option>
			<option value = "o" <%if(ctgr.equals("o")){%> selected = "selected" <%} %>><%=Code_List.getQuestionCtgr("o") %></option>
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
    	<th width = 5%>Q</th>
    	<td><%="["+Code_List.getQuestionCtgr(fd.getCtgr())+"] "+fd.getTitle() %></td>
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