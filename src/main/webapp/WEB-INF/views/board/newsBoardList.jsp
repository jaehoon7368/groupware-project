<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/newsBoardList.css">


	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">이주의 IT뉴스</div>
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
 	
	 	<section class="write-wrap">
		  <form action="" id="writeFrm">
		    <div class="form-wrap">
  			<input type="hidden" id="empId" name="empId" value="${loginMember.empId}">
  			<input type="hidden" id="wrtier" name="writer" value="${loginMember.name}">
		    <input type="hidden" id="title" name="title" value="이번주 IT뉴스">
		      <div class="text-wrap">
		        <textarea></textarea>
		        <div class="button-wrap">
		          <button>첨부파일</button>
		          <button class="write-btn">글쓰기</button>
		        </div>
		      </div>
		    </div>
		  </form>
		</section>

<div class="div-padding"></div>

 <section class="content-wrap">
 <form action="" id="contentFrm">
 	<div class="tool-wrap">
	 	<div class="info-wrap">
	 		<span class="writer-img">
				<a href="#" id="home-my-img"> <img src="${pageContext.request.contextPath}/resources/images/sample.jpg"alt="" class="my-img"></a>
			</span>
			<span class="writer">${board.writer}</span>
			<span id="createdDate" class="createdDate">
				<fmt:parseDate value="${board.createdDate}" pattern="yyyy-MM-dd'T'HH:mm" var="createdDate" />
				<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd EEE HH:mm"/>
			</span>
	 	</div>

 	</div>
 	
 	<div class="div-padding"></div>
 	<div class="content-view">
 		<input type="hidden" id="boardNo" name="boardNo" value="board.no"/>
 		<span class="content" >${board.content}</span>
 	</div>
 	<div class="div-padding"></div>
 	
 	<div class="div-padding"></div>
 	<div class="div-padding"></div>
 	<div class="view-option">
 		<div class="comment">
 			<span>말풍선</span>
 			<span>댓글</span>
 			<span>0</span>
 			<span class="part">|</span>
 		</div>
 		<div class="likeCount">
 			<span>하트</span>
 			<span>좋아요</span>
 			<span>${board.likeCount}</span>
 		</div>
 	</div>

 
<div class="div-report-commend">
    <div>댓글</div>
    <div class="div-report-commend-all">
        <div>
            <img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
        </div>
        <div>
            <form action="${pageContext.request.contextPath}/commentWrite.do" id="commentWriteFrm" method="post">
                <input type="hidden" name="board_no" value="${board.no}" />
                <input type="hidden" name="comment_level" value="0" />
                <textarea rows="1" name="content"></textarea>
                <div>
                    <button class="font-small">댓글작성</button>
                </div>
            </form>
        </div>
    </div>
</div>
</form>
 </section>
</div>
</div>

<script>
//게시물 작성 버튼 클릭 이벤트 처리
document.querySelector("#writeFrm").addEventListener('submit', (e) => {
  e.preventDefault(); // 기본 동작 취소
  const formData = $(e.target).serialize(); // form 데이터 가져오기
  $.ajax({
    type: "POST",
    url: "/write.do", // 게시물 작성 처리하는 서버 API 주소
    data: formData,
    success: function(result) {
      // 게시물 작성 성공 시 처리
      const board = JSON.parse(result); // 서버에서 반환한 JSON 데이터 파싱
      // content 폼의 게시물 목록에 추가
      let content = '<div class="board">';
      content += `<span class="writer">${board.writer}김사장</span>`;
      content += `<span class="createdDate">${board.createdDate}</span>`;
      content += `<span class="content">${board.content}</span>`;
      content += '<div class="view-option"><div class="comment">';
      content += '<span>말풍선</span><span>댓글</span><span>0</span>';
      content += '<span class="part">|</span></div><div class="likeCount">';
      content += '<span>하트</span><span>좋아요</span><span>' + `${board.likeCount}` + '</span></div></div>';
      content += '</div>';
      $(".content-view").prepend(content); // content 폼의 게시물 목록 맨 앞에 추가
      // 게시물 작성 폼 초기화
      $("textarea").val("");
    },
    error: function(error) {
      // 게시물 작성 실패 시 처리
      console.log(error);
    }
  });
});

/* //댓글 작성 버튼 클릭 이벤트 처리
document.querySelector("#commentWriteFrm").addEventListener('submit', (e) => {
e.preventDefault(); // 기본 동작 취소
const formData = $(this).serialize(); // form 데이터 가져오기
$.ajax({
  type: "POST",
  url: "/commentWrite.do", // 댓글 작성 처리하는 서버 API 주소
  data: formData,
  success: function(result) {
    // 댓글 작성 성공 시 처리
    const comment = JSON.parse(result); // 서버에서 반환한 JSON 데이터 파싱
    // 댓글 목록에 추가
    const content = '<div class="comment">';
    content += '<span class="writer">' + comment.writer + '</span>';
    content += '<span class="createdDate">' + comment.createdDate + '</span>';
    content += '<span class="content">' + comment.content + '</span>';
    content += '<button class="font-small">답글</button>';
    content += '</div>';
    $(this).parent().parent().before(content); // 댓글 목록 맨 앞에 추가
    // 댓글 작성 폼 초기화
    $("textarea").val("");
 	 }
  });
}); */
</script>


<!-- <script>
//게시물 작성 버튼 클릭 이벤트 처리
document.writeFrm.addEventListener('submit', (e) => {
  e.preventDefault(); // 기본 동작 취소
  const formData = $(this).serialize(); // form 데이터 가져오기
  $.ajax({
    type: "POST",
    url: "/write.do", // 게시물 작성 처리하는 서버 API 주소
    data: formData,
    success: function(result) {
      // 게시물 작성 성공 시 처리
      const board = JSON.parse(result); // 서버에서 반환한 JSON 데이터 파싱
      // content 폼의 게시물 목록에 추가
      const content = '<div class="board">';
      content += '<span class="writer">' + board.writer + '김사장</span>';
      content += '<span class="createdDate">' + board.createdDate + '</span>';
      content += '<span class="content">' + board.content + '</span>';
      content += '<div class="view-option"><div class="comment">';
      content += '<span>말풍선</span><span>댓글</span><span>0</span>';
      content += '<span class="part">|</span></div><div class="readCount">';
      content += '<span>조회</span><span>' + board.readCount + '</span>';
      content += '<span class="part">|</span></div><div class="likeCount">';
      content += '<span>하트</span><span>좋아요</span><span>' + board.likeCount + '</span></div></div>';
      content += '</div>';
      $(".content-view").prepend(content); // content 폼의 게시물 목록 맨 앞에 추가
      // 게시물 작성 폼 초기화
      $("textarea").val("");
    },
    error: function(error) {
      // 게시물 작성 실패 시 처리
      console.log(error);
    }
  });
});

// 댓글 작성 버튼 클릭 이벤트 처리
document.contentFrm.addEventListener('submit', (e) => {
  e.preventDefault(); // 기본 동작 취소
  const formData = $(this).serialize(); // form 데이터 가져오기
  $.ajax({
    type: "POST",
    url: "/commentWrite.do", // 댓글 작성 처리하는 서버 API 주소
    data: formData,
    success: function(result) {
      // 댓글 작성 성공 시 처리
      const comment = JSON.parse(result); // 서버에서 반환한 JSON 데이터 파싱
      // 댓글 목록에 추가
      const content = '<div class="comment">';
      content += '<span class="writer">' + comment.writer + '</span>';
      content += '<span class="createdDate">' + comment.createdDate + '</span>';
      content += '<span class="content">' + comment.content + '</span>';
      content += '<button class="font-small">답글</button>';
      content += '</div>';
      $(this).parent().parent().before(content); // 댓글 목록 맨 앞에 추가
      // 댓글 작성 폼 초기화
      $("textarea").val("");
</script> -->

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>