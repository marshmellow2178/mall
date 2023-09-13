<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "_inc/inc_head.jsp" %>
<%
List<EventInfo> el = (List<EventInfo>)request.getAttribute("el");
List<ProductInfo> newList = (List<ProductInfo>)request.getAttribute("newList");
List<ProductInfo> saleList = (List<ProductInfo>)request.getAttribute("saleList");
%>
<link rel = "stylesheet" href = "css/index.css">
<link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" ></link>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js" type="text/javascript"></script>
<main>
	<%if(el == null || el.size() == 0) {%>
		<span>준비중입니다</span>
	<%}else{ %>
	  <div class="swiper mySwiper">
	    <div class="swiper-wrapper">
		    <%for(int i = 0;i<el.size();i++){ 
		    	EventInfo ed = el.get(i);
		    %>
			    <div class = "swiper-slide">
			    	<figure>
			    	<img src = "img/event_img/<%=ed.getImg1() %>">
			    	</figure>
			    	<article class = "eventlink">
			    		<h3><a href = "event_view?beidx=<%=ed.getIdx() %>"><%=ed.getTitle() %></a></h3>
			    		<p>
			    		<%=GoodsUtil.getDateFormat(ed.getSdate()) %> ~ 
			    		<%=GoodsUtil.getDateFormat(ed.getEdate()) %></p>
			    	</article>
			    </div>
		    <%} %>
	    </div>
	    <div class="swiper-button-next"></div>
	    <div class="swiper-button-prev"></div>
	    <div class="swiper-pagination"></div>
	  </div>
  	<%} %>
  
  <section class = "product">
	<h3>NEW</h3>
	<%if(newList == null || newList.size() == 0) {%>
		<h3>준비중입니다</h3>
	<%}else{ %>
	<ul>
	<%for(int i = 0;i<newList.size();i++) {
		ProductInfo pi = newList.get(i);
	%>
		<li onclick = "location.href='product_view?piid=<%=pi.getIdx()%>';">
			<figure><img src = "img/product_img/<%= pi.getImg()%>"></figure>
			<h4><%=pi.getName()%></h4>
			<p><%=pi.getArtist() %></p>
			<p><%=pi.getRealprice() %><span class = "dc"><%=pi.getDc()%>%</span></p>
		</li>
	<%} 
	}%>
	</ul>
	
	<h3>SALE</h3>
	<%if(newList == null || newList.size() == 0) {%>
		<h3>준비중입니다</h3>
	<%}else{ %>
	<ul>
	<%for(int i = 0;i<saleList.size();i++) {
		ProductInfo pi = saleList.get(i);
	%>
		<li onclick = "location.href='product_view?piid=<%=pi.getIdx()%>';">
			<figure><img src = "img/product_img/<%= pi.getImg()%>"></figure>
			<h4><%=pi.getName()%></h4>
			<p><%=pi.getArtist() %></p>
			<p><%=pi.getRealprice() %><span class = "dc"><%=pi.getDc()%>%</span></p>
		</li>
	<%} 
	}%>
	</ul>
 </section>
</main>
<%@include file = "_inc/inc_foot.jsp" %>
<script>
var swiper = new Swiper(".mySwiper", {
    spaceBetween: 30,
    centeredSlides: true,
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });
</script>