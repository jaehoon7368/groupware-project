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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/emp/emp.css">
 	<jsp:include page="/WEB-INF/views/emp/empLeftBar.jsp" />
	
	
	
                <div class="home-container">
                    <!-- 상단 타이틀 -->
                    <div class="top-container">
                        <div class="container-title font-bold">근태현황</div>
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
                            <h4><span><i class="fa-solid fa-chevron-left"></i> </span>2023.03<span> <i class="fa-solid fa-chevron-right"></i></span></h4>
                        </div>

                        <div id="work-week-container">
                            <div id="work-week-time">
                                <div>
                                    <p class="font-14">이번주 누적</p>
                                    <h4 class="main-color">13h 4m 26s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 초과</p>
                                    <h4 class="main-color">2h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 잔여</p>
                                    <h4 class="main-color">26h 55m 34s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번달 누적</p>
                                    <h4 class="color-gray">29h 20m 8s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번달 연장</p>
                                    <h4 class="color-gray">2h 0m 0s</h4>
                                </div>
                            </div>
                        </div>

                        <div>
                            <table class="table-expand">
                                <tbody>
                                    <tr class="table-expand-row" data-open-details>
                                        <td class="border-bottom font-18" width="400">1주차 <span class="expand-icon"></span></td>
                                        <td class="total-time-info">누적 근무시간 5h 35m 23s(초과 근무시간 0h 0m 0s)</td>
                                    </tr>
                            
                                    <tr class="table-expand-row-content">
                                        <td colspan="6" class="table-expand-row-nested">
                                            <table id="date-table">
                                                <thead>
                                                    <tr>
                                                        <th width="50">일자</th>
                                                        <th width="100">업무시작</th>
                                                        <th width="100">업무종료</th>
                                                        <th width="100">총근무시간</th>
                                                        <th width="200">근무시간 상세</th>
                                                        <th width="100">승인요청내역</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>27 월</td>
                                                        <td>09:40:52</td>
                                                        <td>18:35:23</td>
                                                        <td class="font-bold">5h 34m 23s</td>
                                                        <td>기본 5h 34m 23s / 연장 0h 0m 0s</td>
                                                        <td>완료 (연차 8.00h)</td>
                                                    </tr>
                                            
                                                    <tr>
                                                        <td>28 화</td>
                                                        <td>09:40:52</td>
                                                        <td>18:35:23</td>
                                                        <td class="font-bold">5h 34m 23s</td>
                                                        <td>기본 5h 34m 23s / 연장 0h 0m 0s</td>
                                                        <td></td>
                                                    </tr>

                                                    <tr>
                                                        <td>01 수</td>
                                                        <td>09:40:52</td>
                                                        <td>18:35:23</td>
                                                        <td class="font-bold">5h 34m 23s</td>
                                                        <td>기본 5h 34m 23s / 연장 0h 0m 0s</td>
                                                        <td>완료 (연차 8.00h)</td>
                                                    </tr>

                                                    <tr>
                                                        <td>02 목</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="font-bold"></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>

                                                    <tr>
                                                        <td>03 금</td>
                                                        <td>09:40:52</td>
                                                        <td>18:35:23</td>
                                                        <td class="font-bold">5h 34m 23s</td>
                                                        <td>기본 5h 34m 23s / 연장 0h 0m 0s</td>
                                                        <td>완료 (연차 8.00h)</td>
                                                    </tr>

                                                    <tr>
                                                        <td>04 토</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="font-bold"></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>

                                                    <tr>
                                                        <td>05 일</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="font-bold"></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                        
                                                </tbody>
                                            </table>

                                        </td>
                                    </tr>
                            
                                    <tr class="table-expand-row" data-open-details>
                                        <td class="border-bottom font-18" width="400">2주차 <span class="expand-icon"></span></td>
                                        <td class="total-time-info">누적 근무시간 5h 35m 23s(초과 근무시간 0h 0m 0s)</td>
                                    </tr>
                            
                                    <tr class="table-expand-row-content">
                                        <td colspan="8" class="table-expand-row-nested">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eaque unde quaerat reprehenderit ipsa
                                                ipsam, adipisci facere repellendus impedit at, quisquam dicta optio veniam quia nesciunt, inventore
                                                quod in neque magni?</p>
                                        </td>
                                        </td>
                                    </tr>
                            
                                    <tr class="table-expand-row" data-open-details>
                                        <td class="border-bottom font-18" width="400">3주차 <span class="expand-icon"></span></td>
                                        <td class="total-time-info">누적 근무시간 5h 35m 23s(초과 근무시간 0h 0m 0s)</td>
                                    </tr>
                            
                                    <tr class="table-expand-row-content">
                                        <td colspan="8" class="table-expand-row-nested">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eaque unde quaerat reprehenderit ipsa
                                                ipsam, adipisci facere repellendus impedit at, quisquam dicta optio veniam quia nesciunt, inventore
                                                quod in neque magni?</p>
                                        </td>
                                        </td>
                                    </tr>
                            
                                <tr class="table-expand-row" data-open-details>
                                    <td class="border-bottom font-18" width="400">4주차 <span class="expand-icon"></span></td>
                                    <td class="total-time-info">누적 근무시간 5h 35m 23s(초과 근무시간 0h 0m 0s)</td>
                                </tr>
                            
                                    <tr class="table-expand-row-content">
                                        <td colspan="8" class="table-expand-row-nested">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eaque unde quaerat reprehenderit ipsa
                                                ipsam, adipisci facere repellendus impedit at, quisquam dicta optio veniam quia nesciunt, inventore
                                                quod in neque magni?</p>
                                        </td>
                                        </td>
                                    </tr>
                            
                                    
                            
                                </tbody>
                            </table>

                        </div>

                    </div>
                    <!-- 본문 end -->
                </div>
             </div>
         
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${pageContext.request.contextPath}/resources/js/emp/emp.js"></script>			