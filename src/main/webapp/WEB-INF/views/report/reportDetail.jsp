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
							<div id="report-title" class="container-title">${reportCheckList[0].title}</div>
							<div class="home-topbar topbar-div">
								<div>
									<a href="#" id="home-my-img">
										<c:if test="${!empty sessionScope.loginMember.attachment}">
											<img src="${pageContext.request.contextPath}/resources/upload/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
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
								<span class="div-exclude">
									<c:if test="${!empty reportCheckList}">
										없음
									</c:if>
									<c:if test="${empty reportCheckList}">
										<c:forEach items="${reportCheckList}" var="reportCheck">
											<c:if test="${report.excludeYn == 'Y'}">
												${report.empId} &nbsp;&nbsp;&nbsp;
											</c:if>
										</c:forEach>
									</c:if>
								</span>
							</div>
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
						<script>
							if (!document.querySelector('.div-unreport-one')) {
								document.querySelector('.div-unreport-all').innerHTML = `
									<div class="div-unreport-non">
										<span>없음</span>
									</div>
								`;
							}
						</script>
						
						<!-- 보고 작성자 -->
						<div class="div-okreport font-small">
							<div class="div-okreport-title"><span>보고자</span></div>
							<div class="div-okreport-all">
								<c:forEach items="${reportCheckList}" var="reportCheck" varStatus="vs">
									<c:if test="${reportCheck.createYn == 'Y'}">
										<div class="div-okreport-one" data-id="${reportCheck.empId}" data-no="${vs.index}">
											<div>
												<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
											</div>
											<div class="left">${reportCheck.empName} ${reportCheck.jobTitle}</div>
										</div>
									</c:if>
								</c:forEach>
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
											<form:form action="${pageContext.request.contextPath}/report/reportDetailDelete.do" method="POST">
												<input type="hidden" name="no" value="${reportCheck.detailNo}" />
												<input type="hidden" name="reportNo" value="${reportCheck.reportNo}" />
												<input type="hidden" name="empId" value="${reportCheck.empId}" />
												<button type="button" class="update-btn" data-no="${vs.index}" data-detail-no="${reportCheck.detailNo}">수정</button>
												<button type="submit" class="delete-btn">삭제</button>
											</form:form>
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
													<button type="button" class="attach-btn" onclick="location.href='${pageContext.request.contextPath}/report/fileDownload.do?no=${attach.no}';">
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
												<textarea id="summernote${vs.index}" name="content">${reportCheck.content}</textarea>
												<script>
													$('#summernote${vs.index}').summernote({
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
																	<label class="td-label" for="exampleFileUpload${vs.index}"><i class="fa-solid fa-up-right-from-square"></i> 이 곳을 클릭하여 파일 업로드</label>
																	<input type="file" name="upFile" id="exampleFileUpload${vs.index}">
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
													document.querySelector('#exampleFileUpload${vs.index}').addEventListener('change', (e) => {
														const file = e.target.files[0];
														const div = e.target.parentElement.nextElementSibling;
														console.log(div);
														
														if (file) {
															div.innerHTML = `
																<div>
																	<input type="button" value="X" data-no="0" data-name="\${file.name}" onclick="delFile(this);"/>&nbsp;\${file.name}
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
										<form:form action="${pageContext.request.contextPath}/report/reportCommentEnroll.do" method="POST" name="commentEnrollFrm">
											<div class="div-report-comment-all">
												<div>
													<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="my-img" />
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
										<c:if test="${reportCheck.comments.size() > 0}">
											<c:forEach items="${reportCheck.comments}" var="comment">
												<div class="div-report-comment-detail">
													<div class="div-report-comment-img">
														<c:if test="${!empty comment.profileImg}">
															<img src="${pageContext.request.contextPath}/resources/upload/${comment.profileImg}" class="my-img" />
														</c:if>
														<c:if test="${empty comment.profileImg}">
															<img src="${pageContext.request.contextPath}/resources/images/default.png" class="my-img" />
														</c:if>
														<input type="hidden" name="reportNo" value="${param.no}" />
														<input type="hidden" name="detailNo" value="${reportCheck.detailNo}" />
													</div>
													<div class="div-report-comment-contain">
														<div class="div-report-comment-title">
															<div style="width: 100%;">
																<span>${comment.writerName} ${comment.jobTitle}</span>
																&nbsp;&nbsp;&nbsp;
																<span>${comment.regDate}</span>
															</div>
															<div class="div-report-comment-btn">
																<button type="submit">수정</button>
																<button>삭제</button>
															</div>
														</div>
														<div class="div-report-comment-content">
															${comment.content}
														</div>
													</div>
												</div>
											</c:forEach>
										</c:if>
									</div>
									
								</div>
							</c:if>
						</c:forEach>
						
						<script>
							/* 클릭한 보고자 및 그의 대한 내용 */
							document.querySelectorAll('.div-okreport-one').forEach((one) => {
								one.addEventListener('click', (e) => {
									let clickDiv = e.target;
									const allView = document.querySelectorAll('.div-report-write-view');
									let no;
									
									/* 보고자 div class 지우기 */
									document.querySelectorAll('.div-okreport-one').forEach((one) => {
										one.classList.remove('div-okreport-one-click');
									});
									
									
									/* 보고자 div class 추가 및 아래 내용 띄우기 */
									while (true) {
										if (clickDiv.classList[0] === 'div-okreport-one') {
											clickDiv.classList.add('div-okreport-one-click');
											
											no = clickDiv.dataset.no;
											
											document.querySelectorAll('.div-report-write-view').forEach((viewDiv) => {
													viewDiv.style.display = 'none';
											});
											
											allView[no].style.display = 'block';
											
											break;
										} else {
											clickDiv = clickDiv.parentElement;
											continue;
										}
									}
								});
							});
							
							
							/* 수정 버튼 클릭 */
							document.querySelectorAll('.update-btn').forEach((update) => {
								update.addEventListener('click', (e) => {
									const div = e.target.parentElement.parentElement;
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
										<input type="hidden" name="noFile" value="\${no}" />
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
								const allViewDiv = document.querySelectorAll('.div-report-write-view');
								const parentDiv = me.parentElement.parentElement.parentElement.parentElement;
								const no = parentDiv.dataset.no;

								allViewDiv[no].querySelector('.div-report-detail-update').style.display = 'none';
								allViewDiv[no].querySelector('.div-report-detail').style.display = 'inline-block';
							}
						</script>
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>