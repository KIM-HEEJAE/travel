<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 400px; margin: 60px auto; text-align: center; }
        input[type=text], input[type=password] {
            width: 100%; padding: 10px; margin: 8px 0; box-sizing: border-box;
        }
        button { width: 100%; padding: 10px; margin-top: 10px; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <h2>로그인</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/member/loginProc" method="post">
        <input type="text" name="userId" placeholder="아이디" required>
        <input type="password" name="password" placeholder="비밀번호" required>
        <button type="submit">로그인</button>
    </form>

    <p>계정이 없으신가요? 
        <a href="${pageContext.request.contextPath}/member/join">회원가입</a>
    </p>
</body>
</html>