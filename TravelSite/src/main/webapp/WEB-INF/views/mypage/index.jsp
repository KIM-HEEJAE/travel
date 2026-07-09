<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; max-width: 800px; margin: 40px auto; }
        h2 { margin-bottom: 30px; }
        .top-link { margin-bottom: 20px; }
        .top-link a { text-decoration: none; color: #999; font-size: 13px; }

        .profile-card {
            background: #f7f9fc; border-radius: 12px; padding: 24px; margin-bottom: 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .profile-info div { margin-bottom: 6px; font-size: 14px; }
        .profile-info .name { font-size: 20px; font-weight: bold; margin-bottom: 10px; }

        .section { margin-bottom: 40px; }
        .section h3 { border-left: 4px solid #2d7ff9; padding-left: 10px; margin-bottom: 16px; }

        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border-bottom: 1px solid #eee; text-align: center; }
        th { background: #f5f5f5; font-size: 13px; }
        td a { text-decoration: none; color: #333; }
        td a:hover { color: #2d7ff9; }
        .empty { text-align: center; color: #999; padding: 30px 0; }

        .pref-tags { display: flex; gap: 10px; flex-wrap: wrap; }
        .pref-tag {
            background: #eaf2ff; color: #2d7ff9; padding: 8px 16px; border-radius: 20px; font-size: 14px;
        }
        .no-pref { color: #999; font-size: 14px; }
        .no-pref a { color: #2d7ff9; }
    </style>
</head>
<body>
    <div class="top-link">
        <a href="${pageContext.request.contextPath}/board/list">← 게시판으로 돌아가기</a>
    </div>

    <h2>마이페이지</h2>

    <div class="profile-card">
        <div class="profile-info">
            <div class="name">${member.name}님</div>
            <div>아이디: ${member.userId}</div>
            <div>이메일: ${member.email}</div>
            <div>가입일: <fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd" /></div>
        </div>
    </div>

    <div class="section">
        <h3>🌏 내 여행 취향</h3>
        <c:choose>
            <c:when test="${not empty myPref}">
                <div class="pref-tags">
                    <span class="pref-tag">${myPref.travelStyle}</span>
                    <span class="pref-tag">${myPref.budgetRange}</span>
                    <span class="pref-tag">${myPref.preferDomestic}</span>
                </div>
            </c:when>
            <c:otherwise>
                <p class="no-pref">
                    아직 취향 설문을 안 하셨네요! 
                    <a href="${pageContext.request.contextPath}/preference/survey">지금 설문하러 가기</a>
                </p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="section">
        <h3>📝 내가 쓴 게시글 (${fn:length(myBoards)}개)</h3>
        <c:choose>
            <c:when test="${empty myBoards}">
                <div class="empty">아직 작성한 게시글이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>제목</th>
                        <th>지역</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                    <c:forEach var="board" items="${myBoards}">
                        <tr>
                            <td style="text-align: left;">
                                <a href="${pageContext.request.contextPath}/board/detail?boardId=${board.boardId}">
                                    ${board.title}
                                </a>
                            </td>
                            <td>${board.region}</td>
                            <td>${board.viewCnt}</td>
                            <td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>