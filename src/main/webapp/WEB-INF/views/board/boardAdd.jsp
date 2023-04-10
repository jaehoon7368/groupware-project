<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardAdd.css">

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="게시판" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/board/boardLeftBar.jsp" />
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">게시판 추가</div>
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
	<form:form action="${pageContext.request.contextPath}/board/boardTypeAdd.do" method="post" name="boardTypeAddFrm">
		<table class="board-add">
			<colgroup>
				<col width="130px">
				<col width="*">
			</colgroup>
			
			<tbody>
				<tr>
					<th>
						<span class="title">게시판 그룹</span>
					</th>
					<td>
						<span class="select-wrap">
							<select name="" id="select-group" style="width:100px;">
								<option value="">다우그룹</option>
							</select>
						</span>
					</td>
				</tr>
			<tr>
	  			<th>
	  				<span class="title">제목</span>
	  			</th>
	  			<td>
	  				<input type="text" name="title" id="title" class="padding-input"/>
	  			</td>
	  		</tr>
	  		<tr>
	  			<th>
	  				<span>설명</span>
	  			</th>
	  			<td>
	  				<div class="textarea-wrap">
	  					<textarea name="explain" id="explain" cols="100" rows="2"></textarea>
	  				</div>
	  			</td>
	  		</tr>
	  		<tr>
				<th>
					<span class="title">유형</span>
				</th>
					<td>
						<ul>
							<li>
								<input type="radio" name="category" id="classic" value="C" checked/>
								<label for="classic">이미지 클래식</label>
							</li>
							<li>
								<input type="radio" name="category" id="feed" value="F"/>
								<label for="feed">이미지 피드</label>
							</li>
						</ul>
						<div class="desc">※ 게시판 유형은 나중에 변경하실 수 없습니다.</div>
					</td>
				</tr>
			
				<tr style="display:none;">
					<th>
						<span>댓글 작성</span>
					</th>
					<td>
						<span class="wrap-option">
							<input type="radio" name="commentYn" id="commentTypeY" value="Y" checked/>
							<label for="commentTypeY">허용</label>
						</span>
						<span class="wrap-option">
							<input type="radio" name="commentYn" id="commentTypeN" value="N"/>
							<label for="commentTypeN">허용하지 않음</label>
						</span>
					</td>
				</tr>
				<tr class="line">
					<td colspan="3">
						<hr>
					</td>
				</tr>
				
			</tbody>
		</table>
		<div class="div-padding div-report-write-btn">
			<button type="submit">만들기</button>
			<button type="button">취소</button>
		</div>
	</form:form>
	<script>
		document.boardTypeAddFrm.addEventListener('submit', (e) => {
			const title = e.target.title;
			const explain = e.target.explain;

			if (/^\s+$/.test(title.value) || !title.value) {
				alert('제목을 작성해주세요.');
				title.select();
				return false;
			};
			
			if (/^\s+$/.test(explain.value) || !explain.value) {
				alert('설명을 작성해주세요.');
				explain.select();
				return false;
			};
		});
	</script>
	
</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>