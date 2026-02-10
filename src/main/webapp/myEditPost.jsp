<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정하기</title>
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

.content textarea{
    width: 100%;
    min-height:200px;
}

.footer {
    display: flex;
    justify-content: flex-end;
    margin-top: 15px;
}


.footer button {
    margin-left: 10px;
    padding: 6px 12px;
    cursor: pointer;
}
</style>
</head>
	<body>
	
	<%
	BoardDTO dto = (BoardDTO) request.getAttribute("details");
	
	if (dto == null) {
	%>
	    <p>게시글 정보를 불러오지 못했습니다.</p>
	<%
	    return;
	}
	%>
	
	<div class="wrap">
	    <form action="myEditPostController" method="post">
		    <input type="hidden" name="board_no" value="<%= dto.getBoard_no() %>">
		
		    <div class="title">제목:
		        <input type="text" name="title" value="<%= dto.getTitle() %>" style="width:100%;" required>
		    </div>
		
		    <div class="info">
		        작성일: <%= dto.getDate() %>
		    </div>
		
		    <div class="content">
		        <textarea name="content" required><%= dto.getContent() %></textarea>
		    </div>
		
		    <div class="footer">
		        <button type="submit">저장</button>
		        <button type="button" onclick="location.href='postDetailController?board_no=<%=dto.getBoard_no()%>'">취소</button>
		    </div>
		</form>

	</div>
	
	</body>
</html>
