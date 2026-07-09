<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 검색</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 900px; margin: 40px auto; }
        h2 { text-align: center; }
        .top-link { margin-bottom: 20px; }
        .top-link a { text-decoration: none; color: #999; font-size: 13px; }

        .search-box {
            display: flex; gap: 10px; background: #f7f9fc; padding: 20px;
            border-radius: 12px; margin-bottom: 30px; flex-wrap: wrap;
        }
        .search-box select, .search-box input {
            padding: 10px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px;
        }
        .search-box button {
            padding: 10px 24px; background: #2d7ff9; color: white; border: none;
            border-radius: 8px; cursor: pointer; font-size: 14px;
        }

        .flight-card {
            display: flex; justify-content: space-between; align-items: center;
            border: 1px solid #eee; border-radius: 12px; padding: 20px; margin-bottom: 14px;
        }
        .flight-info { display: flex; gap: 30px; align-items: center; }
        .airline { font-weight: bold; font-size: 14px; color: #555; min-width: 90px; }
        .route { text-align: center; }
        .route .time { font-size: 18px; font-weight: bold; }
        .route .place { font-size: 13px; color: #888; }
        .route .arrow { color: #ccc; margin: 0 10px; }
        .duration { font-size: 12px; color: #aaa; }
        .price-area { text-align: right; }
        .price { font-size: 20px; font-weight: bold; color: #2d7ff9; }
        .seat-class { font-size: 12px; color: #999; }
        .reserve-btn {
            margin-top: 8px; padding: 8px 16px; background: #2d7ff9; color: white;
            border: none; border-radius: 20px; cursor: pointer; font-size: 13px; text-decoration: none;
            display: inline-block;
        }
        .empty { text-align: center; color: #999; padding: 60px 0; }
    </style>
</head>
<body>
    <div class="top-link">
        <a href="${pageContext.request.contextPath}/">← 홈 화면으로 돌아가기</a>
    </div>
    <h2>✈ 항공권 검색</h2>

    <form class="search-box" action="${pageContext.request.contextPath}/flight/list" method="get">
        <select name="flightType">
            <option value="">전체</option>
            <option value="국내선" ${flightType == '국내선' ? 'selected' : ''}>국내선</option>
            <option value="국제선" ${flightType == '국제선' ? 'selected' : ''}>국제선</option>
        </select>
        <input type="text" name="departure" value="${departure}" placeholder="출발지 (예: 서울)">
        <input type="text" name="arrival" value="${arrival}" placeholder="도착지 (예: 제주)">
        <button type="submit">검색</button>
    </form>

    <c:choose>
        <c:when test="${empty flightList}">
            <div class="empty">검색 결과가 없습니다.</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="flight" items="${flightList}">
                <div class="flight-card">
                    <div class="flight-info">
                        <div class="airline">${flight.airline}</div>
                        <div class="route">
                            <div class="time">${flight.departTime}</div>
                            <div class="place">${flight.departure}</div>
                        </div>
                        <div>
                            <span class="arrow">→</span>
                            <div class="duration">${flight.duration}</div>
                        </div>
                        <div class="route">
                            <div class="time">${flight.arriveTime}</div>
                            <div class="place">${flight.arrival}</div>
                        </div>
                        <div style="font-size: 13px; color: #888;">
                            <fmt:formatDate value="${flight.flightDate}" pattern="yyyy-MM-dd" />
                        </div>
                    </div>
                    <div class="price-area">
                        <div class="price"><fmt:formatNumber value="${flight.price}" pattern="#,###" />원</div>
                        <div class="seat-class">${flight.seatClass}</div>
                        <a class="reserve-btn" href="${pageContext.request.contextPath}/flight/reserve?flightId=${flight.flightId}">예약하기</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</body>
</html>