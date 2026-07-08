<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행 커뮤니티 - TravelSite</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Malgun Gothic', sans-serif; margin: 0; color: #333; }
        
        .header {
            display: flex; justify-content: space-between; align-items: center;
            padding: 16px 40px; border-bottom: 1px solid #eee;
        }
        .logo { font-size: 22px; font-weight: bold; color: #2d7ff9; text-decoration: none; }
        .nav a { margin-left: 20px; text-decoration: none; color: #333; font-size: 14px; }

        .hero {
            background: linear-gradient(135deg, #2d7ff9, #6fb3ff);
            color: white; text-align: center; padding: 80px 20px;
        }
        .hero h1 { font-size: 36px; margin-bottom: 10px; }
        .hero p { font-size: 16px; opacity: 0.9; margin-bottom: 30px; }
        .hero-btn {
            display: inline-block; background: white; color: #2d7ff9;
            padding: 12px 28px; border-radius: 30px; text-decoration: none; font-weight: bold;
        }

        .section { max-width: 900px; margin: 50px auto; padding: 0 20px; }
        .section h2 { font-size: 22px; margin-bottom: 20px; border-left: 4px solid #2d7ff9; padding-left: 10px; }

        .board-list { list-style: none; padding: 0; }
        .board-list li {
            display: flex; justify-content: space-between; padding: 14px 10px;
            border-bottom: 1px solid #eee;
        }
        .board-list a { text-decoration: none; color: #333; }
        .board-list a:hover { color: #2d7ff9; }
        .meta { color: #999; font-size: 13px; }

        .empty { color: #999; text-align: center; padding: 30px 0; }

        .features {
            display: flex; gap: 20px; text-align: center; margin-top: 20px;
        }
        .feature-box {
            flex: 1; padding: 30px 20px; background: #f7f9fc; border-radius: 10px;
        }
        .feature-box .icon { font-size: 32px; margin-bottom: 10px; }
        .feature-box h3 { margin: 8px 0; font-size: 16px; }
        .feature-box p { font-size: 13px; color: #777; }

        .footer {
            text-align: center; padding: 30px; color: #999; font-size: 13px;
            border-top: 1px solid #eee; margin-top: 60px;
        }
    </style>
</head>
<body>

    <div class="header">
        <a href="${pageContext.request.contextPath}/" class="logo">✈ TravelSite</a>
        <div class="nav">
    <a href="${pageContext.request.contextPath}/board/list">게시판</a>
    <a href="${pageContext.request.contextPath}/preference/dashboard">취향통계</a>
        <a href="${pageContext.request.contextPath}/chat/ask">AI 상담</a>
    
    <c:choose>
        <c:when test="${not empty sessionScope.loginMember}">
            <a href="${pageContext.request.contextPath}/preference/survey">취향설문</a>
            <a href="#">${sessionScope.loginMember.name}님</a>
            <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/member/login">로그인</a>
            <a href="${pageContext.request.contextPath}/member/join">회원가입</a>
        </c:otherwise>
    </c:choose>
</div>
    </div>

    <div class="hero">
        <h1>당신의 다음 여행을 찾아보세요</h1>
        <p>여행 후기부터 코스 공유, AI 여행 상담까지 한 곳에서</p>
        <a href="${pageContext.request.contextPath}/board/list" class="hero-btn">게시판 둘러보기</a>
    </div>

    <div class="section">
        <h2>최신 여행 후기</h2>
        <c:choose>
            <c:when test="${empty recentBoards}">
                <div class="empty">아직 등록된 게시글이 없습니다. 첫 번째 후기를 남겨보세요!</div>
            </c:when>
            <c:otherwise>
                <ul class="board-list">
                    <c:forEach var="board" items="${recentBoards}">
                        <li>
                            <a href="${pageContext.request.contextPath}/board/detail?boardId=${board.boardId}">
                                ${board.title}
                            </a>
                            <span class="meta">
                                ${board.memberName} · ${board.region} · 
                                <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />
                            </span>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="section">
        <h2>이런 걸 할 수 있어요</h2>
        <div class="features">
            <div class="feature-box">
                <div class="icon">📝</div>
                <h3>여행 후기 공유</h3>
                <p>다녀온 여행지의 생생한 후기를 남겨보세요</p>
            </div>
            <div class="feature-box">
                <div class="icon">📊</div>
                <h3>취향 분석</h3>
                <p>회원들의 여행 취향을 그래프로 확인해요</p>
            </div>
            <div class="feature-box">
                <div class="icon">🤖</div>
                <h3>AI 여행 상담</h3>
                <p>궁금한 여행 정보를 AI에게 물어보세요</p>
            </div>
        </div>
    </div>

    <div class="footer">
        © 2026 TravelSite. 개인 포트폴리오 프로젝트입니다.
    </div>

</body>
</html>