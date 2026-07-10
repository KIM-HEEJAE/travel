<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 커뮤니티 - TravelSite</title>
</head>
<body>

<jsp:include page="header.jsp" />


	<div class="hero">
		<h1>당신의 다음 여행을 찾아보세요</h1>
		<p>여행 후기부터 코스 공유, AI 여행 상담까지 한 곳에서</p>
		<a href="${pageContext.request.contextPath}/board/list"
			class="hero-btn">게시판 둘러보기</a>
	</div>
	<div class="section">
		<div class="section-header">
			<h2 style="margin-bottom: 0;">✈ 인기 항공권</h2>
			<a href="${pageContext.request.contextPath}/flight/list"
				class="more-link">전체보기 →</a>
		</div>
		<c:choose>
			<c:when test="${empty promoFlights}">
				<div class="empty">등록된 항공권이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<div class="promo-grid">
					<c:forEach var="flight" items="${promoFlights}">
						<a class="promo-card"
							href="${pageContext.request.contextPath}/flight/reserve?flightId=${flight.flightId}">
							<div class="promo-route">${flight.departure}→
								${flight.arrival}</div>
							<div class="promo-sub">${flight.airline}·
								${flight.flightType}</div>
							<div class="promo-price">
								<fmt:formatNumber value="${flight.price}" pattern="#,###" />
								원~
							</div>
						</a>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="section">
		<div class="section-header">
			<h2 style="margin-bottom: 0;">🏨 추천 숙소</h2>
			<a href="${pageContext.request.contextPath}/hotel/list"
				class="more-link">전체보기 →</a>
		</div>
		<c:choose>
			<c:when test="${empty promoHotels}">
				<div class="empty">등록된 숙소가 없습니다.</div>
			</c:when>
			<c:otherwise>
				<div class="promo-grid">
					<c:forEach var="hotel" items="${promoHotels}">
						<a class="promo-card"
							href="${pageContext.request.contextPath}/hotel/detail?hotelId=${hotel.hotelId}">
							<div class="promo-route">${hotel.hotelName}</div>
							<div class="promo-sub">${hotel.location}· ★ ${hotel.rating}</div>
							<div class="promo-price">
								<fmt:formatNumber value="${hotel.pricePerNight}" pattern="#,###" />
								원 / 1박
							</div>
						</a>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="section">
		<h2>최신 여행 후기</h2>
		<c:choose>
			<c:when test="${empty recentBoards}">
				<div class="empty">아직 등록된 게시글이 없습니다. 첫 번째 후기를 남겨보세요!</div>
			</c:when>
			<c:otherwise>
				<ul class="board-list">
					<c:forEach var="board" items="${recentBoards}">
						<li><a
							href="${pageContext.request.contextPath}/board/detail?boardId=${board.boardId}">
								${board.title} </a> <span class="meta"> ${board.memberName} ·
								${board.region} · <fmt:formatDate value="${board.regDate}"
									pattern="yyyy-MM-dd" />
						</span></li>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="section">
		<h2>이런 걸 할 수 있어요</h2>
		<div class="features">
			<div class="feature-box">
				<div class="icon">📝</div>
				<h3>여행 후기 공유</h3>
				<p>다녀온 여행지의 생생한 후기를 남겨보세요</p>
			</div>
			<div class="feature-box">
				<div class="icon">📊</div>
				<h3>취향 분석</h3>
				<p>회원들의 여행 취향을 그래프로 확인해요</p>
			</div>
			<div class="feature-box">
				<div class="icon">🤖</div>
				<h3>AI 여행 상담</h3>
				<p>궁금한 여행 정보를 AI에게 물어보세요</p>
			</div>
		</div>
	</div>

	<div class="footer">© 2026 TravelSite. 개인 포트폴리오 프로젝트입니다.</div>

</body>
</html>