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
	
	<jsp:include page="/WEB-INF/views/sign/signLeftBar.jsp" />
	
	<jsp:include page="/WEB-INF/views/sign/signCreate.jsp">
		<jsp:param value="출장신청서" name="title" />
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
									const nowDate = Date.now();
									const dateOff = new Date().getTimezoneOffset() * 60000;
									const today = new Date(nowDate - dateOff).toISOString().split('T')[0];
									
									document.querySelector('.sign_date').innerText = today;
								</script>
								
								<br />
								<form:form action="${pageContext.request.contextPath}/sign/tripCreate.do" method="post" name="tripFrm">
									<div class="div-sign-tbl">
										<table class="sign-tbl-bottom">
											<tbody>
												<tr>
													<td>긴급&nbsp;문서</td>
													<td colspan="3">
														<input type="radio" name="emergency" id="emergencyY" value="Y" /><label for="emergencyY">여</label>
														<input type="radio" name="emergency" id="emergencyN" value="N" checked /><label for="emergencyN">부</label>
													</td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td colspan="4" class="sign-tbl-bottom-td">
														아래와 같이 출장신청서를 제출합니다.
													</td>
												</tr>
												<tr class="trip-boss">
													<td rowspan="2">출장자</td>
													<td>부서</td>
													<td>직책</td>
													<td>성명</td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td>
														<input type="text" name="boss-dept" id="boss-dept" value="${sessionScope.loginMember.deptTitle}" readonly />
													</td>
													<td>
														<input type="text" name="boss-job" id="boss-job" value="${sessionScope.loginMember.jobTitle}" readonly />
													</td>
													<td>
														<input type="text" name="boss-name" id="boss-name" value="${sessionScope.loginMember.name}" readonly />
													</td>
												</tr>
												<tr>
													<td>
														기간&nbsp;및&nbsp;일시
													</td>
													<td colspan="3">
														<span>
															<span>
																<input id="start-date" name="startDate" class="dayoff-date" type="date" min="2023-03-16" value="2023-03-16">
															</span>
															&nbsp;~&nbsp; 
															<span>
																<input id="end-date" name="endDate" class="dayoff-date" type="date" min="2023-03-16" value="2023-03-16">
															</span>
															&nbsp;&nbsp;
															<span>선택일수 : 
																<span id="usingPointArea"></span>
															</span>
														</span>
													</td>
												</tr>
												<tr>
													<td>
														출장지
													</td>
													<td colspan="3">
														<input type="text" name="location" id="trip-where" />
													</td>
												</tr>
												<tr>
													<td>
														출장 목적
													</td>
													<td colspan="3">
														<textarea name="purpose" class="txta_editor"></textarea>
													</td>
												</tr>
											</tbody>
										</table>
										
										<script>
											let start;
											let end;
											let diff = 1;
											
											const startDate = document.querySelector('#start-date');
											const endDate = document.querySelector('#end-date');
											const usingPointArea = document.querySelector('#usingPointArea');
											
											const diffDay = (start, end) => {
												diff = end - start;
												return diff / (1000 * 60 * 60 * 24) + 1;
											};
											
											const inner = (tag, val) => {
												return tag.innerText = val;
											};
											
											window.addEventListener('load', () => {
												startDate.min = today;
												startDate.value = today;
												endDate.min = today;
												endDate.value = today;
												
												inner(usingPointArea, diff);
											});
											
											
											startDate.addEventListener('change', (e) => {
												endDate.min = startDate.value;
												
												end = new Date(endDate.value).getTime();
												start = new Date(startDate.value).getTime();
												
												if (end < start) {
													endDate.value = startDate.value;
													end = new Date(endDate.value).getTime();
												}
												inner(usingPointArea, diffDay(start, end));
											});
											
											endDate.addEventListener('change', (e) => {
												end = new Date(endDate.value).getTime();
												start = new Date(startDate.value).getTime();
	
												inner(usingPointArea, diffDay(start, end));
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
								const frm = document.tripFrm;
								const location = frm.location;
								const purpose = frm.purpose;
								
								if (/^\s+$/.test(location.value) || !location.value) {
									alert('출장지를 작성해주세요.');
									location.select();
									return false;
								}
								
								if (/^\s+$/.test(purpose.value) || !purpose.value) {
									alert('출장 목적을 작성해주세요.');
									purpose.select();
									return false;
								}
								
								frm.submit();
							};
						</script>
						
						
						<div class="div-sign-bottom">
							<div class="div-sign-bottom-title">
								<div class="font-large">결재선</div>
							</div>
							<div>
								<div>ddd</div>
							</div>
						</div>
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>