<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>write</h1>
	
	<!-- 글쓰기 화면: get/ db에 글쓰기: post -->
	
	<%
	String userId=null;
	userId = (String) session.getAttribute("user_id");
	%>
	
	<button style="align-self: right" onclick="location.href='./board'">리스트로 돌아가기</button>
	<br>
    <br>
	<p>작성자 : <%=userId %></p>
	<form action="./write" method="post">
		<input type="text" name="title" placeholder="제목을 입력하세요">
		<br>
		<textarea name="content" placeholder="내용을 입력하세요"></textarea>
		<br>
		<!-- <input type="text" name="user_id" placeholder="작성자를 입력하세요"> -->
		<input type="hidden" name="user_id" value="<%=userId %>"></input>
		<button type="submit">저장</button>
	</form>
</body>
</html>