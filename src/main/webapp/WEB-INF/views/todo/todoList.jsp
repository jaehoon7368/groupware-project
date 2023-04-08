<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="todoList" name="title" />
</jsp:include>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/todo/todoList.css">
<div class="all-container app-dashboard-body-content off-canvas-content"
	data-off-canvas-content>


	<div class="home-container">
		<!-- 상단 타이틀 -->
		<div class="top-container">
			<div class="container-title"></div>
			<div class="home-topbar topbar-div">
				<div>
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

						</script>
		<!-- 상단 타이틀 end -->
		<!-- 본문 -->
		<div class="div-padding">
<style>
	.groupEmp ul{
        display: flex;
        }
     .groupEmp li {
         list-style: none;
         margin-left: 30px;
         border-radius: 50%;
        }
			

</style>
			<div class="content-top">
				<h2 class="board-menu" id="boardMenu">Board  ${todoBoard.title}</h2>
				<!-- 게시판 메뉴 모달 -->
				<div class="groupEmp">
					<ul>
						<c:forEach items="${attachments}" var ="attachment" varStatus="vs">
							<li><img src="${pageContext.request.contextPath }/resources/upload/emp/${attachment.renameFilename }" alt="" class="my-img"></li>
						</c:forEach>
					</ul>
				</div>
				
				<div class="removeView board-menu-modal" id="boardMenuModal">
					<div class="modalTitle">Board</div>
					<div class="modalList" id="todoHome">Todo홈</div>
					<a href="javascript:groupModalOpen('${todoBoard.no }')" data-open="boardModal"><div class="modalList">사원공유설정</div></a>
					<div class="modalList" id="boardDelete"  >보드 삭제</div>
					
					<form:form action="${pageContext.request.contextPath }/todo/todoBoardDelete.do" method="POST" id="todoBoardDeleteFrm">
						<input type="hidden"  name="no" value="${todoBoard.no }"/>
					</form:form>
 				</div>
 				
 				<style>
 				.modalList{
 					cursor: pointer;
 				}
 				
 				</style>
 				
 				<script>
 				
 				document.querySelector("#boardDelete").addEventListener('click',(e)=>{
 					const boardNo = e.target.dataset.no;
 					console.log(boardNo);
 					const frm = document.querySelector("#todoBoardDeleteFrm");
 					confrm(frm);
 					//frm.submit();
 				})
 				
 				</script>
 		
 	<!-- 사원공유 모달  -->
 										<div class="report-no-modal reveal" id="exampleModal1" data-reveal>
										<h5>선택</h5>
										<div>
										</div>
										<div class="div-emp-group">
											<div class="accordion-box">
												<ul class="accordion" ata-accordion data-multi-expand="true" >
													<c:forEach items="${sessionScope.deptList}" var="dept">
														<li>
															<p class="title font-medium">${dept.deptTitle}</p>
															<div class="">
																<ul class="container-detail font-small">
																	<c:forEach items="${emps}" var="emp">
																		<c:if test="${emp.deptCode eq dept.deptCode and emp.empId ne loginMember.empId }">
																			 <li class="li-emp" data-id="${emp.empId}" data-dept="${emp.deptCode}" data-job="${emp.jobTitle}" data-name="${emp.name}">${emp.name } ${emp.jobTitle }</li>
																		</c:if>
																	</c:forEach>
																</ul>
															</div>
														</li>
													</c:forEach>
												</ul>
											</div>
										</div>
										<div class="div-modal-choice"></div>
										<div class="font-small report-no-modal-btn">
											<button class="add-btn" data-close aria-label="Close reveal" type="button" id="empAddbtn">추가</button>
										</div>
										<form:form action ="${pageContext.request.contextPath }/todo/groupAddEmp.do" method ="POST" id="groupAddFrm">
											<input type="hidden" name ="todoBoardNo" value="${todoBoard.no }" />
										</form:form>
										
										<button class="btn-close close-button" data-close aria-label="Close reveal" type="button">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
 	<!-- 사원공유모달끝 -->
<style>
.div-modal-choice-emp, .div-modal-choice-dept {
	display: inline-block;
	margin: 5px;
	font-size: small;
	padding: 5px;
	border-radius: 50px;
	border: solid 1px lightgray;
}

.div-modal-choice-emp:hover, .div-modal-choice-dept:hover {
	cursor: pointer;
}

.div-emp-tag {
	display: inline-block;
	font-size: small;
	padding: 5px;
	border-radius: 50px;
	border: solid 1px lightgray;
	color: gray;
}
.menu a, .menu .button {
    line-height: 1;
    text-decoration: none;
    display: block;
    padding: 1.7rem 1rem;
}
</style>
 				
				<script>
	document.querySelector("#empAddbtn").addEventListener('click',(event)=>{
		let  empIds = [];
		
		document.querySelectorAll(".div-modal-choice-emp").forEach((div)=>{
			empIds.push(div.dataset.id);
			console.log(div.dataset.id);
		})
		
		if(empIds.length<=0){
			alert('사원을 추가해주세요');
			return; 
		}
		const groupAddFrm = document.querySelector("#groupAddFrm");
		
		for(let i = 0 ; i <empIds.length ; i++){
			const input = document.createElement('input');
			input.name = 'empId';
			input.value = empIds[i]
			input.type = 'hidden';
			groupAddFrm.append(input);
		}
		
		groupAddFrm.submit();
		
		
	})
				
	//사원공유 모달 오픈
	const groupModalOpen =(boardNo)=>{
		console.log(boardNo);
		$('#exampleModal1').foundation('open');
	}
	
	const groupEmp = [];
	/*부서원 선택시 아래에 띄우기*/
	document.querySelectorAll(".li-emp").forEach((li)=>{
	  li.addEventListener('click',(e)=>{
	    const empId = e.target.dataset.id;
	    const deptCode = e.target.dataset.dept;
	    const jobTitle = e.target.dataset.job;
	    const name = e.target.dataset.name;
	    
	   const existingEmp = document.querySelector(`.div-modal-choice-emp[data-id='\${empId}']`);
	    if (existingEmp) {
	      return;
	    }
	    
			const div = document.querySelector('.div-modal-choice');
				div.innerHTML += `
					<div class='div-modal-choice-emp' data-id='\${empId}' data-dept='\${deptCode}' data-name='\${name}' onclick='deleteTag(this);'>
						<span>\${name} \${jobTitle}</span>
					</div>
				`;
	  })
	})
	
	/* 선택된 사람 클릭시 삭제*/
		const deleteTag = (elem) => {
		  // remove corresponding div element from DOM
		  elem.remove();
		
		  // remove person's data from groupEmp array
		  const empId = elem.dataset.id;
		  const empIndex = groupEmp.findIndex((emp) => emp.empId === empId);
		  if (empIndex > -1) {
		    groupEmp.splice(empIndex, 1);
		  }
		};
	
				
				
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
	//바깥누르면 취소  and  첨부파일 없애기
	document.addEventListener('click', (event) => {
    	if (!boardMenuModal.contains(event.target) && event.target !== boardMenu) {
        	boardMenuModal.classList.add('removeView');
        	
   	 }
    	document.querySelector("#img-viewer").src = "";
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
									<button class="comment-btn" style="display :none;" id="todoListDeleteBtn${vs.index}" onclick="confrm(event);">삭제</button>
								</form:form>
								<div class="row">
<script>
	$('#listTitle${vs.index}').hover(
		  function() {
		        $('#todoListDeleteBtn${vs.index}').css("display", "block");
		    },
		    function() {
		        setTimeout(function() {
		            $('#todoListDeleteBtn${vs.index}').css("display", "none");
		        }, 1000); // 1초 후에 숨김 처리
		    }
	);								
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
													<span class="todocontent-span">${todo.content } </span>
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
    transform: translate(0, -20px);
}
.comment-name{
	width : 68px;
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
															<input type="text"   name="content"  id="todoContentText"/>
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
															<textarea name="info" class="todoInfo" id="summernote" cols="30" rows="5" style="margin-top: 21px;"  ></textarea>
															<button class="comment-btn">수정</button>
															<button class="comment-btn" id="epCanclebtn">취소</button>
														</form:form>
													</div> <!--  첨부파일 출력  -->
														<div style="display: flex;  justify-content: center;">
															<img src="${pagContext.request.contextPath }" alt=""  id="image-print"/>
														</div>
														

													<hr>
													<ul>

														<h3>
															<i class="fa fa-paperclip fa-1x" aria-hidden="true"></i>파일첨부
														</h3>
														
														<div class="attach-div">
														<div>
															<i class="fa fa-paperclip" aria-hidden="true"></i>
															<label for="exampleFileUpload" class="button">파일첨부를하려면 선택하세요</label>
															<input type="file" id="exampleFileUpload" class="show-for-sr" name="upFile">
														</div>	
														<div id="img-viewer-container" style="display: flex; justify-content: center; height:100%;">
															<form:form action="${pageContext.request.contextPath}/todo/todoAttachDelete.do">
															<input type="hidden" id="attachDelet-input" name ="renameFilename"/>
															<input type="hidden" name = "todoBoardNo" value="${todoBoard.no }" />
															<button id="delteattachment" onclick="confrm(event)" class="removeView  button  tiny secondary"  style="
							    								width: 69px;" >삭제</button>
															</form:form>
															<img id="img-viewer" width="15%">
															<div class="div-report-write-file-name"></div>
														</div>
														</div>
													</ul>
													<div>
														댓글
														<hr>
													</div>
													<div class="comment-div"> <!--  댓글입력창 -->
														<div style="width: 50px">
   																 <img src="${pageContext.request.contextPath }/resources/upload/emp/${empty emp.attachment.renameFilename ? 'default.png' : emp.attachment.renameFilename }" alt="" class="my-img">
														</div>
														<div class="comment-name">${emp.name }</div>
														<div style="width: 90%"> 
															<form:form action="${pageContext.request.contextPath }/todo/commentEnroll.do">
																<input type="text" class="comment-input" name="content" id="comment-text-input">
																<input type="hidden" class="comment-input" name="todoBoardNo" value="${todoBoard.no }">
																<input type="hidden" id="comment-todo-input" name="todoNo"/>
														</div>
														<button class="comment-btn"id="comment-enroll" style="margin-top: 30px;">등록</button>
															</form:form>
													</div><!-- 댓글 나오게  -->
													<div  id="todoComment">
													</div>
		
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



<c:if test="\${empName.textContent} != null">
</c:if>
				

											<!-- 모달 본문 끝 -->
											<button class="close-button" data-close
												aria-label="Close reveal" type="button">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
									</div><!-- 모달끝 -->
									<style>
									
									</style>

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
					
					
					
					
					const no = data.no;
					const info = data.info;
					const content = data.content;
					const endDate = data.endDate;
					const comments = data.todocomments;
					const attachments = data.attachments					
					let imageName = '';
					
					if(attachments != null  && attachments.length > 0){
					const renameFilename= attachments[0].renameFilename;
					if(renameFilename != null && renameFilename != ""){
					imageName = renameFilename;
					}
					 const btn = document.querySelector("#delteattachment");
					 btn.classList.add('removeView');
					
						if(renameFilename != null && renameFilename != ""){
							// delete 버튼에 no 값 넣기 
							const attachDeletinput= document.querySelector("#attachDelet-input");
							attachDeletinput.value = renameFilename;
						    btn.classList.remove('removeView');
							}
					
					}
					console.log(imageName)
					//todo content info 아이디넣기
					const todoContentinput = document.querySelector("#todoContentinput");
					todoContentinput.value = no;
					//todo info input  아이디 넣기
					const todoUpdateinput = document.querySelector("#todoUpdateinput");
					todoUpdateinput.value = no; // 수정된 부분				
					//todo delete input 아이디넣기
					const todoDeleteinput = document.querySelector("#todoDeleteinput");
					todoDeleteinput.value = no;
					//todo comment no input 아이디 넣기
					const commenttodoinput =  document.querySelector("#comment-todo-input");
					commenttodoinput.value = no;
	
					//이미지 넣기
					const imagePrint = document.querySelector("#image-print")					
					imagePrint.src = '${pageContext.request.contextPath}/resources/upload/todo/'+imageName;
					
					const todoContent = document.querySelector("#todoContent");
					todoContent.innerHTML='';
					todoContent.innerHTML= content;
					const summernote = document.querySelector("#summernote");
					summernote.value = '';
					summernote.value = content;
					
					const todoContentText = document.querySelector("#todoContentText");
					todoContentText.value ='';
					todoContentText.value = content;
					
					const todoInfo = document.querySelector(".todoInfo");
					todoInfo.value = '';
					todoInfo.value = info;
					
					const epContent = document.querySelector("#epContent");
					epContent.innerHTML= '';
					epContent.innerHTML+= `<i class="fa fa-list" aria-hidden="true" style="margin-right: 15px"></i>`;
					epContent.innerHTML+= info;
					
					// 등록된 댓글 뿌리기
					console.log(comments);
					const todoComment = document.querySelector("#todoComment");
					todoComment.innerHTML= "";
					
					if(comments != null && comments != ''){
						comments.forEach((comment,index)=>{
					        
							let no = comment.no;
							let content = comment.content;
							let empId = comment.empId;
							let todoNo = comment.todoNo;
							let empfilename = comment.empFilename;
							let empName = comment.empName;
					        
					        if(empfilename == '' || empfilename == null) {
					            empfilename = 'default.png';
					        }
					                     
					        todoComment.innerHTML += `
					            <div class="comment-div comment-wrapper/${index}">  
					                <div style="width: 50px">
					                    <img src='${pageContext.request.contextPath}/resources/upload/emp/\${empfilename}' alt="" class="my-img";>
					                </div>
					                <div class="comment-name">\${empName}</div>
					                <div style="width: 90%">
					                    <input type="text" class="comment-input" readonly value="\${content}">
					                </div>
					        `;
					        
					        let confrmEmpId = '${sessionScope.loginMember.empId}';
					        
					        if (empId == confrmEmpId){
					            todoComment.innerHTML += `
					                <button class="comment-btn modal-btn" onclick="commentDelete('${no}', event)" id="comment-delete">삭제</button>
					            `;
												
												}
												
							todoComment.innerHTML+=`</div> <!--  댓글  -->`
							
						})
						
					}
					
					

					
					
				},
				error:console.log
			})
};
//비동기 코멘트  댓글 삭제 
const commentDelete =(no)=>{
	console.log(no)
	const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
	
	
	if(confirm('삭제하시겠습니까?')){
		$.ajax({
			url: "${pageContext.request.contextPath}/todo/todoCommentDelete.do",
			method : "POST",
			headers,
			data : {no : no},
			success(data){
				console.log(data)
				
				location.reload();
			},
			error : console.log
		})
	
	}
	
}


document.querySelector("#exampleFileUpload").addEventListener('change',(e)=>{

	const f = e.target;
	if(f.files[0]){//파일 선택한 경우
		const fr = new FileReader();
		fr.readAsDataURL(f.files[0]);  //비동기처리  - 백그라운드 작업
		fr.onload = (e) => {
			//읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#img-viewer").src = '/resources/images/clip.png'; // dataUrl		
			console.log(e.target.result); //파일2진데이터를 인코딩한 결과
			
			const div = document.querySelector('.div-report-write-file-name');
			
			const todoNo = document.querySelector("#todoContentinput");
			console.log(e.target);
			
			if(f){
					div.innerHTML ='파일선택 완료 ';
			}
			
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
		document.querySelector("#img-viewer").src = "";
		
	}
})
//유효성검사
	document.querySelector("#comment-enroll").addEventListener('click',(e)=>{
		const textinput = document.querySelector("#comment-text-input");
		if(/^\s+/.test(textinput.value) || !textinput .value){	
			e.preventDefault();
			alert('한글자 이상 입력해주세요');
		}
	});
	
/* 썸머노트 textarea js */
$('#summernote').summernote({
	placeholder: 'Hello stand alone ui',
	tabsize: 2,
	height: 350,
	width: '100%',
	toolbar: [
		['style', ['style']],
		['font', ['bold', 'underline', 'clear']],
		['color', ['color']],
		['para', ['ul', 'ol', 'paragraph']],
		['table', ['table']],
		['insert', ['link', 'picture', 'video']],
		['view', ['fullscreen', 'codeview', 'help']]
	]
});
	
	

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />