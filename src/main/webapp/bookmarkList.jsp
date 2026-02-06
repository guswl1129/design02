<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>북마크 모아보기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/myHeader.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/myList.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookmarkList.css">
    <script src="${pageContext.request.contextPath}/myList.js"></script>
</head>
<body>
	<div class=myHeader> <span onclick="history.back();">&lt;</span>북마크 모아보기</div> <%--공통 css 파일로 빼기--%>
	<%
	@SuppressWarnings("unchecked") 
	List<BoardDTO> bookList = (ArrayList<BoardDTO>)request.getAttribute("bookList");
	if(bookList == null || bookList.isEmpty()){ %>
		<div class="empty-msg">아직 저장한 북마크가 없어요. <br>마음에 드는 도안을 추가해보세요!<%} 
	else{
		for (BoardDTO bookmark : bookList) { %>
		
		<div class="category-box">
			<div class="post-info">
		        <div class="user-group">
		            <span class="user-id"><%=bookmark.getUser_id()%></span>
		            <span class="post-date"><%=bookmark.getRelativeDate()%></span>
		        </div>
		        
		        <span class="bookmark-btn" onclick="toggleBookmark(this, <%=bookmark.getBoard_no()%>)">
		            <img src="${pageContext.request.contextPath}/book_filled.png" class="bookmark-icon">
		        </span>
		    </div>
			<div class="post-title"><%=bookmark.getTitle()%></div>
	    	<div class="post-content"><%=bookmark.getContent()%></div>
	    	<div class="post-stats"><img src="./like_icon.png" id=like_icon> <%=bookmark.getLike_count()%></div>
		</div>
		<%}
	}%>
</body>
</html>