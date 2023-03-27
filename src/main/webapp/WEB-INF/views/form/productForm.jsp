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
																					<span class="sign_rank">차장</span>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<span class="sign_wrap">아무개</span>
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
											</td>
										</tr>
									</tbody>
								</table>
								
								<br />
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
												<td><input type="text" name="name" id="name" /></td>
												<td><input type="number" name="amount" id="amount" min="0" /></td>
												<td><input type="number" name="price" id="price" min="0" /></td>
												<td><input type="text" name="totalPrice" id="totalPrice" min="0" /></td>
												<td><input type="text" name="purpose" id="purpose" /></td>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<td><input type="text" name="name" id="name" /></td>
												<td><input type="number" name="amount" id="amount" min="0" /></td>
												<td><input type="number" name="price" id="price" min="0" /></td>
												<td><input type="text" name="totalPrice" id="totalPrice" min="0" /></td>
												<td><input type="text" name="purpose" id="purpose" /></td>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<td><input type="text" name="name" id="name" /></td>
												<td><input type="number" name="amount" id="amount" min="0" /></td>
												<td><input type="number" name="price" id="price" min="0" /></td>
												<td><input type="text" name="totalPrice" id="totalPrice" min="0" /></td>
												<td><input type="text" name="purpose" id="purpose" /></td>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<td><input type="text" name="name" id="name" /></td>
												<td><input type="number" name="amount" id="amount" min="0" /></td>
												<td><input type="number" name="price" id="price" min="0" /></td>
												<td><input type="text" name="totalPrice" id="totalPrice" min="0" /></td>
												<td><input type="text" name="purpose" id="purpose" /></td>
											</tr>
											<tr class="sign-tbl-bottom-tr">
												<th colspan="2">합계</th>
												<td colspan="3"></td>
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