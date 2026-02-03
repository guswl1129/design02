<%@page import="com.handiboard.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>list</h1>
	
	<!-- servlet에서 보낸 값 받기 -->
	<%
	// 값 받기
	List<BoardDTO> list=(List<BoardDTO>)request.getAttribute("list");
	%>
	<h1>게시판</h1>
	<%-- <%=list %> --%>
	
	<table border="1" style="width: 100%">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>날짜</th>
			<th>좋아요</th>
		</tr>
		
		<%
		for(BoardDTO dto : list)
		{
		%>
		<tr>
			<td><%=dto.getBoard_no() %></td>
			<td>
				<a href="./detail?board_no=<%=dto.getBoard_no() %>">
					<%=dto.getTitle() %>
				</a>
			</td>
			<td><%=dto.getUser_id() %></td>
			<td><%=dto.getDate() %></td>
			<td><%=dto.getLike() %></td>
		</tr>
		<%
		}
		%>
	</table>
	
	<button type="button" onclick="location.href='./write'">글쓰기</button>
</body>
</html>