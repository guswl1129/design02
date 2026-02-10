<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.handiboard.dto.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/myHeader.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage.css">
<title>나의 디자인</title>
</head>
<body>
	<div class=myHeader> <span onclick="history.back();">&lt;</span>마이페이지</div>
	<%
	UserDTO user = (UserDTO)request.getAttribute("user");
	%>
	<section id="profile" class="category-box">
		<div class="category-content">
			<a href="/editProfile" class="menu-row"> 
                <img src="./user-avator.png" id=user_avator>	
				<span id="nickname" class ="menu-row-content"><%=user.getName()%></span> <!--자바에서 값 가져오는 처리하기 -->
				<span class="arrow-icon">></span>
			</a>
		</div> 
	</section>
	<section id="points" class="category-box">
		<div class="category-header">
			<h3>나의 포인트</h3>
		</div>
		<div class="category-content">
                <span id="point-balance"><%=user.getPoint()%>타래</span>
		</div>
		<div class="category-content">
			<a href="addPoint.jsp" class="menu-row">
                <span class ="menu-row-content">충전</span>
                <span class="arrow-icon">></span>
			</a>
		</div>
	</section>	
	<section id="transactions" class="category-box">
		<div class="category-header">
			<h3>나의 거래</h3>
		</div>
		<div class="category-content">
			<a href="myPostsController" class="menu-row"> <!-- 내 게시글 페이지로 이동하도록 수정 --> 
                <span class ="menu-row-content">내 게시글</span>
				<span class="arrow-icon">></span>
			</a>
		</div>
		<div class="category-content">
			<a href="/editProfile" class="menu-row"> 
                <span class ="menu-row-content">판매내역</span>
				<span class="arrow-icon">></span>
			</a>
		</div>
		<div class="category-content">
			<a href="/editProfile" class="menu-row"> 
                <span class ="menu-row-content">구매내역</span>
				<span class="arrow-icon">></span>
			</a>
		</div>
	</section>
	<section id="wishlist" class="category-box">
		<div class="category-header">
			<h3>나의 관심</h3>
		</div>
		<div class="category-content">
			<a href="${pageContext.request.contextPath}/bookmark" class="menu-row"> 
                <span class ="menu-row-content">북마크 모아보기</span>
				<span class="arrow-icon">></span>
			</a>
		</div>
		<div class="category-content">
			<a href="${pageContext.request.contextPath}/CartList" class="menu-row"> 
                <span class ="menu-row-content">장바구니</span>
				<span class="arrow-icon">></span>
			</a>
		</div>
	</section>
</body>
</html>