<%@page import="com.handiboard.dto.UserDTO"%>
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
	
	<%
	BoardDTO dto=(BoardDTO)request.getAttribute("dto");
	UserDTO user=(UserDTO)session.getAttribute("user");
	%>
	
	<%
	if(dto==null){
		response.sendRedirect("./board");
	}
	
	%>
	
	<div align="right">
		<button onclick="location.href='./board'">리스트로 돌아가기</button>
		<br>
		<%System.out.println("detail.jsp: "+dto.getBoard_no()); %>
		<button type="button" onclick="location.href='./update?board_no=<%=dto.getBoard_no() %>'">수정</button>	<!-- dto is null -->
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
	<h2><%=dto.getTitle() %></h2>
	<p>
		작성자 : <%=dto.getUser_id() %>
		<br>
		작성일 : <%=dto.getDate() %>
		<br>
			<%=dto.getContent() %>
		<br>
		조회수 : <%=dto.getView_count() %>
		<br>
	</p>
		<form action="./like" method="post">
            <input type="hidden" name="board_no" value="<%=dto.getBoard_no() %>"></input>
            <input type="hidden" name="user_id" value="<%=dto.getUser_id() %>"></input>
			<button>좋아요</button> : <%=dto.getLike_count() %>
        </form>

	<%} %>
</body>
</html>