 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

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
						<div class="div-padding"></div>

<section class="content">


  <form:form name="boardFrm" action="${pageContext.request.contextPath}/board/updateBoard.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
  
  	
	<div class="target-select">
	  <span>To.</span>
		  <select name="bType" id="bType">
			<c:forEach items="${sessionScope.boardTypeList}" var="boardType">
				<option value="${boardType.no}" ${board.BType == boardType.no ? 'selected' : ''}>${boardType.title}</option>
			</c:forEach>
		  </select>
	</div>

  <hr style="width:1000px;">
  	<table class="write-table">
  		<tr>
  			<th><input type="hidden" id="no" name="no" value="${board.no}"/></th>
  			<th>
  				<span class="title" id="title" name="title">제목</span>
  			</th>
  			<td><input type="text" id="title" name="title" value="${board.title}"></td>
  			<td><input type="hidden" id="empId" name="empId" value="${loginMember.empId}"></td>
  			<td><input type="hidden" id="wrtier" name="writer" value="${loginMember.name}"></td>
  		</tr>
  		<tr>
			<th>
			  <span class="file">첨부파일</span>
			</th>

			<td>
			  <input type="file" name="upFile" id="upFile" onchange="showSelectedFileName()"/>
			  <span id="selectedFileName">
			    <c:choose>
			      <c:when test="${not empty board.attachments}">
			        ${board.attachments[0].originalFilename}
			      </c:when>
			      <c:otherwise>
			        선택된 파일 없음
			      </c:otherwise>
			    </c:choose>
			  </span>
			</td>
  		</tr>
  	</table>
  	
	<hr style="width:1000px;">
			
  	<div class="editor">
  		<th>
  			<td>
			 	 <textarea id="summernote" name="content">${board.content}</textarea>  			
  			</td>
  		</th>
  	</div>
  
  	
	<div class="div-padding div-report-write-btn">
	  <input type="submit" value="수정"/>
	  <input type="button" value="취소" onclick="history.back()"/>
	</div>
</form:form>
</section>
  </div>
</div>
<script>
function showSelectedFileName() {
  var fileInput = document.getElementById("upFile");
  var fileNameSpan = document.getElementById("selectedFileName");
  
  if (fileInput.files.length > 0) {
    fileNameSpan.innerText = fileInput.files[0].name;
  } else if (fileInput.value) {
    fileNameSpan.innerText = fileInput.value.split("\\").pop();
  } else {
    fileNameSpan.innerText = "선택된 파일 없음";
  }
}
</script>

<script>
document.querySelectorAll("[name=upFile]").forEach((input) => {
    input.addEventListener('change', (e) => {
        const file = e.target.files[0];
        const label = e.target.nextElementSibling;
        
        if(label) { // label이 null인 경우에 대한 예외 처리
            if(file)
                label.innerHTML = file.name;
            else 
                label.innerHTML = '파일을 선택하세요';
        }
    });
});

$('#summernote').summernote({
	 placeholder: 'Hello stand alone ui',
	 tabsize: 2,
	 height: 350,
	 width: 1000,
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
		    
/* //form submit 시 content 값 수정
document.querySelector("form[name=boardFrm]").addEventListener('submit', (e) => {
	const content = document.querySelector('#summernote').value;
	const regex = /(<([^>]+)>)/gi; //정규식을 이용하여 태그 제거
	const contentValue = content.replace(regex, ""); //태그 제거한 내용만 가져오기
	document.querySelector('#summernote').value = contentValue; //태그 제거한 내용으로 content 값 변경
});     */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

