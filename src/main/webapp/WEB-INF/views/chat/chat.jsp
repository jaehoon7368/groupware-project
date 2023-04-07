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
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/chat/chat.css" />

<div class="all-container app-dashboard-body-content off-canvas-content"
	data-off-canvas-content>
	
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
						const chatroomId = data.chatroomId;
						
						
						const url = `${pageContext.request.contextPath}/chat/chatRoomPopUp.do?chatroomId=\${chatroomId}`;
						const name = chatroomId;               //popup의 window 이름, 브라우져가 탭 , 팝업윈도으를 관리하는 이름 
						const spec = "width=600px,height=700px";
						open(url,name,spec);
						
						
						
						
					},
				error: console.log,
			})
			
		})
		
		
	})
	
	</script>
	
	
	<!-- 왼쪽 추가 메뉴 end -->
	<div class="home-container">
	<style>
	</style>
		<!-- 본문 -->
		<div class="div-padding">
	    <table class="chat-table"> 
            <thead>
              <tr>
                <th width="200">채팅방 이름</th>
                <th>메시지</th>
                <th width="150">안읽은 메시지 수</th>
              </tr>
            </thead>
            <tbody>
            <c:if test="${!empty chatLogs }">
	            <c:forEach items="${chatLogs }" var="chatLog">   
	              <tr class="chat-tbl-tr" data-chatroomId = "${chatLog.chatroomId }">
	                <td class="name">${chatLog.emp.name }님 과의 채팅방</td>
	                <td class="msg">${chatLog.msg }</td>
	                <td class="unreadCount"><span>${chatLog.unreadCount }</span></td>
	              </tr>
	             </c:forEach>
             </c:if>
            <c:if test="${empty chatLogs }">
            	<tr class="chat-tbl-tr">
            		<td colspan="3">생성된 채팅방이 없습니다.</td>
            	</tr>
            </c:if>
            </tbody>
          </table>

		</div>
	</div>
</div>

<script>
 document.querySelectorAll("tr[data-chatroomId]").forEach((tr)=>{
	tr.addEventListener('click',(e)=>{
		console.log(e.target);
		let parentTr = e.target;
		while(parentTr.tagName !== 'TR')
			parentTr = parentTr.parentElement;
		
		console.log(parentTr);
		console.log(parentTr.dataset.chatroomid);
		
		
		const chatroomId = parentTr.dataset.chatroomId;
		const url = `${pageContext.request.contextPath}/chat/chatRoomPopUp.do?chatroomId=\${parentTr.dataset.chatroomid}`;
		const name = parentTr.dataset.chatroomid;               //popup의 window 이름, 브라우져가 탭 , 팝업윈도으를 관리하는 이름 
		const spec = "width=600px,height=700px";
		open(url,name,spec);
	})
})
	
	const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);
	const stompClient = Stomp.over(ws);
	
	stompClient.connect({}, (frame) => {
		stompClient.subscribe("/app/chat/<sec:authentication property="principal.username"/>/chatList" , (message)=>{
			console.log(message);
			const {chatroomId, empId, msg, time, unreadCount, type,name} = JSON.parse(message.body);
			let tr = document.querySelector(`tr[data-chatroomId="\${chatroomId}"]`);
			const myId ='<sec:authentication property="principal.username"/>' ;
						
			
			switch(type){
			case "LAST_CHECK" :
				
				if(tr){
				const span = tr.querySelector(".unreadCount span");
				span.innerHTML = 0;
				}
				break;
			case "CHAT" : 
				if (tr) {
					tr.querySelector('.msg').innerHTML = msg;
					
					if(empId !== myId){
						const span = tr.querySelector('.unreadCount span');
						let unreadCount = Number(span.innerHTML);
						span.innerHTML = unreadCount + 1;
					}
					break;
				}
				else{
					tr = document.createElement("tr");
			  		
					tr.dataset.chatroomId = chatroomId;
			  		
			  		const td1 = document.createElement("td");
			  		td1.classList.add('name');
			  		td1.innerHTML = "새로운 채팅방이 생성되었습니다.";
			  		const td2 = document.createElement("td");
			  		td2.classList.add('msg');
			  		td2.innerHTML = msg;
			  		const td3 = document.createElement("td");
			  		td3.classList.add('unreadCount');
			  		td3.innerHTML = unreadCount;
			  		
			  		tr.append(td1, td2, td3);
					
					
				}
				const tbody = document.querySelector('table tbody');
				tbody.insertAdjacentElement('afterbegin', tr);
				location.reload();
				break;
			}
			
			
			
		})
	});
 
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>