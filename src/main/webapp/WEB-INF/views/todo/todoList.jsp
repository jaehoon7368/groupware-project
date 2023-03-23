<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Mail" name="title" />
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/todoList.css">
<div class="all-container app-dashboard-body-content off-canvas-content"
	data-off-canvas-content>


	<div class="home-container">
		<!-- 상단 타이틀 -->
		<div class="top-container">
			<div class="container-title">각자 기능</div>
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
		<div class="div-padding">
			<style>

</style>
			<div class="content-top">
				<h2 class="board-menu" id="boardMenu">Board .${todoBoard.title}</h2>
				<!-- 게시판 메뉴 모달 -->
				<div class="removeView board-menu-modal" id="boardMenuModal">
					<div class="modalTitle">Board</div>
					<div class="modalList" id="todoHome">Todo홈</div>
					<div class="modalList">즐겨찾는보드</div>
					<div class="modalList">내보드</div>
				</div>
				<script>
	//todo홈버튼  
	document.querySelector("#todoHome").addEventListener('click',()=>{
		location.href='${pageContext.request.contextPath}/todo/todo.do';		
	})
	const boardMenu = document.querySelector("#boardMenu");
	const boardMenuModal = document.querySelector("#boardMenuModal");
	// Board 클릭  보이고 안보이고 
	boardMenu.addEventListener('click',()=>{
   		 boardMenuModal.classList.remove('removeView');
	})
	//바깥누르면 취소
	document.addEventListener('click', (event) => {
    	if (!boardMenuModal.contains(event.target) && event.target !== boardMenu) {
        	boardMenuModal.classList.add('removeView');
   	 }
	});
</script>
				<!-- 게시판 메뉴 모달끝 -->
			</div>
			<div class="wrap_board">

				<div class="wrap_todo_board todo-div">
					<ul>
						<c:forEach items="${ todoLists}" var="todoList" varStatus="vs">
							<li class="todo-li" id="listContainer">
								<div class="top-list" id="listTitle${vs.index }"
									onclick="changeView${vs.index}(event);">${todoList.title}</div>
								<!-- 제목 -->
								<form:form method="POST" action="${pageContext.request.contextPath }/todo/todoListUpdate.do" id="updateFrm${vs.index}" class="removeView">
									<input type="text" placeholder="제목" value="${todoList.title}"  name="title"/>
									<input type="hidden"  value="${todoList.no }" name="no" />
									<input type="hidden" value="${todoBoard.no }" name="todoBoardNo"/>
									<button class="comment-btn">저장</button>
									<button class="comment-btn" id="titleCanclebtn${vs.index}">취소</button>
								</form:form>
								<form:form method="POST" action="${pageContext.request.contextPath }/todo/todoListDelete.do">
									<input type="hidden"  value="${todoList.no }" name="no" />
									<input type="hidden" value="${todoBoard.no }" name="todoBoardNo"/>
									<button class="comment-btn" onclick="confrm(event);">삭제</button>
								</form:form>
								<div class="row">
									<script>
// 제목 폼 변경 메소드


var changeView${vs.index}=(e)=>{
const ufrm = document.querySelector("#updateFrm${vs.index}");
const listTitle = document.querySelector("#listTitle${vs.index}")
	listTitle.classList.add('removeView');
	ufrm.classList.remove('removeView');
	e.stopPropagation();
} 

//제목 취소 버튼 이벤트
	document.querySelector("#titleCanclebtn${vs.index}").addEventListener('click',(e)=>{
		const listTitle = document.querySelector("#listTitle${vs.index}")
		const ufrm = document.querySelector("#updateFrm${vs.index}");
	listTitle.classList.remove('removeView');
	ufrm.classList.add('removeView');		
	e.preventDefault();
	});
	</script>
									<c:forEach items="${todoList.todos }" var="todo">
											<a href="javascript:modalOpen('${todoList.no }','${todo.no}')" data-open="___exampleModal">
												<div class="board-list">
													<span>${todo.content } </span>
													<p>Test Line</p>
												</div>
											</a>
										</p>
										</c:forEach>

										
								
									
								</div>

								<div class="new-board-list"onclick="changeView2${vs.index}(event);"id="newboardDiv${vs.index }">
									<i class="fa fa-plus" aria-hidden="true"
										style="font-size: 2em; color: gray;"></i>
								</div> <!--  -->
								<div id="enrollFrm${vs.index }" class="removeView">
									<form:form action="${pageContext.request.contextPath }/todo/todoEnroll.do" method="POST" >
										<input type="hidden" name ="todoListNo"  value="${todoList.no }"/>
										<input type="hidden" name ="todoBoardNo" value="${todoList.todoboardNo }"/>
										<textarea id="todoListcontent${vs.index }"name="content" id="" cols="30" rows="5"
											style="margin-top: 21px;"></textarea>
										<button class="comment-btn" id="todoEnrollbtn" name ="todoEnrollbtn">저장</button>
										<button class="comment-btn"
											id="titleContentCanclebtn${vs.index }">취소</button>
									</form:form>
								</div>
							</li>	
							<script>

	document.querySelector("#enrollFrm${vs.index }").addEventListener('submit',(e)=>{
		
		const todoListcontent${vs.index } = document.querySelector("#todoListcontent${vs.index }");
		
		if(/^\s+/.test(todoListcontent${vs.index }.value) || !todoListcontent${vs.index }.value){	
			e.preventDefault();
			alert('한글자 이상 입력해주세요');
		}
	});
//등록 폼 변경 이벤트
const changeView2${vs.index}=(e)=>{
	console.log('클릭확인')
	e.target.classList.add('removeView');
	var frm = document.querySelector("#enrollFrm${vs.index }");
	frm.classList.remove('removeView');
	e.stopPropagation();
}
// + 취소 버튼 변경 이벤트
document.querySelector("#titleContentCanclebtn${vs.index }").addEventListener('click',(e)=>{
	e.preventDefault();
	const newboardDiv = document.querySelector("#newboardDiv${vs.index }")
	const enrollFrm = document.querySelector("#enrollFrm${vs.index }");
	enrollFrm.classList.add('removeView');
	newboardDiv.classList.remove('removeView');
})


</script>
						</c:forEach>
						<!--  container 끝 -->
						<li class="todo-li">
							<div class="new-board-list" onclick="" id="todoListEnrolldiv">
								<i class="fa fa-plus" aria-hidden="true"
									style="font-size: 2em; color: gray;"></i>
							</div>
							<div id="todoListEnrollFrm" class="removeView">
								<form:form method="POST" action="${pageContext.request.contextPath}/todo/todoListEnroll.do" >
								<input type="text" name="todoListTitle" id="todoListTitle" />
								<input type="hidden" name="no" value="${todoBoard.no }" id="todoBoardNo" />
								<button class="comment-btn" id="todoListEnrollbtn">저장</button>
								<button class="comment-btn" id="todoListEnrollCancle">취소</button>
								</form:form>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>

	</div>
</div>



<script>
	//유효성 검사
	document.querySelector("#todoListEnrollbtn").addEventListener('click',(e)=>{
		const todoListTitle = document.querySelector("#todoListTitle");
		if(/^\s+/.test(todoListTitle.value) || !todoListTitle.value){	
			e.preventDefault();
			alert('한글자 이상 입력해주세요');
		}
	});
	
	
	
	
	//TodoList 클릭 폼변경
	const todoListEnrollFrm = document.querySelector("#todoListEnrollFrm");
	const todoListEnrolldiv =document.querySelector("#todoListEnrolldiv").addEventListener('click',(e)=>{
		e.stopPropagation();
		e.target.classList.add('removeView');
		todoListEnrollFrm.classList.remove('removeView');
	})
	//TodoList 취소 클릭
	document.querySelector("#todoListEnrollCancle").addEventListener('click',(e)=>{
		e.preventDefault();
		const todoListEnrolldiv =document.querySelector("#todoListEnrolldiv");
		todoListEnrollFrm.classList.add('removeView');
		console.log(todoListEnrolldiv)
		todoListEnrolldiv.classList.remove('removeView');
	})
	
	


	
	
	
	</script>
<style>
/*모달 CSS 변경*/
.button {
  background-color: gray; /* 배경 색상을 회색으로 변경 */
  color: white; /* 텍스트 색상을 흰색으로 변경 */
  padding: 10px 20px; /* 선택적으로 패딩 값을 지정할 수 있습니다. */
}
/* todo 모달안 삭제 버튼 */
#todoContent{
	position:relative;
}
#todoDeletebtn{
	position:absolute;
	right: 98px;
    top: 39px;
}
</style>
	<div class="large reveal" id="exampleModal" data-reveal>
											<!-- 모달 본문 -->
							<div class="wrap-todo-detail">
												<div class="todo-header">
													<div class="todo-header">
														<i class="fa fa-folder fa-2x" style="color: gray"
															aria-hidden="true"></i>
														<h5 id="todoContent">
															</h5>
														<form:form action="${pageContext.request.contextPath }/todo/todoContentUpdate.do" id="updateConFrm"
															class="removeView">
															<input type="text"   name="content"/>
															<input type="hidden" name="todoBoardNo" value="${todoBoard.no }" />
															<input type="hidden" name="no" id="todoContentinput"/>
															<button class="comment-btn">수정</button>
															<button class="comment-btn"
																id="contentCanclebtn">취소</button>
														</form:form>
														<form:form action="${pageContext.request.contextPath }/todo/todoDelete.do" id="deletetodoFrm">
															<input type="hidden" name="todoBoardNo" value="${todoBoard.no }" />
															<input type="hidden" name="no" id="todoDeleteinput"/>
															<button class="comment-btn" onclick="confrm(event);" id="todoDeletebtn">삭제</button>
														</form:form>
													</div>
													<div>
														<!-- 공간용 -->
													</div>
												</div>

												<div class="todo-content" id="tododiv">
													<div class="explain-div">
														<!-- 설명 내용 데이터 -->
														<p id="epContent">
															
														</p>
														<!-- 클릭하면 input 내용 보이게   -->
														<form:form action="${pageContext.request.contextPath }/todo/todoInfoUpdate.do" id="updateEpFrm" class="removeView">
															<input type="hidden" name="no" id="todoUpdateinput"/>
															<input type="hidden" name="todoBoardNo" value="${todoBoard.no }"/>
															<textarea name="info" id="" cols="30" rows="5" style="margin-top: 21px;"></textarea>
															<button class="comment-btn">수정</button>
															<button class="comment-btn" id="epCanclebtn">취소</button>
														</form:form>
													</div>
													<div id="img-viewer-container" style="display: flex; justify-content: center;">
														<img id="img-viewer" width="50%">
													</div>
													<hr>
													<ul>

														<h3>
															<i class="fa fa-paperclip fa-1x" aria-hidden="true"><p>
																</p></i>파일첨부
														</h3>
														<div class="attach-div">
															<i class="fa fa-paperclip" aria-hidden="true"></i>
															<label for="exampleFileUpload" class="button">파일첨부를하려면 선택하세요</label>
															<input type="file" id="exampleFileUpload" class="show-for-sr" name="upFile">
														</div>
													</ul>
													<div>
														댓글
														<hr>
													</div>
													<div class="comment-div"> <!--  댓글입력창 -->
														<div style="width: 50px">
															<img src="/김현동/joonpark.jpg" alt="" style="width: 100%;">
														</div>
														<div style="width: 90%">
															<form:form action="${pageContext.request.contextPath }/todo/commentEnroll.do">
																<input type="text" class="comment-input" name="content">
																<input type="hidden" class="comment-input" name="todoBoardNo" value="${todoBoard.no }">
																<input type="hidden" id="comment-todo-input" name="todoNo"/>
														</div>
														<button class="comment-btn">확인</button>
															</form:form>
													</div><!-- 댓글 나오게  -->

													<div class="comment-div">  
														<div style="width: 50px">
															<img src="/김현동/joonpark.jpg" alt="" style="width: 100%;">
														</div>
														<div style="width: 90%">
															<input type="text" class="comment-input" readonly>
														</div>
														<button class="comment-btn">삭제</button>
													</div> <!--  댓글  -->
												</div>
											</div>
											<!-- detail end-->
											<script>
//설명 update 


//모달 섫명 폼변경
let ptag = document.querySelector("#epContent");
const updateEpFrm= document.querySelector("#updateEpFrm");

	ptag.addEventListener('click',(e)=>{
	updateEpFrm.classList.remove('removeView');
	e.target.classList.add("removeView");
		
})
//모달 설명 취소 버튼 
document.querySelector("#epCanclebtn").addEventListener('click',(e)=>{
	
	e.preventDefault();
    ptag.classList.remove('removeView');
    updateEpFrm.classList.add('removeView');
})

// 모달 제목 클릭시 변경 
	    var todoContent = document.querySelector("#todoContent");
		var conFrm= document.querySelector("#updateConFrm") ;
		var headerText= document.querySelector("#headerText");
	document.querySelector("#todoContent").addEventListener('click',(e)=>{
		todoContent.classList.add('removeView');
		conFrm.classList.remove('removeView');
		conFrm.style.marginLeft = '10px';
		headerText.classList.add('removeView');
		conFrm.style.width='100%';
	})
	
	document.querySelector("#contentCanclebtn").addEventListener('click',(e)=>{
		todoContent.classList.remove("removeView");
		conFrm.classList.add("removeView");
		e.preventDefault();
	})

const confrm =(e)=>{
	if(confirm('삭제하시겠습니까')){
		e.submit();
	}
	e.preventDefault();
}

</script>


											<!-- 모달 본문 끝 -->
											<button class="close-button" data-close
												aria-label="Close reveal" type="button">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
									</div><!-- 모달끝 -->

<script>
//$('#element').foundation('open');
//$('#element').foundation('close');
const modalOpen = (todoListNo, todoNo) => {
	// 해당 정보 비동기 요청
	console.log(todoListNo, todoNo);
	$('#exampleModal').foundation('open');
	
	
	
			$.ajax({
				url : "${pageContext.request.contextPath}/todo/todoSelectByNo.do?no="+todoNo,
				success(data){
					console.log(data);
					const no = data.querySelector("no");
					const info = data.querySelector("info");
					const content = data.querySelector("content");
					const endDate = data.querySelector("end_date");
					const comments = data.querySelector("todocomments")
					
					console.log(comments);
					
					//todo content info 아이디넣기
					const todoContentinput = document.querySelector("#todoContentinput");
					todoContentinput.value = no.textContent;
					//todo info input  아이디 넣기
					const todoUpdateinput = document.querySelector("#todoUpdateinput");
					todoUpdateinput.value = no.textContent; // 수정된 부분				
					//todo delete input 아이디넣기
					const todoDeleteinput = document.querySelector("#todoDeleteinput");
					todoDeleteinput.value = no.textContent;
					//todo comment no input 아이디 넣기
					const commenttodoinput =  document.querySelector("#comment-todo-input");
					commenttodoinput.value = no.textContent;
					
					
					const todoContent = document.querySelector("#todoContent");
					todoContent.innerHTML='';
					todoContent.innerHTML= content.textContent;
					
					const epContent = document.querySelector("#epContent");
					epContent.innerHTML= '';
					epContent.innerHTML+= `<i class="fa fa-list" aria-hidden="true" style="margin-right: 15px"></i>`;
					epContent.innerHTML+= info.textContent;
					
					 
				},
				error:console.log
			})
};

document.querySelector("#exampleFileUpload").addEventListener('change',(e)=>{

	const f = e.target;
	console.log(f.files);               //배열
	console.log(f.files[0]);           //보통 0번지에 사진이 들어가있다.
	if(f.files[0]){//파일 선택한 경우
		const fr = new FileReader();
		fr.readAsDataURL(f.files[0]);  //비동기처리  - 백그라운드 작업
		fr.onload = (e) => {
			//읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#img-viewer").src = e.target.result; // dataUrl		
			console.log(e.target.result); //파일2진데이터를 인코딩한 결과
			
			const todoNo = document.querySelector("#todoContentinput");
			const formData = new FormData();
			formData.append('file', f.files[0]); // f는 input[type=file] 엘리먼트
			formData.append('todoNo',todoNo.value);
			console.log(formData)
			console.log(todoNo);
			
			const csrfHeader = "${_csrf.headerName}";
		    const csrfToken = "${_csrf.token}";
		    const headers = {};
		    headers[csrfHeader] = csrfToken;
			
		    $.ajax({
				url: "${pageContext.request.contextPath}/todo/todoFileUpload.do",
				method : "POST",
				headers,
				data : formData,
				dataType : "json",
				contentType:false,
				processData:false,
				success(data){
					console.log(data);
					
				},
				error : console.log
				
			})
			
		}
	}else{ //파일 선택 취소한경우
		document.querySelector("#img-viewer").src = "default-image.jpg";
		
	}
})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />