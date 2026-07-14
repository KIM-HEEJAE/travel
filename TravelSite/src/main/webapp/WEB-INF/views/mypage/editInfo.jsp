<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="page-narrow">
    <h2>회원정보 수정</h2>

    <form action="${pageContext.request.contextPath}/mypage/editInfoProc" method="post">

        <label>아이디</label>
        <input type="text" value="${member.userId}" disabled style="background:#f5f5f5;">

        <label>이름</label>
        <input type="text" name="name" value="${member.name}" required>

        <label>이메일</label>
        <input type="email" name="email" value="${member.email}">

        <button type="submit" class="btn-primary">저장</button>
        <button type="button" class="btn-secondary" style="width:100%; margin-top:10px;" onclick="location.href='${pageContext.request.contextPath}/mypage'">취소</button>
    </form>
</div>
</body>
</html>