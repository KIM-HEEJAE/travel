<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <style>
        #previewImg { max-width: 100%; margin-top: 10px; border-radius: 8px; display: none; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />

<div class="page-medium">

    <h2>게시글 작성</h2>
    <form action="${pageContext.request.contextPath}/board/insert" method="post" enctype="multipart/form-data">

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

        <label>사진 첨부</label>
        <input type="file" name="imageFile" id="imageFile" accept="image/*" onchange="previewImage(this)">
        <img id="previewImg" src="">

        <label>내용</label>
        <textarea name="content" required></textarea>

        <button type="submit" class="btn-primary">등록</button>
        <button type="button" class="btn-secondary" onclick="location.href='${pageContext.request.contextPath}/board/list'">취소</button>
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