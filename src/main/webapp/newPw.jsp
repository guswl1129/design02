<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="background" style="background-color: skyblue; text-align: center;">
		<h1>새 비밀번호 입력</h1>
		<br><br><br>
		<form action="./newPw"method="post">
			<input type="hidden" name="userId" value="${userId}">
			비밀번호 <input name="pw1"><br><br>
			비밀번호 확인 <input name="pw2"><br><br>
			<br>
			<button onclick="location.href='./login.jsp'" type="submit">확인</button>
			<button type="reset">초기화</button>
		</form>
		<br><br>
	
	</div>

</body>
</html>