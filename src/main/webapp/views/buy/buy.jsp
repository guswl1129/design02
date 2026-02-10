<%@page import="com.handiboard.dto.OrderDTO"%>
<%@page import="com.handiboard.dto.ShopDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// Controller에서 보낸 buyList와 totalPrice를 가져옵니다.
	List<OrderDTO> buyList = (List<OrderDTO>)request.getAttribute("buyList");
	int totalPrice = (int) request.getAttribute("totalPrice");
	
	// 현재 세션에서 유저 포인트 정보를 가져옵니다.
	// int userPoint = (int)session.getAttribute("userPoint");
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .purchase-list { width: 600px; margin: 20px auto; border-collapse: collapse; }
    .purchase-table { width: 100%; border-top: 2px solid #333; border-bottom: 1px solid #ddd; }
    .purchase-table td { padding: 10px; border-bottom: 1px solid #eee; }
    .total-info { text-align: right; margin-top: 20px; font-size: 20px; }
    .btn-pay { width: 100%; padding: 15px; background: #e74c3c; color: #fff; border: none; cursor: pointer; font-size: 18px; margin-top: 20px; }
</style>
</head>

<body>
	<div class="purchase-list">
		<h3>🛒 주문 상품 정보</h3>
		<table class="purchase-table">
			<%
				if (buyList != null) {
					for(OrderDTO item : buyList) {
			%>
			<%-- 리스트에 담긴 상품 수만큼 반복해서 출력합니다 --%>
			<tr>
				<td width="100">
	                <img src="<%= request.getContextPath() %>/resources/upload/<%= item.getImg_path() %>" width="80">
	            </td>
	            <td>
	                <strong><%= item.getItem_name() %></strong><br>
	            </td>
	            <td align="right">
	                <%= String.format("%,d", item.getItem_price()) %> P
	            </td>
			</tr>
			<%
					}
				}
			%>		
		</table>
		
		<div class="total-info">
			<strong>최종 결제 금액: <span style="color: #e74c3c;"><%= String.format("%,d", totalPrice) %> P</span></strong>
		</div>
		
		<%-- 결제 폼: 실제 DB 처리를 위해 필요한 정보를 post로 넘깁니다 --%>
		<form action="buyProcess.do" method="post">
			<%-- 어떤 상품들을 사는지 ID를 넘겨야 합니다 --%>
			<% for(OrderDTO item : buyList) { %>
				<input type="hidden" name="shop_nos" value="<%= item.getShop_no() %>">
			<% } %>
			<input type="hidden" name="total_price" value="<%= totalPrice %>">
			
			<button type="submit" class="btn-pay">결제 확정</button>
		</form>
	
	</div>	
</body>
</html>

