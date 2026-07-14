<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>페이지를 찾을 수 없어요 - TravelSite</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .error-page {
            max-width: 500px; margin: 100px auto; text-align: center;
        }
        .error-code { font-size: 80px; font-weight: bold; color: #2d7ff9; margin-bottom: 10px; }
        .error-title { font-size: 22px; margin-bottom: 12px; }
        .error-desc { color: #888; font-size: 14px; margin-bottom: 30px; line-height: 1.6; }
        .error-icon { font-size: 60px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />

    <div class="error-page">
        <div class="error-icon">🧭</div>
        <div class="error-code">404</div>
        <div class="error-title">길을 잃으셨나요?</div>
        <div class="error-desc">
            요청하신 페이지를 찾을 수 없습니다.<br>
            주소가 변경되었거나 삭제된 페이지일 수 있어요.
        </div>
        <a href="${pageContext.request.contextPath}/" class="hero-btn" style="background:#2d7ff9; color:white;">홈으로 돌아가기</a>
    </div>
</body>
</html>