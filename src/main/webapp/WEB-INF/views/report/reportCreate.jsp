<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Report" name="title"/>
	</jsp:include>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/report.css">
	
	<jsp:include page="/WEB-INF/views/report/reportLeftBar.jsp" />

					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">보고서 추가</div>
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
						
						<script>
							const nowDate = Date.now();
							const dateOff = new Date().getTimezoneOffset() * 60000;
							const today = new Date(nowDate - dateOff).toISOString().split('T')[0];
						</script>
						<!-- 보고서 추가 -->
						<div class="div-report-frm div-padding">
							<form:form action="${pageContext.request.contextPath}/report/reportCreate.do" method="POST" name="reportCreateFrm">
								<table class="font-small">
									<tbody>
										<tr>
											<td>제목</td>
											<td><input type="text" id="title" name="title" /></td>
										</tr>
										<tr>
											<td>설명</td>
											<td><textarea rows="3" cols="10" id="explain" name="explain" ></textarea></td>
										</tr>
										<tr>
											<td>비공개 설정</td>
											<td>
												<input type="radio" name="publicYn" id="Y" value="Y" checked /><label for="Y">보고자간 공개</label><br />
												<input type="radio" name="publicYn" id="N" value="N"/><label for="N">보고자간 비공개</label>
											</td>
										</tr>
										<tr>
											<td>마감일</td>
											<td>
												<input type="date" name="_endDate" id="endDate" />
												<script>
													const endDate = document.querySelector('#endDate');
													endDate.min = today;
													endDate.value = today;
												</script>
											</td>
										</tr>
										<tr>
											<td>보고자</td>
											<td>
												<input type="radio" name="deptYn" id="all" value="Y" checked /><label for="all">부서원 전체</label><br />
												<div id="reportAll" class="report-frm-div reportMem"></div>
												<input type="radio" name="deptYn" id="choice" value="N" /><label for="choice">직접 지정</label>
												<div id="divReportChoice" class="div-choice">
													<div id="reportChoice" class="report-frm-div reportMem"></div>
													<button class="add" data-open="exampleModal1" data-type="reportChoice" type="button">+ 추가</button>
												</div>
											</td>
										</tr>
										<tr>
											<td>참조자</td>
											<td>
												<input type="radio" name="reference" id="user" value="E" checked /><label for="user">사용자</label><br />
												<div id="divReferenceUser" class="div-choice" style="display: inline-block;">
													<div id="referenceUser" class="report-frm-div references"></div>
													<button class="add" data-open="exampleModal1" data-type="referenceUser" type="button">+ 추가</button>
												</div>
												<input type="radio" name="reference" id="dept" value="D" /><label for="dept">부서</label>
												<div id="divReferenceDept" class="div-choice">
													<div id="referenceDept" class="report-frm-div references"></div>
													<button class="add" data-open="exampleModal2" data-type="referenceDept" type="button">+ 추가</button>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<button type="submit">확인</button>
												<button type="reset">취소</button>
											</td>
										</tr>
									</tbody>
								</table>
							</form:form>
						</div>

						<script>
							document.querySelector('#divReportChoice').classList.remove('div-choice-focus');
							document.querySelector('#divReferenceUser').classList.remove('div-choice-focus');
							document.querySelector('#divReferenceDept').classList.remove('div-choice-focus');

							document.reportCreateFrm.addEventListener('submit', (e) => {
								e.preventDefault();

								const title = e.target.title;
								const explain = e.target.explain;
								const deptChoice = e.target.deptYn[1].checked;
								const referUser = e.target.reference[0].checked;
								const referDept = e.target.reference[1].checked;

								if (!/^[a-zA-Z0-9가-힣ㄱ-ㅎ]{2,}/.test(title.value)) {
									alert('제목은 최소 3글자로 영문자, 숫자, 한글만 작성 가능합니다.');
									title.select();
									return false;
								};

								if (/\s+/.test(explain.value) || !explain.value) {
									alert('설명을 작성해주세요.');
									explain.select();
									return false;
								};

								if (deptChoice && rapporteur.length == 0) {
									alert('보고자를 추가해주세요.');
									return false;
								};

								if (referUser && referenceUser.length == 0) {
									alert('참조 가능한 사용자를 추가해주세요.');
									return false;
								};

								if (referDept && referenceDept.length == 0) {
									alert('참조 가능한 부서를 추가해주세요.');
									return false;
								};
							});
							
							
							// 보고자 부서원 전체 클릭 시 직접지정 아래에 div 숨기기
							reportCreateFrm.querySelector('#all').addEventListener('click', (e) => {
								divReportChoice.style.display = '';

								document.querySelector('#reportChoice').innerHTML = '';
								rapporteur.length = 0;
							});

							
							// 보고자 직접지정 클릭 시 div 보이기
							reportCreateFrm.querySelector('#choice').addEventListener('click', (e) => {
								divReportChoice.style.display = 'inline-block';
							});
							
							
							// 참조자 사용자 클릭 시 div 보이기 및 부서 아래에 div 숨기기
							reportCreateFrm.querySelector('#user').addEventListener('click', (e) => {
								divReferenceUser.style.display = 'inline-block';
								divReferenceDept.style.display = '';

								document.querySelector('#referenceDept').innerHTML = '';
								referenceDept.length = 0;
							});

							
							// 참조자 부서 클릭 시 div 보이기 및 사용자 아래에 div 숨기기
							reportCreateFrm.querySelector('#dept').addEventListener('click', (e) => {
								divReferenceUser.style.display = '';
								divReferenceDept.style.display = 'inline-block';
								
								document.querySelector('#referenceUser').innerHTML = '';
								referenceUser.length = 0;
							});
						</script>
						
						<!-- 부서원 선택 모달 -->
						<div class="report-no-modal reveal" id="exampleModal1" data-reveal>
							<h5>선택</h5>
							<div>
								<input type="text" name="search" id="search" placeholder="이름/부서/직급" />
							</div>
							<div class="div-emp-group">
								<div class="accordion-box">
									<ul class="container-list">
										<c:forEach items="${deptList}" var="dept">
											<li>
												<p class="title font-medium">${dept.deptTitle}</p>
												<div class="con">
													<ul class="container-detail font-small">
														<c:forEach items="${empList}" var="emp">
															<c:if test="${emp.deptCode eq dept.deptCode}">
																<li class="li-emp" data-id="${emp.empId}" data-dept="${emp.deptCode}" data-job="${emp.jobTitle}" data-name="${emp.name}">${emp.name} ${emp.jobTitle}</li>
															</c:if>
														</c:forEach>
													</ul>
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							<div class="div-modal-choice"></div>
							<div class="font-small report-no-modal-btn">
								<button class="add-btn" data-close aria-label="Close reveal" type="button">추가</button>
							</div>
							<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>

						
						<!-- 부서 선택 모달 -->
						<div class="report-no-modal reveal" id="exampleModal2" data-reveal>
							<h5>부서 선택</h5>
							<div class="div-emp-group">
								<div class="accordion-box">
									<ul class="container-list">
										<c:forEach items="${deptList}" var="dept">
											<li class="li-dept-title" data-code="${dept.deptCode}" data-title="${dept.deptTitle}">${dept.deptTitle}
												<!-- <p class="title font-medium">${dept.deptTitle}</p> -->
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							<div class="div-modal-dept"></div>
							<div class="font-small report-no-modal-btn">
								<button class="add-btn" data-close aria-label="Close reveal" type="button">추가</button>
							</div>
							<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>

						<script>
							// 보고자(직접지정) 목록
							const rapporteur = [];
							// 참조자 목록
							const referenceUser = [];

							// 참조부서 목록
							const referenceDept = [];

							/* 부서원 선택 시 아래에 띄우기 */
							document.querySelectorAll('.li-emp').forEach((li) => {
								li.addEventListener('click', (e) => {
									const empId = e.target.dataset.id;
									const deptCode = e.target.dataset.dept;
									const jobTitle = e.target.dataset.job;
									const name = e.target.dataset.name;
									console.log('empId', empId);
									
									/* 선택한 사람 출력할 div */
									const div = document.querySelector('.div-modal-choice');
									
									/* 어떤 버튼에서 클릭한 모달인지 확인 */
									const addBtn = document.querySelector('.add-btn');
									const type = addBtn.dataset.type;
									/* reportChoice, referenceUser */

									switch (type) {
										case 'reportChoice':
											const isRapporteur = rapporteur.findIndex((report) => {
												return report.empId === empId;
											});
											console.log(isRapporteur);

											if (isRapporteur < 0) {
												rapporteur.push({empId, name, jobTitle});
												
												div.innerHTML += `
													<div class='div-modal-choice-emp' data-id='\${empId}' data-dept='\${deptCode}' data-name='\${name}' onclick='deleteTag(this);'>
														<span>\${name} \${jobTitle}</span>
													</div>
												`;
											}
											console.log(rapporteur);
											break;
										case 'referenceUser':
											const isReferenceUser = referenceUser.findIndex((user) => {
												return user.empId === empId;
											});

											if (isReferenceUser < 0) {
												referenceUser.push({empId, name, jobTitle});
												
												div.innerHTML += `
													<div class='div-modal-choice-emp' data-id='\${empId}' data-dept='\${deptCode}' data-name='\${name}' onclick='deleteTag(this);'>
														<span>\${name} \${jobTitle}</span>
													</div>
												`;
											}
											console.log(referenceUser);
											break;
									}
								});
							});

							/* 부서 선택 시 아래에 띄우기 */
							document.querySelectorAll('.li-dept-title').forEach((dept) => {
								dept.addEventListener('click', (e) => {
									const deptCode = e.target.dataset.code;
									const deptTitle = e.target.dataset.title;

									/* 선택한 사람 출력할 div */
									const div = document.querySelector('.div-modal-dept');
									
									const isReferenceDept = referenceDept.findIndex((dept) => {
										return dept.deptCode === deptCode;
									});
									
									if (isReferenceDept < 0) {
										referenceDept.push({deptCode, deptTitle});
										
										div.innerHTML += `
											<div class='div-modal-choice-dept' data-code='\${deptCode}' onclick='deleteTag(this);'>
												<span>\${deptTitle}</span>
											</div>
										`;
									}
									console.log(referenceDept);
								});
							});

							/* 모달창을 어디서 클릭한 건지 값 대입하기 */
							document.querySelectorAll('.add').forEach((btn) => {
								btn.addEventListener('click', (e) => {
									const modalName = document.querySelector(`#\${e.target.dataset.open}`);
									const type = e.target.dataset.type;
									const div = document.querySelector(`#\${type}`);
									
									modalName.querySelector('.add-btn').dataset.type = type;
									console.log(modalName.querySelector('.add-btn'));
									
									const typeModal1 = document.querySelector('.div-modal-choice');
									const typeModal2 = document.querySelector('.div-modal-dept');

									typeModal1.innerHTML = '';
									typeModal2.innerHTML = '';

									switch (type) {
										case 'reportChoice':
											rapporteur.forEach((report) => {
												typeModal1.innerHTML += `
													<div class='div-emp-tag' data-id='\${report.empId}' onclick='deleteTag(this);'>
														<span>\${report.name} \${report.jobTitle}</span>
													</div>
												`;
											});
											break;
										case 'referenceUser':
											referenceUser.forEach((user) => {
												typeModal1.innerHTML += `
													<div class='div-emp-tag' data-id='\${user.empId}' onclick='deleteTag(this);'>
														<span>\${user.name} \${user.jobTitle}</span>
													</div>
												`;
											});
											break;
										case 'referenceDept':
											referenceDept.forEach((dept) => {
												typeModal2.innerHTML += `
													<div class='div-emp-tag' data-code='\${dept.deptCode}' onclick='deleteTag(this);'>
														<span>\${dept.deptTitle}</span>
													</div>
												`;
											});
											break;
									}
								});
							});

							/* 모달창 추가 버튼 클릭 시 사람 목록 출력 */
							document.querySelectorAll('.add-btn').forEach((add) => {
								add.addEventListener('click', (e) => {
									const type = e.target.dataset.type;
									const typeDiv = document.querySelector(`#\${type}`);
									console.log(typeDiv);
									typeDiv.innerHTML = '';

									switch (type) {
										case 'reportChoice':
											rapporteur.forEach((report, index) => {
												typeDiv.innerHTML += `
													<div class='div-emp-tag'>
														<span data-id='\${report.empId}'>\${report.name} \${report.jobTitle}</span>
														<input type='hidden' name='memberList[\${index}].empId' id='memberList[\${index}].empId' value='\${report.empId}' />
													</div>
												`;
											});
											break;
										case 'referenceUser':
											referenceUser.forEach((user, index) => {
												typeDiv.innerHTML += `
													<div class='div-emp-tag'>
														<span data-id='\${user.empId}'>\${user.name} \${user.jobTitle}</span>
														<input type='hidden' name='referenceList[\${index}].empId' id='referenceList[\${index}].empId' value='\${user.empId}' />
													</div>
												`;
											});
											break;
										case 'referenceDept':
											referenceDept.forEach((dept, index) => {
												typeDiv.innerHTML += `
													<div class='div-emp-tag'>
														<span data-code='\${dept.deptCode}'>\${dept.deptTitle}</span>
														<input type='hidden' name='referenceList[\${index}].deptCode' id='referenceList[\${index}].deptCode' value='\${dept.deptCode}' />
													</div>
												`;
											});
											break;
									}
								});
							});
							
							/* 선택된 사람 클릭 시 삭제 */
							const deleteTag = (elem) => {
								console.log(elem);
								const type = elem.parentElement.nextElementSibling.children[0].dataset.type;
								console.log(type);

								switch (type) {
									case 'reportChoice':
										rapporteur.splice(rapporteur.findIndex((report) => {
											return report.empId === elem.dataset.id;
										}), 1);
										console.log(rapporteur);
										break;
									case 'referenceUser':
										referenceUser.splice(referenceUser.findIndex((user) => {
											return user.empId === elem.dataset.id;
										}), 1);
										console.log(referenceUser);
										break;
									case 'referenceDept':
										referenceDept.splice(referenceDept.findIndex((dept) => {
											console.log(elem.dataset.code);
											return dept.deptCode === elem.dataset.code;
										}), 1);
										break;
								}
								elem.remove();
							};
						</script>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>