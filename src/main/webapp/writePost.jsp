<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/community.css">
</head>
<body>

	<h1>write</h1>
	<!-- 글쓰기 화면: get/ db에 글쓰기: post -->
	
	<%
	String userId=null;
	userId = (String) session.getAttribute("userId");
	%>
	
<section class="write-section">

	<div class="rightButton">
		<button class="back" onclick="history.back()">리스트로 돌아가기</button>
	</div>
	<br>
    <br>
	<p>작성자 : <%=userId %></p>
	<form action="./write" method="post" class="write-from">
		<input type="text" name="title" placeholder="제목을 입력하세요" class="write-title">
		<br>
		<textarea name="content" placeholder="내용을 입력하세요" class="write-content"></textarea>
		<br>
		<input type="hidden" name="userId" value="<%=userId %>"></input>
		<div class="rightButton">
			<button type="submit">저장</button>
		</div>
	</form>

</section>

</body>
</html>