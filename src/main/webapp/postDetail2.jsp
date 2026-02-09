<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.handiboard.dto.BoardDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
body {
    display: flex;
    justify-content: center;
    background-color: #f9f9f9;
    margin: 0;
}

.wrap {
    width: 700px;
    background: white;
    border: 1px solid #ccc;
    padding: 20px;
    margin-top: 50px;
}

.title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
}

.meta {
    font-size: 14px;
    color: gray;
    margin-bottom: 20px;
}

.content {
    font-size: 16px;
    line-height: 1.6;
    white-space: pre-wrap; /* 줄바꿈 유지 */
    margin-bottom: 30px;
}

.stats {
    font-size: 14px;
    color: #555;
    margin-bottom: 20px;
}

.buttons {
    text-align: right;
}

.buttons button {
    padding: 8px 14px;
    cursor: pointer;
}
.footer {
    display: flex;
    justify-content: space-between; /* 양쪽 끝 정렬 */
    align-items: center;
    margin-top: 20px;
}


</style>
</head>
<body>
	<%
	    BoardDTO dto = (BoardDTO) request.getAttribute("details");
	%>
	
	<div class="wrap">
	    <% if (dto != null) { %>
	        <div class="title"><%= dto.getTitle() %></div>
	
	        <div class="meta">
	            작성일: <%= dto.getDate() %>
	        </div>
	
	        <div class="content">
	            <%= dto.getContent() %>
	        </div>
	        
		<div class="footer">
		        <div class="stats">
		            ❤️ 좋아요: <%= dto.getLike_count() %> |
		            👁 조회수: <%= dto.getView_count() %>
		        </div>
		
		        <div class="buttons">
		            <button onclick="history.back()">목록으로</button>
		        </div>
	        </div>
	    <% } else { %>
	        <p>게시글 정보를 불러오지 못했습니다.</p>
	        <button onclick="history.back()">돌아가기</button>
	    <% } %>
	</div>

</body>
</html>
