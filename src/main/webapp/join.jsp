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
    <form action="./join" method="post">
        <p>아이디: <input type="text" name="userid" required></p>
        <p>비밀번호: <input type="password" name="userpw" required></p>
        <p>이름: <input type="text" name="name" required></p>
        <p>이메일: <input type="email" name="email"></p>
        
        <button type="submit">가입하기</button>
        <button type="button" onclick="location.href='index.jsp'">취소</button>
    </form>
</body>
</html>