<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행 AI 상담</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 700px; margin: 30px auto; }
        h2 { text-align: center; }
        .desc { text-align: center; color: #888; margin-bottom: 20px; font-size: 14px; }

        .chat-box {
            border: 1px solid #eee; border-radius: 12px; height: 500px;
            overflow-y: auto; padding: 20px; display: flex; flex-direction: column; gap: 12px;
        }

        .msg { max-width: 75%; padding: 12px 16px; border-radius: 16px; line-height: 1.5; font-size: 14px; }
        .msg.user { align-self: flex-end; background: #2d7ff9; color: white; border-bottom-right-radius: 4px; }
        .msg.bot { align-self: flex-start; background: #f1f3f5; color: #333; border-bottom-left-radius: 4px; white-space: pre-wrap; }
        .msg.loading { align-self: flex-start; background: #f1f3f5; color: #999; font-style: italic; }

        .input-area { display: flex; gap: 10px; margin-top: 16px; }
        .input-area input {
            flex: 1; padding: 12px 16px; border: 1px solid #ddd; border-radius: 30px; font-size: 14px;
        }
        .input-area button {
            padding: 12px 24px; background: #2d7ff9; color: white; border: none;
            border-radius: 30px; cursor: pointer; font-size: 14px;
        }
        .input-area button:disabled { background: #ccc; cursor: not-allowed; }

        .example-tags { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 10px; }
        .example-tags span {
            background: #eaf2ff; color: #2d7ff9; padding: 6px 12px; border-radius: 20px;
            font-size: 12px; cursor: pointer;
        }

        .top-link { text-align: center; margin-bottom: 10px; }
        .top-link a { text-decoration: none; color: #999; font-size: 13px; }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />


    <div class="top-link">
        <a href="${pageContext.request.contextPath}/board/list">← 게시판으로 돌아가기</a>
    </div>
    <h2>🤖 여행 AI 상담</h2>
    <p class="desc">여행지 추천, 예산, 일정 등 궁금한 걸 물어보세요!</p>

    <div class="chat-box" id="chatBox">
        <div class="msg bot">안녕하세요! 여행 계획에 대해 무엇이든 물어보세요 😊</div>
    </div>

    <div class="example-tags">
        <span onclick="sendExample('제주도 3박4일 여행 코스 추천해줘')">제주도 3박4일 코스</span>
        <span onclick="sendExample('혼자 가기 좋은 국내 여행지 추천해줘')">혼행 추천지</span>
        <span onclick="sendExample('배낭여행 예산 어떻게 짜야해?')">배낭여행 예산</span>
    </div>

    <div class="input-area">
        <input type="text" id="questionInput" placeholder="메시지를 입력하세요..." maxlength="500">
        <button id="sendBtn" onclick="sendMessage()">전송</button>
    </div>

    <script>
        function appendMessage(text, type) {
            var div = $('<div class="msg ' + type + '"></div>').text(text);
            $('#chatBox').append(div);
            $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
            return div;
        }

        function sendMessage() {
            var question = $('#questionInput').val().trim();
            if (question === '') return;

            appendMessage(question, 'user');
            $('#questionInput').val('');
            $('#sendBtn').prop('disabled', true);

            var loadingMsg = appendMessage('답변을 생각하고 있어요...', 'loading');

            $.ajax({
                url: '${pageContext.request.contextPath}/chat/send',
                type: 'POST',
                data: { question: question },
                dataType: 'json',
                success: function(res) {
                    loadingMsg.remove();
                    appendMessage(res.answer, 'bot');
                },
                error: function() {
                    loadingMsg.remove();
                    appendMessage('오류가 발생했습니다. 잠시 후 다시 시도해주세요.', 'bot');
                },
                complete: function() {
                    $('#sendBtn').prop('disabled', false);
                }
            });
        }

        function sendExample(text) {
            $('#questionInput').val(text);
            sendMessage();
        }

        // 엔터키로 전송
        $('#questionInput').keypress(function(e) {
            if (e.which === 13) {
                sendMessage();
            }
        });
    </script>
</body>
</html>