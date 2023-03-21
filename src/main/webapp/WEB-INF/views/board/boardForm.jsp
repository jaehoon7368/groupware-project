 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardForm.css">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<style>
	body
</style>
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
						<div class="div-padding"></div>

<section class="content">

	<div class="target-select">
		<span>To.</span>
		<select value="" id="">
			<option value="">전사게시판</option>
			<option value="">부서게시판</option>
		</select>
		<select name="" id="">
			<option value="">전사 공지</option>
			<option value="">Local Policy</option>
			<option value="">주간 식단표</option>
			<option value="">IT뉴스</option>
		</select>
	</div>


  <form method="post">
  	<table class="write-table">
  		<tr>
  			<th>
  				<span class="title">제목</span>
  			</th>
  			<td><input type="text"/></td>
  		</tr>
  		<tr>
  			<th>
  				<span class="file">첨부파일</span>
  			</th>
  			<td><input type="text"/></td>
  		</tr>
  	</table>
  	
  	<div ="editor">
  		<th>
  			<td>
			 	 <textarea id="summernote" name="memo"></textarea>  			
  			</td>
  		</th>
  	</div>
  	
  	<table class="check-table">
  		<tr>
  			<th>공개 설정</th>
  			<td><input type="checkbox"/>공개</td>
  			<td><input type="checkbox"/>비공개</td>
  		</tr>
  		<tr>
  			<th>공지로 등록</th>
  			<td><input type="checkbox"/> 공지로 등록</td>
  		</tr>
  		<tr>
  			<th>알림</th>
  			<td><input type="checkbox"/> 메일알림</td>
  			<td><input type="checkbox"/> 푸시알림</td>
  		</tr>
  	</table>
</form>
	<div class="div-padding div-report-write-btn">
		<button>등록</button>
		<button>임시저장</button>
	</div>




</section>





  	
  
  </div>
		</div>
		<script>
		  $('#summernote').summernote({
		      placeholder: 'Hello stand alone ui',
		      tabsize: 2,
		      height: 350,
		      width: 1350,
		      toolbar: [
		        ['style', ['style']],
		        ['font', ['bold', 'underline', 'clear']],
		        ['color', ['color']],
		        ['para', ['ul', 'ol', 'paragraph']],
		        ['table', ['table']],
		        ['insert', ['link', 'picture', 'video']],
		        ['view', ['fullscreen', 'codeview', 'help']]
		      ]
		    });
		  </script>
		  	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
