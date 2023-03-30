<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Report" name="title"/>
	</jsp:include>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/report.css">
	
	<jsp:include page="/WEB-INF/views/report/reportLeftBar.jsp" />
	
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">보 고</div>
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
							<div class="div-padding div-report-ing">
								<c:forEach items="${reportList}" var="report">
									<c:if test="${report.createYn == 'N'}">
										<div class="div-report" data-no="${report.reportNo}">
											<div class="div-report-tbl">
												<table class="font-small">
		                                            <colgroup>
		                                                <col width="35%" />
		                                                <col width="65%" />
		                                            </colgroup>
													<tbody>
														<tr>
															<td colspan="2" class="report-year">
																<fmt:parseDate value="${report.endDate}" pattern="yyyy-MM-dd" var="endYear" />
																<fmt:formatDate value="${endYear}" pattern="yyyy" />
															</td>
														</tr>
														<tr>
															<td colspan="2" class="report-day">
																<fmt:parseDate value="${report.endDate}" pattern="yyyy-MM-dd" var="endDate" />
																<fmt:formatDate value="${endDate}" pattern="MM/dd(E)" />
															</td>
														</tr>
														<tr>
															<td colspan="2" class="report-title">${report.title}</td>
														</tr>
														<tr>
															<td>부서</td>
															<td>${report.deptTitle}</td>
														</tr>
														<tr>
															<td>보고현황</td>
															<td title="보고자 ${report.createCount}명 (미보고자 ${report.noCreateCount}명)">보고자 ${report.createCount}명 (미보고자 ${report.noCreateCount}명)</td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="div-report-btn">
												<button class="report-btn" type="button">보고하기</button>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<script>
								document.querySelectorAll('.div-report').forEach((report) => {
									report.addEventListener('click', (e) => {
										console.log(e.target);
										let data = e.target;
										
										while (true) {
											if (data.tagName === 'DIV' && data.classList[0] === 'div-report') {
												console.log(data.tagName);
												console.log(data.classList[0]);
												console.log(data);
												location.href = `${pageContext.request.contextPath}/report/reportDetail.do?no=\${data.dataset.no}`;
												break;
											} else {
												data = data.parentElement;
												continue;
											}
										}
									});
								});
							</script>

                            <div>
                                <div class="div-report-list">
                                    <div class="container-title">최근 생성된 보고서</div>
                                    <div class="report-list-tbl">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>부서</th>
                                                    <th>제목</th>
                                                    <th>보고자</th>
                                                    <th>보고마감일</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach items="${reportList}" var="report">
                                            		<c:if test="${report.createYn == 'Y'}">
	                                            		<tr class="report-tr" onclick="detailReport('${report.reportNo}');">
	                                            			<td>${report.deptTitle}</td>
	                                            			<td>${report.title}</td>
	                                            			<td>${report.empName}</td>
	                                            			<td>${report.endDate}</td>
	                                            		</tr>
                                            		</c:if>
                                            	</c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <script>
                            	const detailReport = (no) => {
                            		console.log(no);
                            		location.href = `${pageContext.request.contextPath}/report/reportDetail.do?no=\${no}`;
                            	};
                            </script>
                            
						</div>
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>