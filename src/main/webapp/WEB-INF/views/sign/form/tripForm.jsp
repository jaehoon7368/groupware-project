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
							
												<%-- 
												<div class="sign-div-right">
													<table class="sign-right-tbl">
														<tbody>
															<tr>
																<th>승인</th>
																<td class="sign-right-tbl-border">
																	<table class="sign-right-tbl-line">
																		<tbody>
																			<tr>
																				<td>
																					<span class="sign_rank">차장</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" class="ok-sign" />
																					<br />
																					<span class="sign_name">아무개</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<span class="sign_date">2023-03-15</span>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</tr>
														</tbody>
													</table>
												</div> 
												--%>
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
								<div class="div-sign-tbl">
									<table class="sign-tbl-bottom">
										<tbody>
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
												<td><input type="text" name="boss-dept" id="boss-dept" /></td>
												<td><input type="text" name="boss-job" id="boss-job" /></td>
												<td><input type="text" name="boss-name" id="boss-name" /></td>
											</tr>
											<tr>
												<td>
													기간&nbsp;및&nbsp;일시
												</td>
												<td colspan="3">
													<span>
														<span>
															<input id="start-date" class="dayoff-date" type="date" min="2023-03-16" value="2023-03-16">
														</span>
														&nbsp;~&nbsp; 
														<span>
															<input id="end-date" class="dayoff-date" type="date" min="2023-03-16" value="2023-03-16">
														</span>
														&nbsp;&nbsp;
														<span>선택일수 : 
															<span id="usingPointArea">1</span>
														</span>
													</span>
													
													<script>
														const startDate = document.querySelector('#start-date');
														startDate.min = today;
														startDate.value = today;

														const endDate = document.querySelector('#end-date');
														endDate.min = today;
														endDate.value = today;
														
														const usingPointArea = document.querySelector('#usingPointArea');
														
														startDate.addEventListener('change', (e) => {
															/* 
															console.log('change', startDate.value);
															 */
															endDate.min = startDate.value;
															endDate.value = startDate.value;
														});
													</script>
												</td>
											</tr>
											<tr>
												<td>
													출장지
												</td>
												<td colspan="3">
													<input type="text" name="trip-where" id="trip-where" />
												</td>
											</tr>
											<tr>
												<td>
													출장 목적
												</td>
												<td colspan="3">
													<textarea class="txta_editor"></textarea>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 결재 문서 end -->
						
						
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