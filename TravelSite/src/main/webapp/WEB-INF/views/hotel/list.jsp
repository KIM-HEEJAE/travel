<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 검색</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif;}
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

        .hotel-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .hotel-card {
            border: 1px solid #eee; border-radius: 12px; padding: 20px;
        }
        .hotel-name { font-size: 17px; font-weight: bold; margin-bottom: 6px; }
        .hotel-meta { font-size: 13px; color: #888; margin-bottom: 8px; }
        .hotel-desc { font-size: 13px; color: #666; margin-bottom: 12px; line-height: 1.5; }
        .hotel-bottom { display: flex; justify-content: space-between; align-items: center; }
        .rating { color: #f2994a; font-size: 14px; font-weight: bold; }
        .price { font-size: 18px; font-weight: bold; color: #2d7ff9; }
        .price span { font-size: 12px; color: #999; font-weight: normal; }
        .reserve-btn {
            margin-top: 10px; padding: 8px 16px; background: #2d7ff9; color: white;
            border: none; border-radius: 20px; cursor: pointer; font-size: 13px; text-decoration: none;
            display: inline-block; float: right;
        }
        .empty { text-align: center; color: #999; padding: 60px 0; grid-column: span 2; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />


    <div class="top-link">
        <a href="${pageContext.request.contextPath}/">← 홈으로 돌아가기</a>
    </div>
    <h2>🏨 숙소 검색</h2>

    <form class="search-box" action="${pageContext.request.contextPath}/hotel/list" method="get">
        <input type="text" name="location" value="${location}" placeholder="지역 (예: 제주, 도쿄)">
        <select name="hotelType">
            <option value="">전체 유형</option>
            <option value="호텔" ${hotelType == '호텔' ? 'selected' : ''}>호텔</option>
            <option value="리조트" ${hotelType == '리조트' ? 'selected' : ''}>리조트</option>
            <option value="펜션" ${hotelType == '펜션' ? 'selected' : ''}>펜션</option>
            <option value="게스트하우스" ${hotelType == '게스트하우스' ? 'selected' : ''}>게스트하우스</option>
        </select>
        <button type="submit">검색</button>
    </form>

    <div class="hotel-grid">
        <c:choose>
            <c:when test="${empty hotelList}">
                <div class="empty">검색 결과가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="hotel" items="${hotelList}">
                    <div class="hotel-card">
                        <div class="hotel-name">${hotel.hotelName}</div>
                        <div class="hotel-meta">${hotel.location} · ${hotel.hotelType} · <span class="rating">★ ${hotel.rating}</span></div>
                        <div class="hotel-desc">${hotel.description}</div>
                        <div class="hotel-bottom">
                            <div class="price"><fmt:formatNumber value="${hotel.pricePerNight}" pattern="#,###" />원 <span>/ 1박</span></div>
                            <a class="reserve-btn" href="${pageContext.request.contextPath}/hotel/detail?hotelId=${hotel.hotelId}">상세보기</a>

                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>