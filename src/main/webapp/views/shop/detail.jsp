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
    .detail-container { width: 800px; margin: 30px auto; display: flex; gap: 30px; }
    .image-area { width: 400px; }
    .image-area img { width: 100%; border: 1px solid #ddd; }
    .info-area { width: 400px; }
    .price { font-size: 24px; color: #e74c3c; font-weight: bold; }
    .content-box { margin-top: 20px; padding: 15px; border-top: 1px solid #eee; min-height: 150px; }
    .btn-buy { width: 100%; padding: 15px; background: #333; color: #fff; border: none; cursor: pointer; font-size: 18px; }
    .btn-buy:hover { background: #555; }
</style>
</head>
<body>
	
	<div class="detail-container">
		<div class="image-area">
			<img src="<%= request.getContextPath() %>/resources/upload/<%= shop.getImg_path() %>" alt="도안이미지">
		</div>
		
		<div class="info-area">
	        <h1><%= shop.getTitle() %></h1>
	        <p>작성자: <%= shop.getUser_id() %> | 등록일: <%= shop.getReg_date() %></p>
	        <hr>
	        <h3>아이템명: <%= shop.getItem_name() %></h3>
	        <p class="price">판매가: <%= String.format("%,d", shop.getItem_price()) %>원</p>
	        
	        <div class="content-box">
	            <%= shop.getContent().replace("\n", "<br>") %>
	        </div>
	
	        <button class="btn-buy" onclick="purchase(<%= shop.getShop_no() %>)">구매하기</button>
	        <button onclick="location.href='list.do'" style="width:100%; margin-top:10px;">목록으로</button>
	    </div>
	</div>
	
	<script>
		function purchase(no) {
			if(confirm("이 도안을 구매하시겠습니까?")) {
				// 실제 구매 처리를 담당할 서블릿 경로로 이동
				location.href = "buy.do?shop_no=" + no;
			}
		}
	</script>

</body>
</html>