<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.handiboard.dto.ShopDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도안 판매 목록</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">

</head>
<body>
	<%-- 상단 네비게이션 바 불러오기 --%>
	<%@ include file="/nav.jsp" %>
	
	
	<div class="container">
		<div class="list-header">
            <h2>✨ 도안 판매 목록</h2>
            <button class="btn-write" onclick="location.href='write.do'">판매글 등록</button>
        </div>
		<div class="product-grid">
			<%
	             List<ShopDTO> list = (List<ShopDTO>)request.getAttribute("list");
	             if (list != null && !list.isEmpty()) {
	                 for (ShopDTO shop : list) {
	        %>
	        	<div class="product-card" onclick="location.href='detail.do?shop_no=<%= shop.getShop_no() %>'">
	                    <div class="product-img-box">
	                        <% if(shop.getImg_path() != null && !shop.getImg_path().isEmpty()) { %>
	                            <img src="${pageContext.request.contextPath }/resources/upload/<%= shop.getImg_path() %>" alt="도안이미지">
	                        <% } else { %>
	                            <div class="no-image">No Image</div>
	                        <% } %>
	                    </div>
	                    
	                    <div class="product-info">
	                        <div class="product-tag"><%= shop.getItem_name() %></div>
	                        <div class="product-name"><%= shop.getTitle() %></div>
	                        <div class="product-bottom">
	                            <span class="product-price"><%= String.format("%,d", shop.getItem_price()) %>타래</span>
	                            <span class="product-seller"><%= shop.getUser_id() %></span>
	                        </div>
	                    </div>
	            </div>
	        	<%
	                 }
	             } else {
	        %>
	        	<div class="empty-msg">등록된 판매글이 없습니다. 첫 번째 도안을 등록해보세요!</div>
	        <%
	             }
	        %>
		</div>
	</div>
	
	


</body>
</html>