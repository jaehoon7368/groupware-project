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
		    
                <div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="home-container left-container">
						<div class="container-title">보 고</div>
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
							<div class="container-title">보 고</div>
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
						<div>
							<div class="div-padding">
								<div class="div-report">
									<div class="div-report-tbl">
										<table class="font-small">
                                            <colgroup>
                                                <col width="35%" />
                                                <col width="65%" />
                                            </colgroup>
											<tbody>
												<tr>
													<td colspan="2" class="report-year">2023</td>
												</tr>
												<tr>
													<td colspan="2" class="report-day">02/15(수)</td>
												</tr>
												<tr>
													<td colspan="2" class="report-title">보고이름</td>
												</tr>
												<tr>
													<td>부서</td>
													<td>다우그룹</td>
												</tr>
												<tr>
													<td>보고현황</td>
													<td>보고자 0명 (미보고자 3명)</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="div-report-btn">
										<button class="report-btn">보고하기</button>
									</div>
								</div>
							</div>

                            <div>
                                <div class="div-report-list">
                                    <div class="container-title">최근 생성된 보고서</div>
                                    <div class="report-list-tbl">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>보고일</th>
                                                    <th>부서</th>
                                                    <th>보고서</th>
                                                    <th>제목</th>
                                                    <th>보고자</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
						</div>
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>