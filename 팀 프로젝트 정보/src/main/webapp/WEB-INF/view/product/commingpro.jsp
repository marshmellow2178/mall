<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@include file="../_inc/inc_head.jsp"%>
<%
request.setCharacterEncoding("utf-8");
int rcnt = (int)request.getAttribute("rcnt");
List<ProductInfo> commingList = (List<ProductInfo>)request.getAttribute("commingList");
int cpage = 1;
if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));
%>

<style>
    .Top {
        border: 1px solid black;
        width: 500px;
        height: 30%;

    }
    .Bot{
        display: flex;
        width: 500px;
        flex-direction: row;
        justify-content: space-between;
    }
    .sun{
        width: 20%;
        border: 1px solid black;
    }
    div{
        margin: 0 auto;
    }
</style>
<body>
  <script>
    //타이머를 보여줄 HTML 엘리먼트를 가져옵니다.
    const countdownEl = document.getElementById('countdown');
    
    // 타이머에 사용할 날짜를 설정합니다. 이 예제에서는 현재 날짜에서 30일 후를 사용합니다.
  
    // 월은 0~11이다
    // 1초마다 타이머를 업데이트합니다.
    setInterval(updateCountdown, 1000);
    const one = 2023
    function updateCountdown(x,y,z) {
      // 현재 시간을 가져옵니다.
      const now = new Date();
      const myDate = new Date(x, y, z); 
      // 타이머에 표시할 남은 시간을 계산합니다.
      const diff = targetDate.getTime() - now.getTime();
      const days = Math.floor(diff / (1000 * 60 * 60 * 24));
      const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    
      // 타이머 엘리먼트에 남은 시간을 업데이트합니다.
      if (diff < 0) {
        // 타이머가 종료되었을 때
        countdownEl.textContent = `D+${Math.abs(days)}`;
        finishTimer();
      } else if (days > 0) {
        // 1일 이상 남았을 때
       
        countdownEl.textContent = `${days}일 ${hours}시간 ${minutes}분`;

      } else {
        // 1일 미만으로 남았을 때
        countdownEl.textContent = `${hours}시간 ${minutes}분`;
      }
    }
    function finishTimer() {
          // 여기에 타이머 종료시 실행할 코드를 작성합니다.
         $.ajax({
                type: "POST",
                url: "/comming_up",
                data: {},
                success: function(chkRs) {
                  if (chkRs == 0) {
                    alert("상품 변경에 실패했습니다.\n다시 시도해 보세요.");
                    return;
                  } else {
                    console.log('상품 변경 성공!');
                    // 버튼 활성화하기
                    var button = document.getElementById("myButton");
                    button.disabled = false;
                    button.addEventListener("click", function() {
                      // 버튼 클릭 이벤트 처리하기
                      console.log("버튼이 클릭되었습니다!");
                      // ...
                    });
                  }
                  location.reload();
                },
                error: function(xhr, status, error) {
                  console.log('Ajax 요청 실패!');
                  console.log(error);
                }
              });
    }
    </script>
    <main>
        <div>
            <div class="Top">
                <div class="img">
                    <img alt="">
                </div>
                <div id="countdown"></div>
            </div>
            
            <div class="Bot">
            <%for(int i = 0; i<commingList.size();i++){ 
            	ProductInfo cl = commingList.get(i);
            %>
                <div class="sun">
                    <div class="img">
                        <img alt="">
                        <p><%=cl.getPi_name() %></p>
                    </div>
                    <div id="countdown"></div>
                </div>
            <%} %>
            </div>
        </div>
    </main>    
<script>

    
<%@ include file="../_inc/inc_foot.jsp"%>