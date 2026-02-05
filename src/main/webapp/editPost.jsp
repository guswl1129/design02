<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.handiboard.dto.BoardDTO" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update</title>
</head>
<body>
	<h1>update</h1>
		
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
			<button style="align-self: right" onclick="location.href='./board'">리스트로 돌아가기</button>
			<form action="./updateAction" method="post">
			    <input type="hidden" name="board_no" value="<%=dto.getBoard_no() %>">
				<input type="text" name="title" value="<%=dto.getTitle() %>">
				<textarea name="content" value=""><%=dto.getContent()%></textarea>
				<input type="hidden" name="user_id" value="<%=dto.getUser_id() %>">
				<p>작성자: <%=dto.getUser_id() %></p>
				<button type="submit">저장</button>
			</form>
		<%
		}
		%>
</body>
</html>