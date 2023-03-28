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

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/todo/todo.css" />
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

					<ul id ="bookMarkBody"> 
						<!-- 여기서부터 즐겨찾기  -->
					<c:forEach items ="${bookMarkTodoBoards }" var="bookMarkTodoBoard">
					<li class="todo-li"  onclick="enterTodo('${bookMarkTodoBoard.no}',event);">
						<div class="todo-top">
								<span>${bookMarkTodoBoard.title }</span> <span>  
							
							</div>
							<div class="todo-bottom">
								<img src="/김현동/joonpark.jpg" alt="" style="width: 32px;">
							</div>
						</li>
						<li class="test">
							<i class="fa fa-star-o bookMark" aria-hidden="true" onclick ="bookMarkOff('${bookMarkTodoBoard.no}',event);"></i></span>
						</li>
							<form:form id="offForm" action="${pageContext.request.contextPath}/todo/bookMarkOff.do" method="POST">
  								<input type="hidden" name="todoBoardNo" >
							</form:form>  
					</c:forEach>


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
							<form:form id="myForm" action="${pageContext.request.contextPath}/todo/bookMarkOn.do" method="POST">
									<input type="hidden" name ="todoBoardNo1"  />
							</form:form>
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
function bookMarkOn(todoBoardNo, e) {
  	 		 e.preventDefault();
  	 	
  	 	 document.querySelector('input[name="todoBoardNo1"]').value = todoBoardNo;
   		 document.querySelector('#myForm').submit();
  }
function bookMarkOff(todoBoardNo, e) {
  	 		 e.preventDefault();
  	 	
  	 	 document.querySelector('input[name="todoBoardNo"]').value = todoBoardNo;
   		 document.querySelector('#offForm').submit();
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