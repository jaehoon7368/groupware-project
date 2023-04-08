<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardList.css">


	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">전사 공지</div>
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
						<div class="div-padding"></div>
						
	

 <div class="content">
 
 	<div class="tool-bar">
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/board/boardForm.do?bType=A">
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
  
 <section class="notice">
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                	<th>
						<input type="checkbox" id="selectAllBtn" name="" value=""/>
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
					    <tr data-no="${board.no}">
					        <td><input type="checkbox" name="boardNo" value="${board.no}"/></td>
					        <td>${empty board.no ? '' : (board.no.startsWith('bo') ? board.no.substring(2).replaceFirst("^0+(?!$)", "") : board.no)}</td>
					        <td class="board-title">
					            <a href="#!">${board.title}</a>
					        </td>
					        <td>${board.writer}</td>
					        <td>
					            <fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate"/>
					            <fmt:formatDate value="${createdDate}" pattern="yy-MM-dd"/>
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


  <ul class="pagination justify-content-center">

    <c:if test="${startPage > 1}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/board/boardList.do?cpage=${startPage-1}" aria-label="Previous">
          <span aria-hidden="true">&lt;</span>
          <span class="sr-only">Previous</span>
        </a>
      </li>
    </c:if>

    <c:forEach var="i" begin="${startPage}" end="${endPage}">
      <li class="page-item ${i==currentPage ? 'active' : ''}">
        <a class="page-link" href="${pageContext.request.contextPath}/board/boardList.do?cpage=${i}">${i}</a>
      </li>
    </c:forEach>

    <c:if test="${endPage < totalPage}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/board/boardList.do?cpage=${endPage+1}" aria-label="Next">
          <span aria-hidden="true">&gt;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
  </ul>
</c:if>


<script>
$(document).ready(function() {
    // 전체선택 버튼 클릭 시
    $('#selectAllBtn').click(function() {
        const isChecked = $(this).prop('checked');
        $('input[name=boardNo]').prop('checked', isChecked);
    });

    // 체크박스 선택 시
    $('input[name=boardNo]').change(function() {
        // 선택된 체크박스의 값 가져오기
        const boardNo = $(this).val();
        console.log("Selected boardNo: " + boardNo);
    });

    // 삭제 버튼 클릭 시
    $('a[href$="/boardDelete.do"]').click(function(event) {
        event.preventDefault();
        const boardNos = [];
        const csrfHeader = "${_csrf.headerName}";
  	    const csrfToken = "${_csrf.token}";
  	    const headers = {};
  	  headers[csrfHeader] = csrfToken;
        $('input[name=boardNo]:checked').each(function() {
            boardNos.push($(this).val());
        });
        console.log("Selected boardNos: " + boardNos);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/board/boardsDelete.do',
            type: 'POST',
            data: {boardNos: boardNos},
            headers,
            success: function() {
                location.href = "${pageContext.request.contextPath}/board/boardList.do";
            },
            error: function() {
                alert("삭제 실패");
            }
        });
    });
});
</script>
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		 // 클릭한 엘리먼트가 input 태그인 경우 이벤트 처리를 하지 않음
	    if (e.target.tagName.toLowerCase() === 'input') {
	      return;
	    }
		const no = tr.dataset.no;
		console.log(no);
		location.href = '${pageContext.request.contextPath}/board/boardDetail.do?no=' + no;
	});
});
</script>




	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>