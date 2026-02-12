<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.handiboard.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 모아보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/myHeader.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/myList.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookmarkList.css">
    <style>
        /* 장바구니 전용 추가 스타일 */
        .cart-controls { padding: 10px 20px; border-bottom: 1px solid #eee; display: flex; align-items: center; background: #fff; }
        .cart-checkbox { width: 18px; height: 18px; margin-right: 10px; cursor: pointer; }
        .item-row { display: flex; align-items: center; padding: 0 10px; }
        .price-tag { color: #e74c3c; font-weight: bold; margin-top: 5px; display: block; }
        .cart-footer { position: fixed; bottom: 0; width: 100%; max-width: 800px; /* 헤더와 동일하게 맞춤 */
                       background: #fff; border-top: 1px solid #ddd; padding: 15px 20px; 
                       display: flex; justify-content: space-between; align-items: center; box-sizing: border-box; }
        .btn-buy { background: #333; color: #fff; border: none; padding: 12px 25px; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .category-box { position: relative; }
        .cart-toggle-btn { position: absolute; right: 20px; top: 20px; cursor: pointer; }
        .cart-toggle-btn img { width: 24px; }
        body { padding-bottom: 80px; } /* 하단 구매 버튼 공간 확보 */
    </style>
</head>
<body>
    <div class="myHeader"> <span onclick="history.back();">&lt;</span>장바구니 모아보기</div>

    <form id="cartForm" action="${pageContext.request.contextPath}/buy/buy.do" method="get">
        <%
        @SuppressWarnings("unchecked") 
        List<OrderDTO> cartList = (ArrayList<OrderDTO>)request.getAttribute("cartList");
        
        if(cartList == null || cartList.isEmpty()){ %>
            <div class="empty-msg">장바구니가 비어 있어요. <br>마음에 드는 상품을 담아보세요!</div>
        <%} else { %>
            <div class="cart-controls">
                <input type="checkbox" id="selectAll" class="cart-checkbox" onclick="toggleAll(this)">
                <label for="selectAll">전체 선택</label>
            </div>

            <% for (OrderDTO item : cartList) { %>
            <div class="category-box">
                <div class="item-row">
                    <input type="checkbox" name="shop_no" value="<%=item.getShop_no()%>" class="cart-checkbox item-check" onclick="updateTotal()">
                    
                    <div style="flex:1;">
                        <a href="${pageContext.request.contextPath}/shop/detail.do?shop_no=<%=item.getShop_no()%>">
                            <div class="post-info">
                                <div class="user-group">
                                    <span class="user-id"><%=item.getSeller_name()%></span>
                                    <span class="post-date"><%=item.getOrder_date()%></span>
                                </div>
                            </div>
                            <div class="post-title"><%=item.getShop_title()%></div>
                            <div class="post-content"><%=item.getItem_name()%></div>
                            <span class="price-tag"><%= String.format("%,d", item.getItem_price()) %> P</span>
                        </a>
                    </div>
                </div>
                
                <span class="cart-toggle-btn" onclick="removeFromCart(<%=item.getShop_no()%>, <%=item.getItem_no()%>)">
                    <img src="${pageContext.request.contextPath}/cart_remove.png" alt="장바구니삭제">
                </span>
            </div>
            <% } %>

            <div class="cart-footer">
                <div>선택 상품: <span id="checkCount">0</span>개</div>
                <button type="submit" class="btn-buy">구매하기</button>
            </div>
        <% } %>
    </form>

    <script>
        // 전체 선택 토글
        function toggleAll(selectAll) {
            const checks = document.querySelectorAll('.item-check');
            checks.forEach(cb => cb.checked = selectAll.checked);
            updateTotal();
        }

        // 선택 개수 업데이트
        function updateTotal() {
            const checkedCount = document.querySelectorAll('.item-check:checked').length;
            document.getElementById('checkCount').innerText = checkedCount;
        }

        // 장바구니에서 삭제 (기존 inCart 서블릿의 토글 기능 활용)
        function removeFromCart(shopNo,itemNo) {
            if(confirm("장바구니에서 삭제하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/inCart?shop_no=" + shopNo +"&item_no="+ itemNo +"&from=cart";
            }
        }

        // 구매하기 전 유효성 검사
        document.getElementById('cartForm').onsubmit = function() {
            const checkedCount = document.querySelectorAll('.item-check:checked').length;
            if(checkedCount === 0) {
                alert("구매할 상품을 선택해주세요.");
                return false;
            }
            return true;
        };
    </script>
</body>
</html>