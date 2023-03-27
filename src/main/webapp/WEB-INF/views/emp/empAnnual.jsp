<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Emp" name="title"/>
	</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/empAnnual.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	
			<div class="home-container">
                    <!-- 상단 타이틀 -->
                    <div class="top-container">
                        <div class="container-title font-bold">내 연차 내역</div>
                        <div class="home-topbar topbar-div">
                            <div>
                                <a href="#" id="home-my-img">
                                    <img src="images/sample.jpg" alt="" class="my-img">
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
                            const style = modal.style.display;

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
                        <div id="date-box">
                            <h4>2023.03.26</h4>
                        </div>

                        <div id="annual-container">
                            <div id="annual-info-box">
                                <div id="annual-user-box">
                                    <img src="images/sample.jpg" alt="" class="my-img" /> <span> 유사원</span>
                                </div>
                                <div></div>
                                <div>
                                    <p class="font-14">발생연차</p>
                                    <h4 class="color-gray">15</h4>
                                </div>
                                <div>
                                    <p class="font-14">발생월차</p>
                                    <h4 class="color-gray">0</h4>
                                </div>
                                <div>
                                    <p class="font-14">이월 연차</p>
                                    <h4 class="color-gray">0</h4>
                                </div>
                                <div>
                                    <p class="font-14">총연차</p>
                                    <h4 class="main-color">15</h4>
                                </div>
                                <div>
                                    <p class="font-14">사용 연차</p>
                                    <h4 class="main-color">8</h4>
                                </div>
                                <div>
                                    <p class="font-14">잔여 연차</p>
                                    <h4 class="main-color">7</h4>
                                </div>
                            </div>
                        </div>

                        <div id="search-box">
                            <label for="search-year">연차 사용기간 :</label>
                                <select id="search-year" name="search-year">
                                    <option value="1">2023</option>
                                    <option value="2">2022</option>
                                    <option value="3">2021</option>
                                </select>
                        </div>

                        <div id="annual-detail-box">
                           <p>사용내역</p>
                           <div>
                                <table id="annual-detail-table">
                                    <thead>
                                        <tr>
                                            <th width="100">이름</th>
                                            <th width="100">부서명</th>
                                            <th width="100">휴가종류</th>
                                            <th width="200">연차 사용기간</th>
                                            <th width="100">사용연차</th>
                                            <th width="300">내용</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td width="100">유사원</td>
                                            <td width="100">개발</td>
                                            <td width="100">연차</td>
                                            <td width="200">2023-03-21 ~ 2023-03-21</td>
                                            <td width="100">1</td>
                                            <td width="300">개인사정으로 인한 연차사용</td>
                                        </tr>
                                        <tr>
                                            <td width="100">유사원</td>
                                            <td width="100">개발</td>
                                            <td width="100">연차</td>
                                            <td width="200">2023-03-21 ~ 2023-03-21</td>
                                            <td width="100">1</td>
                                            <td width="300">개인사정으로 인한 연차사용</td>
                                        </tr>
                        
                                    </tbody>
                                </table>
                           </div>
                        </div>

                        <div id="annual-detail-box">
                            <p>생성내역</p>
                            <div>
                                <table id="annual-detail-table">
                                    <thead>
                                        <tr>
                                            <th width="100">등록일</th>
                                            <th width="100">사용기간</th>
                                            <th width="100">발생일수</th>
                                            <th width="200">내용</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td width="100">2023-01-01</td>
                                            <td width="100">2023-12-31</td>
                                            <td width="100">15</td>
                                            <td width="200">연차</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                    <!-- 본문 end -->
                </div>
            </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			