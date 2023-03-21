<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html class="no-js" lang="en" dir="ltr">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="x-ua-compatible" content="ie=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>${param.title}</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/foundation.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
		<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/foundation-icons/foundation-icons.css"> --%>
		
		<script src="https://kit.fontawesome.com/cbe4aa3844.js" crossorigin="anonymous"></script>
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
	</head>
	<body>
		<div class="app-dashboard shrink-medium">
			<div class="app-dashboard-body off-canvas-wrapper">
			    <!-- 전체 메뉴 바 -->
			    <div id="app-dashboard-sidebar" class="app-dashboard-sidebar position-left off-canvas off-canvas-absolute reveal-for-medium" data-off-canvas>
					<div class="app-dashboard-sidebar-title-area">
						<div class="app-dashboard-close-sidebar">
							<h3 class="app-dashboard-sidebar-block-title">Anywhere</h3>
							<!-- Close button -->
							<button id="close-sidebar" data-app-dashboard-toggle-shrink class="app-dashboard-sidebar-close-button show-for-medium" aria-label="Close menu" type="button">
								<span aria-hidden="true"><a href="#"><i class="large fa fa-angle-double-left"></i></a></span>
							</button>
			        	</div>
				        <div class="app-dashboard-open-sidebar">
							<button id="open-sidebar" data-app-dashboard-toggle-shrink class="app-dashboard-open-sidebar-button show-for-medium" aria-label="open menu" type="button">
								<span aria-hidden="true"><a href="#"><i class="large fa fa-angle-double-right"></i></a></span>
							</button>
				        </div>
					</div>
					<div class="nav-font-size app-dashboard-sidebar-inner">
						<ul class="menu vertical">
							<li>
								<a href="${pageContext.request.contextPath}/home/home.do" class="is-active" title="홈">
									<i class="large fa fa-sharp fa-solid fa-house"></i>
									<span class="app-dashboard-sidebar-text">홈</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/mail/mail.do" class="is-active" title="메일">
									<i class="large fa fa-solid fa-envelope"></i>
									<span class="app-dashboard-sidebar-text">메일</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/report/report.do" class="is-active" title="보고">
									<i class="large fa fa-solid fa-file"></i>
									<span class="app-dashboard-sidebar-text">보고</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/reservation/reservation.do" class="is-active" title="예약">
									<i class="large fa fa-solid fa-check-to-slot"></i>
									<span class="app-dashboard-sidebar-text">예약</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/todo/todo.do" class="is-active" title="Todo">
									<i class="large fa fa-solid fa-list-ol"></i>
									<span class="app-dashboard-sidebar-text">Todo</span>
								</a>
							</li>
							<li>
								<a href="#" class="is-active" title="주소록">
									<i class="large fa fa-solid fa-phone-volume"></i>
									<span class="app-dashboard-sidebar-text">주소록</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/board/boardHome.do" class="is-active" title="게시판">
									<i class="large fa fa-solid fa-list"></i>
									<span class="app-dashboard-sidebar-text">게시판</span>
								</a>
							</li>
							<li>
								<a href="#" class="is-active" title="캘린더">
									<i class="large fa fa-solid fa-calendar-days"></i>
									<span class="app-dashboard-sidebar-text">캘린더</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/sign/sign.do" class="is-active" title="전자결재">
									<i class="large fa fa-solid fa-signature"></i>
									<span class="app-dashboard-sidebar-text">전자결재</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/emp/empHome.do" class="is-active" title="근태관리">
									<i class="large fa fa-solid fa-briefcase"></i>
									<span class="app-dashboard-sidebar-text">근태관리</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- 전체 메뉴 바 end -->
		    