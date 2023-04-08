<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board/newsBoardList.css">


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="사진 게시판" name="title" />
</jsp:include>

<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />

<div class="home-container">
	<!-- 상단 타이틀 -->
	<div class="top-container">
		<div class="container-title">
			<c:forEach items="${sessionScope.boardTypeList}" var="boardType">
				<c:if test="${boardType.no == param.no}">${boardType.title}</c:if>
			</c:forEach>
		</div>
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
		<!-- 글 작성폼 -->
		<section class="write-wrap">
			<form name="writeFrm">
				<div class="form-wrap">
					<input type="hidden" id="empId" name="empId"value="${loginMember.empId}"> 
						<input type="hidden"id="wrtier" name="writer" value="${loginMember.name}"> 
						<input type="hidden" id="title" name="title" value="피드게시판">
						<input type="hidden" id="bType" name="bType" value="${param.no}">
					<div class="text-wrap">
						  <textarea id="content" name="content"></textarea>
						  <div class="upfile-img">
						  </div>
						  <div class="button-wrap">
						    <span id="fileName" style="padding-left: 10px;"></span>
						    <input type="file" name="upFile" id="upFile" style="display: none" onchange="displayFileNames()" multiple />
						    <label for="upFile" class="file">
						      <img src="${pageContext.request.contextPath}/resources/images/clip.png" alt="첨부파일" />
						    </label>
						    <input type="submit" id="write-btn" value="글쓰기" />
						  </div>
					</div>
				</div>
			</form>
		</section>

		<div id="div-padding"></div>

		<!-- 게시글 내용 -->
		<section class="content-wrap">
			<form name="contentFrm">
				<div class="content-border">
					<c:forEach var="board" items="${boardList}" varStatus="status">
					<div class="board-item" data-board-no="${board.no}" data-emp-id="${board.empId}">
					<input type="hidden" id="boardNo" name="boardNo" class="like-item" data-board-no="${board.no}" value="${board.no}">
					<div class="foreach-border">
						<div class="tool-wrap">
							<div class="info-wrap">
								<span class="writer-img">
									<c:if test="${empty board.renameFilename}">
										<img src="${pageContext.request.contextPath}/resources/upload/emp/default.png" class="my-img">
									</c:if>
									<c:if test="${!empty board.renameFilename}">
										<img src="${pageContext.request.contextPath}/resources/upload/emp/${board.renameFilename}" class="my-img">
									</c:if>
								</span> <span class="writer">${board.writer}</span> <span
									id="createdDate" class="createdDate"> 
									<fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" /> 
									<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd EEE HH:mm" />
								</span>
								<span clas="content-update-wrap">
									<button type="button" id ="edit-post-btn" class="board-edit-btn" data-board-no="${board.no}">수정</button>
									<button type="button" id ="delete-board-btn" class="delete-board-btn" data-board-no="${board.no}">삭제</button>
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
							<input type="hidden" id="no" name="no" value="${board.no}" />
							<input type="hidden" id="boardNo" name="boardNo" class="like-item" data-board-no="${board.no}" value="${board.no}">
							<div class="content-view-wrap">
								<span class="content" id="post-conten-${board.no}">${board.content}</span>
							</div>
						</div>
						<div class="div-padding"></div>
						
						<div class="file" style="display:flex;">
						  <c:forEach items="${board.attachments}" var="attach" varStatus="vs">
						    <c:set var="extension" value="${fn:substring(attach.originalFilename, fn:length(attach.originalFilename) - 3, fn:length(attach.originalFilename))}"/>
						    <c:choose>
						      <c:when test="${extension == 'jpg' || extension == 'jpeg' || extension == 'png' || extension == 'gif'}">
						        <img class="img-thumbnail" src="${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}" style="width: 200px; height: 200px;"
						         alt="${attach.originalFilename}" onclick="openModal('${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}', '${attach.originalFilename}')">
						      </c:when>
						      <c:otherwise>
						        <button type="button" class="btn btn-outline-success btn-block" onclick="location.href='${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}'; ">
						          첨부파일${vs.count} - ${attach.originalFilename}
						        </button>
						      </c:otherwise>
						    </c:choose>	    
						  </c:forEach>
						</div>
						<div class="div-padding"></div>
						<div class="div-padding"></div>
						<div class="view-option">
							<div class="comment">
								<span>댓글</span>  <span>${board.commentCount}</span> <span class="part">|</span>
							</div>
							<div class="likeCount">
								<span>좋아요</span> <span class="likeCount">${board.likeCount}</span>
							</div>
						</div>
						
						<!-- 댓글  -->
	
						<div class="div-report-commend">
							<div>댓글</div>
							    <div class="commentList-view">
							      <c:forEach var="comment" items="${board.commentList}" varStatus="status">
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
							              <button type="button" id ="comment-edit-btn" class="comment-edit-btn" data-comment-no="${comment.no}">수정</button>
							              <button type="button" id="comment-delete-btn" class="comment-delete-btn" data-comment-no="${comment.no}">삭제</button>
							            </span>
							          </div>
							          <div class="commentlist-content-wrap">
							            <span id="comment-content" class="comment-content" name="content" style="margin-left: 60px;">${comment.content}</span>
							            <form class="comment-edit-form" >
							              <textarea name="content" class="comment-edit-textarea" style="display: none;"></textarea>
							              <button type="submit" class="comment-edit-submit" style="display: none; data-comment-no="${comment.no}">저장 </button>
							              <button type="button" class="comment-edit-cancel" style="display: none; data-comment-no="${comment.no}">취소</button>
							            </form>
							          </div>
							        </div>
							      </c:forEach>
							    </div>
							
							<!-- 댓글 작성  -->
							<div class="div-report-commend-all" >
							  <form id= "commentFrm${board.no}" data-board-no="${board.no}" method="post">
							    <div>
							      <c:if test="${!empty sessionScope.loginMember.attachment}">
									<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
								</c:if>
								<c:if test="${empty sessionScope.loginMember.attachment}">
									<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img">
								</c:if>	
							    </div>
							    <div class="comment-input">
							      <input type="hidden" id="_no" name="no" value="${board.no}">
							      <input type="hidden" id="_empId" name="empId" value="${loginMember.empId}">
							      <input type="hidden" id="_writer" name="writer" value="${loginMember.name}">
							      <input type="hidden" id ="_comment_Level" name="comment_level" value="0" />
							      <input type="hidden" id = "_refCommentNo" name="refCommentNo" value="${board.no}" />
							      <textarea rows="1" id="_content" name="content" style="resize: none;" ></textarea>
							    </div>
							    <div class="comment-submit">
							      <input type="button" id="submit-comment" value="댓글 작성" onclick="submitComment()">
							    </div>
							  </form>
							</div>
						</div>
					</div>
					</div>
					</c:forEach>
				</div>
			</form>
		</section>
	</div>
	
						<%-- <!-- 수정폼 -->
						   <form name="contentEditFrm" id="contentEditFrm">
								<div class="form-wrap">
									<input type="hidden" id="empId" name="empId"value="${loginMember.empId}"> 
										<input type="hidden"id="wrtier" name="writer" value="${loginMember.name}"> 
										<inputtype="hidden" id="title" name="title" value="이번주 IT뉴스"> 
										<inputtype="hidden" id="bType" name="bType" value="N">
									<div class="text-wrap">
										  <textarea id="content" name="content"></textarea>
										  <div class="upfile-img">
										  </div>
										  <div class="button-wrap">
										    <span id="fileName" style="padding-left: 10px;"></span>
										    <input type="file" name="upFile" id="upFile" style="display: none" onchange="displayFileNames()" multiple />
										    <label for="upFile" class="file">
										      <img src="${pageContext.request.contextPath}/resources/images/clip.png" alt="첨부파일" />
										    </label>
										    <input type="submit" id="write-btn" value="글쓰기" />
										  </div>
									</div>
								</div>
							</form>
						  <!-- 수정폼 end --> --%>

</div> <!-- 본문 end -->

<!-- 게시글 수정 -->
<script>
/* const editBtn = document.querySelector('.board-edit-btn');
editBtn.addEventListener('click', (e) => {
e.preventDefault();
const postContent = document.querySelector('.post-content');
const editForm = document.querySelector('.edit-form');
const cancelBtn = editForm.querySelector('.edit-cancel'); // 취소 버튼 추가

postContent.style.display = 'none';
editForm.style.display = 'block';

const editTitleInput = editForm.querySelector('[name="title"]');
const editContentInput = editForm.querySelector('[name="content"]');
const postTitle = document.querySelector('.post-title').innerText.trim();
const postContentText = postContent.innerText.trim();
editTitleInput.value = postTitle;
editContentInput.value = postContentText;

// 취소 버튼 클릭 시 원래 상태로 되돌리기
cancelBtn.addEventListener('click', (e) => {
e.preventDefault();
postContent.style.display = 'block';
editForm.style.display = 'none';
});
}); */
</script> 

<!-- 댓글 -->
<script>
function submitComment() {
	const no = $(event.target).closest('.div-report-commend-all').find('input[name="no"]').val();
	const empId = $(event.target).closest('.div-report-commend-all').find('input[name="empId"]').val();
	const writer = $(event.target).closest('.div-report-commend-all').find('input[name="writer"]').val();
	const comment_level = $(event.target).closest('.div-report-commend-all').find('input[name="comment_level"]').val();
	const refCommentNo = $(event.target).closest('.div-report-commend-all').find('input[name="refCommentNo"]').val();
	const content = $(event.target).closest('.div-report-commend-all').find('textarea[name="content"]').val();
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;

	console.log(no);
	console.log(empId);
	console.log(writer);
	console.log(comment_level);
	console.log(refCommentNo);
	console.log(content);
	$.ajax({
		type: 'POST',
		url: '${pageContext.request.contextPath}/board/commentEnroll.do',
		contentType: 'application/json',
		data: JSON.stringify({
			no: no,
			empId: empId,
			writer: writer,
			comment_level: comment_level,
			refCommentNo: refCommentNo,
			content: content
		}),
		headers,
		success: function(response) {
			location.href = "${pageContext.request.contextPath}/board/boardTypeList.do?no=${param.no}&category=${param.category}";
		},
		error: function(xhr, status, error) {
			alert('댓글 작성에 실패했습니다.');
		}
	});
}
</script>
<!-- 게시글삭제 -->
<script>
const boardDeleteBtnList = document.querySelectorAll('.delete-board-btn');
	boardDeleteBtnList.forEach((boardDeleteBtn) => {
		boardDeleteBtn.addEventListener('click', (e) => {
			e.preventDefault();
			const no = e.target.dataset.boardNo;
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
			console.log(no);
			if (confirm("게시글을 삭제하시겠습니까?")) {
				$.ajax({
			        url: '${pageContext.request.contextPath}/board/boardDelete.do',
			        method: "POST",
			        data: {no},
			        headers,
			        success(data) {
			          console.log(data);
			          location.href = "${pageContext.request.contextPath}/board/boardTypeList.do?no=${param.no}&category=${param.category}";
			        },
			        error: console.log
			      });
			    }
			  });
			});
</script>

<!-- 댓글삭제 -->
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
          location.href = "${pageContext.request.contextPath}/board/boardTypeList.do?no=${param.no}&category=${param.category}";
        },
        error: console.log
      });
    }
  });
});
</script>
<script>
function openModal(imgSrc, imgAlt) {
	var modal = document.createElement('div');
	modal.className = 'modal';
	var modalContent = document.createElement('div');
	modalContent.className = 'modal-content';
	var img = document.createElement('img');
	img.src = imgSrc;
	img.alt = imgAlt;
    var closeBtn = document.createElement('span');
	closeBtn.className = 'close';
	closeBtn.innerHTML = '&times;';
	closeBtn.onclick = function() {
		
	modal.style.display = 'none';
		document.body.removeChild(modal);
	 };
	 
	modalContent.appendChild(img);
	modalContent.appendChild(closeBtn);
	modal.appendChild(modalContent);
	document.body.appendChild(modal);
	modal.style.display = 'block';
}
</script>

<script>
function displayFileNames() {
	  const fileNameSpan = document.getElementById("fileName");
	  const upFileInput = document.getElementById("upFile");
	  const fileList = upFileInput.files; // 선택된 파일 리스트
	  let fileNames = "";

	  // upfile-img 클래스를 가진 div 태그 내부 초기화
	  const upFileImgDiv = document.querySelector(".upfile-img");
	  upFileImgDiv.innerHTML = "";

	  for (let i = 0; i < fileList.length; i++) {
	    const file = fileList[i];
	    const fileName = file.name;
	    if (i > 0) {
	      fileNames += ", ";
	    }
	    fileNames += fileName;

	    // 이미지 파일인 경우, 미리보기 이미지 생성
	    if (file.type.includes("image/")) {
	      const reader = new FileReader();
	      reader.readAsDataURL(file);
	      reader.onload = () => {
	        const img = document.createElement("img");
	        img.src = reader.result;
	        img.onload = () => {
	          // 이미지가 로드되면, 해당 이미지의 크기를 가져와 text-wrap의 높이를 조정합니다.
	          const textWrap = document.querySelector(".text-wrap");
	          const textWrapHeight = textWrap.offsetHeight;
	          const imgHeight = img.height;
	          const newHeight = textWrapHeight + imgHeight;
	          textWrap.style.height = `${newHeight}px`;

	          // content-wrap 영역도 text-wrap 영역만큼 내려가도록 설정합니다.
	          const contentWrap = document.querySelector(".content-wrap");
	          const contentWrapHeight = contentWrap.offsetHeight;
	          const newContentWrapHeight = contentWrapHeight + imgHeight;
	          contentWrap.style.height = `${newContentWrapHeight}px`;

	          upFileImgDiv.appendChild(img);
	        };
	        img.width = 150;
	        img.height = 150;
	      };
	    }
	  }

	  fileNameSpan.innerText = fileNames;
	}
</script>
<script>
document.querySelector("#write-btn").addEventListener('click', (e) => {
  e.preventDefault(); // 기본 동작 취소
  const csrfHeader = "${_csrf.headerName}";
  const csrfToken = "${_csrf.token}";
  const headers = {};
  headers[csrfHeader] = csrfToken;

  const formData = new FormData(document.forms["writeFrm"]);

  $.ajax({
    type: "POST",
    url: "${pageContext.request.contextPath}/board/boardEnroll.do",
    data: formData,
    enctype: 'multipart/form-data',
    processData: false,
    contentType: false,
    headers,
    success: function(board) {
      // 게시물 작성 성공 시 전체페이지를 리로드해온다.
      location.reload();
      // 게시물 작성 폼 초기화
      $("textarea").val("");
    }
  });
});
</script>
<script>
$(document).ready(function() {
    $('.board-item').each(function() {
        const boardNo = $(this).data('board-no');
        const empId = $(this).data('emp-id');
        const heartWrap = $(this).find('.heart-wrap');

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
                    // 좋아요를 누른 경우
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
                    // 좋아요를 누르지 않은 경우
                    const heartImage = heartWrap.find('.heart');
                    const fullHeartImage = heartWrap.find('.full-heart');
                    const likeCountEl = heartWrap.find('.like-count');

                    heartWrap.removeClass('liked');
                    heartImage.show();
                    fullHeartImage.hide();

                    // 좋아요 수 감소
                    if (likeCountEl !== null) {
                        const likeCount = parseInt(likeCountEl.text());
                        heartWrap.find('.like-count').text((likeCount - 1) + '');
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error(status + " : " + error);
            }
        });
    });
});
</script>

<script>
//게시글 목록
const boardList = document.querySelectorAll('.board-item');

// 각각의 게시글에 대해 이벤트 리스너 등록
boardList.forEach(function(board) {
  const heartWrap = board.querySelector('.heart-wrap');
  const heartImage = heartWrap.querySelector('.heart');
  const fullHeartImage = heartWrap.querySelector('.full-heart');

  heartWrap.addEventListener('click', function(e) {
    e.preventDefault();
    const boardNo = board.dataset.boardNo;
    const empId = board.dataset.empId;
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
          location.href = "${pageContext.request.contextPath}/board/boardTypeList.do?no=${param.no}&category=${param.category}";
        },
        error: function(xhr, status, error) {
          console.error(status + " : " + error);
        }
      });
    } else {
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
    		var likeCountEl = heartWrap.querySelector('.like-count');
    		if (likeCountEl !== null) {
    		var likeCount = parseInt(likeCountEl.textContent);
    		heartWrap.querySelector('.like-count').textContent = (likeCount - 1) + '';
    		}
    		} else {
    		console.log('좋아요 취소 처리 실패');
    		}
    		location.href = "${pageContext.request.contextPath}/board/boardTypeList.do?no=${param.no}&category=${param.category}";
    		},
    		error: function(xhr, status, error) {
    		console.error(status + " : " + error);
    		}
    		});
    }
  });
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />