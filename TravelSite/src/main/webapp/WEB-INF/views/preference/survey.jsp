<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행 취향 설문</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 600px; margin: 50px auto; }
        h2 { text-align: center; }
        .desc { text-align: center; color: #888; margin-bottom: 30px; }
        .option-group { margin-bottom: 30px; }
        .option-group label.title { display: block; font-weight: bold; margin-bottom: 12px; font-size: 16px; }
        .options { display: flex; gap: 10px; flex-wrap: wrap; }
        .option-btn {
            flex: 1; min-width: 100px; padding: 14px; text-align: center;
            border: 2px solid #ddd; border-radius: 10px; cursor: pointer;
            transition: all 0.2s;
        }
        .option-btn:hover { border-color: #2d7ff9; }
        .option-btn.selected { border-color: #2d7ff9; background: #eaf2ff; color: #2d7ff9; font-weight: bold; }
        .option-btn input { display: none; }
        .submit-btn {
            width: 100%; padding: 14px; background: #2d7ff9; color: white;
            border: none; border-radius: 10px; font-size: 16px; cursor: pointer; margin-top: 20px;
        }
        .submit-btn:disabled { background: #ccc; cursor: not-allowed; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />


    <h2>✈ 여행 취향 설문</h2>
    <p class="desc">당신의 여행 취향을 알려주세요! 다른 회원들과 통계로 비교해볼 수 있어요.</p>

    <form action="${pageContext.request.contextPath}/preference/save" method="post" id="surveyForm">

        <div class="option-group">
            <label class="title">1. 선호하는 여행 스타일은?</label>
            <div class="options">
                <label class="option-btn" data-name="travelStyle" data-value="자연">
                    <input type="radio" name="travelStyle" value="자연" required> 🌿 자연
                </label>
                <label class="option-btn" data-name="travelStyle" data-value="도심">
                    <input type="radio" name="travelStyle" value="도심"> 🏙 도심
                </label>
                <label class="option-btn" data-name="travelStyle" data-value="휴양">
                    <input type="radio" name="travelStyle" value="휴양"> 🏖 휴양
                </label>
                <label class="option-btn" data-name="travelStyle" data-value="액티비티">
                    <input type="radio" name="travelStyle" value="액티비티"> 🏄 액티비티
                </label>
            </div>
        </div>

        <div class="option-group">
            <label class="title">2. 여행 예산대는?</label>
            <div class="options">
                <label class="option-btn" data-name="budgetRange" data-value="저예산">
                    <input type="radio" name="budgetRange" value="저예산" required> 💸 저예산
                </label>
                <label class="option-btn" data-name="budgetRange" data-value="중간">
                    <input type="radio" name="budgetRange" value="중간"> 💰 중간
                </label>
                <label class="option-btn" data-name="budgetRange" data-value="고예산">
                    <input type="radio" name="budgetRange" value="고예산"> 💎 고예산
                </label>
            </div>
        </div>

        <div class="option-group">
            <label class="title">3. 국내 여행 vs 해외 여행?</label>
            <div class="options">
                <label class="option-btn" data-name="preferDomestic" data-value="국내">
                    <input type="radio" name="preferDomestic" value="국내" required> 🇰🇷 국내
                </label>
                <label class="option-btn" data-name="preferDomestic" data-value="해외">
                    <input type="radio" name="preferDomestic" value="해외"> 🌍 해외
                </label>
            </div>
        </div>

        <button type="submit" class="submit-btn">제출하고 통계 보러가기</button>
    </form>

    <script>
        // 선택지 클릭하면 스타일 표시 + 라디오 체크
        document.querySelectorAll('.option-btn').forEach(function(btn) {
            btn.addEventListener('click', function() {
                var name = btn.dataset.name;
                // 같은 그룹의 다른 버튼 선택 해제
                document.querySelectorAll('.option-btn[data-name="' + name + '"]').forEach(function(b) {
                    b.classList.remove('selected');
                });
                btn.classList.add('selected');
                btn.querySelector('input').checked = true;
            });
        });
    </script>
</body>
</html>