<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int psize = pageInfo.getPsize(), pcnt = pageInfo.getPcnt();
int spage = pageInfo.getSpage(), rcnt = pageInfo.getRcnt();
List<NoticeInfo> noticeList = (List<NoticeInfo>)request.getAttribute("noticeList");
String schtype = pageInfo.getSchtype();
String keyword = pageInfo.getKeyword();
String schargs="",args="";

if(schtype != null&& !schtype.equals("")&& keyword != null && !keyword.equals("")){
// 검색 조건(schtype)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
}
args = "&cpage=" + cpage + schargs;

%>

<style>
<%@include file="../css/init.css" %>
<%@include file="../css/common.css" %>
main{max-width: 100%;
    margin: 0 auto;
    position: relative;
    top: 220px;
}
a{text-decoration: none;}
.notice_main{
width : 1200px;
margin: 0 auto;
}
.menu {
	width : 500px;
	display: flex;
	margin: 0 auto;
	justify-content: space-around;
}
.notice{
	margin: 0 auto;
	width :1000px;
}
.notice_list{
	width :100%;
}
.table{
	width :100%;	
}
.num{
	margin: 0 auto;
}
#list th, #list td {
	padding: 8px 3px;
}

#list th {
	border-bottom: double black 3px;
}

#list td {
	border-bottom: double black 1px;
}

</style>    
<%@include file="../_inc/inc_head.jsp"%>
<main>
<%
// 검색 타입은 제목, 내용, 제목+내용 3가지 
%>
	<div class= "notice_main">
		<h2></h2>
		<div  class="menu">
			<div>
				<a href = "notice">공지사항</a>
			</div>	
			<div>
				<a href = "faq">FAQ</a>
			</div>
			<div>
				<a href = "mantoman">1대1문의</a>			
			</div>
		</div>
		<div class= "notice">
			<h3>공지사항</h3>
			<div class="notice_list">
				<table class="table" id ="list">
					<tr>
						<th  width="10%">번호</th>
						<th width="*">공지사항</th>
						<th width="15%">게시자</th>
						<th width="15%">일자</th>
						<th width="10%">조회수</th>
						
					</tr>
					<%
						if(noticeList.size()>0){ // 게시글 목록이 있으면
							int num= rcnt -(psize*(cpage-1));
						System.out.println(rcnt);
							for(int i=0;i<noticeList.size();i++){	
								NoticeInfo bn= noticeList.get(i);
								String title = bn.getBn_title();
								if(title.length()>30) title = title.substring(0,27)+"...";
								title = "<a href = 'notice_view?bnidx="+bn.getBn_idx()+args+"'>"+title+"</a>";
								
							%>
							<tr align="center" >
								<td><%=num%></td>
								<td align="left">&nbsp;&nbsp;<%=title %></td>
								<td><%=bn.getAi_name() %></td>
								<td><%=bn.getBn_date().substring(0,10) %></td>
								<td><%=bn.getBn_read() %></td>
							</tr>
							<%
							num--;
							}
						}else{ // 게시글 목록이 없으면
							out.print("<tr><td colspan='5' align= 'center'>");
							out.println("검색결과가 없습니다.</td></tr>");
						}
						%>
				</table>
			</div> 
		</div>
		<table cellpadding="5" class="num">
			<tr>
				<td>
					<% if (rcnt>0) { // 게시글이 있으면 - 페이징 영역을 보여줌
				  		String lnk = "noitce?cpage=";
				  		pcnt = rcnt / psize;
				  		if(rcnt% psize>0) pcnt++; // 전체 페이지 수(마지막 페이지 번호)
						if(cpage==1){
							out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;&nbsp;");
						}else{
							out.println("<a href = '" + lnk + 1  + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
							out.println("<a href = '" + lnk + (cpage-1) + "'>[이전]</a>&nbsp;&nbsp;");
						}
						spage = (cpage -1)/bsize*bsize+1; // 현재 블록에서의 시작 페이지 번호
				  		for(int i =1, j=spage; i<=bsize && j <=pcnt ; i++,j++){
				  		// i : 블록에서 보여줄 페이지의 개수많큼 루프를 돌릴 조건으로 사용되는 변수
				  		// j : 살제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함	
				  			if(cpage == j){
				  				out.println("&nbsp;<strong>"+j+"</strong>&nbsp;");
				  			}else{
				  				out.println("&nbsp;<a href='" + lnk + j  + "'>");
				  				out.println(j+"</a>&nbsp;");
				  			}
				  		}
						if(cpage==pcnt){
							out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
						}else{
							out.println("<a href = '" + lnk + (cpage+1)  + "'>&nbsp;&nbsp;[다음]</a>");
							out.println("<a href = '" + lnk + pcnt+ "'>&nbsp;&nbsp;&nbsp;[마지막]</a>");
						}
				  	}
				  	%>
				</td>
			</tr>
		</table>
	</div>
</main>




<%@include file="../_inc/inc_foot.jsp"%>