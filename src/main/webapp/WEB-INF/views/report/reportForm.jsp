<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<!-- summernote 사용 css 및 js -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Report" name="title"/>
	</jsp:include>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/report.css">
	
	<jsp:include page="/WEB-INF/views/report/reportLeftBar.jsp" />
	
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">보고서 타이틀</div>
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
						
						<!-- 보고자 제외 버튼 -->
						<div class="div-report-no">
							<div class="row">
								<div class="columns">
									<button class="font-small" data-open="exampleModal1">보고자 제외</button>
									<!-- 모달 -->
									<div class="report-no-modal reveal" id="exampleModal1" data-reveal>
										<h5>보고자 제외</h5>
										<div>
											<div>
												<p class="font-small report-no-modal-title">미보고자</p>
												<fieldset class="fieldset report-no-modal-fieldset">
													<!-- <legend>미보고자</legend> -->
													<input id="checkAll" type="checkbox" onchange="checkAll();"><label for="checkAll" class="font-small">전체</label><br />
													<input id="checkbox12" name="unreport" type="checkbox" onchange="checkEach(this);"><label for="checkbox12" class="font-small">아아아 대표이사</label><br />
													<input id="checkbox22" name="unreport" type="checkbox" onchange="checkEach(this);"><label for="checkbox22" class="font-small">어어어 사장</label><br />
													<input id="checkbox32" name="unreport" type="checkbox" onchange="checkEach(this);"><label for="checkbox32" class="font-small">오오오 팀장</label><br />
													<script>
												        /**
												         * 전체선택 또는 전체해제
												         */
												        const checkAll = () => {
												            const unreports = document.querySelectorAll("[name=unreport]");
												            console.log(unreports);
												
												            const checkAll = document.getElementById("checkAll");
												            for (let i = 0; i < unreports.length; i++) {
												                const unreport = unreports[i];
												                unreport.checked = checkAll.checked;
												            }
												        }; // checkAll() end
												
												        /**
												         * 개별체크박스를 통해 전체선택 제어
												         */
												        const checkEach = (unreport) => {
												            console.log('checkEach', unreport);
												            const unreports = document.querySelectorAll("[name=unreport]");
												            
												            // false여부 판단
												            for (let i = 0; i < unreports.length; i++) {
												                if (!unreports[i].checked) {
												                    document.getElementById("checkAll").checked = false;
												                    return; // 조기리턴
												                }
												            }
												            document.getElementById("checkAll").checked = true;
												        }
												    </script>
												</fieldset>
											</div>
										</div>
										<div class="font-small report-no-modal-btn">
											<button>확인</button>
											<button data-close aria-label="Close reveal">취소</button>
										</div>
										<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 미보고자 -->
						<div class="div-unreport font-small">
							<div class="div-unreport-title"><span>미보고자</span></div>
							<div class="div-unreport-all">
								<div class="div-unreport-one">
									<div>
										<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
									</div>
									<div class="left">OOO 대표이사</div>
								</div>
								<div class="div-unreport-one">
									<div>
										<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
									</div>
									<div class="left">OOO 사장</div>
								</div>
							</div>
						</div>
						
						<!-- 보고 작성 -->
						<div class="div-report-write">
							<div class="div-padding div-report-write-name">dkdkdkdk</div>
							<div class="div-padding div-report-write-content">
								<textarea id="summernote" name="memo"></textarea>
								<script>
									$('#summernote').summernote({
										placeholder: 'Hello stand alone ui',
										tabsize: 2,
										height: 350,
										width: '100%',
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
								<!-- <textarea rows="10" cols="10"></textarea> -->
							</div>
							<div class="div-padding div-report-write-btn">
								<button>등록</button>
							</div>
						</div>
						
						<!-- 보고 댓글 -->
						<div class="div-report-commend">
							<div>댓글</div>
							<div class="div-report-commend-all">
								<div>
									<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
								</div>
								<div>
									<textarea rows="1"></textarea>
								</div>
								<div>
									<button class="font-small">댓글작성</button>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>