<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addr/addrAnywhere.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="주소록" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/addr/addrLeftBar.jsp" />


<div class="home-container">
	<!-- 상단 타이틀 -->
	<div class="top-container">
		<div class="container-title">주소록</div>
		<div class="home-topbar topbar-div">
			<div>
				<a href="#" id="home-my-img"> <img
					src="${pageContext.request.contextPath}/resources/images/sample.jpg"
					alt="" class="my-img">
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
	const style =  modal.style.display;
	
		if (style == 'inline-block') {
				modal.style.display = 'none';
			} else {
				modal.style.display = 'inline-block';
				}
			});
	</script>

	<!-- 상단 타이틀 end -->

	<!-- 본문 -->
	<div class="div-padding"></div>
	
	<div class="content">
	
	<div class="tool-bar">
 		<div class="tool-button">
 			<a href="#">
		 		<span><img src="${pageContext.request.contextPath}/resources/images/pencil.png" alt="" class="tool-img" /></span>
		 		<span>빠른등록</span>
	 		</a>
 		</div>
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/board/boardForm.do?bType=A">
		 		<span><img src="${pageContext.request.contextPath}/resources/images/pencil.png" alt="" class="tool-img" /></span>
		 		<span>메일발송</span>
	 		</a>
 		</div>
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/board/boardDelete.do">
	 			<span><img src="${pageContext.request.contextPath}/resources/images/trash.png" alt="" class="tool-img" /></span>
	 			<span>삭제</span>
	 		</a>
 		</div>
 	</div>
 	
 	<div class="div-padding"></div>
 	
 	<div class="simpleFrm-wrap">
 		<form action="" id="simpleEnrollFrm">
 			<input style="color:gray; font-size:13px;" type="text" id="" name="" value="이름"/>
 			<input style="color:gray; font-size:13px;"  type="text" id="" name="" value="이메일"/>
 			<input style="color:gray; font-size:13px;" type="text" id="" name="" value="휴대폰" />
 			<input type="button" id="" name="" style="height:30px; width:30px; border:none;" value="+"/> 
 		</form>
 	</div>
 	<div class="div-padding"></div>
 	
 	<div id="serch-all-wrap">
 		<ul style="display:flex;">
 			<li data-param class="serch-All"><span>전체</span></li>
 			<li data-param="ㄱ"><span>ㄱ</span></li>
 			<li data-param="ㄴ"><span>ㄴ</span></li>
 			<li data-param="ㄷ"><span>ㄷ</span></li>
 			<li data-param="ㄹ"><span>ㄹ</span></li>
 			<li data-param="ㅁ"><span>ㅁ</span></li>
 			<li data-param="ㅂ"><span>ㅂ</span></li>
 			<li data-param="ㅅ"><span>ㅅ</span></li>
 			<li data-param="ㅇ"><span>ㅇ</span></li>
 			<li data-param="ㅈ"><span>ㅈ</span></li>
 			<li data-param="ㅊ"><span>ㅊ</span></li>
 			<li data-param="ㅋ"><span>ㅋ</span></li>
 			<li data-param="ㅌ"><span>ㅌ</span></li>
 			<li data-param="ㅍ"><span>ㅍ</span></li>
 			<li data-param="ㅎ"><span>ㅎ</span></li>
 		</ul>
 	</div>
 	
<section class="notice">
  <!-- board list area -->
    <div id="addr-list">
        <div class="container">
            <table class="addr-table">
                <thead>
                <tr>
                	<th style="width:20px;">
						<input type="checkbox" id="selectAllBtn" name="" value=""/>
					</th>
                    <th scope="col" class="th-name">이름</th>
                    <th scope="col" class="th-jobName">직위</th>
                    <th scope="col" class="th-phone">휴대폰</th>
                    <th scope="col" class="th-email">이메일</th>
                    <th scope="col" class="th-deptTitle">부서</th>
                </tr>
                </thead>
                <tbody>
	              	 <c:forEach items="${addressBookList}" var="addr">
					   	<tr data-no="${addr.addrNo}">
					   		<td><input type="checkbox" name="addrNo" value="${addr.addrNo}"/></td>
	                		<td>${addr.name}</td>
	                		<td>${addr.jobName}</td>
	                		<td>${addr.phone}</td>
	                		<td>${addr.email}</td>
	                		<td>${addr.deptTitle}</td>
					    </tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>
</div><!-- content end -->

<div class="div-padding"></div>
<!-- 페이지바 -->


  <ul class="pagination justify-content-center">

    <c:if test="${startPage > 1}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/addr/addrAnywhere.do?cpage=${startPage-1}" aria-label="Previous">
          <span aria-hidden="true">&lt;</span>
          <span class="sr-only">Previous</span>
        </a>
      </li>
    </c:if>

    <c:forEach var="i" begin="${startPage}" end="${endPage}">
      <li class="page-item ${i==currentPage ? 'active' : ''}">
        <a class="page-link" href="${pageContext.request.contextPath}/addr/addrAnywhere.do.do?cpage=${i}">${i}</a>
      </li>
    </c:forEach>

    <c:if test="${endPage < totalPage}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/addr/addrAnywhere.do?cpage=${endPage+1}" aria-label="Next">
          <span aria-hidden="true">&gt;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
	  </ul>
	</c:if>

	
<script>
$(document).ready(function() {
    // 전체선택 버튼 클릭 시
    $('#selectAllBtn').click(function() {
        const isChecked = $(this).prop('checked');
        $('input[name=addrNo]').prop('checked', isChecked);
    });

    // 체크박스 선택 시
    $('input[name=addrNo]').change(function() {
        // 선택된 체크박스의 값 가져오기
        const addrNo = $(this).val();
        console.log("Selected addrNo: " + boardNo);
    });
});
</script>







	<jsp:include page="/WEB-INF/views/common/footer.jsp" />