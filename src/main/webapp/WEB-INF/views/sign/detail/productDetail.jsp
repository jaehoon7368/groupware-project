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
		<jsp:param value="비품신청서" name="title" />
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
									const nowDate = new Date();
									const newDate = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate() + 2);
									const dateOff = new Date().getTimezoneOffset() * 60000;
									const today = new Date(newDate - dateOff).toISOString().split('T')[0];
									
									document.querySelector('.sign_date').innerText = today;
								</script>
								
								<br />
								<div class="div-sign-tbl div-sign-tbl-detail">
									<table class="sign-tbl-bottom">
										<tbody>
											<tr>
												<td>긴급&nbsp;문서</td>
												<td colspan="4">
													<input type="radio" name="emergency" id="_emergencyY" value="Y" ${sign.emergency == 'Y' ? 'checked' : 'disabled'} /><label for="_emergencyY">여</label>
													<input type="radio" name="emergency" id="_emergencyN" value="N" ${sign.emergency == 'N' ? 'checked' : 'disabled'} /><label for="_emergencyN">부</label>
												</td>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<th rowspan="2">품명</th>
												<th rowspan="2">수량</th>
												<th colspan="2">구매예정가격</th>
												<th rowspan="2">용도</th>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<th>단가</th>
												<th>금액</th>
											</tr>
											<c:forEach items="${productList}" var="product" varStatus="vs">
												<tr class="sign-tbl-bottom-tr">
													<td><input type="text" name="name" id="name${vs.count}" value="${product.name}" readOnly /></td>
													<td><input type="text" name="amount" id="amount${vs.count}" min="1" value="<fmt:formatNumber value='${product.amount}' pattern='#,##0' />" readOnly/></td>
													<td><input type="text" name="price" id="price${vs.count}" min="1" value="<fmt:formatNumber value='${product.price}' pattern='#,##0' />" readOnly/></td>
													<td><input type="text" name="totalPrice" id="_totalPrice${vs.count}" min="1" value="<fmt:formatNumber value='${product.totalPrice}' pattern='#,##0' />" readOnly/></td>
													<td><input type="text" name="purpose" id="purpose${vs.count}" value="${product.purpose}" readOnly/></td>
												</tr>
											</c:forEach>
											<c:forEach begin="${productList.size() + 1}" end="4" var="n">
												<tr class="sign-tbl-bottom-tr">
													<td><input type="text" name="name" id="name${n}" readOnly /></td>
													<td><input type="text" name="amount" id="amount${n}" min="1" readOnly/></td>
													<td><input type="text" name="price" id="price${n}" min="1" readOnly/></td>
													<td><input type="text" name="totalPrice" id="_totalPrice${n}" min="1" readOnly/></td>
													<td><input type="text" name="purpose" id="purpose${n}" readOnly/></td>
												</tr>
											</c:forEach>
											<tr class="sign-tbl-bottom-tr">
												<th colspan="2">합계</th>
												<td colspan="3" id="finalPrice"></td>
											</tr> 
										</tbody>
									</table>
								</div>
								
								<div class="div-sign-tbl div-sign-tbl-update">
									<form:form action="${pageContext.request.contextPath}/sign/productUpdate.do" method="post" name="productUpdateFrm">
										<table class="sign-tbl-bottom">
											<tbody>
												<tr>
													<td>긴급&nbsp;문서</td>
													<td colspan="4">
														<input type="radio" name="emergency" id="emergencyY" value="Y" ${sign.emergency == 'Y' ? 'checked' : ''} /><label for="emergencyY">여</label>
														<input type="radio" name="emergency" id="emergencyN" value="N" ${sign.emergency == 'N' ? 'checked' : ''} /><label for="emergencyN">부</label>
														
														<input type="hidden" name="signNo" value="${sign.no}" />
														<input type="hidden" name="amount" value=0 />
														<input type="hidden" name="price" value=0 />
														<input type="hidden" name="totalPrice" value=0 />
													</td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<th rowspan="2">품명</th>
													<th rowspan="2">수량</th>
													<th colspan="2">구매예정가격</th>
													<th rowspan="2">용도</th>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<th>단가</th>
													<th>금액</th>
												</tr>
												<c:forEach items="${productList}" var="product" varStatus="vs">
													<tr class="sign-tbl-bottom-tr">
														<td>
															<input type="hidden" name="productFormList[${vs.index}].no" value="${product.no}" />
															<input type="text" name="productFormList[${vs.index}].name" id="name${vs.count}" value="${product.name}" />
														</td>
														<td>
															<input type="text" name="_amount" id="amount${vs.count}" min="1" value="<fmt:formatNumber value='${product.amount}' pattern='#,##0' />"/>
															<input type="hidden" name="productFormList[${vs.index}].amount" />
														</td>
														<td>
															<input type="text" name="_price" id="price${vs.count}" min="1" value="<fmt:formatNumber value='${product.price}' pattern='#,##0' />"/>
															<input type="hidden" name="productFormList[${vs.index}].price" />
														</td>
														<td>
															<input type="text" name="_totalPrice" id="totalPrice${vs.count}" min="1" value="<fmt:formatNumber value='${product.totalPrice}' pattern='#,##0' />"/>
															<input type="hidden" name="productFormList[${vs.index}].totalPrice" />
														</td>
														<td>
															<input type="text" name="productFormList[${vs.index}].purpose" id="purpose${vs.count}" value="${product.purpose}" />
														</td>
													</tr>
												</c:forEach>
												<c:forEach begin="${productList.size() + 1}" end="4" var="n">
													<tr class="sign-tbl-bottom-tr">
														<td>
															<input type="text" name="productFormList[${n - 1}].name" id="name${n}" />
														</td>
														<td>
															<input type="text" name="_amount" id="amount${n}" min="1" />
															<input type="hidden" name="productFormList[${n - 1}].amount" />
														</td>
														<td>
															<input type="text" name="_price" id="price${n}" min="1" />
															<input type="hidden" name="productFormList[${n - 1}].price" />
														</td>
														<td>
															<input type="text" name="_totalPrice" id="totalPrice${n}" min="1" />
															<input type="hidden" name="productFormList[${n - 1}].totalPrice" />
														</td>
														<td>
															<input type="text" name="productFormList[${n - 1}].purpose" id="purpose${n}" />
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</form:form>
								</div>
								
							</div>
						</div>
						<!-- 결재 문서 end -->
						<script>
							let all = 0;
							/* 상세조회 시 합계 띄우기 */
							document.querySelectorAll('[name^=_totalPrice]').forEach((price) => {
								if (price.value) {
									all = all + Number(price.value.replaceAll(',', ''));
								}
								finalPrice.innerText = all.toLocaleString('ko-KR');
							});
							
							
							const detailBtn = document.querySelector('.div-sign-btn-detail');
							const detailDiv = document.querySelector('.div-sign-tbl-detail');
							const updateBtn = document.querySelector('.div-sign-btn-update');
							const updateDiv = document.querySelector('.div-sign-tbl-update');
							
							/* 문서 수정 버튼 클릭 */
							const signUpdateFrm = () => {
								detailBtn.style.display = 'none';
								detailDiv.style.display = 'none';
								updateBtn.style.display = 'inline-block';
								updateDiv.style.display = 'inline-block';
							}; // signUpdateFrm end
							
							
							/* 숫자 입력 칸 문자 입력이나 0 입력 시 1로 세팅 및 , 작성 */
							const keyupChange = (val, tag) => {
								val = Number(val.replaceAll(',', ''));
								
								if (isNaN(val) || val == 0) {
									tag.value = 1;
								} else {
									const formatValue = val.toLocaleString('ko-KR');
									tag.value = formatValue;
								}
							}; // keyupChange end
							
							
							/* 수량 input keyup 이벤트핸들러 */
							document.querySelectorAll('[name=_amount]').forEach((amount) => {
								amount.addEventListener('keyup', (e) => {
									keyupChange(e.target.value, amount);
									
									const price = e.target.parentElement.nextElementSibling.children[0];
									const totalPrice = e.target.parentElement.nextElementSibling.nextElementSibling.children[0];
									if (price.value) {
										const multi = Number(e.target.value.replaceAll(',', '')) * Number(price.value.replaceAll(',', ''));
										totalPrice.value = multi.toLocaleString('ko-KR');
									}
								});
							});
							
							
							/* 단가 input keyup 이벤트핸들러 */
							document.querySelectorAll('[name=_price]').forEach((price) => {
								price.addEventListener('keyup', (e) => {
									keyupChange(e.target.value, price);
									
									const amount = e.target.parentElement.previousElementSibling.children[0];
									const totalPrice = e.target.parentElement.nextElementSibling.children[0];
									const multi = Number(amount.value.replaceAll(',', '')) * Number(e.target.value.replaceAll(',', ''));
									
									if (isNaN(multi) || multi == 0) {
										totalPrice.value = 1;
									} else {
										const formatTotal = multi.toLocaleString('ko-KR');
										totalPrice.value = formatTotal;
									}
								});
							});
							
							
							/* 비품신청서 폼 제출 */
							const signUpdateOk = () => {
								const frm = document.productUpdateFrm;
								const name = frm.querySelectorAll('[name$=name]');
								const amount = frm.querySelectorAll('[name=_amount]');
								const price = frm.querySelectorAll('[name=_price]');
								const totalPrice = frm.querySelectorAll('[name=_totalPrice]');
								const purpose = frm.querySelectorAll('[name$=purpose]');
								
								for (let i = 0; i < name.length; i++) {
									if (i == 0) {
										if (/^\s+$/.test(name[i].value) || !name[i].value) {
											alert('품명을 입력해주세요.');
											name[i].select();
											return false;
										}
										
										if (/^\s+$/.test(amount[i].value) || !amount[i].value) {
											alert('수량을 입력해주세요.');
											amount[i].select();
											return false;
										}

										if (/^\s+$/.test(price[i].value) || !price[i].value) {
											alert('단가를 입력해주세요.');
											price[i].select();
											return false;
										}

										if (/^\s+$/.test(purpose[i].value) || !purpose[i].value) {
											alert('용도를 입력해주세요.');
											purpose[i].select();
											return false;
										}
									} // if (i == 0)
									else {
										if (name[i].value && !/^\s+$/.test(name[i].value)) {
											if (/^\s+$/.test(amount[i].value) || !amount[i].value) {
												alert('수량을 입력해주세요.');
												amount[i].select();
												return false;
											}
	
											if (/^\s+$/.test(price[i].value) || !price[i].value) {
												alert('단가를 입력해주세요.');
												price[i].select();
												return false;
											}
											
											if (/^\s+$/.test(purpose[i].value) || !purpose[i].value) {
												alert('용도를 입력해주세요.');
												purpose[i].select();
												return false;
											}
										} // if end
									} // else (i != 0)
									
									amount[i].nextElementSibling.value = Number(amount[i].value.replaceAll(',', ''));
									price[i].nextElementSibling.value = Number(price[i].value.replaceAll(',', ''));
									totalPrice[i].nextElementSibling.value = Number(totalPrice[i].value.replaceAll(',', ''));
								} // for end
								
								frm.submit();
							};
							
							
							/* 결재, 보류, 수정 */
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
							<div class="div-sign-bottom-content">
								<!-- 기안자 -->
								<div class="div-sign-bottom-tbl">
									<table class="div-sign-bottom-content-tbl">
										<colgroup>
                                               <col width="5%" />
                                               <col width="95%" />
                                           </colgroup>
										<thead>
											<tr>
												<td rowspan="4" class="td-img">
													<c:if test="${empty sign.profileImg}">
														<img src="${pageContext.request.contextPath}/resources/images/default.png" class="my-img" />
													</c:if>
													<c:if test="${!empty sign.profileImg}">
														<img src="${pageContext.request.contextPath}/resources/upload/emp/${sign.profileImg}" class="my-img" />
													</c:if>
												</td>
												<th>${sign.name} ${sign.jobTitle}</th>
											</tr>
											<tr>
												<td>${sign.deptTitle}</td>
											</tr>
											<tr>
												<td>
													기안 상신 |&nbsp;
													<fmt:parseDate value="${sign.regDate}" var="regDate" pattern="yyyy-MM-dd" />
													<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd(E)" />
												</td>
											</tr>
										</thead>
									</table>
								</div>
								
								<!-- 결재자 -->
								<c:forEach items="${sign.signStatusList}" var="signStatus">
									<div class="div-sign-bottom-tbl ${(signStatus.status == 'W' || signStatus.status == 'H' || signStatus.status == 'R') ? 'signStatusHere' : ''}">
										<table class="div-sign-bottom-content-tbl">
											<colgroup>
                                                <col width="5%" />
                                                <col width="95%" />
                                            </colgroup>
											<thead>
												<tr>
													<td rowspan="4" class="td-img">
														<c:if test="${empty signStatus.profileImg}">
															<img src="${pageContext.request.contextPath}/resources/images/default.png" class="my-img" />
														</c:if>
														<c:if test="${!empty signStatus.profileImg}">
															<img src="${pageContext.request.contextPath}/resources/upload/emp/${signStatus.profileImg}" class="my-img" />
														</c:if>
													</td>
													<th>${signStatus.name} ${signStatus.jobTitle}</th>
												</tr>
												<tr>
													<td>${signStatus.deptTitle}</td>
												</tr>
												<tr>
													<td>
														<c:choose>
															<c:when test="${signStatus.status == 'W'}">
																결재 대기
															</c:when>
															<c:when test="${signStatus.status == 'S'}">
																결재 예정
															</c:when>
															<c:when test="${signStatus.status == 'C'}">
																결재 승인
															</c:when>
															<c:when test="${signStatus.status == 'H'}">
																결재 보류
															</c:when>
															<c:when test="${signStatus.status == 'R'}">
																결재 반려
															</c:when>
														</c:choose>
														<c:if test="${!empty signStatus.regDate}">
															&nbsp;|&nbsp;
															<fmt:parseDate value="${signStatus.regDate}" var="regDate" pattern="yyyy-MM-dd" />
															<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd(E)" />
														</c:if>
													</td>
												</tr>
												<c:if test="${!empty signStatus.reason}">
													<tr class="tr-reason">
														<td>${signStatus.reason}</td>
													</tr>
												</c:if>
											</thead>
										</table>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>