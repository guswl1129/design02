<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.handiboard.dto.ShopDTO" %>
<%
    ShopDTO shop = (ShopDTO)request.getAttribute("shop");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .detail-container { width: 800px; margin: 30px auto; display: flex; gap: 30px; font-family: sans-serif; }
    .image-area { width: 400px; }
    .image-area img { width: 100%; border: 1px solid #ddd; border-radius: 8px; }
    .info-area { width: 400px; display: flex; flex-direction: column; }
    .price { font-size: 28px; color: #e74c3c; font-weight: bold; margin: 10px 0; }
    .content-box { margin-top: 20px; padding: 15px; border-top: 1px solid #eee; min-height: 150px; line-height: 1.6; }
    
    /* 버튼 스타일링 */
    .btn-group { display: flex; gap: 10px; margin-top: auto; }
    .btn { padding: 15px; border: none; cursor: pointer; font-size: 16px; border-radius: 5px; flex: 1; transition: 0.3s; }
    .btn-cart { background-color: #f8f9fa; color: #333; border: 1px solid #ccc; }
    .btn-cart:hover { background-color: #e2e6ea; }
    .btn-buy { background-color: #333; color: #fff; font-weight: bold; }
    .btn-buy:hover { background-color: #555; }
    .btn-list { width: 100%; margin-top: 10px; background: none; border: 1px solid #eee; color: #888; padding: 10px; cursor: pointer; }
</style>
</head>

<body>
	
	<div class="detail-container">
		<div class="image-area">
			<img src="<%= request.getContextPath() %>/resources/upload/<%= shop.getImg_path() %>" alt="도안이미지">
		</div>
		
		<div class="info-area">
            <h1><%= shop.getTitle() %></h1>
            <p style="color:#888;">작성자: <%= shop.getUser_id() %> | 등록일: <%= shop.getReg_date() %></p>
            <hr>
            <h3 style="margin-bottom:0;">아이템: <%= shop.getItem_name() %></h3>
            <p class="price"><%= String.format("%,d", shop.getItem_price()) %> P</p>
            
            <div class="content-box">
                <%= shop.getContent().replace("\n", "<br>") %>
            </div>
    
            <div class="btn-group">
                <button type="button" class="btn btn-cart" onclick="addToCart(<%= shop.getShop_no() %>)">장바구니</button>
                <button type="button" class="btn btn-buy" onclick="directBuy(<%= shop.getShop_no() %>)">바로구매</button>
            </div>
            <button class="btn-list" onclick="location.href='list.do'">목록으로 돌아가기</button>
        </div>
	</div>
	
	<script>
		// 1. 바로 구매: 결제 페이지(buy.jsp)로 즉시 이동
	    function directBuy(shopNo) {
	        if(confirm("장바구니를 거치지 않고 바로 구매하시겠습니까?")) {
	            // 바로 결제 폼으로 이동 (shop_no를 들고 감)
	            location.href = "buy.do?shop_no=" + shopNo;
	        }
	    }
	
	    // 2. 장바구니: 담기 처리 후 장바구니 목록으로 이동 여부 확인
	    function addToCart(shopNo) {
	        if(confirm("이 상품을 장바구니에 담으시겠습니까?")) {
	            // 장바구니 담기 처리 서블릿으로 이동
	            // 처리 후 서블릿에서 cartList.do로 보내주거나, 여기서 선택하게 함
	            location.href = "addCart.do?shop_no=" + shopNo;
	        }
	    }
	</script>

</body>
</html>