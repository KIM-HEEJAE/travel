<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 예약</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 500px; margin: 50px auto; }
        h2 { text-align: center; }
        .summary {
            background: #f7f9fc; border-radius: 12px; padding: 20px; margin-bottom: 24px;
        }
        .summary .route { font-size: 18px; font-weight: bold; margin-bottom: 8px; }
        .summary div { font-size: 14px; color: #555; margin-bottom: 4px; }
        .summary .price { font-size: 20px; color: #2d7ff9; font-weight: bold; margin-top: 10px; }

        label { font-weight: bold; display: block; margin-bottom: 6px; }
        input[type=text] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px; box-sizing: border-box; }
        button {
            width: 100%; padding: 14px; background: #2d7ff9; color: white; border: none;
            border-radius: 8px; font-size: 16px; cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>항공권 예약</h2>

    <div class="summary">
        <div class="route">${flight.departure} → ${flight.arrival}</div>
        <div>${flight.airline} | ${flight.seatClass}</div>
        <div><fmt:formatDate value="${flight.flightDate}" pattern="yyyy-MM-dd" /> ${flight.departTime} 출발 (${flight.duration})</div>
        <div class="price"><fmt:formatNumber value="${flight.price}" pattern="#,###" />원</div>
    </div>

    <form action="${pageContext.request.contextPath}/flight/reserveProc" method="post">
        <input type="hidden" name="flightId" value="${flight.flightId}">

        <label>탑승객 이름</label>
        <input type="text" name="passengerName" placeholder="탑승객 성함을 입력하세요" required>

        <button type="submit">예약 확정</button>
    </form>
</body>
</html>