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
							<div class="container-title">
								<c:choose>
									<c:when test="${param.type == 'else'}">그 외</c:when>
									<c:when test="${param.type == 'refer'}">참조</c:when>
									<c:when test="${param.type == 'my'}">내가 생성한</c:when>
								</c:choose>
								&nbsp;보고서
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
                            <div>
                                <div class="div-report-list">
                                    <div class="report-list-tbl">
                                        <table>
                                        	<colgroup>
                                                <col width="20%" />
                                                <col width="35%" />
                                                <col width="15%" />
                                                <col width="15%" />
                                                <col width="15%" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>제목</th>
                                                   	<th>보고 설명</th>
                                                    <th>보고 생성자</th>
                                                    <th>보고 생성일</th>
                                                    <th>보고 마감일</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:if test="${empty myReportList}">
                                           			<tr>
                                           				<td colspan="5">
                                           					<c:choose>
																<c:when test="${param.type == 'else'}">그 외</c:when>
																<c:when test="${param.type == 'refer'}">참조 가능한</c:when>
																<c:when test="${param.type == 'my'}">내가 생성한</c:when>
															</c:choose>
															&nbsp;보고가 없습니다.
                                           				</td>
                                           			</tr>
                                            	</c:if>
                                            	<c:if test="${!empty myReportList}">
	                                            	<c:forEach items="${myReportList}" var="report" varStatus="vs">
	                                            		<c:if test="${vs.index < 5}">
		                                            		<tr class="report-tr" data-no="${report.no}">
		                                            			<td>${report.title}</td>
		                                            			<td>${report.explain}</td>
		                                            			<td>${report.writer}</td>
		                                            			<td>${report.regDate}</td>
		                                            			<td>${report.endDate}</td>
		                                            		</tr>
		                                            	</c:if>
	                                            	</c:forEach>
                                            	</c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <script>
                            	document.querySelectorAll('.report-tr').forEach((tr) => {
                            		tr.addEventListener('click', (e) => {
                            			let clickTr = e.target;
                            			
                            			while (true) {
    										if (clickTr.tagName == 'TR') {
		                            			location.href = '${pageContext.request.contextPath}/report/reportDetail.do?no=' + clickTr.dataset.no;
    											break;
    										} else {
    											clickTr = clickTr.parentElement;
    											continue;
    										}
    									}
                            		});
                            	});
                            </script>
						</div>
						
						
						<div class="div-paging">
							<ul>
								<c:if test="${startPage > 1}">
									<li class="page-item">
										<a class="page-link" href="${pageContext.request.contextPath}/report/reportDeptView.do?code=${sessionScope.loginMember.deptCode}&cpage=${startPage-1}" aria-label="Previous">
											<span aria-hidden="true">&lt;</span>
											<span class="sr-only">Previous</span>
										</a>
									</li>
								</c:if>
								
								<c:forEach var="i" begin="${startPage}" end="${endPage}">
									<li class="page-item ${i==currentPage ? 'active' : ''}">
										<a class="page-link" href="${pageContext.request.contextPath}/report/reportDeptView.do?code=${sessionScope.loginMember.deptCode}&cpage=${i}">${i}</a>
									</li>
								</c:forEach>
								
								<c:if test="${endPage < totalPage}">
									<li class="page-item">
										<a class="page-link" href="${pageContext.request.contextPath}/report/reportDeptView.do?code=${sessionScope.loginMember.deptCode}&cpage=${endPage+1}" aria-label="Next">
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