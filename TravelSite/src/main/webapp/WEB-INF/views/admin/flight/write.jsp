<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../../header.jsp" />

<div class="page-medium">
    <h2>항공권 등록</h2>

    <form action="${pageContext.request.contextPath}/admin/flight/insert" method="post">

        <label>항공사</label>
        <input type="text" name="airline" required>

        <label>출발지</label>
        <input type="text" name="departure" required>

        <label>도착지</label>
        <input type="text" name="arrival" required>

        <label>유형</label>
        <select name="flightType">
            <option value="국내선">국내선</option>
            <option value="국제선">국제선</option>
        </select>

        <label>출발 시간 (예: 09:00)</label>
        <input type="text" name="departTime" required>

        <label>도착 시간 (예: 10:10)</label>
        <input type="text" name="arriveTime" required>

        <label>소요시간 (예: 1시간 10분)</label>
        <input type="text" name="duration">

        <label>가격</label>
        <input type="text" name="price" required>

        <label>좌석 등급</label>
        <select name="seatClass">
            <option value="일반석">일반석</option>
            <option value="비즈니스">비즈니스</option>
        </select>

        <label>운항 날짜</label>
        <input type="date" name="flightDate" required>

        <button type="submit" class="btn-primary">등록</button>
        <button type="button" class="btn-secondary" style="width:100%; margin-top:10px;" onclick="location.href='${pageContext.request.contextPath}/admin/flight/list'">취소</button>
    </form>
</div>
</body>
</html>