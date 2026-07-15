<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<div class="header">
	<a href="${pageContext.request.contextPath}/" class="logo">✈
		TravelSite</a>
	<div class="nav">
		<a href="${pageContext.request.contextPath}/flight/list">항공권 예약</a>
		<a href="${pageContext.request.contextPath}/hotel/list">숙소 예약</a> <a
			href="${pageContext.request.contextPath}/board/list">게시판</a>  <a
			href="${pageContext.request.contextPath}/preference/dashboard">취향통계</a>
		<a href="${pageContext.request.contextPath}/chat/ask">AI 상담</a>
		<c:choose>
			<c:when test="${not empty sessionScope.loginMember}">
				<a href="${pageContext.request.contextPath}/preference/survey">취향설문</a>
				
				<a href="${pageContext.request.contextPath}/flight/myReservations">내 항공권
					예약 목록</a>
				<a href="${pageContext.request.contextPath}/hotel/myReservations">내 숙소
					예약 목록</a>
				<a href="${pageContext.request.contextPath}/mypage">마이페이지</a>
				<c:if test="${sessionScope.loginMember.isAdmin == 'Y'}">
					<a href="${pageContext.request.contextPath}/admin"
						style="color: #ff5555; font-weight: bold;">관리자</a>
						<a href="#">${sessionScope.loginMember.name}님</a>
				</c:if>
				<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath}/member/login">로그인</a>
				<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>