<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardHome.css">

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판 홈" name="title"/>
	</jsp:include>

				<div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="home-container left-container">
						<div class="container-title"><a href="">게시판</a></div>
						<div class="container-btn">
							<button>글쓰기</button>
						</div>
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">즐겨찾기</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">공지게시판</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="${pageContext.request.contextPath}/board/boardList.do">공지게시판</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">부서게시판</p>
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
							<div class="container-title">게시판 홈</div>
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
						
<div class="content-wrapper">
<section class="board-left">
<nav id="board-nav">
<a href="">즐겨찾기</a>
<a href="">전체 게시판</a>
</nav>
	
<div class="wrapper">
	<div class="people-you-might-know" id="content">
		  <div class="row add-people-section">
		      <div class="about-people-author">
		        <p class="author-name">
		          Business Trip 규정
		        </p>
		        <p class="author-mutual">
		          본문내용
		        </p>
		      </div>
		      <table id="writer-info">
			      	<td><img src="${pageContext.request.contextPath}/resources/images/sample.jpg" alt="" class="my-img"></td>
			      	<td>김상후 대표이사</td>
			      	<td>2022-12-08(목) 14:52</td>
		      </table>
		</div>
	</div>
	<div class="people-you-might-know" id="content">
		  <div class="row add-people-section">
		      <div class="about-people-author">
		        <p class="author-name">
		          Business Trip 규정
		        </p>
		        <p class="author-mutual">
		          본문내용
		        </p>
		      </div>
		      <table id="writer-info">
			      	<td><img src="${pageContext.request.contextPath}/resources/images/sample.jpg" alt="" class="my-img"></td>
			      	<td>김상후 대표이사</td>
			      	<td>2022-12-08(목) 14:52</td>
		      </table>
		</div>
	</div>
	<div class="people-you-might-know" id="content">
		  <div class="row add-people-section">
		      <div class="about-people-author">
		        <p class="author-name">
		          Business Trip 규정
		        </p>
		        <p class="author-mutual">
		          본문내용
		        </p>
		      </div>
		      <table id="writer-info">
			      	<td><img src="${pageContext.request.contextPath}/resources/images/sample.jpg" alt="" class="my-img"></td>
			      	<td>김상후 대표이사</td>
			      	<td>2022-12-08(목) 14:52</td>
		      </table>
		</div>
	</div>
</div>
</section>


	<section class="board-right">
	<div>
		<p>최신글 모음</p>
	</div>
	<div class="right-group">
		<div class="resent-every">
			<p>전사게시판</p>
				<ul>
					<li>2017년 하반기 야유회...</li>
					<li>윤리경영 시행 안내</li>
					<li>프린터교체에 따른 설치...</li>
					<li>[공지] SMB 취약점을 이...</li>
				</ul>
		</div>

		<div class="resent-news">
			<p>전사게시판</p>
				<ul>
					<li>5월, 전세계를 공포로 몰...</li>
					<li>이번주에도 어김없이 '이...</li>
				</ul>
		</div>
	</div>
</section>
</div>
 <!-- 본문 div-padding 끝  -->
	
	
	



	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>