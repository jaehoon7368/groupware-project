<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

                <div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="left-container">
						<div class="container-title"><a href="${pageContext.request.contextPath}/board/boardHome.do" class="container-a">주소록</a></div>
						
							<div class="container-btn">
							<a href="${pageContext.request.contextPath}/board/boardForm.do"><button>연락처 추가</button></a>
							</div>
						
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">전체 주소록</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">전체 주소록</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">개인 주소록</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">test1</a></li>
											<li><a class="container-a" href="#">test2</a></li>
											<li><a href="#">+ 주소록 추가</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">부서 주소록</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">인사부</a></li>
											<li><a class="container-a" href="#">총무부</a></li>
											<li><a href="#">+ 주소록 추가</a></li>
										</ul>
									</div>
								</li>
									
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->