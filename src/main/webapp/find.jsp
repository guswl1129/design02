<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
    /* 로그인 페이지와 동일한 배경 설정 */
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    /* 컨테이너 스타일 통일 */
    .find-container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 360px;
        text-align: center;
    }

    h1 {
        margin-bottom: 10px;
        color: #333;
        font-size: 24px;
    }

    p {
        font-size: 14px;
        color: #888;
        margin-bottom: 30px;
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
    input[type="email"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        box-sizing: border-box;
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

    /* 하단 링크 및 돌아가기 */
    .footer-links {
        margin-top: 25px;
        font-size: 14px;
        display: flex;
        justify-content: space-between;
        border-top: 1px solid #eee;
        padding-top: 15px;
    }

    .footer-links a {
        color: #666;
        text-decoration: none;
    }

    .footer-links a:hover {
        color: #007bff;
        text-decoration: underline;
    }
</style>
</head>
<body>

    <div class="find-container">
        <h1>아이디 찾기</h1>
        <p>가입 시 등록한 정보를 입력해 주세요.</p>
        
        <form action="./find" method="post">
            <div class="input-group">
                <label for="name">닉네임</label>
                <input type="text" id="name" name="name" placeholder="닉네임을 입력하세요" required>
            </div>
            
            <div class="input-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="example@email.com" required>
            </div>

            <div class="btn-group">
                <button type="submit">아이디 찾기</button>
                <button type="reset">초기화</button>
            </div>
        </form>

        <div class="footer-links">
            <a href="login.jsp">로그인으로 돌아가기</a>
            <a href="find2.jsp">패스워드 찾기</a>
        </div>
    </div>

</body>
</html>