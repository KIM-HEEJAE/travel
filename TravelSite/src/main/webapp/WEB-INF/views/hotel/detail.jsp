<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${hotel.hotelName}</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif;}
        .top-link { margin-bottom: 20px; }
        .top-link a { text-decoration: none; color: #999; font-size: 13px; }

        h2 { margin-bottom: 6px; }
        .meta { color: #888; font-size: 14px; margin-bottom: 16px; }
        .rating-badge { color: #f2994a; font-weight: bold; }
        .desc { line-height: 1.6; margin-bottom: 20px; color: #444; }
        .price { font-size: 22px; font-weight: bold; color: #2d7ff9; margin-bottom: 24px; }
        .reserve-btn {
            display: inline-block; padding: 12px 28px; background: #2d7ff9; color: white;
            border-radius: 8px; text-decoration: none; font-size: 15px; margin-bottom: 40px;
        }

        .review-section h3 { border-left: 4px solid #2d7ff9; padding-left: 10px; margin-bottom: 16px; }
        .review-item { border-bottom: 1px solid #eee; padding: 14px 0; }
        .review-top { display: flex; justify-content: space-between; margin-bottom: 6px; }
        .review-author { font-weight: bold; font-size: 14px; }
        .review-rating { color: #f2994a; font-weight: bold; font-size: 14px; }
        .review-date { color: #aaa; font-size: 12px; }
        .review-content { font-size: 14px; color: #444; line-height: 1.5; }
        .empty { color: #999; text-align: center; padding: 30px 0; font-size: 14px; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />


    <div class="top-link">
        <a href="${pageContext.request.contextPath}/hotel/list">← 숙소 목록으로</a>
    </div>

    <h2>${hotel.hotelName}</h2>
    <div class="meta">
        ${hotel.location} · ${hotel.hotelType} · 
        <span class="rating-badge">★ ${avgRating}</span> (리뷰 ${reviewCount}개)
    </div>
    <div class="desc">${hotel.description}</div>
    <div class="price"><fmt:formatNumber value="${hotel.pricePerNight}" pattern="#,###" />원 / 1박</div>

    <a class="reserve-btn" href="${pageContext.request.contextPath}/hotel/reserve?hotelId=${hotel.hotelId}">예약하기</a>

    <div class="review-section">
        <h3>💬 숙박 리뷰 (${reviewCount}개)</h3>
        <c:choose>
            <c:when test="${empty reviews}">
                <div class="empty">아직 리뷰가 없습니다. 첫 리뷰를 남겨보세요!</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="review" items="${reviews}">
                    <div class="review-item">
                        <div class="review-top">
                            <div>
                                <span class="review-author">${review.memberName}</span>
                                <span class="review-rating">★ ${review.rating}</span>
                            </div>
                            <span class="review-date"><fmt:formatDate value="${review.regDate}" pattern="yyyy-MM-dd" /></span>
                        </div>
                        <div class="review-content">${review.content}</div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>