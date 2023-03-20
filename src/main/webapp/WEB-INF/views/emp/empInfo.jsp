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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empEnroll.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	<sec:authentication property="principal" var="loginEmp"/>
	<div class="home-container">
                    <!-- 상단 타이틀 -->
                    <div class="top-container">
                        <div class="container-title font-bold">내 인사정보</div>
                        <div class="home-topbar topbar-div">
                            <div>
                                <a href="#" id="home-my-img">
                                    <img src="images/sample.jpg" alt="" class="my-img">
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
                    <div id="empInfo">
                        <form:form action="" method="post">
                            <table>
                                <tr>
                                    <th>사진</th>
                                    <th>이름</th>
                                    <th>사번</th>
                                    <td>
                                        <div id="empId-container">
                                            ${loginEmp.empId}
                                            <input type="hidden" id="idValid" value="0" />
                                        </div>
                                    </td>
                                    <th>주민번호</th>
                                    <td>
                                        ${loginEmp.ssn}
                                    </td>
                                </tr>
                                <tr>
                                    <td rowspan="3">
                                       <div>
										  <img id="preview" src="${pageContext.request.contextPath}/resources/upload/emp/${attach.renameFilename}"  style="max-width:200px; max-height:200px;">
										</div>
                                    </td>
                                    <td rowspan="3" style="width: 200px;">
                                        ${loginEmp.name}
                                    </td>
                                    <th>패스워드</th>
                                    <td>
                                        <input type="password"  name="password" id="password" required>
                                    </td>
                                    <th>패스워드확인</th>
                                    <td>
                                        <input type="password" id="passwordCheck" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        ${loginEmp.email }
                                    </td>
                                    <th>휴대폰</th>
                                    <td>
                                         <input type="tel"  placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11"
                                            value="${loginEmp.phone }" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>부서</th>
                                    <td>
                                        ${emp.deptTitle}
                                    </td>
                                    <th>직급</th>
                                    <td>
                                        ${emp.jobTitle}
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                   <td colspan="5">
                                        <input style="width: 920px;" type="text" class="form-control" name="address" id="address" value="${loginEmp.address }" required>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" id="btn-empEnroll" value="수정">
                        </form:form>
                    </div>
                    <!-- 본문 end -->
                </div>
            </div>
         
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			