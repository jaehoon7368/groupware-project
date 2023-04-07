<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardDetail.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

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
										<button class="my-menu">기본정보</button>
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
 			<a href="${pageContext.request.contextPath}/board/boardForm.do">
 				<button id="write-btn">
			 		<span><img src="${pageContext.request.contextPath}/resources/images/pencil.png" alt="" class="tool-img" /></span>
			 		<span>새글쓰기</span>
		 		</button>
	 		</a>
 		</div>
 		<div class="tool-button">
			  <button id="deleteBtn">
			    <span><img src="${pageContext.request.contextPath}/resources/images/trash.png" alt="" class="tool-img"></span>
			    <span>삭제</span>
			  </button>
 		</div>
 		<div class="tool-button">
			  <a href="${pageContext.request.contextPath}/board/boardUpdateForm.do?no=${board.no}&bType=${board.BType}">
 				<button id="write-btn">
			 		<span><img src="${pageContext.request.contextPath}/resources/images/pencil.png" alt="" class="tool-img" /></span>
			 		<span>수정</span>
		 		</button>
	 		</a>
 		</div>
 		<div class="tool-button">
			<%-- <a href="${pageContext.request.contextPath}/board/boardList.do"> --%>
				<button id="write-btn" onclick="history.back();">
					<span><img src="${pageContext.request.contextPath}/resources/images/bar.png" alt="" class="tool-img" /></span>
					<span>목록</span>
				</button>
			<!-- </a> -->
 		</div>
 	</div>

 <div class="div-padding"></div>
 
 <section class="detail">
 	<div class="title">
 		<h1 id="title" name="title">${board.title}</h1>
 		<input type="hidden" id="boardNo" name="boardNo" class="like-item" data-board-no="${board.no}" value="${board.no}">
 	</div>
 	
 	<div class="tool-wrap">
	 	<div class="info-wrap">
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
	 	<div class="heart-wrap">
	 	<input type="hidden" class="board-empId" name="empId" value="${loginMember.empId}">
		  <img class="heart" src="${pageContext.request.contextPath}/resources/images/heart.png" alt="heart">
		  <img class="full-heart" src="${pageContext.request.contextPath}/resources/images/fullheart.png" alt="full-heart" style="display: none;">
		</div>
 	</div>
 	
 	<div class="div-padding"></div>
 	<div class="content-view">
 		<span class="content">${board.content}</span>
 	</div>
 	<div class="div-padding"></div>
			<div class="file">
				<c:forEach items="${board.attachments}" var="attach" varStatus="vs">
					<c:set var="extension"
						value="${fn:substring(attach.originalFilename, fn:length(attach.originalFilename) - 3, fn:length(attach.originalFilename))}" />
					<c:choose>
						<c:when
							test="${extension == 'jpg' || extension == 'jpeg' || extension == 'png' || extension == 'gif'}">
							<img class="img-thumbnail"
								src="${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}"
								style="width: 400px; height: 400px;"
								alt="${attach.originalFilename}"
								onclick="openModal('${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}', '${attach.originalFilename}')">
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-outline-success btn-block"
								onclick="location.href='${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}'; ">
								첨부파일${vs.count} - ${attach.originalFilename}</button>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>

			<div class="div-padding"></div>
 	<div class="div-padding"></div>
 	<div class="view-option">
	  <div class="comment">
	    <span>댓글</span>
	    <span>${commentCount}</span>
	    <span class="part">|</span>
	  </div>
	  <div class="readCount">
	    <span>조회</span>
	    <span>${board.readCount}</span>
	    <span class="part">|</span>
	  </div>
	  <div>
	    <span>좋아요</span>
	    <span class="likeCount">${likeCount}</span>
	  </div>
	</div>
 </section>
 
<div class="div-report-commend">
  <div>댓글</div>
  <div class="div-report-commend-all">
    <div class="commentList-view">
      <c:forEach var="comment" items="${commentList}" varStatus="status">
        <div class="comment-item" data-comment-id="${comment.no}">
          <div class="info-wrap">
            <input type="hidden" class="comment-id" name="no" data-comment-id="${comment.no}" value="${comment.no}">
            <input type="hidden" class="comment-empId" name="empId" value="${comment.empId}">
            <span class="writer-img">
              	<c:if test="${empty comment.renameFilename }">
					<img src="${pageContext.request.contextPath}/resources/upload/emp/default.png" class="my-img">
				</c:if>
				<c:if test="${!empty comment.renameFilename }">
					<img src="${pageContext.request.contextPath}/resources/upload/emp/${comment.renameFilename}" class="my-img">
				</c:if>
            </span>
            <span class="writer">${comment.writer}</span>
            <span class="createdDate">
              <fmt:parseDate value="${comment.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" />
              <fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd EEE HH:mm"/>
            </span>
            <span class="commentList-view-btn-wrap">
              <button type="button" class="comment-edit-btn" data-comment-no="${comment.no}">수정</button>
              <button type="button" id="comment-delete-btn" class="comment-delete-btn" data-comment-no="${comment.no}">삭제</button>
            </span>
          </div>
          <div class="commentlist-content-wrap">
            <span class="comment-content" name="content" style="margin-left: 60px;">${comment.content}</span>
            <form class="comment-edit-form" style="display:none;">
              <textarea name="content" class="comment-edit-textarea">${comment.content}</textarea>
              <button type="submit" class="comment-edit-submit">저장</button>
              <button type="button" class="comment-edit-cancel">취소</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

    	
        <div class="comment-write-view" style="margin-left: 20px;">
            <form:form action="${pageContext.request.contextPath}/board/boardCommentEnroll.do?${_csrf.parameterName}=${_csrf.token}" method="post">
                   <div>
						<c:if test="${!empty sessionScope.loginMember.attachment}">
							<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
						</c:if>
						<c:if test="${empty sessionScope.loginMember.attachment}">
							<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img">
						</c:if>			       	
			       </div>
				  <div class="comment-input">
				  	
				    <input type="hidden" id="no" name="no" value="${board.no}">
				    <input type="hidden" id="empId" name="empId" value="${loginMember.empId}">
				    <input type="hidden" id="writer" name="writer" value="${loginMember.name}">
				    <input type="hidden" name="comment_level" value="0" />
				    <input type="hidden" name="refCommentNo" value="${board.no}" />
				    <textarea rows="1" name="content" style="resize: none;"></textarea>
				  </div>
				  <div class="comment-submit">
				    <input type="submit" value="댓글 작성">
				  </div>
            </form:form>
        </div>
    </div>
</div>
<!-- 좋아요 -->
<script>
$(document).ready(function() {
	  const boardNo = $('#boardNo').val();
	  const empId = $('.board-empId').val();

	  console.log(boardNo);
	  console.log(empId);
	  // 좋아요 여부 조회
	  $.ajax({
	    type: 'GET',
	    url: '${pageContext.request.contextPath}/board/boardLikeCheck.do',
	    data: {
	      boardNo: boardNo,
	      empId: empId
	    },
	    contentType: 'application/json',
	    success: function(data) {
	      if (data.isLiked === true) {
	    	  console.log(data);
	        // 좋아요를 누른 경우
	        const heartWrap = $('.heart-wrap');
	        const heartImage = heartWrap.find('.heart');
	        const fullHeartImage = heartWrap.find('.full-heart');
	        const likeCountEl = heartWrap.find('.like-count');

	        heartWrap.addClass('liked');
	        heartImage.hide();
	        fullHeartImage.show();

	        // 좋아요 수 증가
	        if (likeCountEl !== null) {
	          const likeCount = parseInt(likeCountEl.text());
	          heartWrap.find('.like-count').text((likeCount + 1) + '');
	        }
	      } else {
	   
	        console.log('좋아요를 누르지 않은 경우');
	      }
	    },
	    error: function(xhr, status, error) {
	      console.error(status + " : " + error);
	    }
	  });
	});
</script>
<script>
const heartWrap = document.querySelector('.heart-wrap');
const heartImage = heartWrap.querySelector('.heart');
const fullHeartImage = heartWrap.querySelector('.full-heart');

heartWrap.addEventListener('click', function(e) {
  e.preventDefault();
  const boardNo = document.getElementById('boardNo').value;
  const empId = document.querySelector('.board-empId').value;
  const csrfHeader = "${_csrf.headerName}";
  const csrfToken = "${_csrf.token}";
  const headers = {};
  headers[csrfHeader] = csrfToken;
  console.log(boardNo);
  console.log(empId);

  // 좋아요를 누르지 않은 경우
  if (!heartWrap.classList.contains('liked')) {
    // 좋아요 등록 처리
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/board/boardLikeUp.do',
      contentType: 'application/json',
      data: JSON.stringify({
        boardNo: boardNo,
        empId: empId
      }),
      headers,
      success: function(data) {
        if (data.result === 'success') {
          // 하트 아이콘 변경
          heartImage.style.display = 'none';
          fullHeartImage.style.display = 'block';
          heartWrap.classList.add('liked');
          // 좋아요 수 증가
         var likeCountEl = heartWrap.querySelector('.like-count');
			if (likeCountEl !== null) {
			  var likeCount = parseInt(likeCountEl.textContent);
			  heartWrap.querySelector('.like-count').textContent = (likeCount + 1) + '';
			}
        } else {
          console.log('좋아요 등록 처리 실패');
        }
        location.href = '${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}';
      },
      error: function(xhr, status, error) {
        console.error(status + " : " + error);
      }
    });
  } else {
    // 좋아요를 누른 경우
    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/board/boardLikeDown.do',
      contentType: 'application/json',
      data: JSON.stringify({
        boardNo: boardNo,
        empId: empId
      }),
      headers,
      success: function(data) {
        if (data.result === 'success') {
          // 하트 아이콘 변경
          heartImage.style.display = 'block';
          fullHeartImage.style.display = 'none';
          heartWrap.classList.remove('liked');
       // 좋아요 수 감소
          var likeCountEl = heartWrap.querySelector('div.like-count span.likeCount');
          if (likeCountEl !== null) { // 수정된 부분
            var likeCount = parseInt(likeCountEl.textContent);
            heartWrap.querySelector('.like-count').textContent = (likeCount - 1) + '';
          }
        } else {
          console.log('좋아요 취소 처리 실패');
        }
        location.href = '${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}';
      },
      error: function(xhr, status, error) {
        console.error(status + " : " + error);
      }
    });
  }
});
</script>

<!-- 댓글 수정 -->
<script>
//댓글 수정 버튼 클릭 시 수정 폼 보여주기
const commentList = document.querySelector('.commentList-view');

commentList.addEventListener('click', (e) => {
  if (e.target.classList.contains('comment-edit-btn')) {
    const commentItem = e.target.closest('.comment-item');
    const commentContent = commentItem.querySelector('.comment-content');
    const editForm = commentItem.querySelector('.comment-edit-form');
    const cancelBtn = editForm.querySelector('.comment-edit-cancel'); // 취소 버튼 추가

    commentContent.style.display = 'none';
    editForm.style.display = 'block';

    const editInput = editForm.querySelector('[name="content"]');
    const commentContentText = commentContent.textContent.trim();
    editInput.value = commentContentText;

    // 취소 버튼 클릭 시 원래 상태로 되돌리기
    cancelBtn.addEventListener('click', (e) => {
      e.preventDefault();
      commentContent.style.display = 'block';
      editForm.style.display = 'none';
    });
  }
});

commentList.addEventListener('submit', async (e) => {
	  e.preventDefault();

	  const commentNo = e.target.closest('.comment-item').dataset.commentId;
	  const commentItem = e.target.closest('.comment-item');
	  const commentContent = commentItem.querySelector('.comment-content');
	  const editForm = commentItem.querySelector('.comment-edit-form');
	  const editInput = editForm.querySelector('[name="content"]');
	  const updatedContent = editInput.value;
	  
	  console.log(commentNo);
	  console.log(commentItem);
	  console.log(commentContent);
	  console.log(editForm);
	  console.log(editInput);
	  console.log(updatedContent);
	  
	  const commentWriter = commentItem.querySelector('.writer').textContent;
	  const commentEmpId = commentItem.querySelector('.comment-empId').value;
	  const csrfHeader = "${_csrf.headerName}";
	  const csrfToken = "${_csrf.token}";
	  const headers = {};
	  headers[csrfHeader] = csrfToken;

	  $.ajax({
	    url: '${pageContext.request.contextPath}/board/boardCommentUpdate.do',
	    type: 'POST',
	    contentType: 'application/json',
	    data: JSON.stringify({
	      no: commentNo,
	      content: updatedContent,
	      writer: commentWriter,
	      empId: commentEmpId
	    }),
	    headers,
	    success: function(data) {
	      // 수정된 댓글 내용을 화면에 반영
	      commentContent.textContent = updatedContent;
	      commentContent.style.display = 'block';
	      editForm.style.display = 'none';
	    },
	    error: function(xhr, status, error) {
	      console.error(error);
	      alert('댓글 수정 중 오류가 발생했습니다.');
	    }
	  });
	});
</script>
<script>
const deleteBtnList = document.querySelectorAll('#comment-delete-btn');
deleteBtnList.forEach((deleteBtn) => {
  deleteBtn.addEventListener('click', (e) => {
    const commentNo = e.target.dataset.commentNo;
    e.preventDefault();
    const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    console.log(commentNo);
    if (confirm("댓글을 삭제하시겠습니까?")) {
      $.ajax({
        url: '${pageContext.request.contextPath}/board/boardCommentDelete.do',
        method: "POST",
        data: {commentNo},
        headers,
        success(data) {
          console.log(data);
          location.href = '${pageContext.request.contextPath}/board/boardDetail.do?no=${board.no}';
        },
        error: console.log
      });
    }
  });
});
</script>
<script>
  document.querySelector('#deleteBtn').addEventListener("click", (e) => {
    e.preventDefault();
    const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    if (confirm("게시물을 삭제하시겠습니까?")) {
      $.ajax({
        url: '${pageContext.request.contextPath}/board/boardDelete.do',
        method: "POST",
        data: {no: "${board.no}"},
        headers,
        success(data) {
          console.log(data);
          location.href = '${pageContext.request.contextPath}/board/boardList.do';
        },
        error: console.log
      });
    }
  });
</script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>