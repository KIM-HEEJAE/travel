<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <style>
        #currentImg, #previewImg { max-width: 100%; margin-top: 10px; border-radius: 8px; }
        #previewImg { display: none; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="page-medium">

    <h2>게시글 수정</h2>
    <form action="${pageContext.request.contextPath}/board/update" method="post" enctype="multipart/form-data">

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

        <label>사진 첨부 (변경 시에만 업로드)</label>
        <c:if test="${not empty board.imagePath}">
            <img id="currentImg" src="${pageContext.request.contextPath}/image/view?filename=${board.imagePath}">
        </c:if>
        <input type="file" name="imageFile" id="imageFile" accept="image/*" onchange="previewImage(this)">
        <img id="previewImg" src="">

        <label>내용</label>
        <textarea name="content" required>${board.content}</textarea>

        <button type="submit" class="btn-primary">수정 완료</button>
        <button type="button" class="btn-secondary" onclick="location.href='${pageContext.request.contextPath}/board/detail?boardId=${board.boardId}'">취소</button>
    </form>

</div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var img = document.getElementById('previewImg');
                    img.src = e.target.result;
                    img.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>