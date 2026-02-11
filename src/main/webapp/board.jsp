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
	<%@ include file="/nav.jsp" %>
	
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
	<br>
	<a href="${pageContext.request.contextPath}/myPage">마이페이지</a>

</body>
</html>