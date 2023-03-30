<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Emp" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empAllInfo.css">
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
                                <button class="my-menu">로그아웃</button>
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

                        <div id="search-box">
                            <label for="search-year">검색 조건 :</label>
                                <select id="search-year" name="search-year">
                                	<option selected>선택</option>
                                    <option value="1">이름</option>
                                    <option value="2">부서</option>
                                </select>
                        </div>

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
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 본문 end -->
                </div>
            </div>	
         
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			