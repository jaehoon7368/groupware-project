<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
									<p class="title font-medium">즐겨찾기</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">Local Policy</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">전사게시판</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="${pageContext.request.contextPath}/board/boardList.do">전사 공지</a></li>
											<li><a class="container-a" href="#">주간 식단표</a></li>
											<li><a class="container-a" href="${pageContext.request.contextPath}/board/openBoardForm.do">IT뉴스</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">부서게시판</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">인사부</a></li>
											<li><a class="container-a" href="#">총무부</a></li>
										</ul>
									</div>
								</li>
								
								<li><a href="${pageContext.request.contextPath}/board/boardAdd.do">+ 게시판 추가</a></li>
									
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->
					
					