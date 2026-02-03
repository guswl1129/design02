<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="background" style="background-color: skyblue; text-align: center;">
		<h1>로그인</h1>
		<br><br><br>
		<form action="./login"method="post">
			아이디 <input type="text" name="id"><br><br>
			비밀번호 <input type="password" name="pw"><br><br>
			<br>
			<button type="submit">로그인</button>
			<button type="reset">초기화</button>
		</form>
		<br><br>
	<a href="find.jsp">아이디/패스워드 찾기</a>
	</div>
	<script>
	    // URL의 파라미터를 분석하는 함수
	    const urlParams = new URLSearchParams(window.location.search);
	    const error = urlParams.get('err');
	
	    if (error === '1') {
	        alert("아이디 또는 비밀번호가 일치하지 않습니다.");
	    }
	</script>

</body>
</html>
