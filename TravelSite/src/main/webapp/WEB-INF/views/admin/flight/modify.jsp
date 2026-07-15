<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../../header.jsp" />

<div class="page-medium">
    <h2>항공권 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/flight/update" method="post">
        <input type="hidden" name="flightId" value="${flight.flightId}">

        <label>항공사</label>
        <input type="text" name="airline" value="${flight.airline}" required>

        <label>출발지</label>
        <input type="text" name="departure" value="${flight.departure}" required>

        <label>도착지</label>
        <input type="text" name="arrival" value="${flight.arrival}" required>

        <label>유형</label>
        <select name="flightType">
            <option value="국내선" ${flight.flightType == '국내선' ? 'selected' : ''}>국내선</option>
            <option value="국제선" ${flight.flightType == '국제선' ? 'selected' : ''}>국제선</option>
        </select>

        <label>출발 시간</label>
        <input type="text" name="departTime" value="${flight.departTime}" required>

        <label>도착 시간</label>
        <input type="text" name="arriveTime" value="${flight.arriveTime}" required>

        <label>소요시간</label>
        <input type="text" name="duration" value="${flight.duration}">

        <label>가격</label>
        <input type="text" name="price" value="${flight.price}" required>

        <label>좌석 등급</label>
        <select name="seatClass">
            <option value="일반석" ${flight.seatClass == '일반석' ? 'selected' : ''}>일반석</option>
            <option value="비즈니스" ${flight.seatClass == '비즈니스' ? 'selected' : ''}>비즈니스</option>
        </select>

        <label>운항 날짜</label>
        <input type="date" name="flightDate" value="<fmt:formatDate value='${flight.flightDate}' pattern='yyyy-MM-dd'/>" required>

        <button type="submit" class="btn-primary">수정 완료</button>
        <button type="button" class="btn-secondary" style="width:100%; margin-top:10px;" onclick="location.href='${pageContext.request.contextPath}/admin/flight/list'">취소</button>
    </form>
</div>
</body>
</html>