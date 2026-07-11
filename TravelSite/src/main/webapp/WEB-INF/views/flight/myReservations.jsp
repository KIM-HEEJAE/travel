<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 예약 목록</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif;}
        h2 { margin-bottom: 24px; }
        .top-link { margin-bottom: 20px; }
        .top-link a { text-decoration: none; color: #999; font-size: 13px; }

        .resv-card {
            display: flex; justify-content: space-between; align-items: center;
            border: 1px solid #eee; border-radius: 12px; padding: 20px; margin-bottom: 14px;
        }
        .resv-info .route { font-size: 16px; font-weight: bold; margin-bottom: 6px; }
        .resv-info div { font-size: 13px; color: #777; margin-bottom: 3px; }
        .status {
            display: inline-block; background: #eaf2ff; color: #2d7ff9;
            padding: 4px 10px; border-radius: 10px; font-size: 12px; margin-top: 6px;
        }
        .cancel-btn {
            padding: 8px 16px; background: none; border: 1px solid #ddd; color: #999;
            border-radius: 20px; cursor: pointer; font-size: 13px;
        }
        .cancel-btn:hover { border-color: #ff5555; color: #ff5555; }
        .empty { text-align: center; color: #999; padding: 60px 0; }
        .empty a { color: #2d7ff9; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />


    <div class="top-link">
        <a href="${pageContext.request.contextPath}/flight/list">← 항공권 검색으로</a>
    </div>
    <h2>🎫 내 예약 목록</h2>

    <c:choose>
        <c:when test="${empty myReservations}">
            <div class="empty">
                예약 내역이 없습니다.<br>
                <a href="${pageContext.request.contextPath}/flight/list">항공권 검색하러 가기</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="r" items="${myReservations}">
                <div class="resv-card">
                    <div class="resv-info">
                        <div class="route">${r.departure} → ${r.arrival}</div>
                        <div>${r.airline} | 탑승객: ${r.passengerName}</div>
                        <div><fmt:formatDate value="${r.flightDate}" pattern="yyyy-MM-dd" /> ${r.departTime} 출발</div>
                        <div><fmt:formatNumber value="${r.price}" pattern="#,###" />원</div>
                        <span class="status">${r.status}</span>
                    </div>
                    <button class="cancel-btn" onclick="cancelReservation(${r.reservationId})">예약취소</button>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <script>
        function cancelReservation(reservationId) {
            if (confirm('예약을 취소하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/flight/cancel?reservationId=' + reservationId;
            }
        }
    </script>
</body>
</html>