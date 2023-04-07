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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empAnnual.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	
			<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title font-bold">내 연차 내역</div>
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
                            <h4 id="yearAnnual"></h4>
                        </div>
                         <div id="insert-Annual-box">
                            <p><a href="${pageContext.request.contextPath}/sign/form/dayOff.do"><span><i class="fa-regular fa-pen-to-square"></i></span> 연차신청</a></p>
                        </div>

                        <div id="annual-container">
                            <div id="annual-info-box">
                                <div id="annual-user-box">
                                    <c:if test="${!empty sessionScope.loginMember.attachment}">
										<p class="font-bold"><span><img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img"></span> ${loginMember.name } <span>${loginMember.jobTitle }</span></p>
									</c:if>
									<c:if test="${empty sessionScope.loginMember.attachment}">
										<p class="font-bold"><span><img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img"></span> ${loginMember.name} <span>${loginMember.jobTitle }</span></p>
									</c:if>
                                </div>
                                <div>
                                    <p class="font-14 font-bold">총연차</p>
                                    <h4 class="main-color">${baseDayOff}</h4>
                                </div>
                                <div>
                                    <p class="font-14 font-bold">사용 연차</p>
                                    <c:if test="${empty dayOffDetail }">
                                    	<h4 class="main-color">0.0</h4>
                                    </c:if>
                                    <c:if test="${!empty dayOffDetail }">
	                                    <h4 class="main-color">${baseDayOff - dayOffDetail.leaveCount}</h4>
                                    </c:if>
                                </div>
                                <div>
                                    <p class="font-14 font-bold">잔여 연차</p>
                                     <c:if test="${empty dayOffDetail }">
                                     	<h4 class="main-color">${baseDayOff}</h4>
                                     </c:if>
                                     <c:if test="${!empty dayOffDetail }">
                                    	<h4 class="main-color">${dayOffDetail.leaveCount}</h4>
                                     </c:if>                                     
                                </div>
                            </div>
                        </div>

                        <div id="search-box">
                            <label for="search-year">연차 사용기간 :</label>
                                <select id="search-year" name="search-year">
                                	<option selected>선택</option>
                                <c:forEach items="${dayOffYear }" var="year">
                                    <option value="${year.dayOffYear }">${year.dayOffYear }</option>
                                </c:forEach>
                                </select>
                        </div>

                        <div id="annual-detail-box">
                           <p>사용내역</p>
                           <div>
                                <table id="annual-detail-table">
                                    <thead>
                                        <tr>
                                            <th width="100">이름</th>
                                            <th width="100">부서명</th>
                                            <th width="100">휴가 종류</th>
                                            <th width="200">연차 사용기간</th>
                                            <th width="100">사용 연차</th>
                                            <th width="300">내용</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:if test="${empty dayoffList }">
                                    		<tr>
	                                    		<td colspan="6">조회된 내역이 없습니다.</td>
                                    		</tr>
                                    	</c:if>
                                    	<c:if test="${!empty dayoffList }">
	                                    	<c:forEach items="${ dayoffList}" var="day">
		                                        <tr>
		                                            <td width="100">${loginMember.name}</td>
		                                            <td width="100">${loginMember.deptTitle} </td>
		                                            <c:if test='${day.type == "D" }'>
			                                            <td width="100">연차</td>
		                                            </c:if>
		                                            <c:if test='${day.type == "H" }'>
			                                            <td width="100">반차</td>
		                                            </c:if>
		                                            <td width="200">${day.startDate} ~ ${day.endDate }</td>
		                                            <td width="100">${day.count }</td>
		                                            <td width="300">${day.content }</td>
		                                        </tr>
	                                       </c:forEach>
                                    	</c:if>
                        
                                    </tbody>
                                </table>
                           </div>
                        </div>


                    </div>
                    <!-- 본문 end -->
                </div>
            </div>
<form name="selectYearFrm" action="${pageContext.request.contextPath}/emp/selectAnnualYear.do" method="GET">
	<input type="hidden" name="year"/>
</form>
<script>
document.querySelector("#search-year").addEventListener('change', (e) => {
		const yearAnnual = e.target;
		console.log(yearAnnual.value);
		
		const frm = document.selectYearFrm;
		frm.year.value = yearAnnual.value;
		frm.submit(); 
		
});

var yearNow = document.getElementById("yearAnnual");
        function clock() {
            var time = new Date();

            var year = time.getFullYear();
            var month = time.getMonth();
            var date = time.getDate();
           
           yearNow.innerHTML = `\${year}.\${month + 1}.\${date}`;
                
        }
 clock();
 



</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			