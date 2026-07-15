<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .admin-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-top: 30px; }
        .admin-card {
            border: 1px solid #eee; border-radius: 12px; padding: 30px; text-align: center;
        }
        .admin-card .count { font-size: 32px; font-weight: bold; color: #2d7ff9; margin: 10px 0; }
        .admin-card a {
            display: inline-block; margin-top: 10px; padding: 8px 20px; background: #2d7ff9;
            color: white; border-radius: 8px; font-size: 14px;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="page-wide">
    <h2>🛠 관리자 페이지</h2>

    <div class="admin-grid">
        <div class="admin-card">
            <div>항공권</div>
            <div class="count">${flightCount}개</div>
            <a href="${pageContext.request.contextPath}/admin/flight/list">항공권 관리</a>
        </div>
        <div class="admin-card">
            <div>숙소</div>
            <div class="count">${hotelCount}개</div>
            <a href="${pageContext.request.contextPath}/admin/hotel/list">숙소 관리</a>
        </div>
    </div>
</div>
</body>
</html>