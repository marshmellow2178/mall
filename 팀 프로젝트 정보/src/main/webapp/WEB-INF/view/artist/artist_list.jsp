<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../_inc/inc_head.jsp"%>

<%
request.setCharacterEncoding("utf-8");

List<ArtistCode> artistList = (List<ArtistCode>)request.getAttribute("artistList");

String orderby = request.getParameter("orderby");
if(orderby==null){ orderby = ""; } 

%>

<style>
<%@include file="../css/common.css"%>
li {list-style: none;}

main { transform: translateY(300px);  width: 70%;
    margin: 0 auto;}
.content_top {

}
.content_top > h2{
    font-size: 60px;
    text-align: center;
    color: #ddd;
    font-family: 'Merriweather', serif;
    font-family: 'Roboto Slab', serif;
}
.content_top > p {
    font-size: 15px;
}
.artistlist {
    padding-top: 1%;
    

}
.artistlist > ul{
   display: flex;
   flex-wrap: wrap;
   width:100%;
   

}
.artistlist > ul > li {
    padding: 0 2%;
    text-align: center;
    padding-top: 3%;
    width:25%;
}
.artistlist > ul > li> p > h3 {
  display: none;
}
.paging {
	width: 100%;
	text-align : center;
	margin-top:5%;
}
.paging a, .paging p{
	display: inline-block;
	 width: 50px;
}
</style>

    <main>
 
    <div class="content_top">
        <h2>ARTIST</h2>
        <p>
           <strong>총 "<%=artistList.size()%>"개의 아티스트 팀이 있습니다. </strong>
        </p>

        <span name ="schForm" style="float:right;">
        <form name = "schForm">
            <select name = "orderby">
       		  	<option value = "a" <%if(orderby!=null && orderby.equals("a")){%> selected = "selected" <%} %>>업데이트 순</option>
				<option value = "b" <%if(orderby!=null && orderby.equals("b")){%> selected = "selected" <%} %>>가나다 순</option>
				
				<input type = "submit" class = "button" value = "검색">
            </select>
        </form>
     </span>
    </div>
    <script>
		function init(){
			let schForm = document.schForm;
			schForm.orderby.value = '';
		}
	</script>
    

    <div class = "artistlist">

        <ul class = "artistinfo">
<%

for(int i = 0; i < artistList.size(); i++) {
	ArtistCode ac = artistList.get(i);
	String KorName = ac.getAc_name_k();
	String EngName = ac.getAc_name_e();
	
%>
   			
            <li >
            	<a href="productlist?ac=<%=ac.getAc_id()%>&key=<%=ac.getAc_name_k()%>&schtype=a">
               <img src="img/artistimg/<%=ac.getAc_img() %>" alt="<%=ac.getAc_name_k()%>"/></a>
				<p>
					<h3>
						<%=KorName %>
						<br>
					</h3><%=EngName %>
				</p>
            </li>
 
		
<%
}
%>	
	
        </ul>

    </div>
  

</main>
</body>
</html>
</body>
</html>