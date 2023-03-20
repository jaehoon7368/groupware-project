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
									<c:if test="${reportCheckList[0].writer == sessionScope.loginMember.empId}">
										<button class="font-small" data-open="exampleModal1">보고자 제외</button>
									</c:if>
									<!-- 모달 -->
									<div class="report-no-modal reveal" id="exampleModal1" data-reveal>
										<h5>보고자 제외</h5>
										<form name="unreportFrm">
											<div>
												<div>
													<p class="font-small report-no-modal-title">미보고자</p>
													<fieldset class="fieldset report-no-modal-fieldset">
														<input type="hidden" name="no" value="${param.no}" />
														<input id="checkAll" type="checkbox"><label for="checkAll" class="font-small">전체</label><br />
														<c:forEach items="${reportCheckList}" var="reportCheck">
															<input id="${reportCheck.empId}" name="unreport" type="checkbox" onchange="checkEach(this);" value="${reportCheck.empId}" data-name="${reportCheck.empName}" data-job-title=" ${reportCheck.jobTitle}" ${reportCheck.excludeYn == 'Y' ? 'checked' : ''}><label for="${reportCheck.empId}" class="font-small">${reportCheck.empName} ${reportCheck.jobTitle}</label><br />
														</c:forEach>
													</fieldset>
												</div>
											</div>
											<div class="font-small report-no-modal-btn">
												<button type="submit">확인</button>
												<button data-close aria-label="Close reveal">취소</button>
											</div>
											<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
												<span aria-hidden="true">&times;</span>
											</button>
										</form>
									</div>
									<script>
										/**
								         * 전체선택 또는 전체해제
								         */
										document.querySelector('#checkAll').addEventListener('change', (e) => {
											const unreportes = document.querySelectorAll("[name=unreport]");
								            console.log(unreportes);
								
								            const checkAll = document.getElementById("checkAll");
								            for (let i = 0; i < unreportes.length; i++) {
								                const unreport = unreportes[i];
								                unreport.checked = checkAll.checked;
								            }
										});
								
								        /**
								         * 개별체크박스를 통해 전체선택 제어
								         */
								        const checkEach = (unreport) => {
								            console.log('checkEach', unreport);
								            const unreportes = document.querySelectorAll("[name=unreport]");
								            
								            // false여부 판단
								            for (let i = 0; i < unreportes.length; i++) {
								                if (!unreportes[i].checked) {
								                    document.getElementById("checkAll").checked = false;
								                    return; // 조기리턴
								                }
								            }
								            document.getElementById("checkAll").checked = true;
								        };
								        
								        document.unreportFrm.addEventListener('submit', (e) => {
								        	e.preventDefault();
								        	
								    		const csrfHeader = "${_csrf.headerName}";
								    		const csrfToken = "${_csrf.token}";
								    		const headers = {};
								    		headers[csrfHeader] = csrfToken;
								    		
								    		const report = [];
								    		const unreport = [];
								    		const unreportes = e.target.unreport;
								    		for (let i = 0; i < unreportes.length; i++) {
								    			if (unreportes[i].checked) {
								    				unreport.push(unreportes[i].id);
								    			} 
								    			if (!unreportes[i].checked) {
								    				report.push(unreportes[i].id);
								    			}
								    		}
								    		
								    		const no = e.target.no.value;
								    		console.log(no);
								    		console.log(report);
								    		console.log(unreport);
								        	
								        	$.ajax({
								        		url: '${pageContext.request.contextPath}/report/updateExcludeYn.do',
								        		method: 'POST',
								        		headers,
								        		data: {report, unreport, no},
								        		success(data){
								        			console.log(data);
								        		},
								        		error: console.log,
								        		complete(){
								        			location.reload();
								        		}
								        	});
								        });
								    </script>
								</div>
							</div>
						</div>
						
						<!-- 제외된 보고자 -->
						<div>
							<div class="div-exception-report">
								<span>제외된 보고자:</span>
								<span class="div-exclude"></span>
							</div>
							<script>
								const div = document.querySelector('.div-exclude');
								div.innerText = '';
								const unreport = [];
								
								document.unreportFrm.unreport.forEach((unrepo, index) => {
									if (unrepo.checked) {
										unreport.push({id:unrepo.id, name:unrepo.dataset.name, jobTitle:unrepo.dataset.jobTitle});
									}
								});
								
								const size = unreport.length;
								console.log(size);
								if (size != 0) {
									unreport.forEach(({id, name, jobTitle}, index) => {
										div.innerText += `\${name} \${jobTitle}`;
										if (index + 1 != size)
											div.innerText += ', ';
									});
								} else {
									div.innerText = '없음';
								}
							</script>
						</div>
						
						<!-- 미보고자 -->
						<div class="div-unreport font-small">
							<div class="div-unreport-title"><span>미보고자</span></div>
							<div class="div-unreport-all">
								<c:forEach items="${reportCheckList}" var="reportCheck">
									<c:if test="${reportCheck.createYn == 'N' && reportCheck.excludeYn == 'N'}">
										<div class="div-unreport-one ${sessionScope.loginMember.empId == reportCheck.empId ? 'div-me' : ''}">
											<div>
												<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
											</div>
											<div class="left">${reportCheck.empName} ${reportCheck.jobTitle}</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						
						<!-- 보고 작성 -->
						<div class="div-report-write">
							<div class="div-padding div-report-write-name">${reportCheckList[0].title}</div>
							<form:form action="${pageContext.request.contextPath}/report/reportDetailEnroll.do" name="reportDetailFrm" method="POST">
								<div class="div-padding div-report-write-content">
									<input type="hidden" name="reportNo" value="${param.no}" />
									<textarea id="summernote" name="content"></textarea>
								</div>
								<div class="div-padding div-report-write-btn">
									<button type="submit">등록</button>
								</div>
							</form:form>
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