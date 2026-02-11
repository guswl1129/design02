<%@page import="com.handiboard.dto.UserDTO"%>
<%@page import="com.handiboard.dao.BoardDAO"%>
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
        <form action="./join" method="post" onsubmit="return validateForm();">
            
            <div class="input-group">
                <label for="userid">아이디</label>
                <input type="text" id="userid" name="userid" placeholder="5~15자의 영문 소문자, 숫자, 특수기호(-,_)" required>
            </div>

            <div class="input-group">
                <label for="userpw">비밀번호</label>
                <input type="password" id="userpw" name="userpw" placeholder="8~16자의 영문 대소문자, 숫자, 특수기호(# $ % & *)" required>
            </div>

            <div class="input-group">
                <label for="userpw2">비밀번호 확인</label>
                <input type="password" id="userpw2" name="userpw2" placeholder="비밀번호를 다시 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="name">닉네임</label>
                <input type="text" id="name" name="name" placeholder="2~10자 이내(특수문자/공백 제외)" required>
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
<script type="text/javascript">
    // 1. 서버에서 보낸 에러 메시지 처리 (함수 밖, 페이지 로드시 실행)
    <%
        String msg = (String)session.getAttribute("errorMessage");
        if(msg != null) {
    %>
        alert("<%= msg %>");
    <%
        session.removeAttribute("errorMessage");
        }
    %>

    // 2. 폼 유효성 검사 함수
    function validateForm() {
        const id = document.querySelector('input[name="userid"]').value.trim();
        const idPattern = /^[a-z0-9_-]{3,15}$/; // 길이를 정규식에 포함하면 더 깔끔합니다.
        
        const pw = document.querySelector('input[name="userpw"]').value.trim();
        const pw2 = document.querySelector('input[name="userpw2"]').value.trim();
        const pwPattern = /^[A-Za-z0-9#$%&*]{8,16}$/;
        
        const name = document.querySelector('input[name="name"]').value.trim();
        const namePattern = /^[a-zA-Z0-9가-힣]{2,10}$/;
        
        const email = document.querySelector('input[name="email"]').value.trim();
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        
        // 아이디 검사
        if (!idPattern.test(id)) {
            alert("아이디는 3~15자의 영문 소문자, 숫자, 특수기호(-,_)만 가능합니다.");
            return false;
        }

        // 비밀번호 검사 (기존 id.length 오타 수정)
        if (!pwPattern.test(pw)) {
            alert("비밀번호는 8~16자의 영문 대소문자, 숫자, 특수기호(# $ % & *)만 가능합니다.");
            return false;
        }
        if(pw!=pw2){
        	alert("비밀번호가 다릅니다.");
            return false;
        }
        
        // 닉네임 검사
        if (!namePattern.test(name)) {
            alert("닉네임은 한글, 영문, 숫자 조합으로 2~10자 이내로 입력해주세요. (특수문자/공백 제외)");
            return false;
        }
        
        // 이메일 검사
        if (email.length > 0 && !emailPattern.test(email)) {
            alert("올바른 이메일 형식이 아닙니다. (예: example@domain.com)");
            return false;
        }
    
        return true;
    }
</script>
</html>