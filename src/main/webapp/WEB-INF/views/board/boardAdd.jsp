<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardAdd.css">

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">게시판 추가</div>
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
						<div class="div-padding"></div>
<div class="content">
	<form action="">
		<table class="board-add">
		
			<div class="target-select">
				<span>게시판 그룹</span>
				<select value="" id="">
					<option value="">다우그룹</option>
				</select>
			</div>
			<tr>
	  			<th>제목</td>
	  			<td><input type="text" class="padding-input"/></td>
	  		</tr>
	  		<tr>
	  			<th>설명</td>
	  			<td><input type="text" class="padding-input"/></td>
	  		</th>
	  		<tr>
				<th>유형</th>
					<td><input type="checkbox" /></td>
					<td><input type="checkbox" /></td>
			</tr>
			
			<tbody>
				<tr>
					<th>공유 부서 설정</th>
						<td><input type="checkbox" />사용함</td>
						<td><input type="checkbox" />사용하지 않음</td>
				</tr>
				<tr>
					<th>비공개 설정</th>
						<td><input type="checkbox" />사용함</td>
						<td><input type="checkbox" />사용하지 않음</td>
				</tr>
				<tr>
					<th>익명 설정</th>
						<td><input type="checkbox" />사용함</td>
						<td><input type="checkbox" />사용하지 않음</td>
				</tr>
				<tr>
					<th>말머리</th>
						<td><input type="checkbox" />사용함</td>
						<td><input type="checkbox" />사용하지 않음</td>
				</tr>
				<tr>
					<th>게시물에 메일발송<br />버튼을표시</th>
						<td><input type="checkbox" />예</td>
						<td><input type="checkbox" />아니오</td>
				</tr>
				<tr>
					<th>비공개 문서 제목 표시</th>
						<td><input type="checkbox" />제목만 표시</td>
						<td><input type="checkbox" />비공개 문서로 표시</td>
				</tr>
				<tr>
					<th>게시글 별 열람자 설정</th>
						<td><input type="checkbox" />사용함</td>
						<td><input type="checkbox" />사용하지 않음</td>
				</tr>
				<tr>
					<th>댓글 작성</th>
						<td><input type="checkbox" />허용</td>
						<td><input type="checkbox" />허용하지 않음</td>
				</tr>
			
			</tbody>
		</table>
	</form>
	<div class="div-padding div-report-write-btn">
		<button>만들기</button>
		<button>취소</button>
	</div>
</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>