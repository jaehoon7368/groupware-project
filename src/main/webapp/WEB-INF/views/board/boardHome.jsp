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

	<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />


<div class="home-container">
	<!-- 상단 타이틀 -->
	<div class="top-container">
		<div class="container-title">게시판 홈</div>
		<div class="home-topbar topbar-div">
			<div>
				<a href="#" id="home-my-img"> <img
					src="${pageContext.request.contextPath}/resources/images/sample.jpg"
					alt="" class="my-img">
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
	
	<div class="content">

		<section class="left-content">
			<div class="left-header">
				<a href="#">즐겨찾기</a>
				<a href="#">전체게시판</a>
			</div>
			
			<div class="left-board">
				<ul class="article-list">
					<li class="article-data">
						<div class="article-wrap">
							<span class="category">다우그룹>Local Policy</span>
							<span class="title"><h5>Business Trip 규정</h5></span>
							<span class="article-content">Business Trip 규정은 저도 잘 모르겠네요..</span>
						
							<div class="writer-info">
								<span class="writer-img">
									<a href="#" id="home-my-img"> <img
										src="${pageContext.request.contextPath}/resources/images/sample.jpg"
										alt="" class="my-img">
									</a>
								</span>
								<span class="writer">김상후 대표이사</span>
								<span class="createDate">2023-03-16</span>
							</div>
						</div>

					</div>
					
					<!-- 왼쪽 추가 메뉴 end -->

					</li>

					
					<li class="article-data">
						<div class="article-wrap">
							<span class="category">다우그룹>Local Policy</span>
							<span class="title"><h5>Business Trip 규정</h5></span>
							<span class="article-content">Business Trip 규정은 저도 잘 모르겠네요..</span>
						
							<div class="writer-info">
								<span class="writer-img">
									<a href="#" id="home-my-img"> <img
										src="${pageContext.request.contextPath}/resources/images/sample.jpg"
										alt="" class="my-img">
									</a>
								</span>
								<span class="writer">김상후 대표이사</span>
								<span class="createDate">2023-03-16</span>
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
			<div class="" id="">
				  <div class="">
				      <div class="">
				        <p class="author-mutual">
				          본문내용
				        </p>
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
</div>
 <!-- 본문 div-padding 끝  -->
	
	
	

					</li>
					
					<li class="article-data">
						<div class="article-wrap">
							<span class="category">다우그룹>Local Policy</span>
							<span class="title"><h5>Business Trip 규정</h5></span>
							<span class="article-content">Business Trip 규정은 저도 잘 모르겠네요..</span>
						
							<div class="writer-info">
								<span class="writer-img">
									<a href="#" id="home-my-img"> <img
										src="${pageContext.request.contextPath}/resources/images/sample.jpg"
										alt="" class="my-img">
									</a>
								</span>
								<span class="writer">김상후 대표이사</span>
								<span class="createDate">2023-03-16</span>
							</div>
						</div>
					</li>
					
					<li class="article-data">
						<div class="article-wrap">
							<span class="category">다우그룹>Local Policy</span>
							<span class="title"><h5>Business Trip 규정</h5></span>
							<span class="article-content">Business Trip 규정은 저도 잘 모르겠네요..</span>
						
							<div class="writer-info">
								<span class="writer-img">
									<a href="#" id="home-my-img"> <img
										src="${pageContext.request.contextPath}/resources/images/sample.jpg"
										alt="" class="my-img">
									</a>
								</span>
								<span class="writer">김상후 대표이사</span>
								<span class="createDate">2023-03-16</span>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</section> <!--  left-content end -->




		<section class="right-content">
			<div class="right-header">
				<a href="">최신글 모음</a>
			</div>
			
			<div class="resent-group">
				<div class="group-list">
					<a href="#">전사 게시판</a>
					<ul>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
					</ul>
				</div>
				
				<div class="group-list">
					<a href="#">전사 게시판</a>
					<ul>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
					</ul>
				</div>
				
				<div class="group-list">
					<a href="#">전사 게시판</a>
					<ul>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
						<li>
							<a href="">2017년 하반기 야유회...</a>
							<span>06-01</span>
						</li>
					</ul>
				</div>
			</div>
		</section> <!--  right-content end -->











	</div>
	<!-- content end -->









	<jsp:include page="/WEB-INF/views/common/footer.jsp" />