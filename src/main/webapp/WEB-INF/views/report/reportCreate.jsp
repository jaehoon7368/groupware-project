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
								<table>
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
												<input type="radio" name="public" id="Y" /><label for="Y">보고자간 공개</label><br />
												<input type="radio" name="public" id="N" /><label for="N">보고자간 비공개</label>
											</td>
										</tr>
										<tr>
											<td>보고자</td>
											<td>
												<input type="radio" name="member" id="dd" /><label for="dd">부서원 전체</label><br />
												<input type="radio" name="member" id="choice" /><label for="choice">직접 지정</label>
												
											</td>
										</tr>
										<tr>
											<td>참조자</td>
											<td>
												<input type="radio" name="reference" id="dd" /><label for="dd">부서원 전체</label><br />
												<input type="radio" name="reference" id="choice" /><label for="choice">직접 지정</label>
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
								<script>
									document.reportCreateFrm.addEventListener('submit', (e) => {
										e.preventDefault();
									});
								</script>
							</form>
						</div>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>