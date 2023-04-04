<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Anywhere" name="title"/>
	</jsp:include>

				<div class="app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 상단 타이틀 -->
					<div class="home-topbar topbar-div">
						<div></div>
						<div>
							<a href="#" id="home-my-img">
								<c:if test="${!empty sessionScope.loginMember.attachment}">
									<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="my-img">
								</c:if>
								<c:if test="${empty sessionScope.loginMember.attachment}">
									<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="my-img">
								</c:if>
							</a>
						</div>
				
						<div id="home-my-menu-modal">
							<div class="my-menu-div">
								<button class="my-menu">기본정보</button>
							</div>
							<div class="my-menu-div">
								<form:form action="${pageContext.request.contextPath}/emp/empLogout.do" method="POST">
									<button class="my-menu" type="submit">로그아웃</button>								
								</form:form>
							</div>
						</div>
					
					</div>
					<script>
						document.querySelector('#home-my-img').addEventListener('click', (e) => {
							const modal = document.querySelector('#home-my-menu-modal');
							const style =  modal.style.display;
							
							if (style == 'inline-block') {
								modal.style.display = 'none';
							} else {
								modal.style.display = 'inline-block';
							}
						});
					</script>
					<!-- 상단 타이틀 end -->
    
					
					<div>
						<div class="home-content">
							<div style="display: flex;">
								<!-- 본문 왼쪽 -->
								<div class="home-content-div">
									<div id="home-left" class="div-padding div-margin">
										<table id="home-my-tbl">
											<tbody>
				                                <tr>
				                                    <td id="year" colspan="2" class="font-14">clock</td>
				                                </tr>
				                                <tr>
				                                    <td colspan="2" id="clock" style="color:black;">clock</td>
				                                </tr>
												<tr>
													<td colspan="2">
														<c:if test="${!empty sessionScope.loginMember.attachment}">
															<img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}" alt="" class="img">
														</c:if>
														<c:if test="${empty sessionScope.loginMember.attachment}">
															<img src="${pageContext.request.contextPath}/resources/images/default.png" alt="" class="img">
														</c:if>
													</td>
												</tr>
												<tr>
													<td colspan="2">${sessionScope.loginMember.name} ${sessionScope.loginMember.jobTitle}</td>
												</tr>
												<tr>
													<td colspan="2">${sessionScope.loginMember.deptTitle}</td>
												</tr>
				                                <tr>
				                                    <td class="font-14 font-bold">출근시간</td>
				                                    <td class="text-right font-14" id="startwork-time">미등록</td>
				                                </tr>
				                                <tr>
				                                    <td class="font-14 font-bold">퇴근시간</td>
				                                    <td class="text-right font-14" id="endwork-time">미등록</td>
				                                </tr>
				                                <tr class="btn-tr">
				                                    <td><button class="font-bold" id="btn-startwork">출근하기</button></td>
				                                    <td class="text-right"><button class="font-bold" id="btn-endwork">퇴근하기</button></td>
				                                </tr>
				                            </tbody>
				                        </table>
				                    
				                    </div>
								</div>
		
								<!-- 본문 가운데 -->
								<div>
									<div id="home-center" class="div-padding div-margin">
										<h5>전사게시판</h5>
										<div id="board-div" class="home-div">
											<button class="btn-board-title" onclick="styleChange(this);">ㅇㅇ</button>
											<button class="btn-board-title" onclick="styleChange(this);">ㄱㄱ</button>
											<button class="btn-board-title" onclick="styleChange(this);">ㅊㅊ</button>
											<button class="btn-board-title" onclick="styleChange(this);">ㄹㄹ</button>
										</div>
									</div>
									<script>
										const styleChange = (btn) => {
											document.querySelectorAll('#board-div .btn-board-title').forEach((btn) => {
												btn.style.borderBottom = 'none';
											});
											
											btn.style.borderBottom = 'solid 2px #000';
										};
									</script>
								
									<div id="home-center" class="div-padding div-margin">
										<h5 class="sign-h5" onclick="location.href='${pageContext.request.contextPath}/sign/signStatus.do?status=W';">결재 대기 문서</h5>
										<table id="home-sign-tbl">
											<thead>
												<tr>
													<th>기안일</th>
													<th>결재양식</th>
													<th>긴급</th>
													<th>결재상태</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${empty mySignList}">
													<tr>
														<td colspan="4" class="home-sign-no">결재 대기 문서가 없습니다.</td>
													</tr>
												</c:if>
												<c:if test="${!empty mySignList}">
													<c:forEach items="${mySignList}" var="sign" varStatus="vs">
														<c:if test="${vs.index < 4}">
															<tr class="div-sign-all-tbl-tr" data-no="${sign.no}" data-type="${sign.type}">
																<td>${sign.regDate}</td>
																<td>
																	<c:choose>
																		<c:when test="${sign.type == 'D'}">연차신청서</c:when>
																		<c:when test="${sign.type == 'P'}">비품신청서</c:when>
																		<c:when test="${sign.type == 'T'}">출장신청서</c:when>
																		<c:when test="${sign.type == 'R'}">사직서</c:when>
																	</c:choose>
																</td>
																<td>
																	<c:if test="${sign.emergency == 'Y'}">
																		<button type="button" class="tiny alert button hollow">긴급</button>
																	</c:if>
																</td>
																<td class="div-sign-all-tbl-td-btn">
																	<c:forEach items="${sign.signStatusList}" var="signStatus" varStatus="vs">
																		<c:if test="${signStatus.status == 'H'}">
																			<button class="tiny warning button">보류</button>
																		</c:if>
																		<c:if test="${signStatus.status == 'R'}">
																			<button class="tiny warning button">반려</button>
																		</c:if>
																	</c:forEach>
																</td>
															</tr>
														</c:if>
													</c:forEach>
												</c:if>
											</tbody>
										</table>
										<script>
										window.addEventListener('load', (e) => {
											document.querySelectorAll('.div-sign-all-tbl-td-btn').forEach((btnTd) => {
												if (!btnTd.innerText) {
													btnTd.innerHTML = `
														<button class="tiny success button">진행중</button>
													`;
												}
											});
										});
									</script>
									</div>
									
									<div id="home-center" class="div-padding div-margin">
										<h5>메일함</h5>
										<div id="mail-div" class="home-div">
											<button class="btn-board-title" onclick="mailStyleChange(this);">ㅇㅇ</button>
											<button class="btn-board-title" onclick="mailStyleChange(this);">ㄱㄱ</button>
											<button class="btn-board-title" onclick="mailStyleChange(this);">ㅊㅊ</button>
											<button class="btn-board-title" onclick="mailStyleChange(this);">ㄹㄹ</button>
										</div>
									</div>
									<script>
										const mailStyleChange = (btn) => {
											document.querySelectorAll('#mail-div .btn-board-title').forEach((btn) => {
												btn.style.borderBottom = 'none';
											});
											btn.style.borderBottom = 'solid 2px #000';
										};
									</script>
								</div>
								
								<!-- 본문 오른쪽 -->
								<div>
									<div id="home-right" class="div-padding div-margin">
										<h5 style="padding:20px">최근 알림</h5>
										
										<c:forEach items ="${reNotis }" var="reNoti" varStatus="vs">
										<c:if test="${vs.index <4}">
		
											<c:set  var = "notiType" value=""/>
											        <c:set var="notiType" value="전자결재"/>
											<c:choose>
												<c:when test="${fn:contains(reNoti.pkNo,'tdb') }">
													<c:set var="notsiType" value="할일게시판"/>
												</c:when>
												<c:when test="${fn:contains(reNoti.pkNo,'r') }">
													<c:set var="notiType" value="보고서"/>
												</c:when>
												<c:when test="${fn:contains(reNoti.pkNo,'bo') }">
													<c:set var="notiType" value="게시판"/>
												</c:when>
												<c:when test="${fn:contains(reNoti.pkNo,'s') }">
													<c:set var="notiType" value="전자결재"/>
												</c:when>
											</c:choose>	
											<div class="notification-list">
				        						<div class="left-noti">
				        							<img src="${pageContext.request.contextPath }/resources/upload/emp/${reNoti.attachment.renameFilename}" alt="" class="my-img">
				        						</div>
								            	<div class="right-noti">
								               		<p> [<span class="noti-type-span">${notiType}등록</span>] '${reNoti.emp.name}' ${reNoti.emp.jobTitle }님 (이)가 <br />'${notiType}'를 등록하였습니다.</p>
		  										<p><span class="noti-time-span">${reNoti.regDate }</span><span> </span></p>
		    
						          				</div>
						       				</div>
						       				</c:if>
										</c:forEach>
													
									</div>
									
									<div id="home-report" class="div-padding div-margin">
										<div class="div-padding home-report-div">
											<h5 onclick="location.href='${pageContext.request.contextPath}/report/report.do';">보고</h5>
											<div class="home-bottom-div">
												<c:if test="${empty reportList}">
													<div class="home-bottom-title">작성해야 하는 보고가 없습니다.</div>
												</c:if>
												<c:if test="${!empty reportList}">
													<c:forEach items="${reportList}" var="report" varStatus="vs">
														<c:if test="${report.createYn == 'N'}">
															<c:if test="${empty i}">
																<c:set var="i" value="1" />
																<div class="div-report" data-no="${report.reportNo}">
																	<div class="div-report-tbl">
																		<table class="font-small">
								                                            <colgroup>
								                                                <col width="35%" />
								                                                <col width="65%" />
								                                            </colgroup>
																			<tbody>
																				<tr>
																					<td colspan="2" class="report-year">
																						<fmt:parseDate value="${report.endDate}" pattern="yyyy-MM-dd" var="endYear" />
																						<fmt:formatDate value="${endYear}" pattern="yyyy" />
																					</td>
																				</tr>
																				<tr>
																					<td colspan="2" class="report-day">
																						<fmt:parseDate value="${report.endDate}" pattern="yyyy-MM-dd" var="endDate" />
																						<fmt:formatDate value="${endDate}" pattern="MM/dd(E)" />
																					</td>
																				</tr>
																				<tr>
																					<td colspan="2" class="report-title">${report.title}</td>
																				</tr>
																				<tr>
																					<td>부서</td>
																					<td>${report.deptTitle}</td>
																				</tr>
																				<tr>
																					<td>보고현황</td>
																					<td title="보고자 ${report.createCount}명 (미보고자 ${report.noCreateCount}명)">보고자 ${report.createCount}명 (미보고자 ${report.noCreateCount}명)</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<div class="div-report-btn">
																		<button class="report-btn" type="button">보고하기</button>
																	</div>
																</div>
															</c:if>
														</c:if>
													</c:forEach>
												</c:if>
											</div>
										</div>
									</div>
									<script>
										document.querySelectorAll('.div-report').forEach((report) => {
											report.addEventListener('click', (e) => {
												console.log(e.target);
												let data = e.target;
												
												while (true) {
													if (data.tagName === 'DIV' && data.classList[0] === 'div-report') {
														console.log(data.tagName);
														console.log(data.classList[0]);
														console.log(data);
														location.href = `${pageContext.request.contextPath}/report/reportDetail.do?no=\${data.dataset.no}`;
														break;
													} else {
														data = data.parentElement;
														continue;
													}
												}
											});
										});
										
										const noReport = document.querySelectorAll('.div-report');
										if (noReport.length == 0) {
											document.querySelector('.home-bottom-div').innerHTML = `
												<div class="home-bottom-title">작성해야 하는 보고가 없습니다.</div>
											`;
										}
									</script>
									
								</div>
							</div>
						</div>
						
						<div>
							<%-- <div id="home-bottom" class="div-padding div-margin">
								<h5 onclick="location.href='${pageContext.request.contextPath}/report/report.do';">보고</h5>
								<div class="home-bottom-div">
									<c:if test="${empty reportList}">
										<div class="home-bottom-title">작성해야 하는 보고가 없습니다.</div>
									</c:if>
									<c:if test="${!empty reportList}"><c:set var="j" value="0" />
										<c:forEach items="${reportList}" var="report" varStatus="vs">
											<c:if test="${report.createYn == 'N'}">
												<c:if test="${j <= 20}">
													<c:set var="j" value="${j += 1}" />
													<div class="div-report" data-no="${report.reportNo}">
														<div class="div-report-tbl">
															<table class="font-small">
					                                            <colgroup>
					                                                <col width="35%" />
					                                                <col width="65%" />
					                                            </colgroup>
																<tbody>
																	<tr>
																		<td colspan="2" class="report-year">
																			<fmt:parseDate value="${report.endDate}" pattern="yyyy-MM-dd" var="endYear" />
																			<fmt:formatDate value="${endYear}" pattern="yyyy" />
																		</td>
																	</tr>
																	<tr>
																		<td colspan="2" class="report-day">
																			<fmt:parseDate value="${report.endDate}" pattern="yyyy-MM-dd" var="endDate" />
																			<fmt:formatDate value="${endDate}" pattern="MM/dd(E)" />
																		</td>
																	</tr>
																	<tr>
																		<td colspan="2" class="report-title">${report.title}</td>
																	</tr>
																	<tr>
																		<td>부서</td>
																		<td>${report.deptTitle}</td>
																	</tr>
																	<tr>
																		<td>보고현황</td>
																		<td title="보고자 ${report.createCount}명 (미보고자 ${report.noCreateCount}명)">보고자 ${report.createCount}명 (미보고자 ${report.noCreateCount}명)</td>
																	</tr>
																</tbody>
															</table>
														</div>
														<div class="div-report-btn">
															<button class="report-btn" type="button">보고하기</button>
														</div>
													</div>
												</c:if>
											</c:if>
										</c:forEach>
									</c:if>
								</div>
							</div>
							<script>
								document.querySelectorAll('.div-report').forEach((report) => {
									report.addEventListener('click', (e) => {
										console.log(e.target);
										let data = e.target;
										
										while (true) {
											if (data.tagName === 'DIV' && data.classList[0] === 'div-report') {
												console.log(data.tagName);
												console.log(data.classList[0]);
												console.log(data);
												location.href = `${pageContext.request.contextPath}/report/reportDetail.do?no=\${data.dataset.no}`;
												break;
											} else {
												data = data.parentElement;
												continue;
											}
										}
									});
								});
								
								const noReport = document.querySelectorAll('.div-report');
								if (noReport.length == 0) {
									document.querySelector('.home-bottom-div').innerHTML = `
										<div class="home-bottom-title">작성해야 하는 보고가 없습니다.</div>
									`;
								}
							</script> --%>
						</div>
					</div>
					
				</div>

<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>