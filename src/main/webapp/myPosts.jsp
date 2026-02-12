<%@page import="com.handiboard.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 게시글 모아보기</title>
<style type="text/css">
    /* 전체 배경 및 레이아웃 */
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }

    /* 상단 헤더 스타일 (프로필 수정 페이지와 동일) */
    .myHeader {
        width: 100%;
        max-width: 500px;
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

    /* 컨테이너 */
    .wrap-container {
        width: 100%;
        max-width: 500px;
        background-color: #ffffff;
        min-height: calc(100vh - 56px);
        box-sizing: border-box;
        padding: 10px 0;
    }

    /* 리스트 스타일 */
    .post-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .post-item {
        padding: 18px 20px;
        border-bottom: 1px solid #f1f3f5;
        display: flex;
        flex-direction: column;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .post-item:hover {
        background-color: #f8f9fa;
    }

    .post-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 6px;
    }

    .post-num {
        font-size: 0.8rem;
        color: #007bff;
        font-weight: bold;
    }

    .post-date {
        font-size: 0.8rem;
        color: #999;
    }

    .post-title {
        font-size: 1.05rem;
        font-weight: 500;
        color: #333;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis; /* 제목이 길면 ... 처리 */
        margin-top: 10px
    }

    /* 데이터 없을 때 */
    .empty-msg {
        text-align: center;
        padding: 100px 20px;
        color: #bbb;
        font-size: 1rem;
    }

    /* 하단 버튼 구역 */
    .footer-action {
        padding: 20px;
        text-align: center;
    }

    .back-btn {
        width: 100%;
        padding: 14px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: white;
        color: #666;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.2s;
    }

    .back-btn:hover {
        background-color: #f8f9fa;
        color: #333;
    }
    .post-nickname{
    	color: orange;
    	font-size: 0.8rem;
    
    }
    .nickname{
    margin-left: auto;
    margin-top: 10px;
    }
</style>
</head>
<body>
    <%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="myHeader"> 
        <span onclick="location.href='myPage'">&lt;</span> 내 게시글 모아보기
    </div>

<div class="wrap-container">
    <div class="post-list">
        <% 
        List<BoardDTO> myPost = (List<BoardDTO>) request.getAttribute("myPosts");
        
        if (myPost != null && !myPost.isEmpty()) {
            // 1. 순번을 위한 변수를 1로 초기화합니다.
            int seq = 1; 
            for(BoardDTO dto : myPost) {
        %>
        <div class="post-item" onclick="location.href='postDetailController?board_no=<%=dto.getBoard_no()%>'">
            <div class="post-header">
                <span class="post-num">No.<%= seq++ %></span>
                <span class="post-date"><%= dto.getDate() %></span>
            </div>
            <div class="post-title"><%= dto.getTitle() %></div>
            <div class="nickname"><span class="post-nickname"><%= dto.getUser_nickname() %></span></div>
        </div>
        <% 
            }
        } else { 
        %>
        <div class="empty-msg">
            <p>작성된 게시글이 없습니다.</p>
        </div>
        <% 
        } 
        %>
    </div>

        <div class="footer-action">
            <button class="back-btn" onclick="location.href='myPage'">마이페이지로 돌아가기</button>
        </div>
    </div>
</body>
</html>