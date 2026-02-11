<%@page import="com.handiboard.util.PagingResult"%>
<%@page import="com.handiboard.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/community.css">
<title>Insert title here</title>
</head>
<body>
	<!-- servlet에서 보낸 값 받기 -->
	<%
	// 값 받기
	List<BoardDTO> list=(List<BoardDTO>)request.getAttribute("list");
	PagingResult pageResult=(PagingResult)request.getAttribute("pagingResult");
	String searchWord=(String)request.getAttribute("searchWord");
	String searchType=(String)request.getAttribute("searchType");
	HttpSession sessions=request.getSession();
	%>
	
	<%-- 상단 네비게이션 바 불러오기 --%>
	<%@ include file="/nav.jsp" %>
	
	<h1>커뮤니티 게시판</h1>
	
	<div class=rightButton>
		<form action="./board" method="get" style="display: inline;">
		    <select name="searchType" id="searchType">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="user_id">글쓴이</option>
                <option value="all">전체</option>
            </select>
			<input type="text" id="searchWord" name="searchWord" placeholder="검색어 입력">
			<input type="submit" value="검색">
		</form>
		<button type="button" onclick="location.href='./write'">글쓰기</button>
	</div>
	<br>
	<table class="board-table">
		<tr class="board-tr">
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>좋아요</th>
			<th>날짜</th>
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
			<td><%=dto.getView_count() %></td>
			<td><%=dto.getLike_count() %></td>
			<td><%=dto.getDate() %></td>
		</tr>
		<%} %>
		
	</table>
	
	<br>
	<!-- page -->
	<!-- 검색어x -->
	<%	if(searchWord==null || searchWord.equals("")) { %>
		<div align="center">
			<%	if(pageResult.isHasPrevious())  {%>
				<a href="./board?page=<%=pageResult.getStartPage()-1%>&pageSize=<%=pageResult.getPageSize()%>">이전</a>
			<%  }%>
			<%for(int i=pageResult.getStartPage(); i<=pageResult.getEndPage(); i++)  {	%>
				<a href="./board?page=<%=i %>&pageSize=<%=pageResult.getPageSize()%>"><%=i %></a>
			<%	}%>
			<%	if(pageResult.isHasNext()) {%>
				<a href="./board?page=<%=pageResult.getEndPage()+1%>&pageSize=<%=pageResult.getPageSize()%>">이후</a>
			<%	}%>
		</div>
	<%	} else {%>
	<!-- 검색어o -->
		<div align="center">
			<%	if(pageResult.isHasPrevious())  {%>
				<a href="./board?page=<%=pageResult.getStartPage()-1%>&pageSize=<%=pageResult.getPageSize()%>&searchType=<%=searchType%>&searchWord=<%=searchWord%>">이전</a>
			<%  }%>
			<%for(int i=pageResult.getStartPage(); i<=pageResult.getEndPage(); i++)  {	%>
				<a href="./board?page=<%=i %>&pageSize=<%=pageResult.getPageSize()%>&searchType=<%=searchType%>&searchWord=<%=searchWord%>"><%=i %></a>
			<%	}%>
			<%	if(pageResult.isHasNext()) {%>
				<a href="./board?page=<%=pageResult.getEndPage()+1%>&pageSize=<%=pageResult.getPageSize()%>&searchType=<%=searchType%>&searchWord=<%=searchWord%>">이후</a>
			<%	}%>
		</div>
	<%	} %>
	
</body>
</html>