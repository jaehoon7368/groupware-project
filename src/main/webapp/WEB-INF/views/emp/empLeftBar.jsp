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
                                <tr class="btn-tr">
                                    <td colspan="2">
                                        <!-- <button>상태변경(select태그로 변경...)</button> -->
                                        <!-- <select class="form-select" aria-label="Default select example"> -->
                                        <select class="work-select font-bold">
                                            <option selected>상태변경</option>
                                            <option value="1">업무</option>
                                            <option value="2">업무종료</option>
                                            <option value="3">외근</option>
                                            <option value="4">출장</option>
                                            <option value="5">반차</option>
                                        </select>
                                    </td>
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
		   console.log(data.state);

	       if(data.state === "성공"){
	           alert("출근이 성공적으로 등록됬습니다.");
	           
	       }
	       else{
	           alert("이미 출근하셨습니다.");
	       }
	   },
	   error : console.log
   });
});
</script>					
					