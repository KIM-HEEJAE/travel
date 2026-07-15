<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>항공권 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../../header.jsp" />

<div class="page-wide">
    <div class="top-link"><a href="${pageContext.request.contextPath}/admin">← 관리자 메인으로</a></div>

    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>✈ 항공권 관리 (총 ${fn:length(flightList)}개)</h2>
        <a href="${pageContext.request.contextPath}/admin/flight/write" class="btn-primary" style="width:auto; padding:10px 20px; margin-top:0;">+ 새 항공권 등록</a>
    </div>

    <table>
        <tr>
            <th>번호</th><th>항공사</th><th>구간</th><th>유형</th><th>출발</th><th>가격</th><th>날짜</th><th>관리</th>
        </tr>
        <c:forEach var="flight" items="${flightList}">
            <tr>
                <td>${flight.flightId}</td>
                <td>${flight.airline}</td>
                <td>${flight.departure} → ${flight.arrival}</td>
                <td>${flight.flightType}</td>
                <td>${flight.departTime}</td>
                <td><fmt:formatNumber value="${flight.price}" pattern="#,###" />원</td>
                <td><fmt:formatDate value="${flight.flightDate}" pattern="yyyy-MM-dd" /></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/flight/modify?flightId=${flight.flightId}" style="color:#2d7ff9; margin-right:8px;">수정</a>
                    <a href="#" onclick="deleteFlight(${flight.flightId}); return false;" style="color:#ff5555;">삭제</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    function deleteFlight(flightId) {
        if (confirm('정말 삭제하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/admin/flight/delete?flightId=' + flightId;
        }
    }
</script>
</body>
</html>