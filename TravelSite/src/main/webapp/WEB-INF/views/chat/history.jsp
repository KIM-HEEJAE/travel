<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix = "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 채팅 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
  <style>
        .history-item { border: 1px solid #eee; border-radius: 12px; padding: 20px; margin-bottom: 16px; }
        .history-q { font-weight: bold; margin-bottom: 10px; color: #2d7ff9; }
        .history-a { color: #444; line-height: 1.6; white-space: pre-wrap; font-size: 14px; }
        .history-date { color: #aaa; font-size: 12px; margin-top: 10px; text-align: right; }
    </style>

</head>
<body>
<jsp:include page = "../header.jsp" />
<div class="page-medium">
<div class= "top-link"><a href="${pageContext.request.contextPath}/chat/ask"> ← AI 상담으로 돌아가기</a></div>
<h2> 💬내 AI 상담 기록</h2>
<c:choose>
<c:when test ="${empty myChats}">
<div class="empty">대화 기록이 없습니다.</div>
</c:when>
<c:otherwise>
<c:forEach var = "chat" items="${myChats}">
<div class= "history-item">
<div class ="history-q">Q. ${chat.question}</div>
<div class= "history-a">${chat.answer}</div>
<div class= "history-date"><fmt:formatDate value = "${chat.regDate}" pattern = "yyyy-MM-dd HH:mm" /></div>
</div>
</c:forEach>
</c:otherwise>
</c:choose>
</div>
</body>
</html>