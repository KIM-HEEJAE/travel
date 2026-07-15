<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../../header.jsp" />

<div class="page-wide">
    <div class="top-link"><a href="${pageContext.request.contextPath}/admin">← 관리자 메인으로</a></div>

    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>🏨 숙소 관리 (총 ${fn:length(hotelList)}개)</h2>
        <a href="${pageContext.request.contextPath}/admin/hotel/write" class="btn-primary" style="width:auto; padding:10px 20px; margin-top:0;">+ 새 숙소 등록</a>
    </div>

    <table>
        <tr>
            <th>번호</th><th>숙소명</th><th>지역</th><th>유형</th><th>1박 가격</th><th>평점</th><th>관리</th>
        </tr>
        <c:forEach var="hotel" items="${hotelList}">
            <tr>
                <td>${hotel.hotelId}</td>
                <td>${hotel.hotelName}</td>
                <td>${hotel.location}</td>
                <td>${hotel.hotelType}</td>
                <td><fmt:formatNumber value="${hotel.pricePerNight}" pattern="#,###" />원</td>
                <td>★ ${hotel.rating}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/hotel/modify?hotelId=${hotel.hotelId}" style="color:#2d7ff9; margin-right:8px;">수정</a>
                    <a href="#" onclick="deleteHotel(${hotel.hotelId}); return false;" style="color:#ff5555;">삭제</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    function deleteHotel(hotelId) {
        if (confirm('정말 삭제하시겠습니까?\n연관된 예약/리뷰가 있으면 삭제되지 않을 수 있습니다.')) {
            location.href = '${pageContext.request.contextPath}/admin/hotel/delete?hotelId=' + hotelId;
        }
    }
</script>
</body>
</html>