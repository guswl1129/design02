<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HandiBoard - 핸드메이드 도안 커뮤니티(메인페이지)</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>

<body>
	<div class="nav-bar">
		<a href="${pageContext.request.contextPath}/" class="logo">HandiBoard</a>
		<div class="nav-menu">
            <a href="${pageContext.request.contextPath}/shop/list.do">도안 판매</a>
            <a href="${pageContext.request.contextPath}/board">커뮤니티</a>
            <a href="${pageContext.request.contextPath}/myPage">마이페이지</a>
        </div>
        <div class="user-info">
	    <%
	        // 세션에서 userId를 가져옵니다.
	        String sUserId = (String)session.getAttribute("userId");
	        
	        // 로그인 상태에 따라 다른 화면을 보여줍니다.
	        if (sUserId != null) { 
	    %>
	        <span class="welcome-msg"><b><%= sUserId %></b>님 환영합니다!</span>
	        <a href="logout" class="auth-link">로그아웃</a>
	    <%
	        } else { 
	    %>
	        <a href="login.jsp" class="auth-link">로그인</a>
	    <%
	        } 
	    %>
		</div>
	</div>


	
	<div class="market-section">
        <div class="section-title">✨ 지금 인기있는 도안</div>
        <div class="card-container">
        	<div class="item-card only-img">
                <div class="card-img-box">
                    <img src="${pageContext.request.contextPath}/resources/images/image01.jpg" alt="도안 1">
                </div>
            </div>

            <div class="item-card only-img">
                <div class="card-img-box">
                    <img src="${pageContext.request.contextPath}/resources/images/image04.jpg" alt="도안 2">
                </div>
            </div>

            <div class="item-card only-img">
                <div class="card-img-box">
                    <img src="${pageContext.request.contextPath}/resources/images/image05.jpg" alt="도안 3">
                </div>
            </div>
            
        </div>
    </div>


	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<a href="logout">로그아웃</a>
	<br>
	<a href="addPoint.jsp">충전</a>
	<br>
	<a href="${pageContext.request.contextPath}/myPage">마이페이지</a>

</body>
</html>