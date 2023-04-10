<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    

                <div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="left-container">
						<div class="container-title"><a href="${pageContext.request.contextPath}/addr/addrHome.do" class="container-a">주소록</a></div>
						
							<div class="container-btn">
							<a href="${pageContext.request.contextPath}/addr/addrEnrollForm.do"><button>연락처 추가</button></a>
							</div>
						
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">전체 주소록</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="${pageContext.request.contextPath}/addr/addrHome.do">전체 주소록</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">개인 주소록</p>
									<div class="con">
										<ul class="container-detail font-small">
												
											
											<c:forEach items="${sessionScope.addrGroupList}" var="addrGroup">
											    <li>
											        <a href="${pageContext.request.contextPath}/addr/addrListForm.do?groupName=${addrGroup.groupName}" style="color:black;">
											            ${addrGroup.groupName}
											        </a>
											    </li>
											</c:forEach>
											
											<li>
												<div id="create-input" class="create-input" style="display:none; padding:3px; margin:0px;">
												<form id="createGroupFrm" action="${pageContext.request.contextPath}/addr/createAddrGroup.do?${_csrf.parameterName}=${_csrf.token}" method="post">
													<input type="hidden" id="empId" name="empId" value="${loginMember.empId}"/>
   													<input type="hidden" id="groupType" name="groupType" value="P"/>
													<input type="text" id="groupName" name="groupName" class="groupName" 
													style="height:25px; width:100px; font-size:12px; color:gray; border:2px solid black; background-color: #efeded;
	   												border-radius: 5px; " value="" placeholder="주소록 이름"/>
												</form>
													<span id="ok-btn" name="create-btn" style="margin:3px; margin-left:10px;">
														<img src="${pageContext.request.contextPath}/resources/images/check.png" style="width:20px; height:20px; display:flex;" alt="" />
													</span>
													<span id="back-btn" name="back-btn" style="margin:3px;">
														<img src="${pageContext.request.contextPath}/resources/images/back.png" style="width:20px; height:20px; display:flex;" alt="" />
													</span>
												</div>
											</li>
											<li id="create-group" name="create-group"><a href="#">+ 주소록 추가</a></li>
										</ul>
									</div>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/addr/addrAnywhere.do"><p class="title font-medium">Anywhere 연락망</p></a>
								</li>
									
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->

<script>
//주소록 추가 버튼을 클릭하면
$('#create-group').click(function(){
  // create-input 태그와 이미지 태그들을 보이도록 설정
  $('#create-input').css('display', 'flex');
});

// 뒤로 가기 버튼을 클릭하면
$('#back-btn img').click(function(){
  // create-input 태그와 이미지 태그들을 숨기도록 설정
  $('#create-input').css('display', 'none');
});
</script>
<script>
  $(function() {
    $("#ok-btn").click(function() {
      $("#createGroupFrm").submit();
    });
  });
</script>