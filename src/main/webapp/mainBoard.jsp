<%@page import="com.handiboard.dto.UserDTO"%>
<%@page import="com.handiboard.util.PagingResult"%>
<%@page import="com.handiboard.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/mainBoard.css">
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
	
	<div class=right-btn>
		<form class="search-type" action="./board" method="get">
		    <select name="searchType" id="searchType">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="user_nickname">글쓴이</option>
                <option value="all">전체</option>
            </select>
			<input type="text" id="searchWord" name="searchWord" placeholder="검색어 입력">
			<input class="search-btn" type="submit" value="검색">
		</form>
		<button class="write-btn" type="button" onclick="location.href='./write'">글쓰기</button>
	</div>
	<br>
	<table class="board-table">
		<tr class="board-header">
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
		<tr class="board-content">
			<td><%=dto.getBoard_no() %></td>
			<td>
				<a class="board-title" href="./detail?board_no=<%=dto.getBoard_no() %>">
					<%=dto.getTitle() %>
				</a>
			</td>
			<td><%=dto.getUser_nickname()%></td>
			<td><%=dto.getView_count() %></td>
			<td><%=dto.getLike_count() %></td>
			<td><%=dto.getDate() %></td>
		</tr>
		<%} %>
		
	</table>
	
	<br>
	<!-- page -->
	<!-- 검색어x -->
	<div class="paging-parent">
	
		<%	if(searchWord==null || searchWord.equals("")) { %>
		<div class="paging">
			<%	if(pageResult.isHasPrevious())  {%>
				<a class="paging-link" href="./board?page=<%=pageResult.getStartPage()-1%>&pageSize=<%=pageResult.getPageSize()%>">이전</a>
			<%  }%>
			<%for(int i=pageResult.getStartPage(); i<=pageResult.getEndPage(); i++)  {	%>
				<a class="paging-link" href="./board?page=<%=i %>&pageSize=<%=pageResult.getPageSize()%>"><%=i %></a>
			<%	}%>
			<%	if(pageResult.isHasNext()) {%>
				<a class="paging-link" href="./board?page=<%=pageResult.getEndPage()+1%>&pageSize=<%=pageResult.getPageSize()%>">이후</a>
			<%	}%>
		</div>
	<%	} else {%>
	<!-- 검색어o -->
		<div class="paging">
			<%	if(pageResult.isHasPrevious())  {%>
				<a class="paging-link" href="./board?page=<%=pageResult.getStartPage()-1%>&pageSize=<%=pageResult.getPageSize()%>&searchType=<%=searchType%>&searchWord=<%=searchWord%>">이전</a>
			<%  }%>
			<%for(int i=pageResult.getStartPage(); i<=pageResult.getEndPage(); i++)  {	%>
				<a class="paging-link" href="./board?page=<%=i %>&pageSize=<%=pageResult.getPageSize()%>&searchType=<%=searchType%>&searchWord=<%=searchWord%>"><%=i %></a>
			<%	}%>
			<%	if(pageResult.isHasNext()) {%>
				<a class="paging-link" href="./board?page=<%=pageResult.getEndPage()+1%>&pageSize=<%=pageResult.getPageSize()%>&searchType=<%=searchType%>&searchWord=<%=searchWord%>">이후</a>
			<%	}%>
		</div>
	<%	} %>
	
	</div>
	
</body>
</html>