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
	
<style>
.navigation ul li a .icon i {
    position: relative;
    font-size: 1.7em;
    z-index: 1;
    margin-top: 20px;
}

.navigation ul li a .title {
    position: relative;
    display: block;
    padding-left: 10px;
    height: 60px;
    line-height: 60px;
    white-space: nowrap;
    font-weight: bold;
    font-size : 1.1em;
}
	
</style>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/report.css">
	
	<jsp:include page="/WEB-INF/views/report/reportLeftBar.jsp" />
	

					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div id="report-title" class="container-title">${reportCheckList[0].title} <span style="font-size: small;">(${reportCheckList[0].explain})</span></div>
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
						
						
						<!-- 보고자 제외 버튼 -->
						<div class="div-report-no">
							<div class="row">
								<div class="columns">
									<c:if test="${reportCheckList[0].writer == sessionScope.loginMember.empId}">
										<button class="font-small" data-open="exampleModal1">보고자 제외</button>
										<script>
											/* 모달 오픈 시 모든 사원 체크되어 있으면 전체선택도 체크 */
											document.querySelector('[data-open=exampleModal1]').addEventListener('click', (e) => {
												const unreportes = document.querySelectorAll('[name=unreport]');
												
												for (let i = 0; i < unreportes.length; i++) {
									                if (!unreportes[i].checked) {
									                    document.getElementById("checkAll").checked = false;
									                    return; // 조기리턴
									                }
									            }
									            document.getElementById("checkAll").checked = true;
											});
										</script>
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
															<input id="${reportCheck.empId}" name="unreport" type="checkbox" onchange="checkEach(this);" value="${reportCheck.empId}" data-name="${reportCheck.empName}" data-job-title=" ${reportCheck.jobTitle}" ${reportCheck.excludeYn == 'Y' ? 'checked' : ''}>
															<label for="${reportCheck.empId}" class="font-small">${reportCheck.empName} ${reportCheck.jobTitle}</label><br />
														</c:forEach>
													</fieldset>
												</div>
											</div>
											<div class="font-small report-no-modal-btn">
												<button type="submit">확인</button>
												<button type="button" data-close aria-label="Close reveal">취소</button>
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
								        
								        /* 보고자 제외 폼 제출 */
								        document.unreportFrm.addEventListener('submit', (e) => {
								        	e.preventDefault();
								        	
								    		const csrfHeader = "${_csrf.headerName}";
								    		const csrfToken = "${_csrf.token}";
								    		const headers = {};
								    		headers[csrfHeader] = csrfToken;
								    		
								    		const report = [];
								    		const unreport = [];
								    		const unreportes = e.target.querySelectorAll('[name=unreport]');
								    		console.log('unreportes', unreportes);
								    		
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
								
								const unreportAll = document.querySelectorAll('[name=unreport]');
								
								if (unreportAll.length > 0) {
									unreportAll.forEach((unrepo, index) => {
										if (unrepo.checked) {
											unreport.push({id:unrepo.id, name:unrepo.dataset.name, jobTitle:unrepo.dataset.jobTitle});
										}
									});
								}
								
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
										<div class="div-unreport-one">
											<div>
												<c:if test="${empty reportCheck.profileImg}">
													<img src="${pageContext.request.contextPath}/resources/images/default.png" class="my-img" />
												</c:if>
												<c:if test="${!empty reportCheck.profileImg}">
													<img src="${pageContext.request.contextPath}/resources/upload/emp/${reportCheck.profileImg}" class="my-img" />
												</c:if>
											</div>
											<div class="left">${reportCheck.empName} ${reportCheck.jobTitle}</div>
											<div class="div-me-btn">
												<c:if test="${sessionScope.loginMember.empId == reportCheck.empId}">
													<button class="div-me-btn-create" onclick="clickReportCreate(this);" type="button">보고 작성</button>
												</c:if>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						
						<!-- 보고 작성자 -->
						<div class="div-okreport font-small">
							<div class="div-okreport-title"><span>보고자 (보고자간 보고 ${reportCheck[0].createYn == 'Y' ? '공개' : '비공개'})</span></div>
							<div class="div-okreport-all">
								<c:forEach items="${reportCheckList}" var="reportCheck" varStatus="vs">
									<c:if test="${reportCheck.createYn == 'Y' && reportCheck.excludeYn == 'N'}">
										<div class="div-okreport-one" data-id="${reportCheck.empId}" data-no="${vs.index}" data-yn="${reportCheck.publicYn}">
											<div>
												<c:if test="${empty reportCheck.profileImg}">
													<img src="${pageContext.request.contextPath}/resources/images/default.png" class="my-img" />
												</c:if>
												<c:if test="${!empty reportCheck.profileImg}">
													<img src="${pageContext.request.contextPath}/resources/upload/emp/${reportCheck.profileImg}" class="my-img" />
												</c:if>
											</div>
											<div class="left">${reportCheck.empName} ${reportCheck.jobTitle}</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<script>
							const okreport = document.querySelectorAll('.div-okreport-one');
							console.log('okreport', okreport);
							
							if (okreport.length == 0) {
								document.querySelector('.div-okreport-all').innerHTML = `
									<div class="div-okreport-non"><span>없음</span></div>
								`;
							}
						</script>
						
						<!-- 보고 작성 -->
						<div class="div-report-create">
							<div class="div-report-write">
								<div class="div-padding div-report-write-name" style="font-weight: bold; font-size: medium;">${sessionScope.loginMember.name} ${sessionScope.loginMember.jobTitle}</div>
								<form action="${pageContext.request.contextPath}/report/reportDetailEnroll.do?${_csrf.parameterName}=${_csrf.token}" name="reportDetailFrm" method="POST" enctype="multipart/form-data">
									<div class="div-padding div-report-write-content">
										<input type="hidden" name="reportNo" value="${param.no}" />
										<textarea id="summernote" name="content"></textarea>
									</div>
									<div class="div-padding div-report-write-upload">
										<table class="div-report-write-tbl">
											<tbody>
												<tr>
													<td class="font-small">파일 첨부</td>
													<td>
														<div class="div-report-write-file">
															<label class="td-label" for="exampleFileUpload"><i class="fa-solid fa-up-right-from-square"></i> 이 곳을 클릭하여 파일 업로드</label>
															<input type="file" name="upFile" id="exampleFileUpload">
														</div>
														<div class="div-report-write-file-name"></div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="div-padding div-report-write-btn">
										<button type="submit">등록</button>
										<button type="button" onclick="reportCreateNo(this);">취소</button>
									</div>
								</form>
								<script>
									/* 썸머노트 textarea js */
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
	
									// 첨부파일목록
									// const fileList = Array.from(exampleFileUpload.files);
	
									// 첨부파일 추가
									document.querySelector('#exampleFileUpload').addEventListener('change', (e) => {
										const file = e.target.files[0];
										// const index = fileList.findIndex((files) => {
										// 	return files[0].name === file.name;
										// });
										// if (index < 0) {
										// 	fileList.push(Array.from(e.target.files));
	
											const div = document.querySelector('.div-report-write-file-name');
											
											if (file) {
												div.innerHTML = `
													<div><input type="button" value="X" data-name="\${file.name}" onclick="cancelFile(this);"/>&nbsp;\${file.name}</div>
												`;
											}
	
										// }
										
										// console.log(fileList);
									});
	
									// 첨부파일 삭제
									const cancelFile = (btn) => {
										const name = btn.dataset.name;
	
										// input[type=file] value 초기화
										exampleFileUpload.value = '';
	
										// 파일명 출력한 태그 제거
										btn.parentElement.remove();
	
										// fileList의 값 제거
										// fileList.splice(fileList.findIndex((files) => {
										// 	console.log(name);
										// 	return files[0].name === btn.dataset.name;
										// }), 1);
										// console.log(fileList);
									};
									
	
									/* 보고 내용 작성 폼 전송 시 유효성검사 */
									document.reportDetailFrm.addEventListener('submit', (e) => {
										e.preventDefault();
										
										const content = e.target.content;
	
										if (/^\s+$/.test(content.value) || !content.value) {
											alert('보고내용을 작성해주세요.');
											content.select();
											return false;
										};
										
										if (/[']+/.test(content.value) || !content.value) {
											alert("보고내용에 '는 작성이 불가능합니다.");
											content.select();
											return false;
										};
										
										reportDetailFrm.submit();
									});
								</script>
							</div>
						</div>
						
						<!-- 보고 조회 -->
						<c:forEach items="${reportCheckList}" var="reportCheck" varStatus="vs">
							<c:if test="${reportCheck.createYn == 'Y'}">
								<div class="div-report-write-view" data-no="${vs.index}">
									<div class="div-padding div-report-write-top">
										<div class="div-report-write-name">
											<span class="write-name">${reportCheck.empName}</span>
											<span class="write-date">${reportCheck.createDate}</span>
										</div>
										<div class="div-report-write-btn-group">
											<c:if test="${sessionScope.loginMember.empId eq reportCheck.empId}">
												<form:form action="${pageContext.request.contextPath}/report/reportDetailDelete.do" method="POST">
													<input type="hidden" name="no" value="${reportCheck.detailNo}" />
													<input type="hidden" name="reportNo" value="${reportCheck.reportNo}" />
													<input type="hidden" name="empId" value="${reportCheck.empId}" />
													<button type="button" class="update-btn" data-no="${vs.index}" data-detail-no="${reportCheck.detailNo}">수정</button>
													<button type="submit" class="delete-btn">삭제</button>
												</form:form>
											</c:if>
										</div>
									</div>
									<div class="div-report-detail">
										<div class="div-padding div-report-write-content">
											<div class="before-content">
												${reportCheck.content}
											</div>
										</div>
										<div class="div-padding div-report-write-attach">
											<c:if test="${reportCheck.attachments.size() > 0}">
												<c:forEach items="${reportCheck.attachments}" var="attach" varStatus="vs">
													<button type="button" class="attach-btn" data-no="${attach.no}" data-name="${attach.originalFilename}" onclick="location.href='${pageContext.request.contextPath}/report/fileDownload.do?no=${attach.no}';">
														첨부파일${vs.count} - ${attach.originalFilename}
													</button>
												</c:forEach>
											</c:if>
										</div>
									</div>
									<div class="div-report-detail-update" style="display: none;">
										<form action="${pageContext.request.contextPath}/report/reportDetailUpdate.do?${_csrf.parameterName}=${_csrf.token}" name="reportDetailUpdateFrm${vs.index}" method="POST" enctype="multipart/form-data">
											<div class="div-padding div-report-write-content">
												<input type="hidden" name="no" value="${reportCheck.detailNo}" />
												<textarea id="updateSummernote${vs.index}" name="content">${reportCheck.content}</textarea>
												<script>
													$('#updateSummernote${vs.index}').summernote({
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
											<div class="div-padding div-report-write-upload">
												<table class="div-report-write-tbl">
													<tbody>
														<tr>
															<td class="font-small">파일 첨부</td>
															<td>
																<div class="div-report-write-file">
																	<label class="td-label" for="exampleFileUpload${reportCheck.detailNo}"><i class="fa-solid fa-up-right-from-square"></i> 이 곳을 클릭하여 파일 업로드</label>
																	<input type="file" name="upFile" id="exampleFileUpload${reportCheck.detailNo}" />
																</div>
																<div class="div-report-write-file-name">
																	<c:if test="${reportCheck.attachments.size() > 0}">
																		<c:forEach items="${reportCheck.attachments}" var="attach" varStatus="vs">
																			<div>
																				<input type="button" value="X" data-no="${attach.no}" data-name="${attach.originalFilename}" onclick="delFile(this);"/>&nbsp;${attach.originalFilename}
																			</div>
																		</c:forEach>
																	</c:if>
																</div>
															</td>
														</tr>
													</tbody>
												</table>
												<div class="div-report-update-file">
													<input type="hidden" name="noFile" />
												</div>
												<script>
													document.querySelector('#exampleFileUpload${reportCheck.detailNo}').addEventListener('change', (e) => {
														const file = e.target.files[0];
														const div = e.target.parentElement.nextElementSibling;
														console.log(div);
														
														if (file) {
															div.innerHTML += `
																<div>
																	<input type="button" value="X" data-no="\${file.no}" data-name="\${file.name}" onclick="delFile(this);"/>&nbsp;\${file.name}
																</div>
															`;
														}
													});
												</script>
											</div>
											<div class="div-padding div-report-write-btn">
												<button type="submit">수정</button>
												<button type="button" onclick="beforeDivOpen(this);">취소</button>
											</div>
										</form>
										<script>
											document.querySelector('[name=reportDetailUpdateFrm${vs.index}]').addEventListener('submit', (e) => {
												e.preventDefault();
												console.log(e.target);
												const content = e.target.content;
												console.log(content.value);

												if (/^\s+$/.test(content.value) || !content.value) {
													alert('보고내용을 작성해주세요.');
													content.select();
													return false;
												};
												
												if (/[']+/.test(content.value)) {
													alert("보고내용에 '는 작성이 불가능합니다.");
													content.select();
													return false;
												};
												
												e.target.submit();
											});
										</script>
									</div>
									
									<!-- 보고 댓글 -->
									<div class="div-report-comment">
										<div style="font-weight: bold;">댓글</div>
										<form:form action="${pageContext.request.contextPath}/report/reportCommentEnroll.do" method="post" name="commentEnrollFrm${vs.index}">
											<div class="div-report-comment-all">
												<div>
													<c:if test="${!empty sessionScope.loginMember.attachment}">
														<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
													</c:if>
													<c:if test="${empty sessionScope.loginMember.attachment}">
														<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img">
													</c:if>
													<input type="hidden" name="reportNo" value="${param.no}" />
													<input type="hidden" name="detailNo" value="${reportCheck.detailNo}" />
												</div>
												<div>
													<textarea name="content"></textarea>
												</div>
												<div>
													<button type="submit" class="font-small">댓글작성</button>
												</div>
											</div>
										</form:form>
										<script>
											document.commentEnrollFrm${vs.index}.addEventListener('submit', (e) => {
												e.preventDefault();
												
												const content = e.target.content;
												
												if (/^\s+$/.test(content.value) || !content.value) {
													alert('댓글을 작성해주세요.');
													content.select();
													return false;
												}
												
												e.target.submit();
											});
										</script>
										<c:if test="${reportCheck.comments.size() > 0}">
											<c:forEach items="${reportCheck.comments}" var="comment" varStatus="vs">
												<div class="div-report-comment-detail">
													<div class="div-report-comment-img">
														<c:if test="${!empty comment.profileImg}">
															<img src="${pageContext.request.contextPath}/resources/upload/emp/${comment.profileImg}" class="my-img" />
														</c:if>
														<c:if test="${empty comment.profileImg}">
															<img src="${pageContext.request.contextPath}/resources/images/default.png" class="my-img" />
														</c:if>
													</div>
													<div class="div-report-comment-contain">
														<div class="div-report-comment-before">
															<div class="div-report-comment-title">
																<div style="width: 100%;">
																	<span>${comment.writerName} ${comment.jobTitle}</span>
																	&nbsp;&nbsp;&nbsp;
																	<span class="report-comment-date">${comment.regDate}</span>
																</div>
																<c:if test="${sessionScope.loginMember.empId eq comment.writer}">
																	<div class="div-report-comment-btn">
																		<form name="reportCommentDeleteFrm${comment.no}">
																			<input type="hidden" name="no" value="${comment.no}" />
																			<input type="hidden" name="detailNo" value="${comment.detailNo}" />
																			<input type="hidden" name="reportNo" value="${param.no}" />
																			<button type="button" onclick="reportCommentUpdateForm(this);">수정</button>
																			<button type="submit">삭제</button>
																		</form>
																	</div>
																	<script>
																		/* 댓글 삭제 */
																		document.reportCommentDeleteFrm${comment.no}.addEventListener('submit', (e) => {
																			e.preventDefault();
																			
																			const no = e.target.no.value;
																			
																			const csrfHeader = "${_csrf.headerName}";
																	        const csrfToken = "${_csrf.token}";
																	        const headers = {};
																	        headers[csrfHeader] = csrfToken;
																			
																			$.ajax({
																				url: '${pageContext.request.contextPath}/report/reportCommentDelete.do?no=' + no,
																				method: 'POST',
																				headers,
																				success(data){
																					console.log(data);
																					const commentOne = e.target.parentElement.parentElement.parentElement.parentElement.parentElement;
																					commentOne.remove();
																				},
																				error: console.log
																			});
																		});
																	</script>
																</c:if>
															</div>
															<div class="div-report-comment-content">
																${comment.content}
															</div>
														</div>
														<form name="reportCommentUpdateFrm${comment.no}">
															<div class="div-report-comment-after">
																<div>
																	<div class="div-report-comment-title">
																		<div style="width: 100%;">
																			<span>${comment.writerName} ${comment.jobTitle}</span>
																		</div>
																	</div>
																	<div class="div-report-comment-content">
																		<input type="hidden" name="no" id="no" value="${comment.no}" />
																		<input type="hidden" name="detailNo" id="detailNo" value="${comment.detailNo}" />
																		<textarea name="content" id="content">${comment.content}</textarea>
																	</div>
																</div>
																<div class="div-report-comment-update-btn">
																	<button type="submit">수정</button>
																	<button type="button" onclick="reportCommentUpdateNo(this);">취소</button>
																</div>
															</div>
														</form>
														<script>
															document.reportCommentUpdateFrm${comment.no}.addEventListener('submit', (e) => {
																e.preventDefault();
																
																const no = e.target.no;
																const detailNo = e.target.detailNo;
																const content = e.target.content;
																
																if (/^\s+$/.test(content.value) || !content.value) {
																	alert('댓글을 작성해주세요.');
																	content.select();
																	return false;
																};
																
																const frmData = new FormData();
																frmData.append('no', e.target.no.value);
																frmData.append('detailNo', e.target.detailNo.value);
																frmData.append('content', e.target.content.value);
															
													    		const csrfHeader = "${_csrf.headerName}";
													    		const csrfToken = "${_csrf.token}";
													    		const headers = {};
													    		headers[csrfHeader] = csrfToken;
																
																$.ajax({
																	url : '${pageContext.request.contextPath}/report/reportCommentUpdate.do',
																	method : 'POST',
																	data : frmData,
																	headers,
																	contentType: false,
																	processData: false,
																	success(data){
																		console.log(data);
																		/* 
																		const reportComment = data.querySelector('ReportComment');
																		const regDate = data.querySelectorAll('regDate');
																		const content = data.querySelector('content'); 
																		*/
																		
																		const regDate = data.regDate;
																		const content = data.content;
																		console.log(regDate);
																		reportCommentUpdateNo(e.target.querySelector('[type=button]'));
																		
																		const before = e.target.previousElementSibling;
																		const spanDate = before.querySelector('.report-comment-date');
																		spanDate.innerText = '';
																		regDate.forEach((date, index) => {
																			if (index === regDate.length - 1)
																				spanDate.innerText += date;
																				/* spanDate.innerText += date.textContent; */
																			else
																				spanDate.innerText += date + '-';
																				/* spanDate.innerText += date.textContent + '-'; */
																		});
																		before.querySelector('.div-report-comment-content').innerText = content;
																		/* before.querySelector('.div-report-comment-content').innerText = content.textContent; */
																	},
																	error : console.log
																});
																
															});
														</script>
													</div>
												</div>
											</c:forEach>
										</c:if>
									</div>
									
								</div>
							</c:if>
						</c:forEach>
						
						<script>
							let referList = [];
							<c:forEach items="${referList}" var="refer">
								referList.push('${refer.empId}');
							</c:forEach>
							console.log("referList", referList);
						
							/* 미보고자 보고 작성 클릭 */
							const clickReportCreate = (btn) => {
								btn.parentElement.parentElement.classList.add('div-me');
								document.querySelector('.div-report-write').style.display = 'inline-block';
								
								document.querySelectorAll('.div-report-write-view').forEach((writeView) => {
									writeView.style.display = 'none';
								});
								
								document.querySelectorAll('.div-okreport-one').forEach((one) => {
									one.classList.remove('div-okreport-one-click');
								});
							};
							
							
							/* 미보고자 보고 작성 취소 버튼 클릭 */
							const reportCreateNo = (btn) => {
								const unreportDiv = document.querySelectorAll('.div-unreport-one');
								console.log(unreportDiv);
								
								unreportDiv.forEach((div) => {
									div.classList.remove('div-me');
								});
								
								document.querySelector('.div-report-write').style.display = 'none';
							};
							
						
							/* 클릭한 보고자 및 그의 대한 내용 */
							document.querySelectorAll('.div-okreport-one').forEach((one) => {
								one.addEventListener('click', (e) => {
									let loginEmpId = '${sessionScope.loginMember.empId}';
									let yn = '${reportCheckList[0].publicYn}';
									console.log(loginEmpId);
									console.log(yn);
									
									let clickDiv = e.target;
									const allView = document.querySelectorAll('.div-report-write-view');
									console.log('allView', allView);
									let no;
									
									
									/* 보고자 div class 추가 및 아래 내용 띄우기 */
									while (true) {
										if (clickDiv.classList[0] === 'div-okreport-one') {
											no = clickDiv.dataset.no;
											console.log(no);
											
											id = clickDiv.dataset.id;
											const index = referList.findIndex((refer) => {
												return refer === loginEmpId;
											});
											console.log(index);
											
											if (yn === 'Y' || ((yn === 'N' && id == loginEmpId) || yn === 'N' && index >= 0)) {

												/* 보고자 div class 지우기 */
												document.querySelectorAll('.div-okreport-one').forEach((one) => {
													one.classList.remove('div-okreport-one-click');
												});
												
												clickDiv.classList.add('div-okreport-one-click');
												
												allView.forEach((viewDiv) => {
													if (viewDiv.dataset.no === no)
														viewDiv.style.display = 'block';
													else
														viewDiv.style.display = 'none';
												});
											} else {
												console.log('no');
											}
											
											//allView[no].style.display = 'block';
											
											break;
										} else {
											clickDiv = clickDiv.parentElement;
											continue;
										}
									}
									
									
									/* 미보고자 보고 작성 폼 숨기기 */
									document.querySelectorAll('.div-report-write').forEach((write) => {
										write.style.display = 'none';
									});
									
									document.querySelectorAll('.div-unreport-one').forEach((one) => {
										one.classList.remove('div-me');
									});
								});
							});
							
							
							/* 수정 버튼 클릭 */
							document.querySelectorAll('.update-btn').forEach((update) => {
								update.addEventListener('click', (e) => {
									const div = e.target.parentElement.parentElement.parentElement;
									console.log(div);

									const before = div.nextElementSibling;
									before.style.display = 'none';

									const after = div.nextElementSibling.nextElementSibling;
									after.style.display = 'inline-block';
								});
							});
							
							
							/* 첨부파일 취소 */
							const delFile = (btn) => {
								const name = btn.dataset.name;
								const no = btn.dataset.no;
								console.log(no);

								if (no !== '0') {
									const tag = btn.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.nextElementSibling;
									tag.innerHTML += `
										<input type="hidden" name="noFile" data-name="\${name}" value="\${no}" />
									`;
									console.log(tag);
								}


								// input[type=file] value 초기화
								exampleFileUpload.value = '';

								// 파일명 출력한 태그 제거
								btn.parentElement.remove();
								
							};
							
							
							/* 수정폼의 최소버튼 클릭 */
							const beforeDivOpen = (me) => {
								console.log(me);
								const afterDiv = me.parentElement.parentElement.parentElement;
								const fileNameDiv = afterDiv.querySelector('.div-report-write-file-name');
								const beforeDiv = afterDiv.previousElementSibling;
								
								console.log('afterDiv', afterDiv);
								console.log('beforeDiv', beforeDiv);
								
								fileNameDiv.innerHTML = '';
								const files = beforeDiv.children[1].querySelectorAll('.attach-btn');
								files.forEach((file) => {
									fileNameDiv.innerHTML += `
										<div>
											<input type="button" value="X" data-no="\${file.dataset.no}" data-name="\${file.dataset.name}" onclick="delFile(this);" />&nbsp;\${file.dataset.name}
										</div>
									`;
								});
								
								const noFileDiv = afterDiv.querySelector('.div-report-update-file');
								noFileDiv.innerHTML = `
									<input type="hidden" name="noFile" />
								`;
								
								
								beforeDiv.style.display = 'inline-block';
								afterDiv.style.display = 'none';
								
								const beforeContent = beforeDiv.querySelector('.before-content');
								const afterContent = afterDiv.querySelector('.note-editable');
								afterContent.innerHTML = beforeContent.innerHTML;
							};
							
							/* 댓글 수정 */
							const reportCommentUpdateForm = (btn) => {
								const before = btn.parentElement.parentElement.parentElement.parentElement;
								const after = before.nextElementSibling.children;
								console.log(before);
								console.log(after);
								after[0].style.display = 'block';
								before.style.display = 'none';
							};
							
							
							/* 댓글 수정 취소 */
							const reportCommentUpdateNo = (no) => {
								const after = no.parentElement.parentElement;
								const before = after.parentElement.previousElementSibling;
								
								console.log('after', after);
								console.log('before', before);
								
								after.style.display = 'none';
								before.style.display = 'block';
								
								const beforeContent = before.querySelector('.div-report-comment-content');
								const afterContent = after.querySelector('#content');
								afterContent.value = beforeContent.innerText;
							};
						</script>
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>