<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	        // 세션에서 userName을 가져옵니다.
	        String sUserName = (String)session.getAttribute("userName");
	        
	        // 로그인 상태에 따라 다른 화면을 보여줍니다.
	        if (sUserName != null) { 
	    %>
	        <span class="welcome-msg"><b><%= sUserName %></b>님 환영합니다!</span>
	        <a href="logout" class="logout">로그아웃</a>
	    <%
	        } else { 
	    %>
	        <a href="login.jsp" class="auth-link">로그인</a>
	    <%
	        } 
	    %>
		</div>
	</div>
</body>
</html>