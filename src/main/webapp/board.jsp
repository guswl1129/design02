<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<style>
	.nav-bar { 
        background: #B2C9AB; padding: 12px 20px; 
        display: flex; align-items: center; gap: 25px;
        border-radius: 12px; margin-bottom: 20px;
    }
    .nav-bar a { 
        color: #4A5D45; text-decoration: none; /* 글자는 진한 녹색으로 가독성 확보 */
        font-weight: 600; font-size: 15px; 
    }
    .nav-bar a:first-child { color: white; font-size: 18px; text-shadow: 1px 1px 2px rgba(0,0,0,0.1); }

    /* 버튼: 부드러운 로즈 파스텔 */
    .btn-write { 
        padding: 10px 18px; background: #E8D2CC; border: none;
        color: #5D4D4A; border-radius: 8px; cursor: pointer; 
        font-weight: bold; transition: 0.3s;
    }
    .btn-write:hover { background: #DBC1B9; transform: translateY(-2px); }
    
    /* [추가] 카드 레이아웃 영역 */
    .market-section { margin-top: 40px; }
    .section-title { font-size: 20px; color: #4A5D45; margin-bottom: 15px; font-weight: bold; }
    
    /* 카드들이 가로로 배치될 박스 */
    .card-container { 
        display: grid; 
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); 
        gap: 20px; 
    }
    
    /* 임시 카드 박스 (데이터 들어올 자리) */
    .dummy-card { 
        background: #fff; border: 1px solid #eee; border-radius: 10px; 
        padding: 15px; text-align: center; height: 150px;
        display: flex; flex-direction: column; justify-content: center;
        color: #999; border: 2px dashed #D1E3F0; /* 점선으로 영역 표시 */
    }
</style>
</head>

<body>
	<div class="nav-bar">
		<a href="${pageContext.request.contextPath}/">HandiBoard Logo</a> 
		<a href="${pageContext.request.contextPath}/shop/list.do">도안 판매</a>
		<a href="${pageContext.request.contextPath}/board">커뮤니티</a>
	</div>

	<div class="button-area">
		<button type="button" class="btn-write" onclick="location.href='write.do'">도안판매글 쓰기</button>
	</div>
	
	<div class="market-section">
        <div class="section-title">✨ 지금 인기있는 도안 (임시 영역)</div>
        <div class="card-container">
            <div class="dummy-card">도안 이미지/정보 준비 중</div>
            <div class="dummy-card">도안 이미지/정보 준비 중</div>
            <div class="dummy-card">도안 이미지/정보 준비 중</div>
        </div>
    </div>


	<h1>메인 페이지 입니다.</h1>
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