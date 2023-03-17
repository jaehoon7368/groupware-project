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
	<form action="">
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
						<span class="btn-wrap">
							<span>+</span>
							<span>게시판 그룹 선택</span>
						</span>
					</td>
				</tr>
			<tr>
	  			<th>
	  				<span class="title">제목</span>
	  			</th>
	  			<td>
	  				<input type="text" class="padding-input"/>
	  			</td>
	  		</tr>
	  		<tr>
	  			<th>
	  				<span>설명</span>
	  			</th>
	  			<td>
	  				<div class="textarea-wrap">
	  					<textarea name="" id="" cols="100" rows="2"></textarea>
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
								<label for="">
									<input type="radio" name="type" value="classic" checked="checked"/>
									<span>이미지</span>
									<span>클래식</span>
								</label>
							</li>
							<li>
								<label for="">
									<input type="radio" name="type" value="stream" checked="checked"/>
									<span>이미지</span>
									<span>피드</span>
								</label>
							</li>
						</ul>
						<div class="desc">※ 게시판 유형은 나중에 변경하실 수 없습니다.</div>
					</td>
			</tr>
			<tr class="line">
				<td colspan="2">
					<hr>
				</td>
			</tr>
			<tr>
				<th>
					<span>공유 부서 설정</span>
				</th>
				<td>
					<span class="wrap-option">
						<input type="radio" />
						<lebel>사용함</lebel>
					</span>
					<span class="wrap-option">
						<input type="radio" checked="checked"/>
						<lebel>사용하지 않음</lebel>
					</span>
						<div class="desc">※ 게시판을 공유할 부서를 지정하세요</div>
				</td>
			</tr>
			<tr class="line">
				<td colspan="3">
					<hr>
				</td>
			</tr>
			<tr>
				<th>
					<span>비공개 설정</span>
				</th>
				<td>
					<span class="wrap-option">
						<input type="radio" />
						<lebel>사용함</lebel>
					</span>
					<span class="wrap-option">
						<input type="radio" checked="checked"/>
						<lebel>사용하지 않음</lebel>
					</span>
						<div class="desc">※ 게시판을 공개할 멤버를 지정하세요.</div>
				</td>
			</tr>
			<tr class="line">
				<td colspan="3">
					<hr>
				</td>
			</tr>
			<tr>
				<th>
					<span>익명 설정</span>
				</th>
				<td>
					<span class="wrap-option">
						<input type="radio" />
						<lebel>사용함</lebel>
					</span>
					<span class="wrap-option">
						<input type="radio" checked="checked"/>
						<lebel>사용하지 않음</lebel>
					</span>
						<div class="desc">※ 익명 설정은 나중에 변결하실 수 없습니다.</div>
				</td>
			</tr>
			<tr class="line">
				<td colspan="3">
					<hr>
				</td>
			</tr>
			<tr>
				<th>
					<span>말머리</span>
				</th>
				<td>
					<span class="wrap-option">
						<input type="radio" />
						<lebel>사용함</lebel>
					</span>
					<span class="wrap-option">
						<input type="radio" checked="checked"/>
						<lebel>사용하지 않음</lebel>
					</span>
				</td>
			</tr>
			<tr class="line">
				<td colspan="3">
					<hr>
				</td>
			</tr>
			<tr>
				<th>
					<span>댓글 작성</span>
				</th>
				<td>
					<span class="wrap-option">
						<input type="radio" checked="checked" />
						<lebel>허용</lebel>
					</span>
					<span class="wrap-option">
						<input type="radio" />
						<lebel>허용하지 않음</lebel>
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
	</form>
	
	<div class="div-padding div-report-write-btn">
		<button>만들기</button>
		<button>취소</button>
	</div>
</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>