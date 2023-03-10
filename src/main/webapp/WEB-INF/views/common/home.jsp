<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Anywhere" name="title"/>
	</jsp:include>

				<div class="app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 상단 타이틀 -->
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
    
					
					<div class="home-content">
						<!-- 본문 왼쪽 -->
						<div>
							<div id="home-left" class="div-padding div-margin">
								<table id="home-my-tbl">
									<tbody>
										<tr>
											<td colspan="2">
												<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" alt="" class="img">
											</td>
										</tr>
										<tr>
											<td colspan="2">대표</td>
										</tr>
										<tr>
											<td colspan="2">그룹</td>
										</tr>
										<tr>
											<td>오늘 온 메일</td>
											<td>dd</td>
										</tr>
										<tr>
											<td>오늘 온 일정</td>
											<td>dd</td>
										</tr>
									</tbody>
								</table>
							</div>
							
							<div id="home-left" class="div-padding div-margin">
								<table id="home-work-tbl">
									<thead>
										<tr>
											<th colspan="2"><h5>근태관리</h5></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="2">2023년 3월 8일 (수)</td>
										</tr>
										<tr>
											<td>출근시간</td>
											<td>미등록</td>
										</tr>
										<tr>
											<td>퇴근시간</td>
											<td>미등록</td>
										</tr>
										<tr class="btn-tr">
											<td><button>출근하기</button></td>
											<td><button>퇴근하기</button></td>
										</tr>
										<tr class="btn-tr">
											<td colspan="2">
												<select class="work-select">
													<option selected>상태변경</option>
													<option value="1">업무</option>
													<option value="2">업무종료</option>
													<option value="3">외근</option>
													<option value="4">출장</option>
													<option value="5">반차</option>
												</select>
											</td>	
										</tr>
									</tbody>
								</table>
							</div>
						</div>

						<!-- 본문 가운데 -->
						<div>
							<div id="home-center" class="div-padding div-margin">
								<h5>전사게시판</h5>
								<div id="board-div" class="home-div">
									<button class="btn-board-title" onclick="styleChange(this);">ㅇㅇ</button>
									<button class="btn-board-title" onclick="styleChange(this);">ㄱㄱ</button>
									<button class="btn-board-title" onclick="styleChange(this);">ㅊㅊ</button>
									<button class="btn-board-title" onclick="styleChange(this);">ㄹㄹ</button>
								</div>
							</div>
							<script>
								const styleChange = (btn) => {
									document.querySelectorAll('#board-div .btn-board-title').forEach((btn) => {
										btn.style.borderBottom = 'none';
									});
									
									btn.style.borderBottom = 'solid 2px #000';
								};
							</script>
						
							<div id="home-center" class="div-padding div-margin">
								<h5>결재 대기 문서</h5>
								<table id="sign-tbl">
									<thead>
										<tr>
											<th>기안일</th>
											<th>결재양식</th>
											<th>긴급</th>
											<th>제목</th>
											<th>첨부</th>
											<th>결재상태</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							
							<div id="home-center" class="div-padding div-margin">
								<h5>메일함</h5>
								<div id="mail-div" class="home-div">
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㅇㅇ</button>
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㄱㄱ</button>
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㅊㅊ</button>
									<button class="btn-board-title" onclick="mailStyleChange(this);">ㄹㄹ</button>
								</div>
							</div>
							<script>
								const mailStyleChange = (btn) => {
									document.querySelectorAll('#mail-div .btn-board-title').forEach((btn) => {
										btn.style.borderBottom = 'none';
									});
									btn.style.borderBottom = 'solid 2px #000';
								};
							</script>
						</div>
						
						<!-- 본문 오른쪽 -->
						<div>
							<div id="home-right" class="div-padding div-margin">
								<h5>최근 알림</h5>
							</div>
							<div id="home-right" class="div-padding div-margin">
								<h5>보고</h5>
							</div>
						</div>
					</div>
				</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>