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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empDept.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	
			<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title font-bold">부서 근태 현황</div>
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
										<button class="my-menu">로그아웃</button>
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

                        <div id="search-box">
                            <label for="search-year">검색조건 :</label>
                                <select id="search-year" name="search-year">
                                    <option value="1">2023</option>
                                    <option value="2">2022</option>
                                    <option value="3">2021</option>
                                </select>
                        </div>

                        <div>
                         
                           <div>
                                <table id="dept-detail-table">
                                	<thead>
	                                	<tr id="dept-detail-tr"></tr>
                                	</thead>
                                	<tbody id="dept-detail-tbody"></tbody>
                                </table>
                           </div>
                        </div>                       
                    </div>
                    <!-- 본문 end -->
                </div>
            </div>

<script>
window.addEventListener('load',()=>{
     deptSendData();
});

let date = new Date();

function setCurrentDate() {
    const dateText = document.getElementById("date-text");
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const monthText = month < 10 ? `0\${month}` : month;
    dateText.textContent = `\${year}.\${monthText}`;
}

setCurrentDate();

document.getElementById("prev-btn").addEventListener("click", () => {
		date.setMonth(date.getMonth() - 1);
        setCurrentDate();
        deptSendData();
        
});

    document.getElementById("next-btn").addEventListener("click", () => {
    	date.setMonth(date.getMonth() + 1);
        setCurrentDate();
        deptSendData();
});
    
function deptSendData(){
	const dateText = document.getElementById("date-text").textContent;
	const deptCode = "${deptCode}";
	const deptTr = document.querySelector("#dept-detail-tr");
	deptTr.innerHTML = "";
	const tbody = document.querySelector("#dept-detail-tbody");
	tbody.innerHTML = "";
	
	
	
	$.ajax({
		url : '${pageContext.request.contextPath}/workingManagement/selectDeptWork.do',
		data : {dateText, deptCode},
		success(data){
			console.log(data);
			console.log(data[0]);
			
			// thead 동적태그 넣기
			const th1 = document.createElement("th");
			th1.setAttribute("width", "100");
            th1.textContent = "이름";
            
            const th2 = document.createElement("th");
			th2.setAttribute("width", "100");
            th2.textContent = "누적근무시간";
            
            deptTr.append(th1,th2);
           	
           	const weekDates = data[0].weekDates;
            weekDates.sort((a, b) => {
      		  // 주차 문자열에서 '주차' 부분을 제외한 정수만 추출하여 비교
      		  const weekA = parseInt(a.week.replace(/[^0-9]/g, ''));
      		  const weekB = parseInt(b.week.replace(/[^0-9]/g, ''));
      		  return weekA - weekB;
      		});
            
           	console.log(data[0].weekDates);
            for(let i = 0; i < weekDates.length;i++){
            	const start = weekDates[i].start.substring(5);
            	const end = weekDates[i].end.substring(5);
            	
		    	const th3 = document.createElement("th");
		    	th3.setAttribute("width", "100");
		    	const pp1 = document.createElement("p");
		    	pp1.classList.add("margin-buttom0");
		    	pp1.textContent = `\${i+1}주차`;
		    	const pp2 = document.createElement("p");
		    	pp2.classList.add("font-11","color-gray");
		    	pp2.textContent = " ( " + start + " ~ " + end + " ) ";
		    	th3.append(pp1,pp2);
		    	deptTr.append(th3);
            }
            
         // thead 동적태그 넣기 end
         
         // tbody 동적테그 넣기
         
         data.forEach((work)=>{
        	const {name, deptTitle, jobTitle, profile, monthWorkTime, monthOverTime, weekDates } = work;
        	console.log(weekDates);
        	
        	const tr2 = document.createElement("tr");
        	const td1 = document.createElement("td");
        	td1.setAttribute("width","100");
        	
        	const p = document.createElement('p');
        	p.setAttribute("id","dept-name");
        	p.classList.add('font-bold');
        	p.textContent = name + " " + jobTitle;
        	const span = document.createElement('span');
        	const img = document.createElement('img');
        	img.setAttribute('src', `${pageContext.request.contextPath}/resources/upload/emp/\${profile}`);
        	img.classList.add('my-img');
        	span.append(img);
        	p.append(span);
        	td1.append(p);
        	
        	const td2 = document.createElement("td");
        	td2.setAttribute("width","100");
        	
        	const p1 = document.createElement("p");
        	p1.classList.add("font-14","font-bold");
        	p1.textContent = chageWorkTime(monthWorkTime + monthOverTime);
        	
        	const p2 = document.createElement("p");
        	p2.classList.add("font-12","color-gray","font-bold");
        	p2.textContent = "기본:"+chageWorkTime(monthWorkTime);
        	
        	const p3 = document.createElement("p");
        	p3.classList.add("font-12","color-gray","font-bold");
        	p3.textContent = "연장:"+chageWorkTime(monthOverTime);
        	
        	td2.append(p1,p2,p3);
        	tr2.append(td1,td2);
        	
        	//주차 순서대로 정렬
        	weekDates.sort((a, b) => {
        		  // 주차 문자열에서 '주차' 부분을 제외한 정수만 추출하여 비교
        		  const weekA = parseInt(a.week.replace(/[^0-9]/g, ''));
        		  const weekB = parseInt(b.week.replace(/[^0-9]/g, ''));
        		  return weekA - weekB;
        	});
        	
        	Object.keys(weekDates).sort().forEach(key  =>{
        		const workTime = weekDates[key].workTime;
        		const overTime = weekDates[key].overTime;
        		
        		const td3 = document.createElement("td");
            	td3.setAttribute("width","100");
            	
            	const p4 = document.createElement("p");
            	p4.classList.add("font-14","font-bold");
            	p4.textContent = chageWorkTime(workTime + overTime);
            	
            	const p5 = document.createElement("p");
            	p5.classList.add("font-12","color-gray","font-bold");
            	p5.textContent = "기본:"+chageWorkTime(workTime);
            	
            	const p6 = document.createElement("p");
            	p6.classList.add("font-12","color-gray","font-bold");
            	p6.textContent = "연장:"+chageWorkTime(overTime);
            	
            	td3.append(p4,p5,p6);
            	tr2.append(td3);
        		
        	});
        	tbody.append(tr2);
        	
        	
        	
         });
      	 // tbody 동적테그 넣기 end   
            
		},
		error : console.log
	});
}

//총근무시간
function chageWorkTime(times){
	const time = times / 1000;
	const hours = Math.floor(time / 3600); // 시간 계산
	const minutes = Math.floor((time % 3600) / 60); // 분 계산
	const seconds = Math.floor(time % 60); // 초 계산
	
	return `\${hours}h \${minutes}m \${seconds}s`;	
}
    
</script>

<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>