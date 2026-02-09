<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.handiboard.dto.ShopDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도안 판매 목록</title>
<style>
    .shop-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    .shop-table th, .shop-table td { border: 1px solid #ddd; padding: 12px; text-align: center; }
    .shop-table th { background-color: #f4f4f4; }
    .price { color: #e74c3c; font-weight: bold; }
</style>
</head>
<body>

	<h2>도안 판매 목록</h2>

	<table class="shop-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>이미지</th>
				<th>제목</th>
				<th>아이템명</th>
				<th>판매가</th>
				<th>작성자</th>
				<th>등록일</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				// Controller에서 request.setAttribute("list", list)로 보낸 데이터를 꺼냅니다.
				List<ShopDTO> list = (List<ShopDTO>)request.getAttribute("list");
				
				if (list != null && !list.isEmpty()) {
					for (ShopDTO shop : list) {
						
			%>
						<tr>
                            <td><%= shop.getShop_no() %></td>                
                            <td>
                                <%-- 이미지가 저장되어 있으면 출력 --%>
                                <img src="resources/upload/<%= shop.getImg_path() %>" width="50" alt="도안">
                            </td>                
                            <td style="text-align: left;">
                                <a href="detail.do?shop_no=<%= shop.getShop_no() %>"><%= shop.getTitle() %></a>
                            </td>
                            <td><%= shop.getItem_name() %></td>
                            <td class="price">
                                <%-- 콤마 포맷팅은 자바 메서드를 활용할 수 있습니다 --%>
                                <%= String.format("%,d", shop.getItem_price()) %>원
                            </td>
                            <td><%= shop.getUser_id() %></td> <%-- JOIN으로 가져온 문자열 아이디 --%>
                            <td><%= shop.getReg_date() %></td>
                        </tr>
			<%
					} // for문 끝
				} else { // 데이터가 없을 경우
			%>
					<tr>
						<td colspan="7">등록된 판매글이 없습니다. 첫 번째 도안을 등록해보세요.</td>
					</tr>		
			<%
				} // if문 끝
			%>
		</tbody>
			
	</table>
	
	<div style="margin-top: 20px; text-align: right;">
	    <button onclick="location.href='write.do'">판매글 등록</button>
	</div>

</body>
</html>