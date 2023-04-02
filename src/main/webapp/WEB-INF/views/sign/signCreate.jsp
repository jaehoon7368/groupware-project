<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

					<div class="font-small home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">${param.title}</div>
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
						<div class="top-container">
							<div class="div-sign-btn font-small">
								<button onclick="signCreate();">결재요청</button>
								<button onclick="location.href='${pageContext.request.contextPath}/sign/sign.do';">취소</button>
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
						
						<!-- 결재 문서 -->
						<div class="div-sign-form">
							<div class="div-sign-form-detail">
								<table class="sign-tbl">
									<tbody>
										<tr>
											<td colspan="2" class="sign-tbl-title font-large">
												${param.title}
											</td>
										</tr>
										<tr>
											<td class="sign-tbl-left">
												<table class="sign-tbl-left-tbl">
													<tbody>
														<tr>
															<td class="sign-tbl-left-title">
																기안자
															</td>
															<td class="sign-tbl-left-content">
																<span>${sessionScope.loginMember.name}</span>
															</td>
														</tr>
														<tr>
															<td class="sign-tbl-left-title">
																기안부서
															</td>
															<td class="sign-tbl-left-content">
																<span>${sessionScope.loginMember.deptTitle}</span>
															</td>
														</tr>
														<tr>
															<td class="sign-tbl-left-title">
																기안일
															</td>
															<td class="sign-tbl-left-content">
																<span>
																	<c:set var="now" value="<%= new Date() %>" />
																	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd (E)" />
																</span>
															</td>
														</tr>
														<tr>
															<td class="sign-tbl-left-title">
																문서번호
															</td>
															<td class="sign-tbl-left-content">
																<span></span>
															</td>
														</tr>
													</tbody>
												</table>
				