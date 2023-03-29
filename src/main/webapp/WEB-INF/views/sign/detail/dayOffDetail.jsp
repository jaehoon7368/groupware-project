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
	
	<jsp:include page="/WEB-INF/views/sign/signDetail.jsp">
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
																					<span class="sign_rank">${sign.jobTitle}</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<span class="sign_name">${sign.name}</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<span class="sign_date">
																						<fmt:parseDate value="${sign.regDate}" var="now" pattern="yyyy-MM-dd" />
																						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
																					</span>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</tr>
														</tbody>
													</table>
												</div>
							
												<div class="sign-div-right sign-div-tbl">
													<table class="sign-right-tbl">
														<tbody>
															<tr>
																<th>승인</th>
																<c:forEach items="${sign.signStatusList}" var="signStatus">
																	<td class="sign-right-tbl-border">
																		<table class="sign-right-tbl-line">
																			<tbody>
																				<tr>
																					<td>
																						<span class="sign_rank">${signStatus.jobTitle}</span>
																					</td>
																				</tr>
																				<tr>
																					<td>
																						<c:if test="${signStatus.status == 'C'}">
																							<img src="${pageContext.request.contextPath}/resources/images/ok.png" class="ok-sign" />
																							<br />
																							<span class="sign_name">${signStatus.name}</span>
																						</c:if>
																						<c:if test="${signStatus.status != 'C'}">
																							<span class="sign_wrap">${signStatus.name}</span>
																						</c:if>
																					</td>
																				</tr>
																				<tr>
																					<td>
																						<span class="sign_date">
																							<c:if test="${!empty signStatus.regDate}">
																								<fmt:parseDate value="${signStatus.regDate}" var="regDate" pattern="yyyy-MM-dd" />
																								<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd" />
																							</c:if>
																							<c:if test="${empty signStatus.regDate}">
																								&nbsp;
																							</c:if>
																						</span>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</td>
																</c:forEach>
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
								</script>
								
								<br />
								<div class="div-sign-tbl">
									<table class="sign-tbl-bottom">
										<tbody>
											<tr>
												<td>긴급&nbsp;문서</td>
												<td>
													<input type="radio" name="emergency" id="emergencyY" value="Y" ${sign.emergency == 'Y' ? 'checked' : 'disabled'} /><label for="emergencyY">여</label>
													<input type="radio" name="emergency" id="emergencyN" value="N" ${sign.emergency == 'N' ? 'checked' : 'disabled'} /><label for="emergencyN">부</label>
												</td>
											</tr>
											<tr>
												<td>
													휴가&nbsp;종류
												</td>
												<td>
													<select class="vacationType" name="type" id="vacationType" disabled>
														<option value="D" ${dayOff.type == 'D' ? 'selected' : ''}>연차</option>
														<option value="H" ${dayOff.type == 'H' ? 'selected' : ''}>반차</option>
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
															<input id="start-date" name="startDate" class="dayoff-date" type="date" value="${dayOff.startDate}" readonly>
														</span>
														&nbsp;~&nbsp; 
														<span>
															<input id="end-date" name="endDate" class="dayoff-date" type="date" value="${dayOff.endDate}" readonly>
														</span>
														&nbsp;&nbsp;
														<span>선택일수 : 
															<span id="usingPointArea">${dayOff.count}</span>
														</span>
													</span>
												</td>
											</tr>
											<tr>
												<td>
													반차&nbsp;여부
												</td>
												<td>
													<span id="vacationHalfArea">
														<input type="radio" name="half" id="A" value="A" ${dayOff.half == 'A' ? 'checked' : 'disabled'} /><label for="A">오전</label>
														<input type="radio" name="half" id="P" value="P" ${dayOff.half == 'P' ? 'checked' : 'disabled'} /><label for="P">오후</label>
														<input type="radio" name="half" id="X" value="X" ${dayOff.half == 'X' ? 'checked' : 'disabled'} /><label for="X">연차</label>
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
														신청연차 : <span id="applyPoint">${dayOff.count}</span>
														<input type="hidden" name="count" />
													</span> &nbsp;&nbsp;
													<span id="finalPointArea">
														최종 남은 연차 : <span id="finalPoint">${leaveCount - dayOff.count}</span>
													</span> 
												</td>
											</tr>
											<tr>
												<td>
													<b style="color: rgb(255, 0, 0);">*</b>&nbsp;휴가&nbsp;사유 
												</td>
												<td>
													<textarea name="content" class="txta_editor" readonly>${dayOff.content}</textarea>
												</td>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<td colspan="2" class="sign-tbl-bottom-content">
													1. 연차의 사용은 근로기준법에 따라 전년도에 발생한 개인별 잔여 연차에 한하여 사용함을 원칙으로 한다. 단, 최초 입사시에는 근로 기준법에 따라 발생 예정된 연차를 차용하여 월 1회 사용 할 수 있다.<br> 2. 경조사 휴가는 행사일을 증명할 수 있는 가족 관계 증명서 또는 등본, 청첩장 등 제출<br> 3. 공가(예비군/민방위)는 사전에 통지서를, 사후에 참석증을 반드시 제출 
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 결재 문서 end -->
						<script>
							const signStatusUpdate = (status) => {
								const modal = signStatusUpdateModal;
								const h5 = modal.querySelector('h5');
								const btn = modal.querySelector('.btn-status');
								const frmStatus = document.signStatusUpdateFrm.status;
								
								switch (status) {
								case 'C' :
									h5.innerText = '결재하기';
									btn.innerText = '결재';
									break;
								case 'R' :
									h5.innerText = '반려하기';
									btn.innerText = '반려';
									break;
								case 'H' :
									h5.innerText = '보류하기';
									btn.innerText = '보류';
									break;
								} // switch end
								
								frmStatus.value = status;
							};
							
							
							/* 결재, 반려, 보류 폼 제출 */
							document.signStatusUpdateFrm.addEventListener('submit', (e) => {
								e.preventDefault();
								console.log(e.target);
								
								const status = e.target.status;
								const reason = e.target.reason;
								
								if (status.value == 'R' || status.value == 'H') {
									if (/^\s+$/.test(reason.value) || !reason.value) {
										alert('결재 의견을 작성해주세요.');
										reason.select();
										return false;
									}
								}
								
								e.target.submit();
							});
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