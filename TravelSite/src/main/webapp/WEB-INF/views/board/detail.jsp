<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 700px; margin: 40px auto; }
        .info { color: #888; font-size: 14px; margin-bottom: 20px; }
        .content { border-top: 1px solid #ddd; border-bottom: 1px solid #ddd; padding: 20px 0; min-height: 150px; }
        .btn-group { margin-top: 20px; text-align: right; }

        .comment-section { margin-top: 40px; }
        .comment-section h3 { font-size: 16px; margin-bottom: 16px; }
        .comment-form { display: flex; gap: 8px; margin-bottom: 20px; }
        .comment-form input {
            flex: 1; padding: 10px 14px; border: 1px solid #ddd; border-radius: 20px; font-size: 14px;
        }
        .comment-form button {
            padding: 10px 20px; background: #2d7ff9; color: white; border: none;
            border-radius: 20px; cursor: pointer; font-size: 14px;
        }
        .comment-list { list-style: none; padding: 0; }
        .comment-item {
            padding: 12px 0; border-bottom: 1px solid #f0f0f0;
            display: flex; justify-content: space-between; align-items: flex-start;
        }
        .comment-body { flex: 1; }
        .comment-author { font-weight: bold; font-size: 13px; margin-right: 8px; }
        .comment-date { color: #aaa; font-size: 12px; }
        .comment-content { margin-top: 4px; font-size: 14px; }
        .comment-delete {
            background: none; border: none; color: #ccc; cursor: pointer; font-size: 12px;
        }
        .comment-delete:hover { color: #ff5555; }
        .comment-empty { color: #999; text-align: center; padding: 20px 0; font-size: 14px; }
        .login-notice { color: #999; font-size: 13px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <h2>${board.title}</h2>
    <div class="info">
        작성자: ${board.memberName} | 지역: ${board.region} | 조회수: ${board.viewCnt} |
        <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm" />
    </div>

    <div class="content">
        ${board.content}
    </div>

    <div class="btn-group">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/modify?boardId=${board.boardId}'">수정</button>
        <button type="button" onclick="deletePost(${board.boardId})">삭제</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/list'">목록</button>
    </div>

    <!-- 댓글 영역 -->
    <div class="comment-section">
        <h3>💬 댓글 <span id="commentCount">0</span>개</h3>

        <c:choose>
            <c:when test="${not empty sessionScope.loginMember}">
                <div class="comment-form">
                    <input type="text" id="commentInput" placeholder="댓글을 입력하세요..." maxlength="500">
                    <button onclick="submitComment()">등록</button>
                </div>
            </c:when>
            <c:otherwise>
                <p class="login-notice">
                    댓글을 작성하려면 <a href="${pageContext.request.contextPath}/member/login">로그인</a>이 필요합니다.
                </p>
            </c:otherwise>
        </c:choose>

        <ul class="comment-list" id="commentList"></ul>
    </div>

    <script>
        var boardId = ${board.boardId};
        var loginMemberId = ${not empty sessionScope.loginMember ? sessionScope.loginMember.memberId : 0};
        var contextPath = '${pageContext.request.contextPath}';

        function loadComments() {
            $.ajax({
                url: contextPath + '/comment/list',
                type: 'GET',
                data: { boardId: boardId },
                dataType: 'json',
                success: function(comments) {
                    renderComments(comments);
                }
            });
        }

        function renderComments(comments) {
            var $list = $('#commentList');
            $list.empty();
            $('#commentCount').text(comments.length);

            if (comments.length === 0) {
                $list.append('<li class="comment-empty">아직 댓글이 없습니다. 첫 댓글을 남겨보세요!</li>');
                return;
            }

            comments.forEach(function(c) {
                var deleteBtn = (loginMemberId === c.memberId)
                    ? '<button class="comment-delete" onclick="deleteComment(' + c.commentId + ')">삭제</button>'
                    : '';

                var $item = $(
                    '<li class="comment-item">' +
                        '<div class="comment-body">' +
                            '<span class="comment-author">' + escapeHtml(c.memberName) + '</span>' +
                            '<span class="comment-date">' + formatDate(c.regDate) + '</span>' +
                            '<div class="comment-content"></div>' +
                        '</div>' +
                        deleteBtn +
                    '</li>'
                );
                $item.find('.comment-content').text(c.content); // XSS 방지 위해 text()로 삽입
                $list.append($item);
            });
        }

        function submitComment() {
            var content = $('#commentInput').val().trim();
            if (content === '') return;

            $.ajax({
                url: contextPath + '/comment/write',
                type: 'POST',
                data: { boardId: boardId, content: content },
                success: function(res) {
                    if (res === 'fail:login') {
                        alert('로그인이 필요합니다.');
                        location.href = contextPath + '/member/login';
                        return;
                    }
                    $('#commentInput').val('');
                    loadComments();
                },
                error: function() {
                    alert('댓글 등록에 실패했습니다.');
                }
            });
        }

        function deleteComment(commentId) {
            if (!confirm('댓글을 삭제하시겠습니까?')) return;

            $.ajax({
                url: contextPath + '/comment/delete',
                type: 'POST',
                data: { commentId: commentId },
                success: function() {
                    loadComments();
                }
            });
        }

        function deletePost(boardId) {
            if (confirm("정말 삭제하시겠습니까?")) {
                location.href = contextPath + "/board/delete?boardId=" + boardId;
            }
        }

        // 엔터키로 댓글 등록
        $(document).on('keypress', '#commentInput', function(e) {
            if (e.which === 13) {
                submitComment();
            }
        });

        function escapeHtml(str) {
            return $('<div>').text(str).html();
        }

        function formatDate(dateStr) {
            var d = new Date(dateStr);
            var pad = function(n) { return n < 10 ? '0' + n : n; };
            return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()) + ' ' +
                   pad(d.getHours()) + ':' + pad(d.getMinutes());
        }

        // 페이지 로드 시 댓글 불러오기
        $(function() {
            loadComments();
        });
    </script>
</body>
</html>