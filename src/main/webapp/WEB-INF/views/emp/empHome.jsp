<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Emp" name="title"/>
	</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/emp.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	
	
	
                <div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title font-bold">내 근태 현황</div>
							<div class="home-topbar topbar-div">
								<div>
									<a href="#" id="home-my-img">
										<c:if test="${!empty sessionScope.loginMember.attachment}">
											<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
										</c:if>
										<c:if test="${empty sessionScope.loginMember.attachment}">
											<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img">
										</c:if>
									</a>
								</div>
								<div id="my-menu-modal">
									<div class="my-menu-div">
										<button class="my-menu">기본정보</button>
									</div>
									<div class="my-menu-div">
										<form:form action="${pageContext.request.contextPath}/emp/empLogout.do" method="POST">
											<button class="my-menu" type="submit">로그아웃</button>								
										</form:form>
									</div>
								</div>
							</div>
						</div>
                    <script>
                        document.querySelector('#home-my-img').addEventListener('click', (e) => {
                            const modal = document.querySelector('#my-menu-modal');
                            const style = modal.style.display;

                            if (style == 'inline-block') {
                                modal.style.display = 'none';
                            } else {
                                modal.style.display = 'inline-block';
                            }
                        });
                    </script>
                    <!-- 상단 타이틀 end -->

                    <!-- 본문 -->
                    <div class="div-padding">
                        <div id="date-box">
                            <h4>
                                <button id="prev-btn"><i class="fa-solid fa-chevron-left"></i></button>
                                <span id="date-text">2023.03</span>
                                <button id="next-btn"><i class="fa-solid fa-chevron-right"></i></button>
                            </h4>
                        </div>

                        <div id="work-week-container">
                            <div id="work-week-time">
                                <div>
                                    <p class="font-14">이번주 누적</p>
                                    <h4 class="main-color" id="main-totalwork-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 초과</p>
                                    <h4 class="main-color" id="main-week-over-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 잔여</p>
                                    <h4 class="main-color" id="main-work-time">40h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번달 누적</p>
                                    <h4 class="color-gray" id="main-month-work-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번달 연장</p>
                                    <h4 class="color-gray" id="main-month-over-time">0h 0m 0s</h4>
                                </div>
                            </div>
                        </div>

                        <div id="work-info-container"></div>

                    </div>
                    <!-- 본문 end -->
                </div>
            </div>
     
	<script>
        window.addEventListener('load',()=>{
                sendData();
        });
        
        let currentDate = new Date();

            function setCurrentDate() {
                const dateText = document.getElementById("date-text");
                const year = currentDate.getFullYear();
                const month = currentDate.getMonth() + 1;
                const monthText = month < 10 ? `0\${month}` : month;
                dateText.textContent = `\${year}.\${monthText}`;
            }

            setCurrentDate();

            document.getElementById("prev-btn").addEventListener("click", () => {
                    currentDate.setMonth(currentDate.getMonth() - 1);
                    setCurrentDate();
                     sendData();
                    
            });

                document.getElementById("next-btn").addEventListener("click", () => {
                    currentDate.setMonth(currentDate.getMonth() + 1);
                    setCurrentDate();
                    sendData();
            });

            // ajax 호출
            function sendData() {
                const dateText = document.getElementById("date-text").textContent;
                const container = document.querySelector("#work-info-container");
                container.innerHTML = "";
                
                 $.ajax({
                    url : '${pageContext.request.contextPath}/workingManagement/selectMonthWork.do',
                    data : {dateText},
                    contentType : "application/json; charset=utf-8",
                    success(data){
                        console.log(data);
                        const {weekDates, workList} = data;
                        console.log(weekDates);
                        console.log(workList);
                        
                        const container = document.querySelector("#work-info-container");
                        
                        const table = document.createElement("table");
                        table.classList.add("table-expand");

                        const tbody = document.createElement("tbody");
						
                        
                        //주간별 정보
                        Object.keys(weekDates).sort().forEach(key  =>{
  
	                        const row1 = document.createElement("tr");
	                        row1.classList.add("table-expand-row");
	                        row1.setAttribute("id","work-container-tr");
	                        row1.dataset.openDetails = "";
	        				row1.dataset.start = weekDates[key].start;
	        				row1.dataset.end = weekDates[key].end;
	        				
	        			
	        				const tbody2 = document.createElement("tbody");
						
	        				row1.onclick = (e) =>{
	        					const start = e.target.parentNode.dataset.start;
	        					const end = e.target.parentNode.dataset.end;
	        					$.ajax({
	        						url : '${pageContext.request.contextPath}/workingManagement/selectWeekDatas.do',
	        						data : {start,end},
	        						success(data){
	        							console.log(data);
	        							
	        							if(tbody2.innerHTML == ""){
		        							data.forEach((datas) =>{
		        								const subTr = document.createElement("tr");
		        								const {dayWorkTime, empId, endWork, no, overtime, regDate, startWork, state} = datas;
		        								const subTd1 = document.createElement("td");
		        								subTd1.textContent = changeRegDate(regDate);
		        								
		        								const subTd2 = document.createElement("td");
		        								subTd2.textContent = changeTimeText(startWork);
		        								
		        								const subTd3 = document.createElement("td");
		        								subTd3.textContent = changeTimeText(endWork);
		        								
		        								const subTd4 = document.createElement("td");
		        								subTd4.classList.add("font-bold");
		        								subTd4.textContent = chageWorkTime(dayWorkTime+overtime);
		        								
		        								const subTd5 = document.createElement("td");
		        								subTd5.textContent = "기본 "+ chageWorkTime(dayWorkTime) + " / 연장 " + chageWorkTime(overtime);
		        								
		        								const subTd6 = document.createElement("td");
		        								if(state == '출장' || state == '연차'){
			        								subTd6.textContent = "완료(" + state + " 8.00h)";
		        								}
		        								else if(state == '반차'){
		        									subTd6.textContent = "완료(" + state + " 4.00h)";
		        								}
		        								else{
		        									subTd6.textContent = "";
		        								}
		        								
		        								subTr.append(subTd1,subTd2,subTd3,subTd4,subTd5,subTd6);
		        								tbody2.append(subTr);
		        							});
	        								
	        							}
	        							
	        						
	        						},
	        						error :console.log
	        					});
	        				};
	
	                        const td1 = document.createElement("td");
	                        td1.classList.add("border-bottom", "font-18");
	                        td1.setAttribute("width", "400");
	                        td1.textContent = key;
	             
	                        const start = weekDates[key].start.substring(5);
	                        const end = weekDates[key].end.substring(5);
	                        const workTime = weekDates[key].workTime;
	                        const workOverTime = weekDates[key].workOverTime;
	                        const span = document.createElement("span");
	                        span.classList.add("font-14","color-gray");
	                        span.textContent = " ( " + start + " ~ " + end + " ) ";
	                        td1.append(span);
	                        
	                        const expandIcon = document.createElement("span");
	                        expandIcon.classList.add("expand-icon");
	                        td1.append(expandIcon);
	
	                        const td2 = document.createElement("td");
	                        td2.classList.add("total-time-info");
	                        td2.textContent = "누적 근무시간 " + chageWorkTime(workTime+workOverTime);
							const span0 = document.createElement("span");
							span0.classList.add("font-12","color-gray");
							span0.textContent = " ( 초과 근무시간 " + chageWorkTime(workOverTime) +" )";
							td2.append(span0);
	                        
	                        const row2 = document.createElement("tr");
	                        row2.classList.add("table-expand-row-content");
	
	                        const td3 = document.createElement("td");
	                        td3.colSpan = 6;
	                        td3.classList.add("table-expand-row-nested");
	
	                        const nestedTable = document.createElement("table");
	                        nestedTable.setAttribute("id", "date-table");
	
	                        const thead = document.createElement("thead");
	
	                        const headerRow = document.createElement("tr");
	
	                        const header1 = document.createElement("th");
	                        header1.setAttribute("width", "50");
	                        header1.textContent = "일자";
	
	                        const header2 = document.createElement("th");
	                        header2.setAttribute("width", "100");
	                        header2.textContent = "업무시작";
	
	                        const header3 = document.createElement("th");
	                        header3.setAttribute("width", "100");
	                        header3.textContent = "업무종료";
	
	                        const header4 = document.createElement("th");
	                        header4.setAttribute("width", "100");
	                        header4.textContent = "총근무시간";
	
	                        const header5 = document.createElement("th");
	                        header5.setAttribute("width", "200");
	                        header5.textContent = "근무시간 상세";
	
	                        const header6 = document.createElement("th");
	                        header6.setAttribute("width", "100");
	                        header6.textContent = "승인요청내역";
	
	                        
	                        headerRow.append(header1,header2,header3,header4,header5,header6);
	                        thead.append(headerRow);
	                        nestedTable.append(thead,tbody2);
	                        td3.append(nestedTable);
	                        row2.append(td3);
	                        row1.append(td1,td2);
	                        tbody.append(row1,row2);
	                        
                        });
                        table.append(tbody);
                        container.append(table);

                    },
                    error:console.log
                }); 
            }
            
document.querySelector("#work-info-container").addEventListener('click',(e)=>{
 
		$('[data-open-details]').click(function (e) {
        	  $(this).next().toggleClass('is-active');
        	  $(this).toggleClass('is-active');
		});
});

// 시간으로 변경
function changeTimeText(time) {
	if(time !== null){
	  const date = new Date(time); // Epoch 시간을 한국 시간으로 변환한 Date 객체 생성
	  
	  const hours = date.getHours().toString().padStart(2, '0'); 
	  const minutes = date.getMinutes().toString().padStart(2, '0'); 
	  const seconds = date.getSeconds().toString().padStart(2, '0'); 
	  
	  return `\${hours}:\${minutes}:\${seconds}`;				
	}
}

// 총근무시간
function chageWorkTime(times){
	const time = times / 1000;
	const hours = Math.floor(time / 3600); // 시간 계산
	const minutes = Math.floor((time % 3600) / 60); // 분 계산
	const seconds = Math.floor(time % 60); // 초 계산
	
	return `\${hours}h \${minutes}m \${seconds}s`;	
}

// regDate날짜 00일 (월)로 변경
function changeRegDate(regDate) {
  const year = regDate[0];
  const month = regDate[1] - 1; // JavaScript의 Date 객체에서 월은 0부터 시작합니다.
  const date = regDate[2];
  
  const dayOfWeekNames = ["일", "월", "화", "수", "목", "금", "토"];
  const dayOfWeekIndex = new Date(year, month, date).getDay(); // 해당 날짜의 요일을 구합니다.
  const dayOfWeek = dayOfWeekNames[dayOfWeekIndex]; // 요일 이름을 배열에서 찾아옵니다.
  
  return `\${date}일 (\${dayOfWeek})`;
}

        	
    </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			