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
				<a href="#" id="home-my-img">
					<c:if test="${!empty sessionScope.loginMember.attachment}">
						<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
					</c:if>
					<c:if test="${empty sessionScope.loginMember.attachment}">
						<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img">
					</c:if>
				</a>
			</div>
			<div id="my-menu-modal">
				<div class="my-menu-div">
					<button class="my-menu" onclick="location.href = '${pageContext.request.contextPath }/emp/empInfo.do'">기본정보</button>
				</div>
				<div class="my-menu-div">
					<form:form action="${pageContext.request.contextPath}/emp/empLogout.do" method="POST">
						<button class="my-menu" type="submit">로그아웃</button>								
					</form:form>
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
				<span>전체 게시판</span>
			</div>
			
			<form action="${pageContext.request.contextPath}/board/boardHome.do" method="get">
			<div class="left-board">
				<ul class="article-list">
				
					<c:forEach var="board" items="${boardList}">
					  <li class="article-data" onclick="location.href='${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}'">
					    <div class="article-wrap">
					      <span class="bType">
					      	<c:forEach items="${sessionScope.boardTypeList}" var="boardType">
					      		<c:if test="${board.BType == boardType.no}">다우그룹>${boardType.title}</c:if>
					      	</c:forEach>
					      </span>
					      <span class="title">${board.title}</span>
					      <span class="article-content">${board.content}</span>
					      <div class="writer-info">
					        <span class="writer-img">
					        	<c:if test="${empty board.renameFilename }">
					        		<img src="${pageContext.request.contextPath}/resources/upload/emp/default.png" class="my-img">
					        	</c:if>
					        	<c:if test="${!empty board.renameFilename }">
						           <img src="${pageContext.request.contextPath}/resources/upload/emp/${board.renameFilename}" class="my-img">
					        	</c:if>
					        </span>
					        <span class="writer">${board.writer}</span>
					        <span id="createdDate" class="createdDate">
					            <fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" />
					            <fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd EEE HH:mm"/>
					        </span>
					      </div>
					    </div>
					  </li>
					</c:forEach>
				</ul>
			</div>
			</form>
		</section> <!--  left-content end -->




		<section class="right-content">
			<div class="right-header">
				<span>최신글 모음</span>
			</div>
			
			<div class="resent-group">
				<c:forEach items="${sessionScope.boardTypeList}" var="boardType">
				<c:if test="${boardType.category == 'C'}">
					<div class="group-list">
					    <a href="${pageContext.request.contextPath}/board/boardList.do"><span class="group-list-title">${boardType.title}</span></a>
					    <ul>
				        <c:set var="count" value="0"/>
					        <c:forEach items="${boardList}" var="board">
					            <c:if test="${board.BType == boardType.no && count < 5}">
					                <c:set var="onclick" value="''" />
					                <c:if test="${board.title.length() > 13}">
					                    <c:set var="title" value="${board.title.substring(0, 13)}..." />
					                </c:if>
					                <c:if test="${board.title.length() <= 13}">
					                    <c:set var="title" value="${board.title}" />
					                </c:if>
					                <li>
					                    <a href="${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}">${title}</a>
					                    <span class="createdDate">
					                        <fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" />
					                        <fmt:formatDate value="${createdDate}" pattern="MM-dd"/>
					                    </span>
					                </li>
					                <c:set var="count" value="${count + 1}" />
					            </c:if>
					        </c:forEach>
					    </ul>
					</div>
					</c:if>
				</c:forEach>
				
				<%-- <div class="group-list">
					<a href="${pageContext.request.contextPath}/board/newsBoardList.do"><span class="group-list-title">이주의 IT뉴스</span></a>
					<ul>
				        <c:set var="count" value="0"/>
					        <c:forEach items="${boardList}" var="board">
					            <c:if test="${board.BType == 'N' && count < 5}">
					                <c:set var="onclick" value="''" />
					                <c:if test="${board.title.length() > 13}">
					                    <c:set var="title" value="${board.title.substring(0, 13)}..." />
					                </c:if>
					                <c:if test="${board.title.length() <= 13}">
					                    <c:set var="title" value="${board.title}" />
					                </c:if>
					                <li>
					                    <a href="${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}">${title}</a>
					                    <span class="createdDate">
					                        <fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" />
					                        <fmt:formatDate value="${createdDate}" pattern="MM-dd"/>
					                    </span>
					                </li>
					                <c:set var="count" value="${count + 1}" />
					            </c:if>
					        </c:forEach>
					    </ul>
				</div>
				
				<div class="group-list">
					<a href="${pageContext.request.contextPath}/board/menuBoardList.do"><span class="group-list-title">주간 식단표</span></a>
					<ul>
				        <c:set var="count" value="0"/>
					       <c:forEach items="${boardList}" var="board">
					            <c:if test="${board.BType == 'M' && count < 5}">
					                <c:set var="onclick" value="''" />
					                <c:if test="${board.title.length() > 13}">
					                    <c:set var="title" value="${board.title.substring(0, 13)}..." />
					                </c:if>
					                <c:if test="${board.title.length() <= 13}">
					                    <c:set var="title" value="${board.title}" />
					                </c:if>
					                <li>
					                    <a href="${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}">${title}</a>
					                    <span class="createdDate">
					                        <fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" />
					                        <fmt:formatDate value="${createdDate}" pattern="MM-dd"/>
					                    </span>
					                </li>
					                <c:set var="count" value="${count + 1}" />
					            </c:if>
					        </c:forEach>
					    </ul>
				</div> --%>
			</div>
		</section> <!--  right-content end -->











	</div>
	<!-- content end -->








	<jsp:include page="/WEB-INF/views/common/footer.jsp" />