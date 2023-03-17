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
	
					<div class="font-small home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">비품신청서</div>
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
						<div class="top-container">
							<div class="div-sign-btn font-small">
								<button>결재요청</button>
								<button>취소</button>
								<button>결재 정보</button>
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
						
						<!-- 결재 문서 -->
						<div class="div-sign-form">
							<div class="div-sign-form-detail">
								<table class="sign-tbl">
									<tbody>
										<tr>
											<td colspan="2" class="sign-tbl-title font-large">
												비품신청서
											</td>
										</tr>
										<tr>
											<td class="sign-tbl-left">
												<table class="sign-tbl-left-tbl">
													<tbody>
														<tr>
															<td class="sign-tbl-left-title">
																기안자
															</td>
															<td class="sign-tbl-left-content">
																<span>기안자</span>
															</td>
														</tr>
														<tr>
															<td class="sign-tbl-left-title">
																기안부서
															</td>
															<td class="sign-tbl-left-content">
																<span>기안부서</span>
															</td>
														</tr>
														<tr>
															<td class="sign-tbl-left-title">
																기안일
															</td>
															<td class="sign-tbl-left-content">
																<span>기안일</span>
															</td>
														</tr>
														<tr>
															<td class="sign-tbl-left-title">
																문서번호
															</td>
															<td class="sign-tbl-left-content">
																<span>문서번호</span>
															</td>
														</tr>
													</tbody>
												</table>
								
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