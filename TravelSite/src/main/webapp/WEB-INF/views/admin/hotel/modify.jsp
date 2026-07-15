<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../../header.jsp" />

<div class="page-medium">
    <h2>숙소 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/hotel/update" method="post">
        <input type="hidden" name="hotelId" value="${hotel.hotelId}">

        <label>숙소명</label>
        <input type="text" name="hotelName" value="${hotel.hotelName}" required>

        <label>지역</label>
        <input type="text" name="location" value="${hotel.location}" required>

        <label>유형</label>
        <select name="hotelType">
            <option value="호텔" ${hotel.hotelType == '호텔' ? 'selected' : ''}>호텔</option>
            <option value="리조트" ${hotel.hotelType == '리조트' ? 'selected' : ''}>리조트</option>
            <option value="펜션" ${hotel.hotelType == '펜션' ? 'selected' : ''}>펜션</option>
            <option value="게스트하우스" ${hotel.hotelType == '게스트하우스' ? 'selected' : ''}>게스트하우스</option>
        </select>

        <label>1박 가격</label>
        <input type="text" name="pricePerNight" value="${hotel.pricePerNight}" required>

        <label>평점 (리뷰 기반 자동 계산 — 참고용)</label>
        <input type="text" value="${hotel.rating}" disabled style="background:#f5f5f5;">

        <label>설명</label>
        <textarea name="description" required>${hotel.description}</textarea>

        <button type="submit" class="btn-primary">수정 완료</button>
        <button type="button" class="btn-secondary" style="width:100%; margin-top:10px;" onclick="location.href='${pageContext.request.contextPath}/admin/hotel/list'">취소</button>
    </form>
</div>
</body>
</html>