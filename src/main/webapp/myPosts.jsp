<%@page import="com.handiboard.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="myPosts.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	display: flex; /* Flexbox 레이아웃 활성화 */
	justify-content: center; /* 가로 방향 중앙 정렬 */
	min-height: 90vh; /* viewport height 화면 전체 높이만큼 확보 */
	margin: 0;
}

.wrap-container {
	position: relative;
	display: inline-block;
}


table {
	border: 2px solid black;
}

th, td {
	border: 1px solid grey;
	padding: 0.5em 1.5em; /*위아래 여백간격, 좌우 여백간격*/
}

th {
	background-color: #e6e6e6;
}

caption {
	margin: 20px;
	size: 20px;
}

th.content {
	width: 300px;
}

td {
	height: 20px;
}

.back-btn {
	position: absolute;
	right: 0;
	bottom: -40px; /* 테두리 바로 아래 */
}

</style>
</head>
<body>
	<div class="wrap-container">
		<div class="wrap">
			<table>
				<caption>내 글</caption>
				<tr>
					<th class="num">번호</th>
					<th class="content">내용</th>
					<th class="date">날짜</th>
				</tr>

				<% 
				List<BoardDTO> myPost = (List<BoardDTO>) request.getAttribute("myPosts");
				
				if (myPost != null && !myPost.isEmpty()) {
				    int index = 1;
				    for(BoardDTO dto : myPost) {
				%>
				<tr onclick="location.href='postDetailController?board_no=<%=dto.getBoard_no()%>'"
				    style="cursor:pointer">
				    <td><%= index++ %></td>
				    <td><%= dto.getTitle() %></td>
				    <td><%= dto.getDate() %></td>
				</tr>
				<% 
				    }
				} else { 
				%>
				<tr>
				    <td colspan="3">작성된 게시글이 없습니다.</td>
				</tr>
				<% 
				} 
				%>
			</table>
		</div>

		<button class="back-btn" onclick="history.back()">이전으로</button>
	</div>
</body>

</html>