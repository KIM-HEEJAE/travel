<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 500px; margin: 50px auto; }
        h2 { text-align: center; }
        label { font-weight: bold; display: block; margin-bottom: 8px; margin-top: 16px; }
        .star-rating { font-size: 32px; cursor: pointer; }
        .star-rating span { color: #ddd; }
        .star-rating span.selected { color: #f2994a; }
        textarea { width: 100%; height: 150px; padding: 10px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; }
        button {
            width: 100%; padding: 14px; background: #2d7ff9; color: white; border: none;
            border-radius: 8px; font-size: 16px; cursor: pointer; margin-top: 24px;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />


    <h2>숙박 리뷰 작성</h2>

    <form action="${pageContext.request.contextPath}/review/insert" method="post" id="reviewForm">
        <input type="hidden" name="hotelResvId" value="${hotelResvId}">
        <input type="hidden" name="hotelId" value="${hotelId}">
        <input type="hidden" name="rating" id="ratingInput" value="5">

        <label>평점</label>
        <div class="star-rating" id="starRating">
            <span data-value="1">★</span><span data-value="2">★</span><span data-value="3">★</span>
            <span data-value="4">★</span><span data-value="5">★</span>
        </div>

        <label>리뷰 내용</label>
        <textarea name="content" placeholder="숙박 경험을 남겨주세요" required></textarea>

        <button type="submit">리뷰 등록</button>
    </form>

    <script>
        // 별점 클릭 처리
        var stars = document.querySelectorAll('#starRating span');
        stars.forEach(function(star) {
            star.addEventListener('click', function() {
                var value = star.dataset.value;
                document.getElementById('ratingInput').value = value;
                stars.forEach(function(s) {
                    s.classList.toggle('selected', s.dataset.value <= value);
                });
            });
        });
        // 기본 5점으로 표시
        stars.forEach(function(s) { s.classList.add('selected'); });
    </script>
</body>
</html>