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
<c:if test="${not empty msg}">
	<script>
	alert('${msg}');
	</script>	
</c:if>
	<body>

		 <div class="app-dashboard shrink-medium">
        <div class="app-dashboard-body off-canvas-wrapper">
            <!-- 전체 메뉴 바 -->
            <div class="navigation">
                <ul>
                    <li class="list active">
                        <a href="${pageContext.request.contextPath}/home/home.do"  title="홈">
                            <span class="icon">
                                <i class="large fa fa-sharp fa-solid fa-house"></i>
                            </span>
                            <span class="title">홈</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/emp/empHome.do" title="근태관리">
                            <span class="icon">
                                <i class="fa-solid fa-user"></i>
                            </span>
                            <span class="title">근태관리</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/chat/chat.do" title="채팅">
                            <span class="icon">
                                <i class="fa-solid fa-message"></i>
                            </span>
                            <span class="title">채팅</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/mail/mail.do" title="메일">
                            <span class="icon">
                                <i class="large fa fa-solid fa-envelope"></i>
                            </span>
                            <span class="title">메일</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/report/report.do" title="보고">
                            <span class="icon">
                                <i class="large fa fa-solid fa-file"></i>
                            </span>
                            <span class="title">보고</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/todo/todo.do"  title="Todo">
                            <span class="icon">
                                <i class="fa-solid fa-table-list"></i>
                            </span>
                            <span class="title">Todo</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/addr/addrHome.do"  title="주소록">
                            <span class="icon">
                                <i class="large fa fa-solid fa-phone-volume"></i>
                            </span>
                            <span class="title">주소록</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/board/boardHome.do" title="게시판">
                            <span class="icon">
                                <i class="large fa fa-solid fa-list"></i>
                            </span>
                            <span class="title">게시판</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="${pageContext.request.contextPath}/sign/sign.do" title="전자결재">
                            <span class="icon">
                                <i class="large fa fa-solid fa-signature"></i>
                            </span>
                            <span class="title">전자결제</span>
                        </a>
                    </li>
                   
                </ul>
            </div>
            <!-- 전체 메뉴 바 end -->

<script>
function setActiveMenu() {
	  const currentLocation = location.href;
	  const menuItems = document.querySelectorAll('.list');

	  menuItems.forEach(item => {
	    const link = item.querySelector('a');
	    if (link.href === currentLocation) {
	      item.classList.add('active');
	    } else {
	      item.classList.remove('active');
	    }
	  });
	}
	// 페이지가 로드될 때 setActiveMenu 함수 호출
	window.addEventListener('load', setActiveMenu);
</script>