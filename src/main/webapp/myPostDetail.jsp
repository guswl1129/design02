<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
body {
    display: flex;
    justify-content: center;
    margin-top: 50px;
}

.wrap {
    width: 700px;
    border: 2px solid black;
    padding: 20px;
}

.title {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 10px;
}

.info {
    color: gray;
    margin-bottom: 15px;
}

.content {
    min-height: 200px;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    padding: 15px 0;
}

.footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 15px;
}

.stats {
    font-size: 14px;
}

.buttons button {
    margin-left: 8px;
    padding: 6px 12px;
    cursor: pointer;
}
</style>
</head>
	<body>
	
	<%
	BoardDTO dto = (BoardDTO) request.getAttribute("details");
	%>
	
	<div class="wrap">
	    <div class="title"><%= dto.getTitle() %></div>
	    <div class="info">
	        작성일: <%= dto.getDate() %>
	        <%if(dto.getUpdated_date()!=null){ %>
	        수정일: <%=dto.getUpdated_date() %>
	        <%} %>
	    </div>
	
	    <div class="content">
	        <%= dto.getContent() %>
	    </div>
	
	    <div class="footer">
	        <div class="stats">
	            ❤️ 좋아요:<%= dto.getLike_count() %> |
	            👁 조회수:<%= dto.getView_count() %>
	        </div>
	
	        <div class="buttons">
	            <button onclick="location.href='postDetailController?board_no=<%=dto.getBoard_no()%>&mode=edit'">수정</button>
	            <button onclick="location.href='myDeletePostController?board_no=<%=dto.getBoard_no()%>'">삭제</button>
	            <button onclick="location.href='myPostsController'">목록으로</button>
	        </div>
	    </div>
	</div>
	
	</body>
</html>
