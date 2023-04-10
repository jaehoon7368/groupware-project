<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Sign" name="title"/>
	</jsp:include>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sign.css">
	
	<jsp:include page="/WEB-INF/views/sign/signLeftBar.jsp" />
	
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">
								결재&nbsp;
								<c:choose>
									<c:when test="${param.status == 'W'}">대기</c:when>
									<c:when test="${param.status == 'S'}">예정</c:when>
									<c:when test="${param.status == 'C'}">수신</c:when>
								</c:choose>
								&nbsp;문서
							</div>
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
										<button class="my-menu" onclick="location.href = '${pageContext.request.contextPath }/emp/empInfo.do'">기본정보</button>
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
								const style =  modal.style.display;
								
								if (style == 'inline-block') {
									modal.style.display = 'none';
								} else {
									modal.style.display = 'inline-block';
								}
							});
						</script>
						<!-- 상단 타이틀 end -->
						
						<!-- 본문 -->
						<div>
							<!-- 기안 진행 문서 -->
							<div class="div-sign-all">
								<div class="div-sign-all-tbl div-sign-ing-tbl">
									<table class="div-sign-all-tbl-ing">
										<thead>
											<tr>
												<td>기안일</td>
												<td>결재양식</td>
												<td>기안자</td>
												<td>긴급</td>
												<td>결재상태</td>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty mySignStatusList}">
												<tr>
													<td colspan="5">
														결재&nbsp;
														<c:choose>
															<c:when test="${param.status == 'W'}">대기</c:when>
															<c:when test="${param.status == 'S'}">예정</c:when>
															<c:when test="${param.status == 'C'}">수신</c:when>
														</c:choose>
														&nbsp;문서가 없습니다.
													</td>
												</tr>
											</c:if>
											<c:if test="${!empty mySignStatusList}">
												<c:forEach items="${mySignStatusList}" var="sign">
													<tr class="div-sign-all-tbl-tr" data-no="${sign.no}" data-type="${sign.type}">
														<td>${sign.regDate}</td>
														<td>
															<c:choose>
																<c:when test="${sign.type == 'D'}">연차신청서</c:when>
																<c:when test="${sign.type == 'P'}">비품신청서</c:when>
																<c:when test="${sign.type == 'T'}">출장신청서</c:when>
																<c:when test="${sign.type == 'R'}">사직서</c:when>
															</c:choose>
														</td>
														<td>${sign.name}</td>
														<td>
															<c:if test="${sign.emergency == 'Y'}">
																<button type="button" class="small alert button hollow">긴급</button>
															</c:if>
														</td>
														<td class="div-sign-all-tbl-td-btn">
															<c:if test="${sign.signStatusList[0].status == 'W'}">
																<button class="small success button">대기</button>
															</c:if>
															<c:if test="${sign.signStatusList[0].status == 'S'}">
																<button class="small success button">예정</button>
															</c:if>
															<c:if test="${sign.signStatusList[0].status == 'H'}">
																<button class="small warning button">보류</button>
															</c:if>
															<c:if test="${sign.signStatusList[0].status == 'R'}">
																<button class="small warning button">반려</button>
															</c:if>
															<c:if test="${sign.signStatusList[0].status == 'C'}">
																<button class="small secondary button">완료</button>
															</c:if>
														</td>
													</tr>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
							<script>
								window.addEventListener('load', (e) => {
									document.querySelectorAll('.div-sign-all-tbl-td-btn').forEach((btnTd) => {
										if (!btnTd.innerText) {
											btnTd.innerHTML = `
												<button class="small success button">진행중</button>
											`;
										}
									});
								});
							</script>
						</div>
						<script>
							/* tr 클릭 시 상세 페이지 이동 */
							document.querySelectorAll('.div-sign-all-tbl-tr').forEach((tr) => {
								tr.addEventListener('click', (e) => {
									let clickTr = e.target;
                           			
                           			while (true) {
   										if (clickTr.tagName == 'TR') {
   											const no = clickTr.dataset.no;
	                            			
	                            			location.href = '${pageContext.request.contextPath}/sign/signDetail.do?no=' + no + '&type=' + clickTr.dataset.type;
   											break;
   										} else {
   											clickTr = clickTr.parentElement;
   											continue;
   										}
   									}
								});
							});
						</script>
						
						
						<div class="div-paging">
							<ul>
								<c:if test="${startPage > 1}">
									<li class="page-item">
										<a class="page-link" href="${pageContext.request.contextPath}/sign/signStatus.do?status=${param.status}&cpage=${startPage-1}" aria-label="Previous">
											<span aria-hidden="true">&lt;</span>
											<span class="sr-only">Previous</span>
										</a>
									</li>
								</c:if>
								
								<c:forEach var="i" begin="${startPage}" end="${endPage}">
									<li class="page-item ${i==currentPage ? 'active' : ''}">
										<a class="page-link" href="${pageContext.request.contextPath}/sign/signStatus.do?status=${param.status}&cpage=${i}">${i}</a>
									</li>
								</c:forEach>
								
								<c:if test="${endPage < totalPage}">
									<li class="page-item">
										<a class="page-link" href="${pageContext.request.contextPath}/sign/signStatus.do?status=${param.status}&cpage=${endPage+1}" aria-label="Next">
											<span aria-hidden="true">&gt;</span>
											<span class="sr-only">Next</span>
										</a>
									</li>
								</c:if>
							</ul>
						</div>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>