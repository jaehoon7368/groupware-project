<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Mail" name="title"/>
	</jsp:include>

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
.wrap_board ul {
	list-style: none;
	list-style: none;
	display: flex;
	align-content: center;
	flex-wrap: wrap;
}

.todo-li {
	min-width: 300px;
	width: 20%;
	min-height: 96px;
	height: 100%;
	border: 1px solid rgb(227, 227, 227);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	padding: 6px;
	margin-right: 15px;
	margin-top: 20px;
	transition-duration: .3s;
	font-size: 14px;
	background-color: #e5e5e5;
}

.board-info {
	color: rgb(104, 104, 104);
}

.board-list {
	background-color: white;
	padding-left: 7px;
	margin-top: 5px;
	display: flex;
	flex-direction: column;
}

.top-list {
	height: 50px;
	display: flex;
	align-items: center;
}

.new-board-list {
	margin-top: 20px;
	margin-bottom: 10px;
	height: 50px;
	border: 1px dashed gray;
	display: flex;
	align-items: center;
	padding-left: 10px;
}
.todo-div ul{
	cursor:auto;
}

.wrap-todo-detail{
    margin: 20px;
}
.todo-header{
    display: flex;
    justify-content: flex-start;
    width :90%;
}
.explain-div{
    margin-left: 50px;
    height: 20%;
    min-height: 100px;
}
.explain-div p:hover{
	background-color: #D6D9E0;
	cursor: pointer;
}
.todo-content ul{
    margin-bottom: 50px;
}
.attach-div{
    height: 100px;
    width: 100%;
    border: 2px dashed rgba(128, 128, 128, 0.336);
    color: gray;
    display: flex;
    align-items: center;
    justify-content: center;
}
.comment-div{
    display: flex;
    align-items: center;
}
.comment-div input{
    margin-left :30px;
    width: 90%;
    height: 30px;
    border: 1px solid #e3dede;
}
.todo-title{
    padding-left: 10px;
    color: gray;
}
.comment-btn{	
	border: solid gray 1px;
	padding: 0px;
	border-radius: 0px;
	width: 59px;
	height: 31px;
	margin-top: 5px;
	background-color: white;
	color: black;
	transform: translate(0, -11px);
	
}
.removeView{
	display : none;
}
.addView{
	display : block;
}
.enrollFrm{
	height : 130px;
	
}
#todoContent{
	cursor: pointer;
	margin-left : 10px;
}
/*게시판 모달*/
.board-menu {
	position : relative;
	cursor: pointer;
	
}
.board-menu-modal{
    position: absolute;
    transform: translate(0,-10px);
    border: 1px solid #dddddd;
    width: 241px;
    height: 218px; 
    background-color: white;
    z-index: 2;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
    transition: all 0.3s cubic-bezier(.25,.8,.25,1);
}
.board-menu-modal:hover {
  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
.board-menu-modal div {
    font-size: 20px;
    line-height: 2.7;
    text-rendering: optimizeLegibility;
    margin-bottom: 0px;
    
}
.modalList:hover {
	color : white;
	background-color: #00b6c2;
}
.modalTitle{
	text-align: center;
	color: #c3c3c3;;
}
/*게시판 모달*/


</style>
			<div class="content-top">
				<h2 class="board-menu" id="boardMenu">Board .${todoBoard.title}</h2>
				<!-- 게시판 메뉴 모달 -->
				<div class="removeView board-menu-modal" id="boardMenuModal" >
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
						<li class="todo-li" id = "listContainer">
							<div class="top-list" id="listTitle${vs.index }" onclick="changeView${vs.index}(event);">${todoList.title}</div> <!-- 제목 -->
									<form action="" id="updateFrm${vs.index}" class="removeView"> 
										<input type="text"  placeholder="제목" value=""/>
												<button class="comment-btn"> 저장 </button>
												<button class="comment-btn" id="titleCanclebtn${vs.index}"> 취소 </button>
												<button class="comment-btn"> 삭제 </button>
									</form>
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
}) 

</script>				
					
									
									<!-- 모달시작 -->
								<div class="columns">
									<p>
										<a data-open="exampleModal1">					
										<div class="board-list">
										<span>할일 리스트 제목 </span>
										<p>Moreimage</p>
										</div>
									</a>
									</p>

									<div class="large reveal" id="exampleModal1" data-reveal>
										<!-- 모달 본문 -->

										<div class="wrap-todo-detail">
											<div class="todo-header" >
												<div class="todo-header" >
												<i class="fa fa-folder fa-2x" style="color:gray" aria-hidden="true"></i>
													<h5 id ="todoContent">할일리스트 내용 content 컬럼</h5>
													<form action="" id="updateConFrm" class="removeView">
													<input type="text" class="" />
													<button class="comment-btn"> 저장 </button>
													<button class="comment-btn" id="contentCanclebtn"> 취소 </button>
													<button class="comment-btn"> 삭제 </button>
													</form>
													<p class="todo-title" id="headerText">in 할일 제목</p>
												</div>
												<div><!-- 공간용 --></div>
											</div>

											<div class="todo-content">
												<div class="explain-div">
											  <!-- 설명 내용 데이터 -->
												<p id="epContent"><i class="fa fa-list" aria-hidden="true" style="margin-right :15px"></i>설명</p>
											  <!-- 클릭하면 input 내용 보이게   -->												
												<form action="" id="updateEpFrm" class="removeView">
												<textarea name="" id="" cols="30" rows="5" style="margin-top: 21px;"></textarea>
												<button class="comment-btn"> 저장 </button>
												<button class="comment-btn" id="epCanclebtn"> 취소 </button>
												<button class="comment-btn"> 삭제 </button>
												</form>
												</div>  
												<hr>
												<ul>
													<h3><i class="fa fa-paperclip fa-1x" aria-hidden="true"><p> </p></i>파일첨부</h3>
													<div class="attach-div">
													<i class="fa fa-paperclip" aria-hidden="true"></i>
													이곳에 파일을 드래그 하세요. 또는 파일선택
													</div>
												</ul>
												<div>
													댓글
													<hr>
												</div>
												<div class="comment-div">
													<div style="width: 50px">
														<img src="/김현동/joonpark.jpg" alt="" style="width: 100%;">
													</div>
													<div style="width: 90%">
														<input type="text" class="comment-input">
													</div>
														<button class="comment-btn">확인</button>
												</div>

												<div class="comment-div">
													<div style="width: 50px">
														<img src="/김현동/joonpark.jpg" alt="" style="width: 100%;">
													</div>
													<div style="width: 90%">
														<input type="text" class="comment-input" readonly>
													</div>
														<button style="visibility: hidden;"class="comment-btn">확인</button> 
												</div>
											</div>
										</div>
										<!-- detail end-->


										<!-- 모달 본문 끝 -->
										<button class="close-button" data-close
											aria-label="Close reveal" type="button">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
								</div>
								<!-- 모달끝 -->
							</div>
							
							<div class="new-board-list" onclick="changeView2${vs.index}(event);" id="newboardDiv${vs.index }">
								<i class="fa fa-plus" aria-hidden="true"
									style="font-size: 2em; color: gray;"></i>
							</div>
							<!--  -->
							<div id="enrollFrm${vs.index }" class="removeView">
									<form action="" class="">
										<textarea name="" id="" cols="30" rows="5" style="margin-top: 21px;"></textarea>
												<button class="comment-btn"> 저장 </button>
												<button class="comment-btn" id="titleContentCanclebtn${vs.index }"> 취소 </button>
												<button class="comment-btn"> 삭제 </button>
									</form>
							</div>
						</li>
<script>
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
						</c:forEach> <!--  container 끝 -->
						<li class="todo-li">
							<div class="new-board-list" onclick="" id="todoListEnrolldiv">
								<i class="fa fa-plus" aria-hidden="true"
									style="font-size: 2em; color: gray;"></i>
							</div>
							<div id="todoListEnrollFrm" class="removeView">
											    <input type="text"  id="todoListTitle"/>
												<button class="comment-btn" id="todoListEnrollbtn"> 저장 </button>
												<button class="comment-btn" id="todoListEnrollCancle"> 취소 </button>
												<button class="comment-btn"> 삭제 </button>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>

	</div>
</div>



	<script>
	
	
	//todolist 등록 하면  비동기로 화면 뿌리기
	const queryString= window.location.search;
	const urlParams = new URLSearchParams(queryString);
	const pageTodoBoardNo = urlParams.get('no');
	
	document.querySelector("#todoListEnrollbtn").addEventListener('click',(e)=>{
		const todoListTitle = document.querySelector("#todoListTitle");
		console.log(todoListTitle.value);
		
		const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
	
		$.ajax({
			url : '${pageContext.request.contextPath}/todo/todoListEnroll.do',
			method :"POST",
			headers,
			data: { 
				todoListTitle: todoListTitle.value,
				pageTodoBoardNo : pageTodoBoardNo	
			},		
			success(data){
				console.log(data)
				const container = document.querySelector("#listContainer");
				renderTodoList(container);
				
				//등록 후 다시 원래대로 돌아감
				const todoListEnrolldiv =document.querySelector("#todoListEnrolldiv");
				todoListEnrollFrm.classList.add('removeView');
				console.log(todoListEnrolldiv)
				todoListEnrolldiv.classList.remove('removeView');
				
			},
			error : console.log
		}) //ajax 끝
	})
	
	//리스트 등록후 화면 렌디렁
	renderTodoList=(selector,data)=>{
		let html = ``
		
	}
	//윈도우가 로드되면 렌더링
	window.onload=()=>{
		renderTodoList();
	}
	
	
	
	
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
	
	

	
	//모달 섫명 폼변경
	const ptag = document.querySelector("#epContent");
	const updateEpFrm = document.querySelector("#updateEpFrm");
		document.querySelector("#epContent").addEventListener('click',(e)=>{
		updateEpFrm.classList.remove('removeView');
		e.target.classList.add("removeView");
			
	})
	//모달 설명 취소 버튼 
	document.querySelector("#epCanclebtn").addEventListener('click',(e)=>{
		const updateEpFrm = document.querySelector("#updateEpFrm")
		e.preventDefault();
	    ptag.classList.remove('removeView');
	    updateEpFrm.classList.add('removeView');
	})
	
	// 타이틀 제목 클릭시 변경 
	var todoContent = document.querySelector("#todoContent");
			var conFrm = document.querySelector("#updateConFrm") ;
			var headerText = document.querySelector("#headerText");
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
		
		
	
	
	
	
	</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>