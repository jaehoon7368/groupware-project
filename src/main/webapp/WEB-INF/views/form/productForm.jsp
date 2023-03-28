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
								<form:form action="${pageContext.request.contextPath}/sign/productCreate.do" method="post" name="productCreateFrm">
									<div class="div-sign-tbl">
										<table class="sign-tbl-bottom">
											<tbody>
												<tr class="sign-tbl-bottom-tr">
													<th>제목</th>
													<td colspan="5">
														<input type="text" name="title" id="title" />
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
												<tr class="sign-tbl-bottom-tr">
													<td><input type="text" name="name" id="name1" /></td>
													<td><input type="text" name="amount" id="amount1" min="1" /></td>
													<td><input type="text" name="price" id="price1" min="1" /></td>
													<td><input type="text" name="totalPrice" id="totalPrice1" min="1" /></td>
													<td><input type="text" name="purpose" id="purpose1" /></td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td><input type="text" name="name" id="name2" /></td>
													<td><input type="text" name="amount" id="amount2" min="1" /></td>
													<td><input type="text" name="price" id="price2" min="1" /></td>
													<td><input type="text" name="totalPrice" id="totalPrice2" min="1" /></td>
													<td><input type="text" name="purpose" id="purpose2" /></td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td><input type="text" name="name" id="name3" /></td>
													<td><input type="text" name="amount" id="amount3" min="1" /></td>
													<td><input type="text" name="price" id="price3" min="1" /></td>
													<td><input type="text" name="totalPrice" id="totalPrice3" min="1" /></td>
													<td><input type="text" name="purpose" id="purpose3" /></td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<td><input type="text" name="name" id="name4" /></td>
													<td><input type="text" name="amount" id="amount4" min="1" /></td>
													<td><input type="text" name="price" id="price4" min="1" /></td>
													<td><input type="text" name="totalPrice" id="totalPrice4" min="1" /></td>
													<td><input type="text" name="purpose" id="purpose4" /></td>
												</tr>
												<tr class="sign-tbl-bottom-tr">
													<th colspan="2">합계</th>
													<td colspan="3" id="finalPrice"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</form:form>
							</div>
						</div>
						<!-- 결재 문서 end -->
						<script>
							/* 숫자 입력 칸 문자 입력이나 0 입력 시 1로 세팅 및 , 작성 */
							const keyupChange = (val, tag) => {
								val = Number(val.replaceAll(',', ''));
								
								if (isNaN(val) || val == 0) {
									tag.value = 1;
								} else {
									const formatValue = val.toLocaleString('ko-KR');
									tag.value = formatValue;
								}
							};
							
							
							/* 수량 input keyup 이벤트핸들러 */
							document.querySelectorAll('[name=amount]').forEach((amount) => {
								amount.addEventListener('keyup', (e) => {
									keyupChange(e.target.value, amount);
								});
							});
							
							
							let all = 0;
							/* 단가 input keyup 이벤트핸들러 */
							document.querySelectorAll('[name=price]').forEach((price) => {
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
							const signCreate = () => {
								const frm = document.productCreateFrm;
								const name = frm.name;
								const amount = frm.amount;
								const price = frm.price;
								const totalPrice = frm.totalPrice;
								const purpose = frm.purpose;
								
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
								} // for end
								
								//frm.submit();
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