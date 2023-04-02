<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/foundation.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/index.css" />
</head>
<body>
<form:form
	action="${pageContext.request.contextPath}/emp/login.do"
	method="post">
  <div class="sign-in-form">
    <h2 class="text-center">Anyware</h2>
    <h4 class="text-center">Sign In</h4>
	<c:if test="${param.error != null}">
		 <div class="text-center" id="login-error">
			<p>아이디 또는 비밀번호가 일치하지 않습니다.</p>
		</div>
	</c:if>
    <label for="sign-in-form-username">Username</label>
    <input type="text" class="sign-in-form-username" id="sign-in-form-username" name="empId">
    <label for="sign-in-form-password">Password</label>
    <input type="text" class="sign-in-form-password" id="sign-in-form-password" name="password">
    <div>
		<input type="checkbox" name="remember-me" id="remember-me"/>
		<label for="remember-me">Remember me</label>
	</div>
    <button type="submit" class="sign-in-form-button">Sign In</button>
  </div>
</form:form>

	
</body>
</html>