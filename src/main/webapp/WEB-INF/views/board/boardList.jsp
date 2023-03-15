<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/board.css">

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판" name="title"/>
	</jsp:include>

				<div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="home-container left-container">
						<div class="container-title"><a href="${pageContext.request.contextPath}/board/boardHome.do">게시판</a></div>
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
											<li><a class="container-a" href="#">공지게시판</a></li>
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
						<div class="div-padding"> 전체 게시판</div>
						
	
<section class="notice">
  
  <div id="board-button">
  	<input type="button" value="글쓰기" id="board-btn" class=""/>
  	<input type="button" value="이동" id="board-btn" class=""/>
  	<input type="button" value="복사" id="board-btn" class=""/>
  	<input type="button" value="삭제" id="board-btn" class=""/>
  	<input type="button" value="공지로 등록" id="board-btn" class=""/>
  	<input type="button" value="목록 다운로드" id="board-btn" class=""/>
  </div>
   
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                	<th>
						<input type="checkbox" name="" value=""/>
					</th>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-title">작성자</th>
                    <th scope="col" class="th-date">작성일</th>
                    <th scope="col" class="th-title">조회</th>
                    <th scope="col" class="th-title">좋아요</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                	<td><input type="checkbox" name="" value=""/></td>
                    <td>5</td>
                    <td>
                      <a href="#!">마찬가집니다</a>
                    </td>
                    <td>김기훈</td>
                    <td>23/03/15</td>
                    <td>1</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="" value=""/></td>
                    <td>4</td>
                    <td><a href="#!">저두요</a></td>
                    <td>최민경</td>
                    <td>23/03/14</td>
                    <td>3</td>
                    <td>2</td>
                </tr>
                <tr>
                	<td><input type="checkbox" name="" value=""/></td>
                    <td>3</td>
                    <td><a href="#!">저는 상관없습니다</a></td>
                    <td>유재훈</td>
                    <td>23/03/13</td>
                    <td>5</td>
                    <td>0</td>
                </tr>
                <tr>
                	<td><input type="checkbox" name="" value=""/></td>
                    <td>2</td>
                    <td><a href="#!">2차 갈래?</a></td>
                    <td>김현동</td>
                    <td>23/03/12</td>
                    <td>7</td>
                    <td>2</td>
                </tr>
                <tr>
                	<td><input type="checkbox" name="" value=""/></td>
                    <td>1</td>
                    <td><a href="#!">너무 졸려요</a></td>
                    <td>한혜진</td>
                    <td>23/03/12</td>
                    <td>2</td>
                    <td>1</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</section>

<!-- 페이지바 -->

<ul class="pagination text-center" role="navigation" aria-label="Pagination" data-page="6" data-total="16">
  <li class="pagination-previous disabled">Previous <span class="show-for-sr">page</span></li>
  <li class="current"><span class="show-for-sr">You're on page</span> 1</li>
  <li><a href="#" aria-label="Page 2">2</a></li>
  <li><a href="#" aria-label="Page 3">3</a></li>
  <li><a href="#" aria-label="Page 4">4</a></li>
  <li class="ellipsis" aria-hidden="true"></li>
  <li><a href="#" aria-label="Page 12">12</a></li>
  <li><a href="#" aria-label="Page 13">13</a></li>
  <li class="pagination-next"><a href="#" aria-label="Next page">Next <span class="show-for-sr">page</span></a></li>
</ul>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>