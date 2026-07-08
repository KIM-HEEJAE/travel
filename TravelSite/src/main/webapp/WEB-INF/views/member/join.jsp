<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <meta charset="UTF-8">
    <title>회원가입</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 500px; margin: 40px auto; }
        input[type=text], input[type=password], input[type=email] {
            width: 100%; padding: 8px; margin: 6px 0 6px 0; box-sizing: border-box;
        }
        label { font-weight: bold; }
        .error { color: red; margin-bottom: 10px; }
        .check-msg { font-size: 13px; margin-bottom: 10px; }
        .ok { color: green; }
        .fail { color: red; }
    </style>
</head>
<body>
    <h2>회원가입</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/member/joinProc" method="post" id="joinForm">
        <label>아이디</label>
        <input type="text" name="userId" id="userId" required>
        <button type="button" id="checkBtn">중복확인</button>
        <div class="check-msg" id="checkMsg"></div>

        <label>비밀번호</label>
        <input type="password" name="password" required>

        <label>이름</label>
        <input type="text" name="name" required>

        <label>이메일</label>
        <input type="email" name="email">

        <br><br>
        <button type="submit">가입하기</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/list'">취소</button>
    </form>

    <script>
        var isChecked = false; // 중복확인 통과 여부

        $('#checkBtn').click(function() {
            var userId = $('#userId').val();
            if (userId === '') {
                alert('아이디를 입력하세요.');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/member/checkUserId',
                type: 'GET',
                data: { userId: userId },
                success: function(isDuplicate) {
                    if (isDuplicate) {
                        $('#checkMsg').text('이미 사용중인 아이디입니다.').removeClass('ok').addClass('fail');
                        isChecked = false;
                    } else {
                        $('#checkMsg').text('사용 가능한 아이디입니다.').removeClass('fail').addClass('ok');
                        isChecked = true;
                    }
                }
            });
        });

        $('#joinForm').submit(function(e) {
            if (!isChecked) {
                alert('아이디 중복확인을 해주세요.');
                e.preventDefault();
            }
        });

        // 아이디 다시 입력하면 중복확인 초기화
        $('#userId').on('input', function() {
            isChecked = false;
            $('#checkMsg').text('');
        });
    </script>
</body>
</html>