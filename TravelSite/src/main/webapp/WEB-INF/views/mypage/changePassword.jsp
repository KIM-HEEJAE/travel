<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="page-narrow">
    <h2>비밀번호 변경</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/mypage/changePasswordProc" method="post">

        <label>현재 비밀번호</label>
        <input type="password" name="currentPassword" required>

        <label>새 비밀번호</label>
        <input type="password" name="newPassword" required>

        <label>새 비밀번호 확인</label>
        <input type="password" name="newPasswordCheck" required>

        <button type="submit" class="btn-primary">변경하기</button>
        <button type="button" class="btn-secondary" style="width:100%; margin-top:10px;" onclick="location.href='${pageContext.request.contextPath}/mypage'">취소</button>
    </form>
</div>
</body>
</html>