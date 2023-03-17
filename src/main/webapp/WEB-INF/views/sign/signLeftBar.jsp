<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

                <div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="left-container">
						<div class="container-title"><a href="${pageContext.request.contextPath}/sign/sign.do" class="container-a">전자결재</a></div>
						<!-- 
						<div class="container-btn">
							<button onclick="location.href='${pageContext.request.contextPath}/sign/signCreate.do';">새로 만들기</button>
						</div>
						-->
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">결재 양식</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="${pageContext.request.contextPath}/sign/form/dayOff.do">연차신청서</a></li>
											<li><a class="container-a" href="${pageContext.request.contextPath}/sign/form/product.do">비품신청서</a></li>
											<li><a class="container-a" href="${pageContext.request.contextPath}/sign/form/trip.do">출장신청서</a></li>
											<li><a class="container-a" href="${pageContext.request.contextPath}/sign/form/resignation.do">사직서</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">결재하기</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">결재 예정 문서</a></li>
											<li><a class="container-a" href="#">결재 대기 문서</a></li>
											<li><a class="container-a" href="#">결재 수신 문서</a></li>
											<li><a class="container-a" href="#">참조/열람 대기 문서</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->
					
					