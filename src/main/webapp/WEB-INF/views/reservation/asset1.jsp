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
	<style>
	        .asset-menu{
            display: flex;
            width: 100%;
        }
        .asset-menu p{
            margin-left: 20px;
            font-size: 14px;
            color: #a5a5a5e8;
            font-family: 맑은 고딕;
        }
        .asset-menu p:hover{
            color: gray;
            border-bottom: 1px solid black;;
            cursor: pointer;
        }
        
        .enrollFrm-wrapper{
            margin-top: 100px;
        }

        .asset-btn-wrapper{
            text-align: center;
        }
        .asset-btn-wrapper :first-child{
            border: none;
            color: white;
            background-color: #00b6c2;
            width: 60px;
            height: 37px;
            margin-left: 20px;
            cursor: pointer;
            border-radius: 3px 3px 3px 3px;
            -moz-border-radius: 3px 3px 3px 3px;
            -webkit-border-radius: 3px 3px 3px 3px;
        }
        .asset-btn-wrapper :first-child:hover{
            background-color: #06c2cf;
        }
        .asset-btn-wrapper :last-child{
            border: none;
            color: black;
            background-color: rgba(184, 184, 184, 0.603);
            width: 60px;
            height: 37px;
            margin-left: 20px;
            cursor: pointer;
            border-radius: 3px 3px 3px 3px;
            -moz-border-radius: 3px 3px 3px 3px;
            -webkit-border-radius: 3px 3px 3px 3px;
        }
        .asset-btn-wrapper :last-child:hover{
            background-color: rgb(201 199 199 / 60%);
        }
          /* 테이블*/
        .reservation-table{
        border-collapse: collapse;
        width: 100%;
        
        }


        .reservation-table thead {
        background-color: #f9f9f9;
        }

        .reservation-table th, .reservation-table td {
        padding: 8px;
        text-align: left;
        border-right: none;
        }
        .reservation-table th{
        border-top: solid 1px #c3c0c0;
        border-bottom: solid 1px #c3c0c0;
        font-size: 14px;
        font-family: 맑은 고딕;
        }
        .reservation-table td{
        font-size: 14px;
        color: #a5a5a5e8;
        font-family: 맑은 고딕;

        }
        .reservation-table button:hover {
        background-color: #3e8e41;
        }
        .assetadd-btn{
        border: 1px solid #c3c0c0;
        color: black;
        background-color: white;
        width: 69px;
        height: 33px;
        cursor: pointer;
        margin: 20px;
        font-weight: 200;
        }
        .assetadd-btn:hover{
            border: 1px solid black;
        }
/* 테이블*/
	</style>

				<div class="all-container app-dashboard-body-content off-canvas-content" data-off-canvas-content>
					<!-- 왼쪽 추가 메뉴 -->
					<div class="left-container">
						<div class="container-title"></div>
						<div class="container-btn">
							<h2>예약</h2>
						</div>
						<div class="accordion-box">
							<ul class="container-list">
								<li>
									<p class="title font-medium">기능별 메뉴 <a href="${pageContext.request.contextPath }/reservation/asset1.do">본사1층회의실</a></p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#"></a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">기능별 메뉴2</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
								<li>
									<p class="title font-medium">기능별 메뉴3</p>
									<div class="con">
										<ul class="container-detail font-small">
											<li><a class="container-a" href="#">어어어</a></li>
											<li><a class="container-a" href="#">오오오</a></li>
											<li><a class="container-a" href="#">어어어</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!-- 왼쪽 추가 메뉴 end -->
					
					<div class="home-container">
						<!-- 상단 타이틀 -->
						<div class="top-container">
							<div class="container-title">각자 기능</div>
							<div class="home-topbar topbar-div">
								<div>
									<a href="#" id="home-my-img">
										<img src="${pageContext.request.contextPath}/resources/images/sample.jpg" alt="" class="my-img">
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

			<!-- 탑 메뉴-->
			<div class="asset-top-wrapper">
				<div class="asset-title">
					<h2>본사 1층 회의실</h2>
				</div>

				<div class="asset-menu">
					<p>이용안내</p>
					<p>자산관리</p>
					<p>자산정보관리</p>
					<p>자산이용정보</p>
				</div>
				<hr>
			</div>

			<!-- 서식  폼-->
			<div class="asset-middle-wrapper">

				<div class="enrollFrm-wrapper">
					<p>첫 페이지에 나오는 안내문을 작성할수 있습니다.</p>
					<textarea name="" id="" cols="100%" rows="30"></textarea>
				</div>
			</div>

			<div class="asset-btn-wrapper">
				<button>확인</button>
				<button>취소</button>
			</div>
			<!-- 비동기식 테이블 나오게 -->
			<div class="asset-admin-wrapper">
				<div>
					<h3>자산 관리</h3>
					<button class="assetadd-btn">자산추가</button>
				</div>

				<table class="reservation-table">
					<thead>
						<tr>
							<th>코드</th>
							<th>이름</th>
							<th>설정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>A</td>
							<td>도 회의실 (20)명</td>
							<td>수정 btn</td>
						</tr>
						<tr>
							<td>B</td>
							<td>레 회의실 (20)명</td>
							<td>수정 btn</td>
						</tr>
						<td>C</td>
						<td>미 회의실 (20)명</td>
						<td>수정 btn</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--비동기식 테이블-->




		</div>
					</div>
				</div>

		

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>