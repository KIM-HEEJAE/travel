<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행 취향 통계 대시보드</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        h2 { text-align: center; margin-bottom: 40px; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; }
        .card {
            border: 1px solid #eee; border-radius: 12px; padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .card h3 { margin-top: 0; text-align: center; font-size: 16px; color: #555; }
        .card-full { grid-column: span 2; }
        .empty { text-align: center; color: #999; padding: 40px 0; }
        .top-btn { text-align: center; margin-bottom: 20px; }
        .top-btn a { text-decoration: none; color: #2d7ff9; }
    </style>
</head>
<body>
    <div class="top-btn">
        <a href="${pageContext.request.contextPath}/board/list">← 게시판으로 돌아가기</a>
    </div>
    <h2>📊 여행 취향 통계 대시보드</h2>

    <div class="grid">
        <div class="card">
            <h3>선호 여행 스타일 (원형 그래프)</h3>
            <canvas id="styleChart"></canvas>
        </div>
        <div class="card">
            <h3>예산대별 분포 (막대 그래프)</h3>
            <canvas id="budgetChart"></canvas>
        </div>
        <div class="card">
            <h3>국내 vs 해외 선호도</h3>
            <canvas id="domesticChart"></canvas>
        </div>
        <div class="card">
            <h3>인기 여행지 TOP5 (게시판 기준)</h3>
            <canvas id="regionChart"></canvas>
        </div>
    </div>

    <script>
        $(function() {
            $.ajax({
                url: '${pageContext.request.contextPath}/preference/statsData',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log(data); // 데이터 구조 확인용
                    renderPieChart('styleChart', data.styleStats, '여행 스타일');
                    renderBarChart('budgetChart', data.budgetStats, '예산대', '#2d7ff9');
                    renderPieChart('domesticChart', data.domesticStats, '국내/해외');
                    renderBarChart('regionChart', data.popularRegions, '지역', '#ff7f50');
                },
                error: function() {
                    alert('통계 데이터를 불러오지 못했습니다.');
                }
            });
        });

        // 데이터 키가 대문자(NAME, COUNT)로 올 수도 있어서 둘 다 대응
        function getName(item) { return item.name || item.NAME; }
        function getCount(item) { return item.count || item.COUNT; }

        function renderPieChart(canvasId, dataList, label) {
            var ctx = document.getElementById(canvasId).getContext('2d');
            if (!dataList || dataList.length === 0) {
                document.getElementById(canvasId).parentElement.innerHTML += '<p class="empty">데이터가 없습니다</p>';
                return;
            }
            var labels = dataList.map(getName);
            var counts = dataList.map(getCount);
            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{
                        data: counts,
                        backgroundColor: ['#2d7ff9', '#ff7f50', '#6fcf97', '#f2c94c', '#bb6bd9']
                    }]
                },
                options: { responsive: true }
            });
        }

        function renderBarChart(canvasId, dataList, label, color) {
            var ctx = document.getElementById(canvasId).getContext('2d');
            if (!dataList || dataList.length === 0) {
                document.getElementById(canvasId).parentElement.innerHTML += '<p class="empty">데이터가 없습니다</p>';
                return;
            }
            var labels = dataList.map(getName);
            var counts = dataList.map(getCount);
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: label,
                        data: counts,
                        backgroundColor: color
                    }]
                },
                options: {
                    responsive: true,
                    scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
                }
            });
        }
    </script>
</body>
</html>