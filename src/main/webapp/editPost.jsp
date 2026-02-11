<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.handiboard.dto.BoardDTO" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/editPost.css">
</head>
<body>
		<%
		BoardDTO dto=(BoardDTO)request.getAttribute("dto");
		if (dto==null){
			System.out.println("dto가 널임");
		%>
			<p>해당 글이 없습니다.</p>
		<%
		} else{
		%>
			<!-- 글쓰기 화면: get/ db에 글쓰기: post -->
		
<section class="update-section">

	<div class="right-btn">
				<button class="back-btn" onclick="location.href='./board'">리스트로 돌아가기</button>
	</div>
	<br>
	<br>
	<form class="update-form" action="./update" method="post">
		<div class="writer">작성자: <%=dto.getUser_id() %></div>
	    <input type="hidden" name="board_no" value="<%=dto.getBoard_no() %>">
		<input class="update-title" type="text" name="title" value="<%=dto.getTitle() %>">
		<br>
		<textarea class="update-content" name="content"><%=dto.getContent()%></textarea>
		<br>
		<input type="hidden" name="user_id" value="<%=dto.getUser_id() %>">
		<div class="right-btn">
			<button class="submit-btn" type="submit">저장</button>
		</div>
	</form>

</section>
			
		<%
		}
		%>
</body>
</html>