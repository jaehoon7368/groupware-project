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
						<div class="container-title"><a href="${pageContext.request.contextPath}/report/report.do" class="container-a">보 고</a></div>
						<div class="container-btn">
							<button onclick="location.href='${pageContext.request.contextPath}/report/reportCreateView.do';">새로 만들기</button>
						</div>
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">부서별 보고서</p>
									<div class="con">
										<ul class="container-detail font-small">
											<c:forEach items="${sessionScope.deptList}" var="dept">
												<li><a class="container-a" href="${pageContext.request.contextPath}/report/reportDeptView.do?code=${dept.deptCode}">${dept.deptTitle}</a></li>
											</c:forEach>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">그 외 보고서</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->
					
					