<%@ page import="java.util.List" %>
<%@ page import="com.handiboard.dto.OrderDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 주문 내역</title>
<style type="text/css">
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

    .wrap-container {
        width: 100%;
        max-width: 500px;
        background-color: #ffffff;
        min-height: calc(100vh - 56px);
        box-sizing: border-box;
        padding: 10px 0;
    }

    .order-list {
        padding: 0;
        margin: 0;
    }

    .order-item {
        padding: 18px 20px;
        border-bottom: 1px solid #f1f3f5;
        display: flex;
        flex-direction: column;
        cursor: default;
        transition: background-color 0.2s;
    }

    .order-item:hover {
        background-color: #f8f9fa;
    }

    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 6px;
    }

    .order-num {
        font-size: 0.8rem;
        color: #007bff;
        font-weight: bold;
    }

    .order-date {
        font-size: 0.8rem;
        color: #999;
    }

    .order-title {
        font-size: 1.05rem;
        font-weight: 500;
        color: #333;
        margin-bottom: 4px;
    }

    .order-price {
        font-size: 0.9rem;
        color: #555;
    }

    .empty-msg {
        text-align: center;
        padding: 100px 20px;
        color: #bbb;
        font-size: 1rem;
    }

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
    <span onclick="location.href='myPage'">&lt;</span> 나의 주문 내역
</div>

<div class="wrap-container">
    <div class="order-list">
        <%
            List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orderList");

            if (orderList != null && !orderList.isEmpty()) {
                int seq = 1;
                for (OrderDTO order : orderList) {
        %>
        <div class="order-item">
            <div class="order-header">
                <span class="order-num">No.<%= seq++ %></span>
                <span class="order-date"><%= order.getOrder_date() %></span>
            </div>
            <div class="order-title"><%= order.getItem_name() %></div>
            <div class="order-price"><%= order.getItem_price() %>타래</div>
        </div>
        <%
                }
            } else {
        %>
        <div class="empty-msg">
            <p>주문 내역이 없습니다.</p>
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
