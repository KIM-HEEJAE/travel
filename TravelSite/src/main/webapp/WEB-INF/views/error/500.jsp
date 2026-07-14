<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오류가 발생했어요 - TravelSite</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .error-page {
            max-width: 500px; margin: 100px auto; text-align: center;
        }
        .error-code { font-size: 80px; font-weight: bold; color: #ff5555; margin-bottom: 10px; }
        .error-title { font-size: 22px; margin-bottom: 12px; }
        .error-desc { color: #888; font-size: 14px; margin-bottom: 30px; line-height: 1.6; }
        .error-icon { font-size: 60px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />

    <div class="error-page">
        <div class="error-icon">⚠️</div>
        <div class="error-code">500</div>
        <div class="error-title">일시적인 오류가 발생했어요</div>
        <div class="error-desc">
            서버에 문제가 생겼습니다.<br>
            잠시 후 다시 시도해주시거나, 홈으로 돌아가주세요.
        </div>
        <a href="${pageContext.request.contextPath}/" class="hero-btn" style="background:#2d7ff9; color:white;">홈으로 돌아가기</a>
    </div>
</body>
</html>