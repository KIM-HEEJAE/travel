<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 700px; margin: 40px auto; }
        input[type=text], textarea, select { width: 100%; padding: 8px; margin: 6px 0 16px 0; box-sizing: border-box; }
        textarea { height: 200px; }
        label { font-weight: bold; }
    </style>
</head>
<body>
    <h2>게시글 작성</h2>
    <form action="${pageContext.request.contextPath}/board/insert" method="post">

        <!-- 임시: 로그인 기능 만들기 전까지 회원번호 직접 입력 (나중에 세션값으로 교체) -->
        <label>작성자 회원번호 (임시)</label>
        <input type="text" name="memberId" value="1" required>

        <label>제목</label>
        <input type="text" name="title" required>

        <label>카테고리</label>
        <select name="category">
            <option value="후기">여행 후기</option>
            <option value="코스공유">코스 공유</option>
            <option value="자유">자유 게시판</option>
        </select>

        <label>여행 지역</label>
        <input type="text" name="region" placeholder="예: 제주도, 부산 등">

        <label>내용</label>
        <textarea name="content" required></textarea>

        <button type="submit">등록</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/list'">취소</button>
    </form>
</body>
</html>