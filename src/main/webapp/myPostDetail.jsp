<%@page import="com.handiboard.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
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

    .myHeader {
        width: 100%;
        
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

    /* 본문 컨테이너 */
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

    /* 제목 영역 */
    .title {
        font-size: 26px;
        font-weight: 700;
        color: #1a1a1a;
        margin-bottom: 15px;
        line-height: 1.4;
    }

    /* 메타 정보 (작성일, 수정일) */
    .info {
        font-size: 14px;
        color: #888;
        padding-bottom: 20px;
        border-bottom: 1px solid #f1f3f5;
        margin-bottom: 25px;
    }

    .info span {
        margin-right: 15px;
    }

    /* 본문 내용 */
    .content {
        min-height: 300px;
        font-size: 16px;
        line-height: 1.8;
        color: #333;
        word-break: break-all; /* 긴 영문/숫자 줄바꿈 */
    }

    /* 하단 푸터 (통계 및 버튼) */
    .footer {
        margin-top: 40px;
        padding-top: 20px;
        border-top: 1px solid #f1f3f5;
    }

    .stats {
        display: flex;
        gap: 15px;
        font-size: 14px;
        color: #666;
        margin-bottom: 25px;
    }

    .stats b {
        color: #333;
    }

    /* 버튼 그룹 */
    .buttons {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .buttons button {
        padding: 10px 18px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        border: 1px solid #ddd;
        background-color: #fff;
        color: #555;
        transition: all 0.2s;
    }

    /* 버튼별 포인트 컬러 */
    .buttons .btn-edit { background-color: #007bff; color: white; border: none; }
    .buttons .btn-edit:hover { background-color: #0056b3; }

    .buttons .btn-delete { color: #dc3545; }
    .buttons .btn-delete:hover { background-color: #fff5f5; border-color: #dc3545; }

    .buttons .btn-list:hover { background-color: #f8f9fa; border-color: #bbb; }
</style>
</head>
<body>

    <% BoardDTO dto = (BoardDTO) request.getAttribute("details"); %>

    <div class="myHeader"> 
        <span onclick="location.href='myPostsController'">&lt;</span> 게시글 상세보기
    </div>

    <div class="wrap">
        <div class="title"><%= dto.getTitle() %></div>
        
        <div class="info">
            <span><b>작성일</b> <%= dto.getDate() %></span>
            <% if(dto.getUpdated_date() != null) { %>
            <span><b>수정일</b> <%= dto.getUpdated_date() %></span>
            <% } %>
        </div>

        <div class="content">
            <%= dto.getContent().replace("\n", "<br>") %> 
            <%-- 줄바꿈이 적용되도록 처리 --%>
        </div>

        <div class="footer">
            <div class="stats">
                <span>❤️ 좋아요 <b><%= dto.getLike_count() %></b></span>
                <span>👁 조회수 <b><%= dto.getView_count() %></b></span>
            </div>

            <div class="buttons">
                <button class="btn-edit" onclick="location.href='postDetailController?board_no=<%=dto.getBoard_no()%>&mode=edit'">수정하기</button>
                <button class="btn-delete" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='myDeletePostController?board_no=<%=dto.getBoard_no()%>'">삭제</button>
                <button class="btn-list" onclick="location.href='myPostsController'">목록으로</button>
            </div>
        </div>
    </div>

</body>
</html>