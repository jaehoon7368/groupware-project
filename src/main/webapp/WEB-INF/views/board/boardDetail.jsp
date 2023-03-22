<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardList.css">


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
 <section class="tool-bar">
 	<ul>
 		<li>글쓰기</li>
 		<li>삭제하기</li>
 	</ul>
 </section>
  
  
 <section class="notice">
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
                    <th scope="col" class="th-writer">작성자</th>
                    <th scope="col" class="th-date">작성일</th>
                    <th scope="col" class="th-readCount">조회</th>
                    <th scope="col" class="th-likeCount">좋아요</th>
                </tr>
                </thead>
                <tbody>
	                <c:forEach items="${boardList}" var="board">
		                <tr>
		                	<td><input type="checkbox" name="" value=""/></td>
		                    <td>${board.no}</td>
		                    <td>
		                      <a href="#!">${board.title}</a>
		                    </td>
		                    <td>${board.writer}</td>
		                    <td>
								<fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate"/>
								<fmt:formatDate value="${createdDate}" pattern="yy-MM-dd HH:mm"/>
							</td>
		                    <td>${board.readCount}</td>
		                    <td>${board.likeCount}</td>
		                </tr>
	                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>
</div>
<div class="div-padding"></div>
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