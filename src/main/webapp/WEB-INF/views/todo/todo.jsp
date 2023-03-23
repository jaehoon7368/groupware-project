<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Todo" name="title" />
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
.wrap_board {
	
}

.wrap_board ul {
	list-style: none;
	list-style: none;
	display: flex;
	align-content: center;
	flex-wrap: wrap;
}

.todo-li {
	position :relative;
	min-width: 200px;
	width: 20%;
	height: 96px;
	border: 1px solid rgb(227, 227, 227);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	padding: 14px;
	margin-right: 30px;
	margin-top: 20px;
	cursor: pointer;
	border-radius: 12px 12px 12px 12px;
	-moz-border-radius: 12px 12px 12px 12px;
	-webkit-border-radius: 12px 12px 12px 12px;
	transition-duration: .3s;
	font-size: 14px;
}

.todo-li:hover {
	box-shadow: 0 5px 5px -5px #333;
	transform: translate(0, -2px);;
}

.todo-top {
	display: flex;
	justify-content: space-between;
}
.todo-top p{
line-height: 0.6;
}

.todo-top a {
	text-decoration: none;
	color: black;
}

.todo-bottom {
	display: flex;
}

.board-info {
	color: rgb(104, 104, 104);
}

.newboard {
	display: flex;
	align-items: center;
	justify-content: center;
}

.todo-input {
	height: 20px;
	margin: 0px;
}

.todo-btn {
	border: solid gray 1px;
	padding: 0px;
	border-radius: 0px;
	width: 59px;
	height: 20px;
	margin-top: 5px;
	background-color: white;
	color: black;
}

.todo-btn:hover {
	background-color: #00b6c2;
}
.removeView{
	display : none;
}
/* 게시판 보드 모달 */
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
.removeView{
	display:none;
}

/* 게시판 보드 모달 */
/* 북마크  위치조정 */
.test{
	position:relative;
}
.bookMark{
    position: absolute;
    right: 36px;
    top: 32px;
}
	
 </style> 
			<div class="content-top">
				<h2 class="board-menu" id="boardMenu">Board</h2>
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

	boardMenu.addEventListener('click',()=>{
   		 boardMenuModal.classList.remove('removeView');
	})

	document.addEventListener('click', (event) => {
    	if (!boardMenuModal.contains(event.target) && event.target !== boardMenu) {
        	boardMenuModal.classList.add('removeView');
   	 }
	});
</script>
				<!-- 게시판 메뉴 모달끝 -->
			</div>
			<div class="wrap_board">

				<div class="wrap_todo_board ui-favorite-board">
					<h5 class="board-info">즐겨찾는보드</h5>

					<ul> 
						<!-- 여기서부터 즐겨찾기  -->
						<li class="todo-li">
							<div class="todo-top">
								<span>1팀_업무지시방</span> <span> <a href=""><i
										class="fa fa-link" aria-hidden="true"></i></a> <a href=""><i
										class="fa fa-star-o" aria-hidden="true"></i></a></span>
							</div>
							<div class="todo-bottom">
								<img src="/김현동/joonpark.jpg" alt="" style="width: 32px;">
							</div>
						</li>


					</ul>
				</div>
				<!-- favorite end -->



				<hr>

				<div class="wrop_todo_board ui-myboard">
					<h5 class="board-info">내보드</h5>
					<ul>
						<c:forEach items="${todoBoards}" var="todoBoard" varStatus="vs">
						
						<li class="todo-li"  onclick="enterTodo('${todoBoard.no}',event);">
							<div class="todo-top">
								<span>${todoBoard.title }</span> <span>  
							
							</div>
							<div class="todo-bottom">
								<img src="/김현동/joonpark.jpg" alt="" style="width: 32px;">
							</div>
						</li>
						<li class="test">
							<i class="fa fa-star-o bookMark" aria-hidden="true" onclick ="bookMarkOn('${todoBoard.no}',event);"></i></span>
						</li>
						</c:forEach>
						
						<!-- 등록 폼 -->
						<li class="todo-li newboard" onclick ="" id="beforeNewTodo">
							<i class="fa fa-plus" style="font-size: 2em;" aria-hidden="true" ></i>
						<div class="removeView" id="afterNewTodo">
							<div class="todo-top">
									<p>이름</p>
							</div>
										<form:form action="${pageContext.request.contextPath}/todo/todoBoardEnroll.do" method="POST">
									<div>
											<input type="text" class="todo-input" name="title" placeholder="새 보드 만들기">
									</div>
									<div class="todo-bottom">
										<button class="todo-btn">확인</button>
										<button class="todo-btn" id="enrollCanclebtn" >취소</button>
									</div>
										</form:form>
						</div>
						</li>
						
					</ul>
				</div>
				<!-- myboard end-->
	
	<style>
	
	</style>
			</div>

		</div>
	</div>
</div>

<script>
	const bookMarkOn=(todoBoardNo,e)=>{
		const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
		console.log(todoBoardNo)
		
		$.ajax({
			url: "${pageContext.request.contextPath}/todo/bookMarkOn.do",
			method : "POST",
			headers,
			data :{
				todoBoardNo : todoBoardNo
			},
			success(data){
				console.log(data);
				
				
				
				
				
				
				
				
				
			},
			error:console.log
			
		}) /* ajax 끝*/
		
	}
	const enterTodo =(no,e)=>{
		e.stopPropagation(); 
		location.href='${pageContext.request.contextPath}/todo/todoList.do?no='+no; 
		
	}

	// +버튼 클릭  enroll 로 전환 
		const beforeBox = document.querySelector("#beforeNewTodo i");
		const afterNewTodo = document.querySelector("#afterNewTodo");
	document.querySelector("#beforeNewTodo").addEventListener('click',(e)=>{
		beforeBox.classList.add('removeView');
		afterNewTodo.classList.remove('removeView');
		e.stopPropagation();
	})
	//취소버튼 클릭 + 로 전환
	document.querySelector("#enrollCanclebtn").addEventListener('click',(e)=>{
		e.preventDefault();
		beforeBox.classList.remove('removeView');
		afterNewTodo.classList.add('removeView');
		e.stopPropagation();
	})
    
  

  
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>