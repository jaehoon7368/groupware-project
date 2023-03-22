<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardDetail.css">


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
 	<div class="tool-bar">
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/board/boardForm.do">
		 		<span><img src="${pageContext.request.contextPath}/resources/images/pencil.png" alt="" class="tool-img" /></span>
		 		<span>새글쓰기</span>
	 		</a>
 		</div>
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/board/boardDelete.do">
	 			<span><img src="${pageContext.request.contextPath}/resources/images/trash.png" alt="" class="tool-img" /></span>
	 			<span>삭제</span>
	 		</a>
 		</div>
 	</div>

 <div class="div-padding"></div>
 
 <section class="detail">
 	<div class="title">
 		<h1 id="title" name="title">${board.title} <span id="readCount" name="readCount">[${board.readCount}]</span></h1>
 	</div>
 	
 	<div class="info-wrap">
 		<div>
 			<span><img src="" alt="" />${board.writer}</span>
 			<a href="">이미지클릭시 정보 팝업</a>
 			<span id="createdDate" class="createdDate">
			    <fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" />
			    <fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd EEE HH:mm"/>
			</span>
 		</div>
 	</div>
 	
 	<div class="div-padding"></div>
 	
 	<div class="content-view">
 		<span class="content">${board.content}</span>
 	</div>
 	
 	<div class="div-padding"></div>
 	
 	<div class="view-option">
 		<div class="comment">
 			<span>말풍선</span>
 			<span>댓글</span>
 			<span>0</span>
 			<span class="part">|</span>
 		</div>
 		<div class="readCount">
 			<span>조회</span>
 			<span>${board.readCount}</span>
 			<span class="part">|</span>
 		</div>
 		<div class="likeCount">
 			<span>하트</span>
 			<span>좋아요</span>
 			<span>${board.likeCount}</span>
 		</div>
 	</div>
 </section>
 
  <div class="div-report-commend">
	<div>댓글</div>
		<div class="div-report-commend-all">
			<div>
				<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
			</div>
			<div>
				<textarea rows="1"></textarea>
			</div>
			<div>
				<button class="font-small">댓글작성</button>
			</div>
		</div>
	</div>
  
</div>
<div class="div-padding"></div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>