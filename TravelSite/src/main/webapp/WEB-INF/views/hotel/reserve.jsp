<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 예약</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 500px; margin: 50px auto; }
        h2 { text-align: center; }
        .summary {
            background: #f7f9fc; border-radius: 12px; padding: 20px; margin-bottom: 24px;
        }
        .summary .name { font-size: 18px; font-weight: bold; margin-bottom: 8px; }
        .summary div { font-size: 14px; color: #555; margin-bottom: 4px; }

        label { font-weight: bold; display: block; margin-bottom: 6px; margin-top: 16px; }
        input[type=text], input[type=date] {
            width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box;
        }
        .date-row { display: flex; gap: 10px; }
        .date-row > div { flex: 1; }

        .price-box {
            background: #eaf2ff; border-radius: 10px; padding: 16px; margin-top: 20px;
        }
        .price-box .nights { font-size: 14px; color: #555; margin-bottom: 6px; }
        .price-box .total { font-size: 22px; font-weight: bold; color: #2d7ff9; }
        .error-msg { color: #ff5555; font-size: 13px; margin-top: 8px; display: none; }

        button {
            width: 100%; padding: 14px; background: #2d7ff9; color: white; border: none;
            border-radius: 8px; font-size: 16px; cursor: pointer; margin-top: 24px;
        }
        button:disabled { background: #ccc; cursor: not-allowed; }
        .server-error { color: #ff5555; background: #ffefef; padding: 12px; border-radius: 8px; margin-bottom: 16px; font-size: 14px; }
    </style>
</head>
<body>
    <h2>숙소 예약</h2>

    <c:if test="${not empty error}">
        <div class="server-error">${error}</div>
    </c:if>

    <div class="summary">
        <div class="name">${hotel.hotelName}</div>
        <div>${hotel.location} · ${hotel.hotelType} · ★ ${hotel.rating}</div>
        <div><fmt:formatNumber value="${hotel.pricePerNight}" pattern="#,###" />원 / 1박</div>
    </div>

    <form action="${pageContext.request.contextPath}/hotel/reserveProc" method="post" id="reserveForm">
        <input type="hidden" name="hotelId" value="${hotel.hotelId}">

        <div class="date-row">
            <div>
                <label>체크인</label>
                <input type="date" name="checkIn" id="checkIn" required>
            </div>
            <div>
                <label>체크아웃</label>
                <input type="date" name="checkOut" id="checkOut" required>
            </div>
        </div>
        <div class="error-msg" id="dateError">체크아웃 날짜는 체크인 날짜보다 늦어야 합니다 (최소 1박).</div>

        <label>예약자 이름</label>
        <input type="text" name="guestName" placeholder="예약자 성함을 입력하세요" required>

        <div class="price-box">
            <div class="nights">숙박 일수: <span id="nightsText">-</span></div>
            <div class="total">총 <span id="totalPrice">0</span>원</div>
        </div>

        <button type="submit" id="submitBtn" disabled>예약 확정</button>
    </form>

    <script>
        var pricePerNight = ${hotel.pricePerNight};
        var today = new Date().toISOString().split('T')[0];

        // 체크인 날짜는 오늘 이후만 선택 가능
        $('#checkIn').attr('min', today);

        $('#checkIn').on('change', function() {
            // 체크아웃 최소값을 체크인 다음날로 설정
            var checkInDate = new Date($(this).val());
            checkInDate.setDate(checkInDate.getDate() + 1);
            var minCheckOut = checkInDate.toISOString().split('T')[0];
            $('#checkOut').attr('min', minCheckOut);
            calculate();
        });

        $('#checkOut').on('change', calculate);

        function calculate() {
            var checkIn = $('#checkIn').val();
            var checkOut = $('#checkOut').val();

            if (!checkIn || !checkOut) return;

            var d1 = new Date(checkIn);
            var d2 = new Date(checkOut);
            var nights = Math.round((d2 - d1) / (1000 * 60 * 60 * 24));

            if (nights < 1) {
                $('#dateError').show();
                $('#nightsText').text('-');
                $('#totalPrice').text('0');
                $('#submitBtn').prop('disabled', true);
                return;
            }

            $('#dateError').hide();
            $('#nightsText').text(nights + '박');
            $('#totalPrice').text((nights * pricePerNight).toLocaleString());
            $('#submitBtn').prop('disabled', false);
        }
    </script>
</body>
</html>