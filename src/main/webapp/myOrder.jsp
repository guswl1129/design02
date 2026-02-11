<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.handiboard.dto.OrderDTO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 주문 내역</title>
    <style>
        table { width: 80%; border-collapse: collapse; margin: 20px auto; font-family: sans-serif; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
    <h2 style="text-align: center;"> 나의 주문 내역</h2>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>상품명</th>
                <th>결제금액</th>
                <th>주문일자</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orderList");
                int no = 1;

                if (orderList != null && !orderList.isEmpty()) {
                    for (OrderDTO order : orderList) {
            %>
                        <tr>
                            <td><%= no++ %></td>
                            <td><%= order.getItem_name() %></td>
                            <td><%= order.getItem_price() %>원</td>
                            <td><%= order.getOrder_date() %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="4">주문 내역이 없습니다.</td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
