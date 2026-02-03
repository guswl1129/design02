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
	<h1>detail</h1>
	
	<%BoardDTO dto=(BoardDTO)request.getAttribute("dto"); %>
	
	<h2>제목</h2>
	<button style="align-self: right" onclick="location.href='./board'">리스트로 돌아가기</button>
	<div  text-align="right">
		<button type="button" onclick="location.href='./update?board_no=<%=dto.getBoard_no() %>'">수정</button>
		<br>
		<button type="button" onclick="location.href='./delete?board_no=<%=dto.getBoard_no() %>'">삭제</button>
	</div>
	
	<br>
	<%
	dto=(BoardDTO)request.getAttribute("dto");
	
	if (dto==null){
	%>
	<p>해당 글이 없습니다.</p>
	<%
	} else{
	%>
		<%=dto.getTitle() %>
	<h3>작성자: </h3>
	<br>
		<%=dto.getUser_id() %>
	<br>
	<h3>작성일: </h3>
	<br>
        <%=dto.getDate() %>
    <br>
	<h3>본문</h3>
	<br>
		<%=dto.getContent() %>
	<%} %>
</body>
</html>