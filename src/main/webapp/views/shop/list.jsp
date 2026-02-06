<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도안 판매 목록</title>
</head>
<body>
	<div class="container">
		<h2>도안 판매 목록</h2>

		<div style="text-align: right; margin-bottom: 20px;">
			<button type="button" class="btn-write"
				onclick="location.href='write.do'">도안 판매하기</button>
		</div>

		<div class="card-container">
			<c:forEach var="item" items="${list}"> // 이거 ShopController에서 보낸거면 list가 맞는 거 같은데 
				<div class="shop-card">
					<img src="${item.img_path}" alt="도안이미지">
					<h3>${item.title}</h3>
					<p>가격: ${item.price }원</p>
					<a href="detail.do?id=${item.id }">상세보기</a>
				</div>
			</c:forEach>
		</div>

	</div>

</body>
</html>