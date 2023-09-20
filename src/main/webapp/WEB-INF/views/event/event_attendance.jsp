<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
List<Attendance> aList = (List<Attendance>)request.getAttribute("aList");
LocalDate today = LocalDate.now();
int month = today.getMonthValue();
int length = today.lengthOfMonth();
int sdate = today.withDayOfMonth(1).getDayOfWeek().getValue();
int[] temp = new int[length];
for(int i = 0;i<aList.size();i++){
	int idx = aList.get(i).getLogin().getDayOfMonth();
	temp[idx] = aList.get(i).getConsecutive();
}
%>
<link rel = "stylesheet" href = "css/common.css">
<main>
	<h3><%=loginInfo.getId() %>님 <%=month %>월 출석체크</h3>
    <ul class = "calendar">
    	<%for(int i = 1;i<=35;i++){%>
    	 	<li>
    		<%int date = i-sdate+1;
			if(1<=date && date<=length) {
    			String str = (temp[date-1]>=1)?"출석!":"";
    			String level = GoodsUtil.attendance_level(temp[date-1], length);
    		%> 
    			<div class = "<%=level%>">
    			<p><%=date %></p> 
    			<p><%=str %></p>
    			</div>
    		<%} %>
    		</li>
    	<%} %>
    </ul>
</main>

<%@include file="../_inc/inc_foot.jsp"%>