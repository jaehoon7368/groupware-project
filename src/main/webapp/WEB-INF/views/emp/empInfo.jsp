<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="근태관리" name="title"/>
	</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empEnroll.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	<sec:authentication property="principal" var="loginEmp"/>
	
	<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title font-bold">내 인사 정보</div>
							<div class="home-topbar topbar-div">
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
                    <div id="empInfo">
                        <form:form action="" method="post" name="empInfoFrm">
                            <table>
                            	<tr>
                            		<th></th>
                            		<td>
                                        <div id="profile-box">
                                        	<c:if test="${!empty attach.renameFilename}">
	                                            <img id="preview" src="${pageContext.request.contextPath}/resources/upload/emp/${attach.renameFilename}" style="max-width:150px; max-height:150px;">
                                        	</c:if>
                                        	<c:if test="${empty attach.renameFilename}">
	                                            <img id="preview" src="${pageContext.request.contextPath}/resources/upload/emp/default.png" style="max-width:150px; max-height:150px;">
                                        	</c:if>
                                        </div>
                                    </td>
                            	</tr>
                            	<tr>
                            		<th>이름</th>
                            		<td><p>${loginMember.name}</p></td>
                            	</tr>
                            	<tr>
                            		<th>패스워드</th>
                                    <td>
                                        <input type="password"  name="password" id="password" required><span>* 기존 비밀번호를 입력하시거나 변경하실 비밀번호를 입력해주세요.</span>
                                    </td>
                            	</tr>
                            	<tr>
                            		<th>패스워드확인</th>
                                    <td>
                                        <input type="password" id="passwordCheck" required>
                                    </td>
                            	</tr>
                            	<tr>
                            		<th>이메일</th>
                            		<td><p>${loginMember.email}</p></td>
                            	</tr>
                            	<tr>
                            		<th>전화번호</th>
                            		<td>
                                         <input type="tel"  placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11"
                                            value="${loginMember.phone }" required>
                                    </td>
                            	</tr>
                            	 <tr>
                                    <th>주소</th>
                                   <td colspan="5">
                                        <input style="width: 500px;" type="text" class="form-control" name="address" id="address" value="${loginMember.address }" required>
                                    </td>
                                </tr>
                                 <tr>
                                    <th>부서</th>
                                    <td>
                                        <p>${emp.deptTitle}</p> 
                                    </td>
                                </tr>
                                <tr>
                                    <th>직급</th>
                                    <td>
                                        <p>${emp.jobTitle}</p> 
                                    </td>
                                </tr>
                            	
                            </table>
                            <input type="submit" id="btn-empEnroll" value="수정">
                        </form:form>
                    </div>
                    <!-- 본문 end -->
                </div>
            </div>

<script>
document.empInfoFrm.addEventListener('submit',(e)=>{
	const password = document.querySelector("#password");
	const passwordCheck = document.querySelector("#passwordCheck");
	
	if(password.value !== passwordCheck.value){
		alert("비밀번호를 확인해주세요.");
		e.preventDefault();
		password.focus();
		return false;
	}
});
</script>

         
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			