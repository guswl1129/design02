<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/writePost.css">
</head>
<body>

	<!-- 글쓰기 화면: get/ db에 글쓰기: post -->
	
	<%
	String userId=null;
	userId = (String) session.getAttribute("userId");
	%>
	
<section class="write-section">

	<div class="right-btn">
		<button class="back-btn" onclick="history.back()">리스트로 돌아가기</button>
	</div>
	<br>
    <br>
	<form class="write-form" action="./write" method="post">
		<div class="writer">작성자 : <%=userId %></div>
		<input class="write-title" type="text" name="title" placeholder="제목을 입력하세요">
		<br>
		<textarea class="write-content" name="content" placeholder="내용을 입력하세요"></textarea>
		<br>
		<input type="hidden" name="userId" value="<%=userId %>"></input>
		<div class="right-btn">
			<button class="submit-btn" type="submit">저장</button>
		</div>
	</form>

</section>

</body>
</html>