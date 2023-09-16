<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
EventInfo el = (EventInfo)request.getAttribute("eventview");

int beidx = el.getBe_idx();

String status = "진행중";

%>
<style>
<%@include file="../css/init.css" %>
<%@include file="../css/common.css" %>
main { transform: translateY(300px); }
.cs_box 
{
	width : 70%;
	margin: 0 auto;
    padding : 40px;
    border-radius: 20px;
    background-color: #fdfdfd;
    box-shadow: 0 30px 60px rgb(20 20 21 / 6%);
}

.ce_view
{
	display: inline-block;
    vertical-align: middle;
    width: 100%;
    border-top:#64646b solid 1px;
    font-size:12px;
    color:#64646b
}

.cevh_title 
{
	background-color : #f5f5fa;
	font-size : 16px;
	font-weight : 600;
	color : #141415;
	line-height: 30px;
	word-wrap:normal;
	word-break:keep-all;
	padding: 15px 20px;
	border-bottom:#dcdce6 solid 1px;
}

.cevh_title2
{
	background-color : #ffffff;
	font-size : 16px;
	font-weight : 600;
	color : #141415;
	line-height: 30px;
	word-wrap:normal;
	word-break:keep-all;
	padding: 15px 20px;
	border-bottom:#dcdce6 solid 1px;
}

.cev_body
{
	margin-bottom: 60px;
    padding: 60px 20px;
    border-bottom: #efeff5 solid 1px;
}

</style>

<main>
<div class="cs_box">
    <div class="ce_view">
        <div class="cev_head">
            <div class="cevh_title">
            <%
				if(el.getBe_status().equals("a")) status = "대기중";
				if(el.getBe_status().equals("c")) status = "마감임박";	
				if(el.getBe_status().equals("d")) status = "종료";
			%>
            <span class ="cevh_state">[<%=status %>]</span>
                <strong><%=el.getBe_title() %></strong> 
            </div>
            <div class="cevh_title2">
                <span>이벤트기간 : <%=el.getBe_sdate().substring(0, 10) %></span>
                ~
                <span><%=el.getBe_edate().substring(0, 10) %></span>
            </div>
        </div>
        <div class="cev_body">
        <% if(el.getBe_img2() != null) { %>
        	<p><img src="img/event_img/<%=el.getBe_img2() %>"></p>
        <% } else { %>
        	<script>
        	alert('종료된 이벤트 입니다.');
        	history.back();
        	</script>
		<% } %>
        </div>
    </div>
</div>
</main>

</body>
</html>

<%@include file="../_inc/inc_foot.jsp"%>