<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>   

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Emp" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empAllInfo.css">
<style>
div#search-memberDept {display: <%= searchType == null || "dept_title".equals(searchType) ? "inline-block" : "none" %>;}
div#search-memberJob {display: <%= "job_title".equals(searchType) ? "inline-block" : "none" %>;}
div#search-memberName {display: <%= "name".equals(searchType) ? "inline-block" : "none" %>;}
</style>
<script>
window.addEventListener('load', () => {
	document.querySelector("#searchType").addEventListener('change', (e) => {
		console.log(e.target.value); // member_id, member_name, gender
		
		// 모두 숨김
		document.querySelectorAll(".search-type").forEach((div) => {
			div.style.display = "none";
		});
		
		// 현재선택된 값에 상응하는 div만 노출
		let id; 
		switch(e.target.value){
		case "dept_title" : id = "search-memberDept"; break; 
		case "job_title" : id = "search-memberJob"; break; 
		case "name" : id = "search-memberName"; break; 
		}
		
		document.querySelector("#" + id).style.display = "inline-block";
	});
});

</script>
 <jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
<sec:authentication property="principal" var="loginEmp"/>
	
	<div class="home-container">
                <!-- 상단 타이틀 -->
                <div class="top-container">
                    <div class="container-title font-bold">전사 인사정보</div>
                    <div class="home-topbar topbar-div">
                        <div>
                            <a href="#" id="home-my-img">
                                <c:if test="${!empty sessionScope.loginMember.attachment}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/emp/${sessionScope.loginMember.attachment.renameFilename}"
                                        alt="" class="my-img">
                                </c:if>
                                <c:if test="${empty sessionScope.loginMember.attachment}">
                                    <img src="${pageContext.request.contextPath}/resources/images/default.png" alt=""
                                        class="my-img">
                                </c:if>
                            </a>
                        </div>
                        <div id="my-menu-modal">
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
                </div>
                    <script>
                        document.querySelector('#home-my-img').addEventListener('click', (e) => {
                            const modal = document.querySelector('#my-menu-modal');
                            const style = modal.style.display;

                            if (style == 'inline-block') {
                                modal.style.display = 'none';
                            } else {
                                modal.style.display = 'inline-block';
                            }
                        });
                    </script>
                    <!-- 상단 타이틀 end -->

                    <!-- 본문 -->
                    <div class="div-padding">

                        <div id="search-container">
						    <select id="searchType">
						        <option value="dept_title" <%= "dept_title".equals(searchType) ? "selected" : "" %>>부서명</option>
						        <option value="job_title" <%= "job_title".equals(searchType) ? "selected" : "" %>>직급</option>				
						        <option value="name" <%= "name".equals(searchType) ? "selected" : "" %>>이름</option>
						    </select>
						    <div id="search-memberDept" class="search-type">
						        <form action="<%=request.getContextPath()%>/emp/empFinder.do">
							            <input type="hidden" name="searchType" value="dept_title"/>
							            <input type="text" name="searchKeyword"  placeholder="검색할 부서명을 입력하세요." 
							            	value="<%= "dept_title".equals(searchType) ? searchKeyword : "" %>"/>
							            <button type="submit">검색</button>			
						        </form>	
						    </div>
						    <div id="search-memberJob" class="search-type">
						        <form action="<%=request.getContextPath()%>/emp/empFinder.do">
							            <input type="hidden" name="searchType" value="job_title"/>
							            <input type="text" name="searchKeyword"  placeholder="검색할 직급을 입력하세요." 
							            	value="<%= "job_title".equals(searchType) ? searchKeyword : "" %>"/>
							            <button type="submit">검색</button>			
						        </form>	
						    </div>
						    <div id="search-memberName" class="search-type">
						        <form action="<%=request.getContextPath()%>/emp/empFinder.do">
							            <input type="hidden" name="searchType" value="name"/>
							            <input type="text" name="searchKeyword" placeholder="검색할 이름을 입력하세요."
							            	value="<%= "name".equals(searchType) ? searchKeyword : "" %>" />
							            <button type="submit">검색</button>			
						        </form>	
						    </div>
						  
					    </div> <!-- search-container end -->

                        <div>
                        
                            <div>
                                <table id="emp-detail-table">
                                    <thead>
                                        <tr>
                                            <th width="70">이름</th>
                                            <th width="100">아이디</th>
                                            <th width="100">부서</th>
                                            <th width="100">직급</th>
                                            <th width="100">이메일</th>
                                            <th width="100">전화번호</th>
                                            <th width="100">입사일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:if test="${empty empList }">
                                    		<tr>
                                    			<td colspan="7">조회된 회원이 없습니다.</td>
                                    		</tr>
                                    	</c:if>
                                    	<c:if test="${!empty empList }">
	                                    	<c:forEach items="${empList}" var="emp">
	                                        <tr>
	                                            <td width="70">
	                                                <p class="font-bold" id="dept-name"><span>
	                                                <c:if test="${!empty emp.renameFilename}">
					                                    <img src="${pageContext.request.contextPath}/resources/upload/emp/${emp.renameFilename}"
					                                        alt="" class="my-img">
					                                </c:if>
					                                <c:if test="${empty emp.renameFilename}">
					                                    <img src="${pageContext.request.contextPath}/resources/images/default.png" alt=""
					                                        class="my-img">
					                                </c:if>
	                                                </span>${emp.name }</p>
	                                            </td>
	                                            <td width="100">${emp.empId }</td>
	                                            <td width="100">${emp.deptTitle }</td>
	                                            <td width="100">${emp.jobTitle }</td>
	                                            <td width="100">${emp.email }</td>
	                                            <td width="100">${emp.phone }</td>
	                                            <td width="100">${emp.hireDate }</td>  
	                                        </tr>
	                                        </c:forEach>
                                    	</c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- 페이지 바 -->
					    <div id="page-bar-box">
						    <ul class="pagination justify-content-center">
						
						    <c:if test="${startPage > 1}">
						      <li class="page-item">
						        <a class="page-link" href="${pageContext.request.contextPath}/emp/empAllInfo.do?cpage=${startPage-1}" aria-label="Previous">
						          <span aria-hidden="true">&lt;</span>
						          <span class="sr-only">Previous</span>
						        </a>
						      </li>
						    </c:if>
						
						    <c:forEach var="i" begin="${startPage}" end="${endPage}">
						      <li class="page-item ${i==currentPage ? 'active' : ''}">
						        <a class="page-link" href="${pageContext.request.contextPath}/emp/empAllInfo.do?cpage=${i}">${i}</a>
						      </li>
						    </c:forEach>
						
						    <c:if test="${endPage < totalPage}">
						      <li class="page-item">
						        <a class="page-link" href="${pageContext.request.contextPath}/emp/empAllInfo.do?cpage=${endPage+1}" aria-label="Next">
						          <span aria-hidden="true">&gt;</span>
						          <span class="sr-only">Next</span>
						        </a>
						      </li>
							</c:if>
						  </ul>
					  </div> <!-- 페이지 바 end -->
                    </div>
                    <!-- 본문 end -->
                </div>
            </div>	
         
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			