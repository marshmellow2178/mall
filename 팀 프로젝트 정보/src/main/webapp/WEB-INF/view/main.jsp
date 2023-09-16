<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@include file="./_inc/inc_head.jsp"%>
 <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" ></link>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js" type="text/javascript"></script>
    
<%
List<ProductInfo> mdpr = (List<ProductInfo>)request.getAttribute("mdpr");
List<ArtistCode> weekList = (List<ArtistCode>)request.getAttribute("weekList");
List<ArtistCode> AlList = (List<ArtistCode>)request.getAttribute("AlList");
List<ArtistCode> productList = (List<ArtistCode>)request.getAttribute("productList");

%>
<main>
<article class="Content-1" background-color="#edfef9;">
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide"> 
         <figure>
         <img src = "img/mainimg/bts.jpg" width=600px height=600px>
         <figcaption class="contents">
            <span>Best Artist</span>
            <h1>BTS</h1>
            <p style="color:#6495ED"> RM (방탄소년단) - Indigo / 1집 솔로앨범 (LP)
            </p>
            <div class="go_artist">
               <p style="background-color:#6495ED"><a href="productlist?cpage=1&ac=BT">바로가기</a></p>
            </div>
         </figcaption>
         </figure>
      </div>
      <div class="swiper-slide">
         <figure>
         <img src = "img/mainimg/blackpink.jpg" width=600px height=600px>
         <figcaption class="contents">
            <span>Global Artist</span>
            <h1>BLACK PINK</h1>
            <p style="color:#FFB6C1">
              아기자기한 한정판 블핑 4팩 피규어 출시!
            </p>
            <div class="go_artist">
               <p style="background-color:#FFB6C1"><a href=productlist?cpage=1&ac=BP>바로가기</a></p>
            </div>
         </figcaption>
         </figure>
      </div>
      <div class="swiper-slide">
         <figure>
         <img src = "img/mainimg/bss.jpg" width=600px height=600px>
         <figcaption class="contents">
            <span>NEW</span>
            <h1>SEVENTEEN</h1>
            <p style="color:#B0E0E6">
               부석순 1st Single Album 'SECOND WIND'발매
            </p>
            <div class="go_artist">
               <p style="background-color:#B0E0E6"><a href=productlist?cpage=1&ac=ST>바로가기</a></p>
            </div>
         </figcaption>
         </figure>
      </div>
      <div class="swiper-slide">
         <figure><img src = "img/mainimg/mainive.jpg" width=600px height=600px>
         <figcaption class="contents">
            <span>신인 BEST</span>
            <h1>IVE</h1>
            <p style="color:#DA70D6">
               IVE 아이브 - 공식 응원봉 출시
            </p>
            <div class="go_artist">
               <p style="background-color:#DA70D6"><a href=productlist?cpage=1&ac=IV>바로가기</a></p>
            </div>
         </figcaption>
         
         </figure>
      </div>
      <div class="swiper-slide">
         <figure><img src = "img/mainimg/idelmain.jpg" width=600px height=600px>
         <figcaption class="contents">
            <span>RESTOCK</span>
            <h1>(G)idle</h1>
            <p style="color:#FFE4B5">
               아이돌 공식 응원봉 재입고
            </p>
            <div class="go_artist">
               <p style="background-color:#FFE4B5"><a href=productlist?cpage=1&ac=ID>바로가기</a></p>
            </div>
         </figcaption>
         </figure>
      </div>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination">
    
    </div>
  </div>
 </article>
 
 <article class="Content-2">
   <% %>
   <div class="artist">
      <h2 >주간 아티스트 베스트</h2>
     
      <div class="artist-best">
          <%ArtistCode ac = weekList.get(0);
          		String img= ac.getAc_img().substring(ac.getAc_img().indexOf('_')+1);
       			img = img.substring(0,img.indexOf('.'));
          %>
          <a href="productlist?cpage=1&ac=<%=ac.getAc_id()%>">
         
          <div class="artname"> <p> <%=ac.getAc_name_k() %></p></div>
             <img src="img/mainimg/<%=img%>.jpg" />
          
             
          </a>
      </div>
      <div class="artist-mid">
         <%for(int i = 1; i < weekList.size(); i++ ) {
        	ac =  weekList.get(i);
        	img= ac.getAc_img().substring(ac.getAc_img().indexOf('_')+1);
    		img = img.substring(0,img.indexOf('.'));
        	
         %>
          <div><a href="productlist?cpage=1&ac=<%=ac.getAc_id()%>"><img src="img/mainimg/<%=img%>.jpg"/><p><%=ac.getAc_name_k() %></p></a></div>
         <%} %>
      </div>
   </div>
   <div class="album">
       <h2>앨범판매 베스트</h2>
         <% ac = AlList.get(0);  
         	img= ac.getAc_img().substring(ac.getAc_img().indexOf('_')+1);
         	img = img.substring(0,img.indexOf('.'));
         	System.out.println("img : "+img);
         %>
       <div class="album-best" >
           <a href="productlist?cpage=1&ac=<%=ac.getAc_id()%>">
                 <div class="artname"><p><%=ac.getAc_name_k() %></p></div>
                     <img src="img/mainimg/<%=img%>.jpg" />
               
               
           </a>
          
       </div>
       
       <div class="album-mid">
           <%for(int i = 1; i < AlList.size(); i++ ) {
        	ac =  AlList.get(i);
        	img = ac.getAc_img().substring(ac.getAc_img().indexOf('_')+1);
         	img = img.substring(0,img.indexOf('.'));
         %>
           <div><a href="productlist?cpage=1&ac=<%=ac.getAc_id()%>"><img src="img/mainimg/<%=img%>.jpg"/><p><%=ac.getAc_name_k() %></p></a></div>
       	  <%} %>
       </div>
   </div>
   <div class="product">
       <h2>상품판매 베스트</h2>
       <% 
       ac = productList.get(0);
       img = ac.getAc_img().substring(ac.getAc_img().indexOf('_')+1);
    	img = img.substring(0,img.indexOf('.'));
       %>
       <div class="product-best">
           <a href="productlist?cpage=1&ac=<%=ac.getAc_id()%>">
           		<div class="artname"><p><%=ac.getAc_name_k() %></p></div>
                <img src="img/mainimg/<%=img%>.jpg" />                   
           </a>
       </div>
       <div class="product-mid">
        <%for(int i = 1; i < productList.size(); i++ ) {
        	ac =  productList.get(i);
        	img = ac.getAc_img().substring(ac.getAc_img().indexOf('_')+1);
         	img = img.substring(0,img.indexOf('.'));
         %>
           <div><a href="productlist?cpage=1&ac=<%=ac.getAc_id()%>"><img src="img/mainimg/<%=img%>.jpg"/><p><%=ac.getAc_name_k() %></p></a></div>
       <%} %>
       </div>
   </div>
</article>


<article class="Content-3">
   <div class="new-Wrap">
      <div>
          <h2 >MD 추천 상품</h2>
      </div>
      <div class="md-product">
          <div>
              <a href="" style="">
               <div>
                   <img src="img/mainimg/jiminalbum.jpg" >
               </div>
               <div>
                   <p>상품명 :FACE/1집 솔로앨범</p>
                   <p>아티스트 : 방탄소년단[지민]</p>
               </div>
             </a >
         </div>
         <div>
             <a href="" style="">
                 <div>
                     <img src="img/mainimg/idelbong.jpg" >
                 </div>
                 <div>
                     <p>상품명 : 01 공식 응원봉 Ver.2 / 2023 행운의 편지</p>
                     <p>아티스트 : (G)-idle</p>
                 </div>
             </a>
         </div>
         <div>
             <a href="" style="">
                 <div>
                    <img src="img/mainimg/yenaablum.jpg" >
                 </div>
                 <div>
                     <p>상품명 : Love War / 1집 싱글앨범</p>
                     <p>아티스트 : YENA</p>
                 </div>
             </a>
         </div>
         <div>
             <a href="" style="">
                 <div>
                    <img src="img/mainimg/monst.jpg" >
                 </div>
                 <div>
                     <p>상품명 :Love War / 1집 싱글앨범</p>
                     <p>아티스트 : 몬스타엑스</p>
                 </div>
             </a>
         </div>
         <div>
             <a href="" style="">
                   <div>
                      <img src="img/mainimg/itzyb.jpg" >
                   </div>
                   <div>
                       <p>상품명 : 02 손그림 뱃지 / 2021 BEST FRIEND’S STORE</p>
                       <p>아티스트 : ITZY</p>
                   </div>
               </a>
           </div>
       </div>
   </div>
   
</article>
 
 
 
</main>

<style>
 <%@include file="css/common.css"%>
    @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
   h2{
   border:1px solid black;
   border-radius : 5px;
   background-color :   #D3D3D3;
   }
    main { 
       transform: translateY(200px); 
       width : 70%;
       margin: 0 auto;
       
    }
    .swiper {
      width: 100%;
     
    }
   
   .swiper-button-next {
   position : absolute;
   top: 60%; 
   right: 15%;
   color : black;
   }
   .swiper-button-prev {
   position : absolute;
   top: 60%; 
   left: 30%;
   color : black;
   }
   
   .contents {
   position : absolute;
   bottom:30%;
   right:80%;
   text-align: left;
   }
   .contents span {
      color: #aeaeba;
      font-family: 'GmarketSansMedium';
      
   }
   .contents p {
      font-family: 'GmarketSansMedium';
      margin:10% 0 ;
   }
   
   .contents h1 {
   font-size:30px;
   }
   .swiper-pagination {
   position : absolute;
   top: 40%;
   }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
      position : relative;
    }

    .swiper-slide figure{
      display: block;
      width: 30%;
      item-align : center;
    }
    
    .swiper-slide figure img {
      width:150%;
     
    
    }
    .go_artist p {
       border : 1px solid black;
       width: 50%;
       text-align : center;
       border-radius: 5px;
       line-height: 40px;

    }
  
    figure img {
    border-radius: 70%;
    margin-top:150px;
    }
    
    a{
    color:black;
    }
    .swiper-pagination {
       display:none;
    }
     .Content-1{min-height: 800px;}
     .Content-2{ width:105%; height: 55em; display: flex; justify-content: space-evenly;}
.Content-2 div { max-width: 1200px; margin: 0 auto; }
.artist {
padding: 0 10px;
}
.Content-2 h2 {
font-family: 'S-CoreDream-3Light';

}
@font-face {
     font-family: 'S-CoreDream-3Light';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}
.Content-2 div h2 {text-align: center; margin: 50px 0; font-size : 35px;}
.Content-2 div a {align-items: center; text-align: center; align-content: center;}
.artist-mid > div {
padding:0 3px;
}
.artname{
border : 1px solid black;
width : 400px; height: 50px;
border-bottm: none;
line-height:10px;
background-color: #edfef9;
}
@font-face {
    font-family: 'Tenada';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2210-2@1.0/Tenada.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.artname p {
font-size:30px;
font-family: 'Tenada';
}
.artist {width: 400px; }

.artist-best img{width: 400px; height: 350px; margin-bottom:10px;}
.artist-best p{margin: 20px 0; font-size:30px;}

.album {width: 400px;}

.album-best img{width: 400px; height: 350px; margin-bottom:10px;}
.album-best p{margin: 20px 0; font-size:30px;}
.album-mid p {
font-size:20px;
font-family: 'GmarketSansMedium';
}
.product {width: 400px;}
.product-best img{width: 400px; height: 350px; margin-bottom:10px;}
.product-best p{margin: 20px 0; font-size:30px;}

.artist-mid {display: flex; justify-content: space-between; font-size: 2px; text-align: center; }
.artist-mid img {width: 130px; height: 130px; }
.artist-mid p {
font-family: 'GmarketSansMedium';
font-size:20px;
}
.album-mid {display: flex; justify-content: space-between; font-size: 2px; text-align: center;}
.album-mid img {width: 130px; height: 130px;}
.product-mid {display: flex; justify-content: space-between; font-size: 2px; text-align: center;}
.product-mid img {width: 130px; height: 130px;}
.product-mid p {
font-family: 'GmarketSansMedium';
font-size:20px;
}



.Content-3{width:100%;height: 25em; }
.Content-3 > div { max-width: 1200px; margin: 0 auto;}
.Content-3 div h2 { margin: 10px 0; width:20%;     text-align: center;}
.Content-3 img {width: 220px; margin: 0 auto; border-bottom: 1px solid #000;}
.Content-3 p {margin: 0;}
.new-Wrap div h2{
font-family: 'S-CoreDream-3Light';
}
.md-product{
    display: flex; justify-content: space-around;
}

.md-product > div {
    width: 250px; border: 1px solid #000;margin: 10px;
}
.md-product > div > a{
    display: flex; flex-wrap: wrap;
}
.new-product{
    display: flex; 
    display:none;
}
.new-product > div {
    width: 250px; 
}
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.md-product p{
 font-family: 'NanumSquareNeo-Variable';
 line-height: 25px;
}
.new-product p{
 font-family: 'NanumSquareNeo-Variable';
}
    
    
</style>

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