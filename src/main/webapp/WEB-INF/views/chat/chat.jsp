<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
<!-- WebSocket: stomp.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="" name="title"/>
	</jsp:include>

<div class="all-container app-dashboard-body-content off-canvas-content"
	data-off-canvas-content>
	
<style>
	
/* 테이블*/
.left-container {
    display: flex;
    flex-direction: row;
    align-content: space-around;
    flex-wrap: wrap;
}
</style>
	<!-- 왼쪽 추가 메뉴 -->
	<div class="left-container">
		<div class="accordion-box">
			<ul class="container-list">
				<c:forEach items="${sessionScope.deptList}" var="dept">
				<li>
					<p class="title font-medium">${dept.deptTitle}</p>
						<div class="">
							<ul class="container-detail font-small">
								<c:forEach items="${empList}" var="emp">
									<c:if test="${emp.deptCode eq dept.deptCode}">
										<c:if test="${emp.empId ne empId }">
										 <li class="li-emp" data-id="${emp.empId}" data-dept="${emp.deptCode}" data-job="${emp.jobTitle}" data-name="${emp.name}">${emp.name } ${emp.jobTitle }</li>
										</c:if>
									</c:if>
								</c:forEach>
							</ul>
						</div>
				</li>
	</c:forEach>

			</ul>
		</div>
	</div>
	<script>
	document.querySelectorAll(".li-emp").forEach((li)=>{
		li.addEventListener('click',(e)=>{
			const empId = e.target.dataset.id;
			const myEmpId = ${empId};
			console.log(myEmpId);
			const csrfHeader = "${_csrf.headerName}";
	        const csrfToken = "${_csrf.token}";
	        const headers = {};
	        headers[csrfHeader] = csrfToken;
			
			$.ajax({
				url: "${pageContext.request.contextPath}/chat/selectEmpChat.do",
				method: "POST",
				headers,
				data : {
						empId : empId,
						myEmpId: myEmpId
						},
				success(data){
						console.log(data)
						const chatroomId = data.querySelector("chatroomId");
						console.log(chatroomId.textContent);
						
						
						const url = `${pageContext.request.contextPath}/chat/chatRoomPopUp.do?chatroomId=\${chatroomId.textContent}`;
						const name = chatroomId;               //popup의 window 이름, 브라우져가 탭 , 팝업윈도으를 관리하는 이름 
						const spec = "width=500px,height=500px";
						open(url,name,spec);
						
						
						
					},
				error: console.log
			})
			
		})
		
		
	})
	
	</script>
	
	
	<!-- 왼쪽 추가 메뉴 end -->
	<div class="home-container">
	<style>
	.div-padding{
		margin-top : 200px;
	}
	
	</style>
		<!-- 본문 -->
		<div class="div-padding">
	    <table class="hover"> 
            <thead>
              <tr>
                <th width="200">채팅방 이름</th>
                <th>사원 이름</th>
                <th width="150">메시지</th>
                <th width="150">안읽은 메시지수 </th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Content Goes Here</td>
                <td>This is longer content Donec id elit non mi porta gravida at eget metus.</td>
                <td>Content Goes Here</td>
                <td>Content Goes Here</td>
              </tr>
              <tr>
                <td>Content Goes Here</td>
                <td>This is longer Content Goes Here Donec id elit non mi porta gravida at eget metus.</td>
                <td>Content Goes Here</td>
                <td>Content Goes Here</td>
              </tr>
    
            </tbody>
          </table>

		</div>
	</div>
</div>

<script>




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>