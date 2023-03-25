<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

                <div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
                <!-- 왼쪽 추가 메뉴 -->
                <div class="left-container">
                    <div id="home-left-work" class="div-padding div-margin">
                        <table id="home-work-tbl">
                            <thead>
                                <tr>
                                    <th colspan="2">
                                        <h4 class="text-left font-bold">근태관리</h4>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="year" colspan="2" class="font-14">clock</td>
                                </tr>
                                <tr>
                                    <td colspan="2" id="clock" style="color:black;">clock</td>
                                </tr>
                                <tr>
                                    <td class="font-14 font-bold">업무상태</td>
                                    <td class="text-right font-14" id="work-state">출근전</td>
                                </tr>            
                                <tr>
                                    <td class="font-14 font-bold">출근시간</td>
                                    <td class="text-right font-14" id="startwork-time">미등록</td>
                                </tr>
                                <tr>
                                    <td class="font-14 font-bold">퇴근시간</td>
                                    <td class="text-right font-14" id="endwork-time">미등록</td>
                                </tr>
                                <tr>
                                    <td class="font-14 font-bold">주간 누적 근무시간</td>
                                    <td class="text-right font-14" id="totalwork-time">0h 0m 0s</td>
                                </tr>
                                <tr class="btn-tr">
                                    <td><button class="font-bold" id="btn-startwork">출근하기</button></td>
                                    <td class="text-right"><button class="font-bold" id="btn-endwork">퇴근하기</button></td>
                                </tr>
                            </tbody>
                        </table>
                    
                    </div>
                    <div class="accordion-box">
                        <ul class="container-list">
                            <li>
                                <p class="title font-medium font-bold">근태관리</p>
                                <div class="con">
                                    <ul class="container-detail font-small">
                                        <li><a class="container-a" href="${pageContext.request.contextPath}/emp/empHome.do">내 근태 현황</a></li>
                                        <li><a class="container-a" href="#">내 연차 내역</a></li>
                                        <li><a class="container-a" href="${pageContext.request.contextPath }/emp/empInfo.do">내 인사정보</a></li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <p class="title font-medium font-bold">전사 근태관리</p>
                                <div class="con">
                                    <ul class="container-detail font-small">
                                        <li><a class="container-a" href="#">전사 근태현황</a></li>
                                        <li><a class="container-a" href="#">전사 근태통계</a></li>
                                        <li><a class="container-a" href="#">전사 인사정보</a></li>
                                        <li><a class="container-a" href="#">전사 연차현황</a></li>
                                        <li><a class="container-a" href="#">전사 연차 사용내역</a></li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <p class="title font-medium font-bold a-font"><a href="${pageContext.request.contextPath }/emp/empEnroll.do">인사정보 등록</a></p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- 왼쪽 추가 메뉴 end -->

<script>
window.addEventListener('load', function(){
	
	 getStartAndEndDateOfWeek();
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    
    $.ajax({
 	   url : '${pageContext.request.contextPath}/workingManagement/checkWorkTime.do',
 	   contentType : "application/json; charset=utf-8",
 	   success(data){
 		   console.log(data);
 		   if(data){
 			   const {no,startWork,endWork,overtime,regDate,state,dayWorkTime,empId} = data;
 			   var starttime = new Date(startWork);
 			   var endtime = new Date(endWork);
 			   
 			   //하루 근무시간 계산
 			   const daytime = endtime - starttime;
 			   console.log(daytime);
 			   
 			   const workState = document.querySelector("#work-state");
 			   workState.textContent = state;
 			   
 			   
 			   if(startWork){
 				 var hours = (starttime.getHours()); 
                 var minutes = starttime.getMinutes();
                 var seconds = starttime.getSeconds();
                 var startWorkTime = `\${hours < 10 ? '0' + hours : hours}:\${minutes < 10 ? '0'+minutes : minutes}:\${seconds < 10 ? '0'+seconds : seconds}`;
                 // 출근시간 정보 출력
                 document.querySelector('#startwork-time').textContent = startWorkTime;
 			   }
 			   
 			   if(endWork){
  				  var hours = (endtime.getHours()); 
                  var minutes = endtime.getMinutes();
                  var seconds = endtime.getSeconds();
                  var endWorkTime = `\${hours < 10 ? '0' + hours : hours}:\${minutes < 10 ? '0'+minutes : minutes}:\${seconds < 10 ? '0'+seconds : seconds}`;
                  // 퇴근시간 정보 출력
 				  document.querySelector('#endwork-time').textContent = endWorkTime;
 			   }
 			   
 			   if(daytime > 0){
 				   //하루 근무시간 update
 				  updateDayWorkTime(daytime);
 			   }
 		   }
 	   },
 	   error : console.log
    });
   
});



//출근 버튼 클릭 시
document.querySelector('#btn-startwork').addEventListener('click', function () {
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
	
	$.ajax({
	   url : '${pageContext.request.contextPath}/workingManagement/insertStartWork.do',
	   method : 'POST',
	   headers,
	   contentType : "application/json; charset=utf-8",
	   success(data){

	       if(data.state === "성공"){
	           alert("출근이 성공적으로 등록됬습니다.");
	           location.reload();
	       }
	       else{
	           alert("이미 출근하셨습니다.");
	       }
	   },
	   error : console.log
   });
});

document.querySelector('#btn-endwork').addEventListener('click', function () {
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
	
	$.ajax({
	   url : '${pageContext.request.contextPath}/workingManagement/updateEndWork.do',
	   method : 'POST',
	   headers,
	   contentType : "application/json; charset=utf-8",
	   success(data){
		   console.log(data);
		   
		   if(data.state === "성공"){
	           alert("퇴근이 성공적으로 등록됬습니다.");
	           location.reload();
	       }else if(data.state === '출근전'){
	    	   alert("출근전입니다.");
	    	   return;
	       }
	       else{
	           alert("이미 퇴근하셨습니다.");
	           return;
	       }
		},
	   error : console.log
   });
});

const updateDayWorkTime = (daytime) =>{
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
	
    $.ajax({
        url: '${pageContext.request.contextPath}/workingManagement/updateDayWorkTime.do',
        method: 'POST',
        headers,
        data: {daytime},
        success(data) {
          console.log(data);
          getStartAndEndDateOfWeek();
        },
        error: console.log
      });
	};

//이번주 누적시간 가져오기
function getStartAndEndDateOfWeek() {
	  const today = new Date();
	  const todayDay = today.getDay(); // 오늘 날짜의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)

	  const startDate = new Date(today); // 해당 주의 시작일
	  startDate.setDate(startDate.getDate() - todayDay);

	  const endDate = new Date(today); // 해당 주의 종료일
	  endDate.setDate(endDate.getDate() + (6 - todayDay));

	  const start = startDate.getFullYear() + "." + (startDate.getMonth() + 1) + "." + startDate.getDate();
	  const end = endDate.getFullYear() + "." + (endDate.getMonth() + 1) + "." + endDate.getDate();
	  
	  $.ajax({
		  url : "${pageContext.request.contextPath}/workingManagement/weekTotalTime.do",
		  data : {start, end},
		  contentType : "application/json; charset=utf-8",
		  success(data){
			  console.log(data);
			  const totalWorkTime = document.querySelector("#totalwork-time");
			  const mainTotalWorkTime = document.querySelector("#main-totalwork-time");
			  const mainWorkTime = document.querySelector("#main-work-time");
			  let time = 144000000 - data; // 40시간 - 주간근무시간
			  console.log(chageWorkTime(data));
			  totalWorkTime.textContent = chageWorkTime(data);
			  mainTotalWorkTime.textContent = chageWorkTime(data);
			  mainWorkTime.textContent = chageWorkTime(time);
		  },
		  error : console.log
		  
	  });
}
</script>					
					