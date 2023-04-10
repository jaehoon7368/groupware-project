<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addr/addrHome.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="주소록" name="title"/>
	</jsp:include>

	<jsp:include page="/WEB-INF/views/addr/addrLeftBar.jsp" />


<div class="home-container">
	<!-- 상단 타이틀 -->
	<div class="top-container">
		<div class="container-title">개인 주소록</div>
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
					<button class="my-menu" onclick="location.href = '${pageContext.request.contextPath }/emp/empInfo.do'">기본정보</button>
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
		 		<span><img src="${pageContext.request.contextPath}/resources/images/plus.png" alt="" class="tool-img" /></span>
		 		<span>빠른등록</span>
	 		</a>
 		</div>
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/addr/addrDelete.do">
	 			<span><img src="${pageContext.request.contextPath}/resources/images/trash.png" alt="" class="tool-img" /></span>
	 			<span>삭제</span>
	 		</a>
 		</div>
 		<div class="tool-button">
 			<a href="${pageContext.request.contextPath}/addr/addrDelete.do">
	 			<span><img src="${pageContext.request.contextPath}/resources/images/copy.png" alt="" class="tool-img" /></span>
	 			<span>주소록 복사</span>
	 		</a>
 		</div>
 	</div>
 	
 	<div class="div-padding"></div>
 	
 	<div class="simpleFrm-wrap" style="display:none;">
 		<form action="${pageContext.request.contextPath}/addr/addrEnroll.do?${_csrf.parameterName}=${_csrf.token}" id="simpleEnrollFrm"method="post"
 		enctype="multipart/form-data">
            <div id="profile-box" style="display:none;">
               <label for="upfile"><i class="fa-solid fa-magnifying-glass" style="padding-top:7px;"></i></label>
               <input type="file" id="upFile" name="upFile" accept="image/*" onchange="previewImage(event)">
            </div>                   
 			<input style="color:gray; font-size:13px;" type="text" id="name" name="name" placeholder="이름"/>
 			<input style="color:gray; font-size:13px;"  type="text" id="email" name="email" placeholder="이메일"/>
 			<input style="color:gray; font-size:13px;" type="text" id="phone" name="phone" placeholder="휴대폰"/>
 			<input type="hidden" name="groupType" value="P" />
 			<input type="hidden" name="writer" id="writer" value="${loginMember.empId}" required>
 			<input type="hidden" name="groupName" value="${param.groupName}" />
 			<input type="submit" id="" name="" style="height:30px; width:30px; border:none;" value="+"/> 
 		</form>
 	</div>
 	<div class="div-padding"></div>
 	
 	<div id="search-div" class="search-div" style="display:flex;">
 			<button class="btn-search-keyword" onclick="styleChange(this);">전체</button>
 			<button class="btn-search-keyword" onclick="styleChange(this);">ㄱ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㄴ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㄷ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㄹ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅁ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅂ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅅ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅇ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅈ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅊ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅋ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅌ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅍ</button>
			<button class="btn-search-keyword" onclick="styleChange(this);">ㅎ</button>
 	</div>
 	
<section class="notice">
  <!-- board list area -->
    <div id="addr-list">
        <div class="container">
            <table class="addr-table">
                <thead>
                <tr>
                	<th style="padding-left:5px;">
						<input type="checkbox" id="selectAllBtn" name="" value=""/>
					</th>
                    <th scope="col" class="th-name">이름</th>
                    <th scope="col" class="th-jobName">직위</th>
                    <th scope="col" class="th-phone">휴대폰</th>
                    <th scope="col" class="th-email">이메일</th>
                    <th scope="col" class="th-deptTitle">부서</th>
                    <th scope="col" class="th-company">회사</th>
                    <th scope="col" class="th-companyPhone">회사전화</th>
                    <th scope="col" class="th-cpAddress">회사주소</th>
                    <th scope="col" class="th-memo">메모</th>
                    <th scope="col" class="th-group">그룹</th>
                </tr>
                </thead>
                <tbody>
	                <c:if test="${empty addrGroupByName}">
	                     <tr>
	                        <td colspan="11" style="padding-top:20px;">조회된 주소록이 없습니다..</td>
	                    </tr>
	                </c:if>
	                <c:if test="${!empty addrGroupByName }">
	               <c:forEach items="${addrGroupByName}" var="addr">
					    <tr data-no="${addr.addrNo}">
					        <td style="padding-left:5px;"><input type="checkbox" name="addrNo" value="${addr.addrNo}"/></td>
					        <td>${addr.name}</td>
					        <td>${addr.jobName}</td>
					        <td>${addr.phone}</td>
					        <td>${addr.email} </td>
					        <td>${addr.deptTitle}</td>
					        <td>${addr.company}</td>
					        <td>${addr.cpTel}</td>
					        <td>${addr.cpAddress}</td>
					        <td>${addr.memo}</td>
					        <td>${addr.groupName}</td>
					    </tr>
					</c:forEach>
					</c:if>
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
        <a class="page-link" href="${pageContext.request.contextPath}/addr/addrListForm.do?groupName=${param.groupName}&cpage=${startPage-1}" aria-label="Previous">
          <span aria-hidden="true">&lt;</span>
          <span class="sr-only">Previous</span>
        </a>
      </li>
    </c:if>

    <c:forEach var="i" begin="${startPage}" end="${endPage}">
      <li class="page-item ${i==currentPage ? 'active' : ''}">
        <a class="page-link" href="${pageContext.request.contextPath}/addr/addrListForm.do?groupName=${param.groupName}&cpage=${i}">${i}</a>
      </li>
    </c:forEach>

    <c:if test="${endPage < totalPage}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/addr/addrAddrListForm.do?groupName=${param.groupName}&cpage=${endPage+1}" aria-label="Next">
          <span aria-hidden="true">&gt;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
	  </ul>
	</c:if>

	
<script>
const quickRegisterButton = document.querySelector('.tool-button a');


quickRegisterButton.addEventListener('click', function() {
  const simpleFrmWrap = document.querySelector('.simpleFrm-wrap');

  if (simpleFrmWrap.style.display === 'none') {
    simpleFrmWrap.style.display = 'block';
  } else {
    simpleFrmWrap.style.display = 'none';
  }
  
  
});
</script>
<script>
  // 클릭 이벤트 핸들러 함수
 function handleButtonClick(event) {
	  console.log('event', event);
  const keyword = event.target.innerText;
  location.href = '${pageContext.request.contextPath}/addr/addrHome.do?keyword=' + keyword;
	  console.log(keyword);
  }
  // 버튼 요소들 가져오기
  const buttons = document.querySelectorAll('.btn-search-keyword');
  // 버튼 요소들에 클릭 이벤트 핸들러 함수 등록하기
  buttons.forEach(button => {
    button.addEventListener('click', handleButtonClick);
  });
</script>
<script>
const styleChange = (btn) => {
	document.querySelectorAll('#search-div .btn-search-keyword').forEach((btn) => {
		btn.style.borderBottom = 'none';
	});
		btn.style.borderBottom = 'solid 2px #000';
};
</script>

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
        console.log("Selected addrNo: " + addrNo);
        
 // 삭제 버튼 클릭 시
        $('a[href$="/addrDelete.do"]').click(function(event) {
            event.preventDefault();
            const addrNos = [];
            const csrfHeader = "${_csrf.headerName}";
      	    const csrfToken = "${_csrf.token}";
      	    const headers = {};
      	  headers[csrfHeader] = csrfToken;
            $('input[name=addrNo]:checked').each(function() {
                addrNos.push($(this).val());
            });
            console.log("Selected addrNos: " + addrNos);
            
            $.ajax({
                url: '${pageContext.request.contextPath}/addr/addrsDelete.do',
                type: 'POST',
                data: {addrNos: addrNos},
                headers,
                success: function() {
                    location.href = "${pageContext.request.contextPath}/addr/addrHome.do";
                },
                error: function() {
                    alert("삭제 실패");
                }
            });    
    });
    });
});
</script>
<script>
document.querySelectorAll("tr[data-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		 // 클릭한 엘리먼트가 input 태그인 경우 이벤트 처리를 하지 않음
	    if (e.target.tagName.toLowerCase() === 'input') {
	      return;
	    }
		const addrNo = tr.dataset.no;
		console.log(addrNo);
		location.href = '${pageContext.request.contextPath}/addr/addrUpdateForm.do?addrNo=' + addrNo;
	});
});
</script>






	<jsp:include page="/WEB-INF/views/common/footer.jsp" />