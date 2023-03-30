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
	
	<jsp:include page="/WEB-INF/views/sign/signLeftBar.jsp" />
	
	<jsp:include page="/WEB-INF/views/sign/signCreate.jsp">
		<jsp:param value="사직서" name="title" />
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
								<form:form action="${pageContext.request.contextPath}/sign/resignationCreate.do" method="post" name="resignationCreateFrm">
									<div class="div-sign-tbl">
										<table class="sign-tbl-bottom">
											<tbody>
												<tr class="sign-tbl-bottom-tr">
													<th>긴급 문서</th>
													<td colspan="3">
														<input type="radio" name="emergency" id="emergencyY" value="Y" /><label for="emergencyY">여</label>
														<input type="radio" name="emergency" id="emergencyN" value="N" checked /><label for="emergencyN">부</label>
													</td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<th>입사일</th>
													<td><input type="date" name="start-date" id="start-date" value="${sessionScope.loginMember.hireDate}" readonly/></td>
													<th>퇴사일</th>
													<td>
														<input type="date" name="endDate" id="end-date" />
														<script>
															const endDate = document.querySelector('#end-date');
															endDate.min = today;
															endDate.value = today;
														</script>
													</td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<th>직급</th>
													<th>사번</th>
													<th>성명</th>
													<th>근무부서</th>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td>${sessionScope.loginMember.jobTitle}</td>
													<td>${sessionScope.loginMember.empId}</td>
													<td>${sessionScope.loginMember.name}</td>
													<td>${sessionScope.loginMember.deptTitle}</td>
												</tr>
												<tr>
													<th colspan="4">퇴직 사유</th>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td colspan="4">
														<textarea rows="10" id="reason" name="reason"></textarea>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</form:form>
							</div>
						</div>
						<!-- 결재 문서 end -->
						<script>
							/* 사직서 폼 제출 */
							const signCreate = () => {
								const frm = document.resignationCreateFrm;
								const reason = frm.reason;
								
								if (/^\s+$/.test(reason.value) || !reason.value) {
									alert('퇴사 사유를 작성해주세요.');
									reason.select();
									return false;
								}
								
								frm.submit();
							};
						</script>
						
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>