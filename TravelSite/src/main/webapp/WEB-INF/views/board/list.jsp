<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 게시판</title>
<style>
body {
	font-family: 'Malgun Gothic', sans-serif;
	max-width: 900px;
	margin: 40px auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border-bottom: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f5f5f5;
}

a {
	text-decoration: none;
	color: #333;
}

.title-link:hover {
	color: #2d7ff9;
}

.search-box {
	margin-top: 20px;
	text-align: right;
}

.pagination {
	text-align: center;
	margin-top: 20px;
}

.pagination a {
	margin: 0 5px;
	padding: 5px 10px;
	border: 1px solid #ddd;
}

.pagination .current {
	font-weight: bold;
	background-color: #2d7ff9;
	color: white;
}

.write-btn {
	float: right;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<h2>✈ 여행 게시판</h2>
	<div style="text-align: right; margin-bottom: 10px;">
		<c:choose>
			<c:when test="${not empty sessionScope.loginMember}">
				<b>${sessionScope.loginMember.name}</b>님 환영합니다! 
            <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath}/member/login">로그인</a> | 
            <a href="${pageContext.request.contextPath}/member/join">회원가입</a>
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		<a href="${pageContext.request.contextPath}/board/write"
			class="write-btn">
			<button type="button">글쓰기</button>
		</a>
	</div>

	<table>
		<tr>
			<th width="10%">번호</th>
			<th width="45%">제목</th>
			<th width="15%">작성자</th>
			<th width="15%">지역</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="10%">사진</th>

		</tr>
		<c:choose>
			<c:when test="${empty boardList}">
				<tr>
					<td colspan="7">등록된 게시글이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="board" items="${boardList}">
					<tr>
						<td>${board.boardId}</td>
						<td style="text-align: left;"><a class="title-link"
							href="${pageContext.request.contextPath}/board/detail?boardId=${board.boardId}">
								${board.title} </a></td>
						<td>${board.memberName}</td>
						<td>${board.region}</td>
						<td>${board.viewCnt}</td>
						<td><fmt:formatDate value="${board.regDate}"
								pattern="yyyy-MM-dd" /></td>
						<td><c:if test="${not empty board.imagePath}">
								<img
									src="${pageContext.request.contextPath}/image/view?filename=${board.imagePath}"
									style="width: 50px; height: 50px; object-fit: cover; border-radius: 6px;">
							</c:if></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

	<!-- 검색 -->
	<div class="search-box">
		<form action="${pageContext.request.contextPath}/board/list"
			method="get">
			<input type="text" name="keyword" value="${keyword}"
				placeholder="검색어 입력">
			<button type="submit">검색</button>
		</form>
	</div>

	<!-- 페이징 -->
	<div class="pagination">
		<c:if test="${pageUtil.curBlock > 1}">
			<a
				href="${pageContext.request.contextPath}/board/list?curPage=${pageUtil.prevPage}">이전</a>
		</c:if>

		<c:forEach var="i" begin="${pageUtil.blockStart}"
			end="${pageUtil.blockEnd}">
			<c:choose>
				<c:when test="${i == pageUtil.curPage}">
					<span class="current">${i}</span>
				</c:when>
				<c:otherwise>
					<a
						href="${pageContext.request.contextPath}/board/list?curPage=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${pageUtil.curBlock < pageUtil.totBlock}">
			<a
				href="${pageContext.request.contextPath}/board/list?curPage=${pageUtil.nextPage}">다음</a>
		</c:if>
	</div>

</body>
</html>