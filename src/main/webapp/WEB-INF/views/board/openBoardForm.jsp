<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/openBoardForm.css">


	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">게시판</div>
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
	<div class="write-form-wrap">
		<form action="">
			<textarea name="" id="feedContent" placeholder="새로운 정보, 기분 좋은 소식을 부서원들과 공유하세요." style="width:700px; height:160px; "></textarea>
			
		<div class="notice-wrap">
			
			<span class="notice-option">
				<span class="size">( 0MB )</span>
				<span class="file">이미지</span>
				
				<span class="div-padding div-report-write-btn">
					<button>이야기 하기</button>
				<span>
			</span>
		</div> <!-- notice-wrap end -->
	</div>
	
	<div class="textarea-container">
  <textarea></textarea>
  <div class="notification-options">
    <label>
      <input type="radio" name="notification-type" value="email"> 이메일 알림
    </label>
    <label>
      <input type="radio" name="notification-type" value="push"> 푸시 알림
    </label>
  </div>
  <button class="submit-button">글쓰기</button>
</div>
	
	
	
</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>