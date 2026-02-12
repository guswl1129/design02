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
                    <img src="${pageContext.request.contextPath}/resources/upload/knit00.jpg" alt="도안 2">
                </div>
            </div>

            <div class="item-card only-img">
                <div class="card-img-box">
                    <img src="${pageContext.request.contextPath}/resources/images/warmer.jpg" alt="도안 3">
                </div>
            </div>
            
        </div>
    </div>

	<div class="banner-section">
        <div class="banner-container">
            <div class="banner-content">
                <span class="banner-tag">Special Event</span>
                <h2>나만의 한정판 도안,<br>지금 등록하고 포인트 받으세요!</h2>
                <p>첫 도안 등록 시 1,000P 즉시 지급 이벤트 중 ✨</p>
                <button class="btn-banner" onclick="location.href='${pageContext.request.contextPath}/shop/write.do'">
                    도안 등록하러 가기
                </button>
            </div>
            <%-- <div class="banner-image">
                <img src="${pageContext.request.contextPath}/resources/images/banner_img.png" alt="이벤트 배너">
            </div> --%>
        </div>
    </div>
	
	<%-- 푸터 영역 (선택사항) --%>
    <footer class="main-footer">
        <p>&copy; 2026 HandiBoard. All rights reserved.</p>
    </footer>

</body>
</html>