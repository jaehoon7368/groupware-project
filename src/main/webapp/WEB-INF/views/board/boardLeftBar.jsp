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
						<div class="container-title"><a href="${pageContext.request.contextPath}/board/boardHome.do" class="container-a">게시판</a></div>
						
							<div class="container-btn">
							<a href="${pageContext.request.contextPath}/board/boardForm.do"><button>글쓰기</button></a>
							</div>
						
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">전사 게시판</p>
									<div class="con">
										<ul class="container-detail font-small">
											<c:forEach items="${boardTypeList}" var="boardType">
												<c:if test="${boardType.no >= 1 and boardType.no <= 6}">
													<li><a class="container-a" href="${pageContext.request.contextPath}/board/boardTypeList.do?no=${boardType.no}&category=${boardType.category}">${boardType.title}</a></li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">부서 게시판</p>
									<div class="con">
										<ul class="container-detail font-small">
											<c:forEach items="${boardTypeList}" var="boardType">
											    <c:if test="${boardType.no >= 7 and boardType.no <= 11
											     and sessionScope.loginMember.deptTitle eq boardType.title}"> 
											        <li><a class="container-a" href="${pageContext.request.contextPath}/board/boardTypeList.do?no=${boardType.no}&category=${boardType.category}">${boardType.title}</a></li>
											    </c:if>
											</c:forEach>
										</ul>
									</div>
								</li>
								
								<div class="div-padding"></div>
								<li><a href="${pageContext.request.contextPath}/board/boardAdd.do">+ 게시판 추가</a></li>
									
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->