<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    /* 기본 배경 설정 */
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    /* 로그인 박스 컨테이너 */
    .login-container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 360px;
        text-align: center;
    }

    h1 {
        margin-bottom: 30px;
        color: #333;
        font-size: 24px;
    }

    /* 입력창 스타일 */
    .input-group {
        margin-bottom: 15px;
        text-align: left;
    }

    .input-group label {
        display: block;
        margin-bottom: 5px;
        font-size: 14px;
        color: #666;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        box-sizing: border-box; /* 패딩 포함 크기 조절 */
        transition: border-color 0.3s;
    }

    input:focus {
        border-color: #007bff;
        outline: none;
    }

    /* 버튼 스타일 */
    .btn-group {
        margin-top: 20px;
        display: flex;
        gap: 10px;
    }

    button {
        flex: 1;
        padding: 12px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button[type="submit"] {
        background-color: #007bff;
        color: white;
    }

    button[type="submit"]:hover {
        background-color: #0056b3;
    }

    button[type="reset"] {
        background-color: #f8f9fa;
        color: #333;
        border: 1px solid #ddd;
    }

    button[type="reset"]:hover {
        background-color: #e2e6ea;
    }

    /* 하단 링크 */
    .footer-links {
        margin-top: 20px;
        font-size: 14px;
    }

    .footer-links a {
        color: #007bff;
        text-decoration: none;
        margin-right: 20px;
    }

    .footer-links a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>

    <div class="login-container">
        <h1>로그인</h1>
        
        <form action="./login" method="post">
            <div class="input-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" placeholder="아이디를 입력하세요" required>
            </div>
            
            <div class="input-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="btn-group">
                <button type="submit">로그인</button>
                <button type="reset">초기화</button>
            </div>
        </form>

        <div class="footer-links">
            <a href="find.jsp">아이디/패스워드 찾기</a>
            <a href="join.jsp">회원가입</a>
            <a href="${pageContext.request.contextPath}/">메인으로</a> </div>
        </div>
    </div>

    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('err');

        if (error === '1') {
            alert("아이디 또는 비밀번호가 일치하지 않습니다.");
        }
    </script>

</body>
</html>