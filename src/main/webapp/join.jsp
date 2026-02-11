<%@page import="com.handiboard.dto.UserDTO"%>
<%@page import="com.handiboard.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	body {
        text-align: center; /* 텍스트와 버튼 중앙 */
        padding-top: 50px;  /* 상단 여유 */
    }
    form {
        display: inline-block; /* 폼을 덩어리로 묶어 중앙 배치 */
        text-align: left;      /* 폼 내부 글자는 왼쪽 정렬 */
    }
</style>
</head>
<body>
    <h2>회원가입</h2>
    <form action="./join" method="post" onsubmit="return validateForm();">
        <p>아이디: <input type="text" name="userid" required placeholder="5~15자의 영문 소문자, 숫자, 특수기호(-,_)"></p>
        <p>비밀번호: <input type="password" name="userpw" required placeholder="8~16자의 영문 대소문자, 숫자, 특수기호(# $ % & *)"></p>
        <p>비밀번호 확인: <input type="password" name="userpw2" required></p>
        <p>닉네임: <input type="text" name="name" required placeholder="2~10자 이내(특수문자/공백 제외)"></p>
        <p>이메일: <input type="email" name="email" placeholder="example.domain.com"></p>
        
        <button type="submit">가입하기</button>
        <button type="button" onclick="location.href='index.jsp'">취소</button>
    </form>

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