<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../../header.jsp" />

<div class="page-medium">
    <h2>숙소 등록</h2>

    <form action="${pageContext.request.contextPath}/admin/hotel/insert" method="post">

        <label>숙소명</label>
        <input type="text" name="hotelName" required>

        <label>지역</label>
        <input type="text" name="location" required>

        <label>유형</label>
        <select name="hotelType">
            <option value="호텔">호텔</option>
            <option value="리조트">리조트</option>
            <option value="펜션">펜션</option>
            <option value="게스트하우스">게스트하우스</option>
        </select>

        <label>1박 가격</label>
        <input type="text" name="pricePerNight" required>

        <label>초기 평점 (리뷰 생기면 자동으로 갱신됩니다)</label>
        <input type="text" name="rating" value="4.0">

        <label>설명</label>
        <textarea name="description" required></textarea>

        <button type="submit" class="btn-primary">등록</button>
        <button type="button" class="btn-secondary" style="width:100%; margin-top:10px;" onclick="location.href='${pageContext.request.contextPath}/admin/hotel/list'">취소</button>
    </form>
</div>
</body>
</html>