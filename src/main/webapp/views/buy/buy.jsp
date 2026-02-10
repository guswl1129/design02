<%@page import="com.handiboard.dto.OrderDTO"%>
<%@page import="com.handiboard.dto.ShopDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// Controller에서 보낸 buyList와 totalPrice를 가져옵니다.
	List<OrderDTO> buyList = (List<OrderDTO>)request.getAttribute("buyList");
	//Integer 객체이므로 null 체크를 포함하거나 기본값을 고려해야 안전합니다.
	Object totalPriceObj = request.getAttribute("totalPrice");
	int totalPrice = (totalPriceObj != null) ? (int)totalPriceObj : 0;
	
	// Controller에서 보낸 포인트를 꺼냅니다.
    Object upObj = request.getAttribute("userPoint");
    int userPoint = (upObj != null) ? (int)upObj : 0;
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<style>
    .purchase-container { width: 600px; margin: 40px auto; font-family: sans-serif; }
    .purchase-table { width: 100%; border-top: 2px solid #333; border-collapse: collapse; }
    .purchase-table td { padding: 15px 10px; border-bottom: 1px solid #eee; }
    .point-box { background: #f8f9fa; padding: 20px; margin-top: 20px; border-radius: 8px; }
    .point-row { display: flex; justify-content: space-between; margin: 5px 0; }
    .total-info { text-align: right; margin-top: 20px; font-size: 22px; }
    .btn-pay { width: 100%; padding: 18px; background: #333; color: #fff; border: none; cursor: pointer; font-size: 18px; font-weight: bold; margin-top: 20px; border-radius: 5px; }
    .btn-pay:hover { background: #555; }
</style>
</head>

<body>
	<div class="purchase-container">
		<h3>🛒 주문 상품 정보 (<%= (buyList != null) ? buyList.size() : 0 %>건)</h3>
		<table class="purchase-table">
			<%
				if (buyList != null && !buyList.isEmpty()) {
					for(OrderDTO item : buyList) {
			%>
			<%-- 리스트에 담긴 상품 수만큼 반복해서 출력합니다 --%>
			<tr>
				<td width="100">
                    <img src="<%= request.getContextPath() %>/resources/upload/<%= item.getImg_path() %>" width="80" style="border-radius:4px;">
                </td>
                <td>
                    <strong><%= item.getItem_name() %></strong>
                </td>
                <td align="right" style="font-weight: bold;">
                    <%= String.format("%,d", item.getItem_price()) %> P
                </td>
			</tr>
			<%
					}
				} else {
			%>		
			<tr><td colspan="3" align="center">결제할 상품이 없습니다.</td></tr>
			<%
				}
			%>
		</table>
		
		<div class="point-box">
            <div class="point-row">
                <span>내 현재 포인트</span>
                <span><%= String.format("%,d", userPoint) %> P</span>
            </div>
            <div class="point-row" style="color: #e74c3c; font-weight: bold;">
                <span>차감될 포인트</span>
                <span>- <%= String.format("%,d", totalPrice) %> P</span>
            </div>
            <hr>
            <div class="point-row" style="font-size: 18px; font-weight: bold;">
                <span>결제 후 잔액</span>
                <span style="color: #007bff;"><%= String.format("%,d", userPoint - totalPrice) %> P</span>
            </div>
        </div>
		
		<div class="total-info">
            <strong>최종 결제 금액: <span style="color: #e74c3c;"><%= String.format("%,d", totalPrice) %> P</span></strong>
        </div>
		
		<%-- 결제 폼: 실제 DB 처리를 위해 필요한 정보를 post로 넘깁니다 --%>
		<form action="<%= request.getContextPath() %>/buy/buyProcess.do" method="post" onsubmit="return checkPoint()">
            <% if (buyList != null) {
                for(OrderDTO item : buyList) { %>
                <input type="hidden" name="shop_nos" value="<%= item.getShop_no() %>">
                <%-- [추가] DB에 담을 때 item_no도 필요할 수 있으니 함께 넘깁니다 --%>
                <input type="hidden" name="item_nos" value="<%= item.getItem_no() %>">
            <%  } 
            } %>
            <input type="hidden" name="total_price" value="<%= totalPrice %>">
            
            <% if(userPoint >= totalPrice && totalPrice > 0) { %>
                <button type="submit" class="btn-pay">결제 확정</button>
            <% } else { %>
                <button type="button" class="btn-pay" style="background:#ccc; cursor:not-allowed;" disabled>포인트가 부족합니다</button>
                <p class="low-point">포인트 충전 후 다시 시도해주세요.</p>
            <% } %>
        </form>
	
	</div>	
	
	<script>
        function checkPoint() {
            return confirm("정말로 결제를 진행하시겠습니까? 포인트가 차감됩니다.");
        }
    </script>
</body>
</html>

