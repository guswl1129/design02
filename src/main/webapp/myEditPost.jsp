<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정하기</title>
<style>
    
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }

    /* 상단 헤더 (일관성 유지) */
    .myHeader {
        width: 100%;
        max-width: 700px;
        background-color: #ffffff;
        padding: 15px 20px;
        display: flex;
        align-items: center;
        box-sizing: border-box;
        border-bottom: 1px solid #eee;
        font-weight: bold;
        font-size: 1.1rem;
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .myHeader span {
        cursor: pointer;
        margin-right: 15px;
        font-size: 1.3rem;
    }

    /* 폼 컨테이너 */
    .wrap {
        width: 100%;
        max-width: 700px;
        background-color: #ffffff;
        margin: 20px 0;
        padding: 30px;
        box-sizing: border-box;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    /* 입력 라벨 스타일 */
    .label {
        font-size: 14px;
        color: #666;
        margin-bottom: 8px;
        display: block;
        font-weight: 600;
    }

    /* 제목 입력창 */
    .title-input {
        width: 100%;
        padding: 12px 15px;
        font-size: 1.2rem;
        font-weight: bold;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        margin-bottom: 20px;
        outline: none;
        transition: border-color 0.2s;
    }

    .title-input:focus {
        border-color: #007bff;
    }

    /* 정보 영역 (작성일 표시) */
    .info {
        font-size: 13px;
        color: #999;
        margin-bottom: 20px;
        padding-left: 5px;
    }

    /* 본문 텍스트 영역 */
    .content textarea {
        width: 100%;
        min-height: 350px;
        padding: 15px;
        font-size: 16px;
        line-height: 1.6;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        resize: vertical; /* 높이 조절만 가능하도록 */
        outline: none;
        transition: border-color 0.2s;
    }

    .content textarea:focus {
        border-color: #007bff;
    }

    /* 하단 버튼 구역 */
    .footer {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 25px;
    }

    .footer button {
        padding: 12px 24px;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        border: none;
        transition: all 0.2s;
    }

    .btn-save {
        background-color: #007bff;
        color: white;
    }

    .btn-save:hover {
        background-color: #0056b3;
    }

    .btn-cancel {
        background-color: #f8f9fa;
        color: #666;
        border: 1px solid #ddd !important;
    }

    .btn-cancel:hover {
        background-color: #e2e6ea;
    }
</style>
</head>
<body>

    <%
    BoardDTO dto = (BoardDTO) request.getAttribute("details");
    if (dto == null) {
    %>
        <div class="wrap" style="text-align: center;">
            <p>게시글 정보를 불러오지 못했습니다.</p>
            <button onclick="history.back()">뒤로 가기</button>
        </div>
    <%
        return;
    }
    %>

    <div class="myHeader"> 
        <span onclick="history.back();">&lt;</span> 게시글 수정하기
    </div>

    <div class="wrap">
        <form action="myEditPostController" method="post">
            <input type="hidden" name="board_no" value="<%= dto.getBoard_no() %>">
        
            <label class="label">제목</label>
            <input type="text" name="title" class="title-input" value="<%= dto.getTitle() %>" placeholder="제목을 입력하세요" required>
        
            <div class="info">
                작성일: <%= dto.getDate() %>
            </div>
        
            <label class="label">내용</label>
            <div class="content">
                <textarea name="content" placeholder="내용을 입력하세요" required><%= dto.getContent() %></textarea>
            </div>
        
            <div class="footer">
                <button type="button" class="btn-cancel" onclick="location.href='postDetailController?board_no=<%=dto.getBoard_no()%>'">취소</button>
                <button type="submit" class="btn-save">저장하기</button>
            </div>
        </form>
    </div>

</body>
</html>