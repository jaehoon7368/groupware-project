<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Mail" name="title"/>
	</jsp:include>

				<div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="home-container left-container">
						<div class="container-title">각자 기능</div>
						<div class="container-btn">
							<button>새로 만들기</button>
						</div>
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">기능별 메뉴1</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">기능별 메뉴2</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">기능별 메뉴3</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">각자 기능</div>
							<div class="home-topbar topbar-div">
								<div>
									<a href="#" id="home-my-img">
										<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" alt="" class="my-img">
									</a>
								</div>
								<div id="my-menu-modal">
									<div class="my-menu-div">
										<button class="my-menu">기본정보</button>
									</div>
									<div class="my-menu-div">
										<button class="my-menu">로그아웃</button>
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
						<div class="div-padding">여기에 본문 내용 작성</div>
					</div>
				</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>