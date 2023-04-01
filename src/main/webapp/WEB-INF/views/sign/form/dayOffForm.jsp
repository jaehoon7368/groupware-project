<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Sign" name="title"/>
	</jsp:include>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/form.css">
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<jsp:include page="/WEB-INF/views/sign/signLeftBar.jsp" />
	
	<jsp:include page="/WEB-INF/views/sign/signCreate.jsp">
		<jsp:param value="연차신청서" name="title" />
	</jsp:include>
								
											</td>
											<td class="sign-tbl-right">
												<div class="sign-div-right">
													<table class="sign-right-tbl">
														<tbody>
															<tr>
																<th>신청</th>
																<td class="sign-right-tbl-border">
																	<table class="sign-right-tbl-line">
																		<tbody>
																			<tr>
																				<td>
																					<span class="sign_rank">${sessionScope.loginMember.jobTitle}</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<span class="sign_wrap">${sessionScope.loginMember.name}</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<span class="sign_date"></span>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</tr>
														</tbody>
													</table>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<script>
									const nowDate = new Date();
									const newDate = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate() + 2);
									const dateOff = new Date().getTimezoneOffset() * 60000;
									const today = new Date(newDate - dateOff).toISOString().split('T')[0];
									console.log(today);

									document.querySelector('.sign_date').innerText = today;
								</script>
								
								<br />
								<form:form action="${pageContext.request.contextPath}/sign/dayOffCreate.do" method="post" name="dayOffFrm">
									<div class="div-sign-tbl">
										<table class="sign-tbl-bottom">
											<tbody>
												<tr>
													<td>긴급&nbsp;문서</td>
													<td>
														<input type="radio" name="emergency" id="emergencyY" value="Y" /><label for="emergencyY">여</label>
														<input type="radio" name="emergency" id="emergencyN" value="N" checked /><label for="emergencyN">부</label>
													</td>
												</tr>
												<tr>
													<td>
														휴가&nbsp;종류
													</td>
													<td>
														<select class="vacationType" name="type" id="vacationType">
															<option value="D" selected>연차</option>
															<option value="H">반차</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>
														기간&nbsp;및&nbsp;일시
													</td>
													<td>
														<span>
															<span>
																<!-- <input type="text" id="datepicker" name="startDate" class="dayoff-date" /> -->
																<input id="start-date" name="startDate" class="dayoff-date" type="date" min="2023-03-16" value="2023-03-16">
															</span>
															&nbsp;~&nbsp; 
															<span>
																<!-- <input type="text" id="datepicker" name="endDate" class="dayoff-date" /> -->
																<input id="end-date" name="endDate" class="dayoff-date" type="date" min="2023-03-16" value="2023-03-16">
															</span>
															&nbsp;&nbsp;
															<span>선택일수 : 
																<span id="usingPointArea"></span>
															</span>
														</span>
														<!-- <script>
															const noDateList = [];
															<c:forEach items="${noDateList}" var="noDate">
																noDateList.push("${noDate.reg_date}");
															</c:forEach>
															<c:forEach items="${toBeNoDateList}" var="toBeNoDate">
																noDateList.push("${toBeNoDate.reg_date}");
															</c:forEach>
															console.log(noDateList);
														</script> -->
													</td>
												</tr>
												<tr>
													<td>
														반차&nbsp;여부
													</td>
													<td>
														<span id="vacationHalfArea">
															<input type="radio" name="half" id="A" value="A" disabled/><label for="A">오전</label>
															<input type="radio" name="half" id="P" value="P" disabled/><label for="P">오후</label>
															<input type="radio" name="half" id="X" value="X" checked /><label for="X">연차</label>
														</span> 
													</td>
												</tr>
												<tr>
													<td>
														연차&nbsp;일수
													</td>
													<td>
														<span id="restPointArea">
															잔여연차 : <span id="restPoint">${leaveCount}</span>
														</span>&nbsp;&nbsp;
														<span id="applyPointArea">
															신청연차 : <span id="applyPoint"></span>
															<input type="hidden" name="count" />
														</span> &nbsp;&nbsp;
														<span id="finalPointArea">
															최종 남은 연차 : <span id="finalPoint"></span>
														</span> 
													</td>
												</tr>
												<tr>
													<td>
														<b style="color: rgb(255, 0, 0);">*</b>&nbsp;휴가&nbsp;사유 
													</td>
													<td>
														<textarea name="content" class="txta_editor"></textarea>
													</td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td colspan="2" class="sign-tbl-bottom-content">
														1. 연차의 사용은 근로기준법에 따라 전년도에 발생한 개인별 잔여 연차에 한하여 사용함을 원칙으로 한다. 단, 최초 입사시에는 근로 기준법에 따라 발생 예정된 연차를 차용하여 월 1회 사용 할 수 있다.<br> 2. 경조사 휴가는 행사일을 증명할 수 있는 가족 관계 증명서 또는 등본, 청첩장 등 제출<br> 3. 공가(예비군/민방위)는 사전에 통지서를, 사후에 참석증을 반드시 제출 
													</td>
												</tr>
											</tbody>
										</table>
										
										<script>
											/* 확정 또는 예정된 연차, 반차, 출장 날짜 목록 */
											const noDateList = [];
											<c:forEach items="${noDateList}" var="noDate">
												noDateList.push({
													regDate: "${noDate.reg_date}",
													state: "${noDate.state}"
												});
											</c:forEach>
											
											<c:forEach items="${toBeNoDateList}" var="toBeNoDate">
												noDateList.push({
													regDate: "${toBeNoDate.reg_date}",
													state: "${toBeNoDate.state}"
												});
											</c:forEach>
											console.log(noDateList);
											
											noDateList.sort((a, b) => {
												if (a.regDate > b.regDate) return 1;
												if (a.regDate < b.regDate) return -1;
												return 0;
											});
											
											let start;
											let end;
											let type = vacationType.value;
											let diff = 1;
											
											const halfType = document.querySelector('#vacationType');
											const startDate = document.querySelector('#start-date');
											const endDate = document.querySelector('#end-date');
											const usingPointArea = document.querySelector('#usingPointArea');
											const finalDayOff = document.querySelector('#finalPoint');
											const base = document.querySelector('#restPoint').innerText;
											
											const diffDay = (start, end) => {
												diff = end - start;
												return diff / (1000 * 60 * 60 * 24) + 1;
											};
											
											const inner = (tag, val) => {
												return tag.innerText = val;
											};
											
											const checkDate = (choiceDate) => {
												noDateList.forEach((no) => {
													if (choiceDate == no.regDate)
														alert('해당 날짜는 ${no.state}(으)로 불가합니다.');
												});
											};
											
											window.addEventListener('load', () => {
												startDate.min = today;
												startDate.value = today;
												endDate.min = today;
												endDate.value = today;
												
												inner(usingPointArea, diff);
												inner(applyPoint, diff);
												inner(finalDayOff, base - diff);
											});
											
											
											startDate.addEventListener('change', (e) => {
												endDate.min = startDate.value;
												console.log(type);
												if (type == 'D') {
													end = new Date(endDate.value).getTime();
													start = new Date(startDate.value).getTime();
													
													if (end < start) {
														endDate.value = startDate.value;
														end = new Date(endDate.value).getTime();
													}
													inner(usingPointArea, diffDay(start, end));
													inner(applyPoint, diffDay(start, end));
													inner(finalDayOff, base - diffDay(start, end));
												} else {
													endDate.value = startDate.value;
													inner(usingPointArea, 0.5);
													inner(applyPoint, 0.5);
													inner(finalDayOff, base - 0.5);
												}
											});
											
											endDate.addEventListener('change', (e) => {
												end = new Date(endDate.value).getTime();
												start = new Date(startDate.value).getTime();

												inner(usingPointArea, diffDay(start, end));
												inner(applyPoint, diffDay(start, end));
												inner(finalDayOff, base - diffDay(start, end));
											});
											
											halfType.addEventListener('change', (e) => {
												console.log(e.target);
												type = e.target.value;
												console.log(halfType);
												
												switch (type) {
												case 'H':
													endDate.value = startDate.value;
													endDate.readOnly = 'readOnly';
													A.disabled = '';
													P.disabled = '';
													X.disabled = 'disabled';
													A.checked = 'checked';
													inner(usingPointArea, 0.5);
													inner(applyPoint, 0.5);
													inner(finalDayOff, base - 0.5);
													break;
												case 'D':
													endDate.readOnly = '';
													end = new Date(endDate.value).getTime();
													start = new Date(startDate.value).getTime();

													A.disabled = 'disabled';
													P.disabled = 'disabled';
													X.disabled = '';
													X.checked = 'checked';
													
													inner(usingPointArea, diffDay(start, end));
													inner(applyPoint, diffDay(start, end));
													inner(finalDayOff, base - diffDay(start, end));
													break;
												}
											});
										</script>
									</div>
								</form:form>
							</div>
						</div>
						<!-- 결재 문서 end -->
						<script>
							/* 연차신청서 폼 제출 */
							const signCreate = () => {
								const frm = document.dayOffFrm;
								const content = frm.content;
								const type = frm.type;
								const half = frm.half;
								const start = frm.startDate;
								const end = frm.endDate;
								console.log(frm.startDate.value);
								console.log(frm.endDate.value);
								console.log(vacationType.value);
								console.log(half.value);
								
								frm.count.value = applyPoint.innerText;
								
								if (/^\s+$/.test(content.value) || !content.value) {
									alert('휴가 사유를 작성해주세요.');
									content.select();
									return false;
								}
								
								let dateList = [];
								let text = '현재 선택된 기간에는 다른 일정이 있는 날짜가 존재합니다.\n';
								for (let i = 0; i < noDateList.length; i++) {
									let noDate = noDateList[i];
									
									let no = new Date(noDate.regDate);
									if (new Date(startDate.value) <= no && new Date(endDate.value) >= no) {
										dateList.push(noDate);
									}
									
									if (i === noDateList.length - 1) {
										if (dateList.length > 0) {
											dateList.forEach((date) => {
												text += date.regDate + ' (' + date.state + ')\n';
											});
											alert(text);
											return false;
										} // 신청하면 안되는 날짜가 존재하는 경우
									} // noDateList의 마지막 인덱스인 경우
								};
								
								frm.submit();
							};
						</script>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>