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
	
	<jsp:include page="/WEB-INF/views/report/reportLeftBar.jsp" />
	
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">보고서 추가</div>
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
						
						<!-- 보고서 추가 -->
						<div class="div-report-frm div-padding">
							<form action="" name="reportCreateFrm">
								<table class="font-small">
									<tbody>
										<tr>
											<td>제목</td>
											<td><input type="text" id="title" name="title" /></td>
										</tr>
										<tr>
											<td>설명</td>
											<td><textarea rows="3" cols="10" id="explain" name="explain"></textarea></td>
										</tr>
										<tr>
											<td>비공개 설정</td>
											<td>
												<input type="radio" name="public" id="Y" checked /><label for="Y">보고자간 공개</label><br />
												<input type="radio" name="public" id="N" /><label for="N">보고자간 비공개</label>
											</td>
										</tr>
										<tr>
											<td>보고자</td>
											<td>
												<input type="radio" name="member" id="all" /><label for="all">부서원 전체</label><br />
												<div id="reportAll" class="report-frm-div reportMem"></div>
												<input type="radio" name="member" id="choice" checked /><label for="choice">직접 지정</label>
												<div id="reportChoice" class="report-frm-div reportMem" style="display: inline-block;">
													<button class="add" data-open="exampleModal1">+ 추가</button>
												</div>
											</td>
										</tr>
										<tr>
											<td>참조자</td>
											<td>
												<input type="radio" name="reference" id="user" checked /><label for="user">사용자</label><br />
												<div id="referenceUser" class="report-frm-div references" style="display: inline-block;">
													<button class="add" data-open="exampleModal1">+ 추가</button>
												</div>
												<input type="radio" name="reference" id="dept" /><label for="dept">부서</label>
												<div id="referenceDept" class="report-frm-div references">
													<button class="add" data-open="exampleModal2">+ 추가</button>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<button type="submit">확인</button>
												<button type="reset">취소</button>
											</td>
										</tr>
									</tbody>
								</table>
								
								<!-- 모달 -->
								<div class="report-no-modal reveal" id="exampleModal1" data-reveal>
									<h5>선택</h5>
									<div>
										<input type="text" name="search" id="search" placeholder="이름/부서/직급" />
									</div>
									<div class="div-emp-group">
										<div class="accordion-box">
											<ul class="container-list">
												<li>
													<p class="title font-medium">인사/총무</p>
													<div class="con">
														<ul class="container-detail font-small">
															<li><a class="container-a" href="#">어어어 차장</a></li>
															<li><a class="container-a" href="#">오오오 팀장</a></li>
															<li><a class="container-a" href="#">어어어 사원</a></li>
														</ul>
													</div>
												</li>
												<li>
													<p class="title font-medium">개발</p>
													<div class="con">
														<ul class="container-detail font-small">
															<li><a class="container-a" href="#">어어어 부장</a></li>
															<li><a class="container-a" href="#">오오오 대리</a></li>
															<li><a class="container-a" href="#">어어어 인턴</a></li>
														</ul>
													</div>
												</li>
												<li>
													<p class="title font-medium"><img src="${pageContext.request.contextPath}/resources/images/sample.jpg" style="width: 20px; height: 20px;" />법무</p>
													<div class="con">
														<ul class="container-detail font-small">
															<li><a class="container-a" href="#">어어어 부장</a></li>
															<li><a class="container-a" href="#">오오오 대리</a></li>
															<li><a class="container-a" href="#">어어어 인턴</a></li>
														</ul>
													</div>
												</li>
												<li>
													<p class="title font-medium">인사</p>
													<div class="con">
														<ul class="container-detail font-small">
															<li><a class="container-a" href="#">어어어 부장</a></li>
															<li><a class="container-a" href="#">오오오 대리</a></li>
															<li><a class="container-a" href="#">어어어 인턴</a></li>
														</ul>
													</div>
												</li>
											</ul>
										</div>
									</div>
									<div class="font-small report-no-modal-btn">
										<button data-close aria-label="Close reveal">닫기</button>
									</div>
									<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								
								<!-- 모달 -->
								<div class="report-no-modal reveal" id="exampleModal2" data-reveal>
									<h5>부서 선택</h5>
									<div class="div-emp-group">
										<div class="accordion-box">
											<ul class="container-list">
												<li>
													인사/총무
												</li>
												<li>
													개발
												</li>
												<li>
													법무
												</li>
												<li>
													인사
												</li>
											</ul>
										</div>
									</div>
									<div class="font-small report-no-modal-btn">
										<button data-close aria-label="Close reveal">닫기</button>
									</div>
									<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								
								<script>
									document.reportCreateFrm.addEventListener('submit', (e) => {
										e.preventDefault();
									});
									
									
									// 보고자 부서원 전체 클릭 시 직접지정 아래에 div 숨기기
									reportCreateFrm.querySelector('#all').addEventListener('click', (e) => {
										reportChoice.style.display = '';
									});

									
									// 보고자 직접지정 클릭 시 div 보이기
									reportCreateFrm.querySelector('#choice').addEventListener('click', (e) => {
										reportChoice.style.display = 'inline-block';
									});
									
									
									// 참조자 사용자 클릭 시 div 보이기 및 부서 아래에 div 숨기기
									reportCreateFrm.querySelector('#user').addEventListener('click', (e) => {
										referenceUser.style.display = 'inline-block';
										referenceDept.style.display = '';
									});

									
									// 참조자 부서 클릭 시 div 보이기 및 사용자 아래에 div 숨기기
									reportCreateFrm.querySelector('#dept').addEventListener('click', (e) => {
										referenceUser.style.display = '';
										referenceDept.style.display = 'inline-block';
									});
								</script>
							</form>
						</div>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>