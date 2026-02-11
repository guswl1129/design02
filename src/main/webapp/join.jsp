<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HandiBoard - 회원가입</title>
<style>
	/* 기본 배경 설정 - 로그인 페이지와 통일 */
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #fcfcfc; /* 메인 배경색과 통일 */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }

    /* 회원가입 박스 컨테이너 */
    .join-container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 16px; /* 마이페이지와 통일감 있는 라운딩 */
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        width: 100%;
        max-width: 400px; /* 로그인보다 조금 더 넓게 설정 */
        text-align: center;
        border: 1px solid #eee;
    }

    h2 {
        margin-bottom: 30px;
        color: #333;
        font-size: 24px;
        font-weight: bold;
    }

    /* 입력창 그룹 스타일 */
    .input-group {
        margin-bottom: 18px;
        text-align: left;
    }

    .input-group label {
        display: block;
        margin-bottom: 8px;
        font-size: 14px;
        font-weight: 600;
        color: #555;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        transition: all 0.3s;
        font-size: 15px;
    }

    input:focus {
        border-color: #B2C9AB; /* 포인트 연녹색 */
        outline: none;
        box-shadow: 0 0 0 3px rgba(178, 201, 171, 0.2);
    }

    /* 버튼 스타일 */
    .btn-group {
        margin-top: 30px;
        display: flex;
        gap: 12px;
    }

    button {
        flex: 1;
        padding: 14px;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s;
    }

    /* 가입하기 버튼 - 포인트 컬러 적용 */
    button[type="submit"] {
        background-color: #B2C9AB;
        color: white;
    }

    button[type="submit"]:hover {
        background-color: #9eb697;
        transform: translateY(-2px);
    }

    /* 취소 버튼 */
    .btn-cancel {
        background-color: #f4f4f4;
        color: #666;
    }

    .btn-cancel:hover {
        background-color: #e9e9e9;
    }

    /* 안내 텍스트 */
    .footer-msg {
        margin-top: 25px;
        font-size: 14px;
        color: #888;
    }

    .footer-msg a {
        color: #B2C9AB;
        text-decoration: none;
        font-weight: bold;
    }
</style>
</head>
<body>
    <div class="join-container">
        <h2>회원가입</h2>
        <form action="./join" method="post">
            <div class="input-group">
                <label for="userid">아이디</label>
                <input type="text" id="userid" name="userid" placeholder="4~12자 영문, 숫자" required>
            </div>

            <div class="input-group">
                <label for="userpw">비밀번호</label>
                <input type="password" id="userpw" name="userpw" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="name">이름 (닉네임)</label>
                <input type="text" id="name" name="name" placeholder="사용하실 이름을 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="example@mail.com">
            </div>
            
            <div class="btn-group">
                <button type="submit">가입하기</button>
                <button type="button" class="btn-cancel" onclick="location.href='index.jsp'">취소</button>
            </div>
        </form>

        <div class="footer-msg">
            이미 계정이 있으신가요? <a href="login.jsp">로그인</a>
        </div>
    </div>
</body>
</html>