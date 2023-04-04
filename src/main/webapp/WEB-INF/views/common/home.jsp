<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Anywhere" name="title"/>
	</jsp:include>

				<div class="app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 상단 타이틀 -->
					<div class="home-topbar topbar-div">
						<div></div>
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
				
						<div id="home-my-menu-modal">
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
					<script>
						document.querySelector('#home-my-img').addEventListener('click', (e) => {
							const modal = document.querySelector('#home-my-menu-modal');
							const style =  modal.style.display;
							
							if (style == 'inline-block') {
								modal.style.display = 'none';
							} else {
								modal.style.display = 'inline-block';
							}
						});
					</script>
					<!-- 상단 타이틀 end -->
    
					
					<div class="home-content">
						<!-- 본문 왼쪽 -->
						<div>
							<div id="home-left" class="div-padding div-margin">
								<table id="home-my-tbl">
									<tbody>
										<tr>
											<td colspan="2">
												<c:if test="${!empty sessionScope.loginMember.attachment}">
													<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="img">
												</c:if>
												<c:if test="${empty sessionScope.loginMember.attachment}">
													<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="img">
												</c:if>
											</td>
										</tr>
										<tr>
											<td colspan="2">${sessionScope.loginMember.name} ${sessionScope.loginMember.jobTitle}</td>
										</tr>
										<tr>
											<td colspan="2">${sessionScope.loginMember.deptTitle}</td>
										</tr>
										<tr>
											<td>오늘 온 메일</td>
											<td>dd</td>
										</tr>
										<tr>
											<td>오늘 온 일정</td>
											<td>dd</td>
										</tr>
									</tbody>
								</table>
							</div>
							
							<div id="home-left" class="div-padding div-margin">
                        <table id="home-work-tbl">
                            <thead>
                                <tr>
                                    <th colspan="2">
                                        <h4 class="font-bold">근태관리</h4>
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
                                <tr class="btn-tr">
                                    <td><button class="font-bold" id="btn-startwork">출근하기</button></td>
                                    <td class="text-right"><button class="font-bold" id="btn-endwork">퇴근하기</button></td>
                                </tr>
                            </tbody>
                        </table>
                    
                    </div>
						</div>

						<!-- 본문 가운데 -->
						<div>
							<div id="home-center" class="div-padding div-margin">
								<h5>전사게시판</h5>
								<div id="board-div" class="home-div">
									<button class="btn-board-title" onclick="styleChange(this);">ㅇㅇ</button>
									<button class="btn-board-title" onclick="styleChange(this);">ㄱㄱ</button>
									<button class="btn-board-title" onclick="styleChange(this);">ㅊㅊ</button>
									<button class="btn-board-title" onclick="styleChange(this);">ㄹㄹ</button>
								</div>
							</div>
							<script>
								const styleChange = (btn) => {
									document.querySelectorAll('#board-div .btn-board-title').forEach((btn) => {
										btn.style.borderBottom = 'none';
									});
									
									btn.style.borderBottom = 'solid 2px #000';
								};
							</script>
						
							<div id="home-center" class="div-padding div-margin">
								<h5>결재 대기 문서</h5>
								<table id="sign-tbl">
									<thead>
										<tr>
											<th>기안일</th>
											<th>결재양식</th>
											<th>긴급</th>
											<th>제목</th>
											<th>첨부</th>
											<th>결재상태</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							
							<div id="home-center" class="div-padding div-margin">
								<h5>메일함</h5>
								<div id="mail-div" class="home-div">
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㅇㅇ</button>
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㄱㄱ</button>
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㅊㅊ</button>
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㄹㄹ</button>
								</div>
							</div>
							<script>
								const mailStyleChange = (btn) => {
									document.querySelectorAll('#mail-div .btn-board-title').forEach((btn) => {
										btn.style.borderBottom = 'none';
									});
									btn.style.borderBottom = 'solid 2px #000';
								};
							</script>
						</div>
						
						<!-- 본문 오른쪽 -->
						<div>
							<div id="home-right" class="div-padding div-margin">
								<h5 style="padding:20px">최근 알림</h5>
								
								<c:forEach items ="${reNotis }" var="reNoti" varStatus="vs">
								<c:if test="${vs.index <4}">

									<c:choose>
										<c:when test="${fn:contains(reNoti.pkNo,'tdb') }">
											<c:set var="notiType" value="할일게시판"/>
										</c:when>
										<c:when test="${fn:contains(reNoti.pkNo,'r') }">
											<c:set var="notiType" value="보고서"/>
										</c:when>
										<c:when test="${fn:contains(reNoti.pkNo,'bo') }">
											<c:set var="notiType" value="게시판"/>
										</c:when>
										<c:when test="${fn:contains(reNoti.pkNo,'s') }">
											<c:set var="notiType" value="전자결재"/>
										</c:when>
									</c:choose>	
									<div class="notification-list">
		        						<div class="left-noti">
		        							<img src="${pageContext.request.contextPath }/resources/upload/emp/${reNoti.attachment.renameFilename}" alt="" class="my-img">
		        						</div>
						            	<div class="right-noti">
						               		<p> [<span class="noti-type-span">${notiType}등록</span>] '${reNoti.emp.name}' ${reNoti.emp.jobTitle }님 (이)가 <br />'${notiType}'를 등록하였습니다.</p>
  											<p><span class="noti-time-span"> 
  											<fmt:parseDate value="${reNoti.regDate }" var="regDate" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd" />
  											</span><span> </span></p>
				          				</div>
				       				</div>
				       				</c:if>
								</c:forEach>
											
							</div>
							<div id="home-right" class="div-padding div-margin">
								<h5>보고</h5>
							</div>
						</div>
					</div>
				</div>

<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>