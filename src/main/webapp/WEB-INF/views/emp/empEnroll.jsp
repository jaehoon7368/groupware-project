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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/emp.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	
	<div class="home-container">
                    <!-- 상단 타이틀 -->
                    <div class="top-container">
                        <div class="container-title font-bold">인사정보 등록</div>
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
                            <table class="mx-auto w-100">
                                <tr>
                                    <th>아이디</th>
                                    <td>
                                        <div id="memberId-container">
                                            <input type="text" class="form-control" placeholder="아이디(4글자이상)" name="empId" id="memberId" required>
                                            <input type="hidden" id="idValid" value="0" />
                                        </div>
                            
                                    </td>
                                </tr>
                                <tr>
                                    <th>패스워드</th>
                                    <td>
                                        <input type="password" class="form-control" name="password" id="password" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>패스워드확인</th>
                                    <td>
                                        <input type="password" class="form-control" id="passwordCheck" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이름</th>
                                    <td>
                                        <input type="text" class="form-control" name="name" id="name" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>주민번호</th>
                                    <td>
                                        <input type="text" class="form-control" name="ssn" id="ssn" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        <input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email">
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td>
                                        <input type="text" class="form-control" name="address" id="address">
                                    </td>
                                </tr>
                                <tr>
                                    <th>휴대폰</th>
                                    <td>
                                        <input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11"
                                            required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>부서</th>
                                    <td>
                                        <select class="work-select font-bold" name="deptCode">
                                            <option selected>부서선택</option>
                                            <option value="d1">인사총무</option>
                                            <option value="d2">개발</option>
                                            <option value="d3">법무</option>
                                            <option value="d4">마케팅</option>
                                            <option value="d5">기획</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>직급</th>
                                    <td>
                                        <select class="work-select font-bold" name="jobCode">
                                            <option selected>직급선택</option>
                                            <option value="j1">사장</option>
                                            <option value="j2">부사장</option>
                                            <option value="j3">부장</option>
                                            <option value="j4">차장</option>
                                            <option value="j5">과장</option>
                                            <option value="j6">대리</option>
                                            <option value="j7">주임</option>
                                            <option value="j8">사원</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="등록">
                        </form:form>
                    </div>
                    <!-- 본문 end -->
                </div>
            </div>
         
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			