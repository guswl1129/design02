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
		<h1>아이디 찾기</h1>
		<br><br><br>
		<form action="./find"method="post">
			닉네임 <input type="text" name="name"><br><br>
			이메일 <input type="email" name="email"><br><br>
			<br>
			<button type="submit">확인</button>
			<button type="reset">초기화</button>
		</form>
		<br><br>
	<a href="find2.jsp">패스워드 찾기</a>
	</div>
</body>
</html>