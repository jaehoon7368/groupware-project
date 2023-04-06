<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
                                    <td class="text-right font-14 color-red font-bold" id="work-state">출근전</td>
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
                                        <li><a class="container-a" href="${pageContext.request.contextPath}/emp/empAnnual.do">내 연차 내역</a></li>
                                        <li><a class="container-a" href="${pageContext.request.contextPath }/emp/empInfo.do">내 인사정보</a></li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <p class="title font-medium font-bold">부서 근태현황</p>
                                <div class="con">
                                    <ul class="container-detail font-small">
                                    	<sec:authorize access="hasRole('ROLE_PERSONNEL')">
	                                    	<c:forEach items="${sessionScope.deptList}" var="dept">
												<li><a class="container-a" href="${pageContext.request.contextPath}/workingManagement/empDeptView.do?code=${dept.deptCode}">${dept.deptTitle}</a></li>
											</c:forEach>
										</sec:authorize>
										<sec:authorize access="!hasRole('ROLE_PERSONNEL')">
												<li><a class="container-a" href="${pageContext.request.contextPath}/workingManagement/empDeptView.do?code=${sessionScope.loginMember.deptCode}">${sessionScope.loginMember.deptTitle}</a></li>
										</sec:authorize>
                                    </ul>
                                </div>
                            </li>
                             <sec:authorize access="hasRole('ROLE_PERSONNEL')">
                            <li>
                                <p class="title font-medium font-bold a-font"><a class=" color-black" href="${pageContext.request.contextPath }/emp/empEnroll.do">인사정보 등록</a></p>
                            </li>
                            <li>
                                <p class="title font-medium font-bold a-font"><a class=" color-black" href="${pageContext.request.contextPath }/emp/empAllInfo.do">전사 인사정보</a></p>
                            </li>
                            </sec:authorize>
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
 			   const daytimes = endtime - starttime;
 			   console.log(daytimes);
 			   
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
 			   
 			   if(daytimes > 0){
 				   //하루 근무시간 update
 				  updateDayWorkTime(daytimes);
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
			console.log(data);
	       if(data.state === "성공"){
	           alert("출근이 성공적으로 등록됬습니다.");
	           location.reload();
	       }else if(data.state === '출장'){
	    	   alert("출장시에는 자동적으로 출근처리가 완료됩니다.");
	    	  return;
	       }else if(data.state === '연차'){
	    	   alert("연차중입니다.");
	    	   return;
	       }
	       else{
	           alert("이미 출근하셨습니다.");
	       }
	   },
	   error : console.log
   });
});

//퇴근하기 버튼 누를시
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
	       }else if(data.state === '출장'){
	    	   alert("출장시에는 자동적으로 퇴근처리가 완료됩니다.");
	    	  return;
	       }else if(data.state === '연차'){
	    	   alert("연차중입니다.");
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

const updateDayWorkTime = (daytimes) =>{
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
	
    $.ajax({
        url: '${pageContext.request.contextPath}/workingManagement/updateDayWorkTime.do',
        method: 'POST',
        headers,
        data: {daytimes},
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
			  const {totalMonthOverTime ,totalMonthTime, weekOverTime ,weekTotalTime} = data;
			  const totalWorkTime = document.querySelector("#totalwork-time");
			  const mainTotalWorkTime = document.querySelector("#main-totalwork-time");
			  const mainWeekOverTime = document.querySelector("#main-week-over-time");
			  const mainWorkTime = document.querySelector("#main-work-time");
			  const monthWorkTime = document.querySelector("#main-month-work-time");
			  const monthOverTime = document.querySelector("#main-month-over-time")
			  
			  let times = 144000000 - (weekTotalTime + weekOverTime); // 40시간 - 주간 기본 근무시간
			  totalWorkTime.textContent = chageWorkTime(weekTotalTime + weekOverTime);
			  mainTotalWorkTime.textContent = chageWorkTime(weekTotalTime + weekOverTime);
			  mainWeekOverTime.textContent = chageWorkTime(weekOverTime);
			  mainWorkTime.textContent = chageWorkTime(times);
			  monthWorkTime.textContent = chageWorkTime(totalMonthTime + totalMonthOverTime);
			  monthOverTime.textContent = chageWorkTime(totalMonthOverTime);
		  },
		  error : console.log
		  
	  });
}

</script>					
					