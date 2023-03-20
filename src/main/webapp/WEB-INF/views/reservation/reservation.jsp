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
	
<style>
		 .info-wrapper{
	    margin-left: 40px;
	    width: 100%;
	    height: 175px;
	    border:  1px solid #dcdcdc;
	    background-color: #f9f9f9;
	    position: relative;
	  }
	  .info-wrapper p {
	    padding-left: 20px;
	    font-family: "맑은 고딕";
	    font-size: 10pt;
	    line-height: 150%;
	  }
	  .info-timebox{
	    position: absolute;
	    right: 33px;
	    top: 80px;
	    font-family: "맑은 고딕";
	    font-size: 10pt;
	    line-height: 150%;
	  }
	
	  .info-line{
	    color: #dcdcdc ;
	    border-top: 1px solid #eee;
	    margin-top: 35px;
	  }
	  /* 테이블*/
	  .timeline-wrapper{
	    width: 100%;
	    height: 175px;
	    border:  1px solid #dcdcdc;
	    background-color: #f9f9f9;
	  }
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
	}
	
	
	.reservation-table button {
	  background-color: #e8eee9;
	  border: none;
	  color: black;
	  padding: 8px 16px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 12px;
	  margin: 4px 2px;
	  cursor: pointer;
	  border-radius: 4px;
	  
	}
	.reservation-table button:hover {
	  background-color: #3e8e41;
	}
/* 테이블*/
</style>
	<!-- 왼쪽 추가 메뉴 -->
	<div class="left-container">
		<div class="container-title"></div>
		<div class="container-btn">
		<h2>예약</h2>
		</div>
		<div class="accordion-box">
			<ul class="container-list">
				<li>
					<p class="title font-medium">기능별 메뉴1 <a href="${pageContext.request.contextPath }/reservation/asset1.do">본사1층회의실</a></p>
					<div class="con">
						<ul class="container-detail font-small">
							<li><a class="container-a" href="#">본사 1층 도회의실</a></li>
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

			<h2>본사 1층 회의실</h2>
			<!--맨위 설명 박스-->
			<div class="info-wrapper">
				<p>다우기술 죽전 본사 1층에 위치한 회의실입니다.</p>
				<p>예약 후 이용바랍니다.</p>
				<div class="info-line"></div>
			</div>
			<div class="info-timebox">2020-11-18-16:20</div>
			<!--타임라인 박스-->
			<div class="timeline-wrapper">
				<h2>타임라인 박스!!!</h2>
			</div>

			<!--자산별 상세정보 박스-->
			<div class="reservation-wrapper">
				<div>
					<h3>자산별 상세 정보</h3>
				</div>
				<table class="reservation-table">
					<thead>
						<tr>
							<th>회의실</th>
							<th>예약</th>
							<th>설정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>도 회의실(20명)</td>
							<td><button>예약</button></td>
							<td><button>설정</button></td>
						</tr>
						<tr>
							<td>미 회의실(12명)</td>
							<td><button>예약</button></td>
							<td><button>설정</button></td>
						</tr>
						<tr>
							<td>레 회의실(8명)</td>
							<td><button>예약</button></td>
							<td><button>설정</button></td>
						</tr>
					</tbody>
				</table>


			</div>



		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>