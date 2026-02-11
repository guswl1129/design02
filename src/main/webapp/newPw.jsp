<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 비밀번호 설정</title>
<style>
    /* 전체 페이지 공통 스타일 */
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    /* 중앙 컨테이너 */
    .password-container {
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

    /* 입력 폼 그룹 */
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

    input[type="password"] {
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

    /* 버튼 레이아웃 */
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
        background-color: #28a745; /* 변경 완료의 의미로 초록색 계열 사용 */
        color: white;
    }

    button[type="submit"]:hover {
        background-color: #218838;
    }

    button[type="reset"] {
        background-color: #f8f9fa;
        color: #333;
        border: 1px solid #ddd;
    }

    button[type="reset"]:hover {
        background-color: #e2e6ea;
    }
</style>
</head>
<body>

    <div class="password-container">
        <h1>새 비밀번호 설정</h1>
        <p>새로운 비밀번호를 입력해 주세요.</p>
        
        <form action="./newPw" method="post" onsubmit="return validatePassword()">
            <input type="hidden" name="userId" value="${userId}">
            
            <div class="input-group">
                <label for="pw1">새 비밀번호</label>
                <input type="password" id="pw1" name="pw1" placeholder="새 비밀번호 입력" required>
            </div>
            
            <div class="input-group">
                <label for="pw2">비밀번호 확인</label>
                <input type="password" id="pw2" name="pw2" placeholder="비밀번호 다시 입력" required>
            </div>

            <div class="btn-group">
                <button type="submit">비밀번호 변경</button>
                <button type="reset">초기화</button>
            </div>
        </form>
    </div>

    <script>
        // 비밀번호 일치 여부를 체크하는 간단한 스크립트
        function validatePassword() {
            const pw1 = document.getElementById('pw1').value;
            const pw2 = document.getElementById('pw2').value;

            if (pw1 !== pw2) {
                alert("비밀번호가 일치하지 않습니다.");
                return false; // 폼 제출 중단
            }
            return true;
        }
    </script>

</body>
</html>