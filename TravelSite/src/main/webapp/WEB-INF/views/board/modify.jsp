<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 700px; margin: 40px auto; }
        input[type=text], textarea, select { width: 100%; padding: 8px; margin: 6px 0 16px 0; box-sizing: border-box; }
        textarea { height: 200px; }
        label { font-weight: bold; }
    </style>
</head>
<body>
    <h2>게시글 수정</h2>
    <form action="${pageContext.request.contextPath}/board/update" method="post">

        <input type="hidden" name="boardId" value="${board.boardId}">

        <label>제목</label>
        <input type="text" name="title" value="${board.title}" required>

        <label>카테고리</label>
        <select name="category">
            <option value="후기" ${board.category == '후기' ? 'selected' : ''}>여행 후기</option>
            <option value="코스공유" ${board.category == '코스공유' ? 'selected' : ''}>코스 공유</option>
            <option value="자유" ${board.category == '자유' ? 'selected' : ''}>자유 게시판</option>
        </select>

        <label>여행 지역</label>
        <input type="text" name="region" value="${board.region}">

        <label>내용</label>
        <textarea name="content" required>${board.content}</textarea>

        <button type="submit">수정 완료</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/detail?boardId=${board.boardId}'">취소</button>
    </form>
</body>
</html>