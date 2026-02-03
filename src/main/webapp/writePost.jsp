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
	<button style="align-self: right" onclick="location.href='./board'">리스트로 돌아가기</button>
	<form action="./writeAction" method="post">
		<input type="text" name="title" placeholder="제목을 입력하세요">
		<textarea name="content"></textarea>
		<input type="text" name="user_id" placeholder="작성자를 입력하세요">
		<button type="submit">저장</button>
	</form>
</body>
</html>