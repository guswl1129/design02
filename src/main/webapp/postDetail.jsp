<%@page import="com.handiboard.dto.UserDTO"%>
<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/postBookmark.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/postDetail.css">
	<script>
	    const contextPath = "${pageContext.request.contextPath}";
	</script>
    <script src="${pageContext.request.contextPath}/myList.js"></script>
<meta charset="UTF-8">
<title>커뮤니티</title>
</head>
<body>
	<%
	BoardDTO dto=(BoardDTO)request.getAttribute("dto");
	UserDTO user=(UserDTO)session.getAttribute("user");
	%>
	
	<%
	dto=(BoardDTO)request.getAttribute("dto");
	
	if (dto==null){
	%>
	<div class="no-post">해당 글이 없습니다.</div>
	<%
	} else{
	%>
	
	<div class="right-btn">
		<button class="back-btn" onclick="location.href='${pageContext.request.contextPath}/board'">리스트로 돌아가기</button>
		<br>
		<%System.out.println("detail.jsp: "+dto.getBoard_no()); %>
		<button class="edit-btn" type="button" onclick="location.href='./update?board_no=<%=dto.getBoard_no() %>'">수정</button>
		<button class="del-btn" type="button" onclick="location.href='./delete?board_no=<%=dto.getBoard_no() %>'">삭제</button>
	</div>
	
	<div class="post">
		<div class="post-header" style="position: relative">
			<h2><%=dto.getTitle() %></h2>
			<span class="bookmark-btn" 
		    	  data-db-error="${dbError}"
		    	  data-is-bookmarked="${isBookmarked}"
		    	  onclick="toggleBookmark(this, <%=dto.getBoard_no() %>)">
	           <img src="${pageContext.request.contextPath}/${isBookmarked == 1 ? 'book_filled.png' : 'book_empty.png'}" class="bookmark-icon" alt="북마크">
	    	</span>
    	</div>
		<div class="post-content">
			작성자 : <%=dto.getUser_nickname() %>
			<br>
			작성일 : <%=dto.getDate() %>
			<br>
			<br>
				<%=dto.getContent() %>
			<br>
			<br>
			조회수 : <%=dto.getView_count() %>
			<br>
		</div>
			<form class="like" action="./like" method="post">
	            <input type="hidden" name="board_no" value="<%=dto.getBoard_no() %>"></input>
	            <input type="hidden" name="user_id" value="<%=dto.getUser_id() %>"></input>
				<button class="like-btn">좋아요</button> : <%=dto.getLike_count() %>
	        </form>
	</div>
	<%} %>
</body>
</html>