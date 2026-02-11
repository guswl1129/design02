<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 전체 배경을 마이페이지와 통일감 있게 */
    body {
        background-color: #fcfcfc;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* 화면 꽉 차게 중앙 정렬 */
        margin: 0;
        font-family: 'Pretendard', sans-serif;
    }

    /* 성공 박스 스타일 */
    .success-box {
        background: #ffffff;
        padding: 50px 40px;
        border-radius: 20px;
        text-align: center;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        border: 1px solid #f0f0f0;
        max-width: 450px;
        width: 90%;
    }

    /* 아이콘 혹은 이모지 강조 */
    .success-box h2 {
        color: #4A5D45;
        font-size: 24px;
        margin-bottom: 20px;
    }

    .success-box p {
        color: #777;
        font-size: 16px;
        line-height: 1.6;
        margin-bottom: 40px;
    }

    /* 버튼 그룹 */
    .btns {
        display: flex;
        flex-direction: column; /* 세로로 배치해서 주목도 높임 */
        gap: 12px;
    }

    /* 버튼 공통 스타일 */
    .btns button {
        padding: 15px;
        border-radius: 12px;
        border: none;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    /* 계속 쇼핑하기 (메인 강조 버튼) */
    .btn-shop {
        background-color: #B2C9AB;
        color: white;
    }

    .btn-shop:hover {
        background-color: #9eb697;
        transform: translateY(-2px);
    }

    /* 메인으로 가기 (보조 버튼) */
    .btn-main {
        background-color: #f4f4f4;
        color: #888;
    }

    .btn-main:hover {
        background-color: #eee;
        color: #666;
    }
</style>
</head>
<body>
	<div class="success-box">
    <h2>🎉 결제가 정상적으로 완료되었습니다!</h2>
    <p>구매하신 도안은 <b>마이페이지 > 구매내역</b>에서<br>언제든지 확인하실 수 있습니다.</p>
    <div class="btns">
        <button class="btn-shop" onclick="location.href='${pageContext.request.contextPath}/shop/list.do'">계속 쇼핑하기</button>
        <button class="btn-shop" onclick="location.href='${pageContext.request.contextPath}/main'">메인페이지로 이동</button>
    </div>
</div>
</body>
</html>