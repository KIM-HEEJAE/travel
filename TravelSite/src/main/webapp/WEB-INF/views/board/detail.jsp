<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 700px; margin: 40px auto; }
        .info { color: #888; font-size: 14px; margin-bottom: 20px; }
        .content { border-top: 1px solid #ddd; border-bottom: 1px solid #ddd; padding: 20px 0; min-height: 150px; }
        .btn-group { margin-top: 20px; text-align: right; }
    </style>
</head>
<body>
    <h2>${board.title}</h2>
    <div class="info">
        작성자: ${board.memberName} | 지역: ${board.region} | 조회수: ${board.viewCnt} |
        <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm" />
    </div>

    <div class="content">
        ${board.content}
    </div>

    <div class="btn-group">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/modify?boardId=${board.boardId}'">수정</button>
        <button type="button" onclick="deletePost(${board.boardId})">삭제</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
    </div>

    <script>
        function deletePost(boardId) {
            if (confirm("정말 삭제하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/board/delete?boardId=" + boardId;
            }
        }
    </script>
</body>
</html>