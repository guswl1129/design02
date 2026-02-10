<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.handiboard.dto.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/myHeader.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage.css"> <title>프로필 수정</title>
<style>
    /* 수정 페이지 전용 스타일 추가 */
    .edit-container { padding: 20px; text-align: center; }
    .profile-preview { position: relative; display: inline-block; margin-bottom: 20px; }
    .profile-preview img { width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 2px solid #eee; }
    .file-input { margin-top: 10px; margin-bottom: 30px;}
    .save-btn { width: 100%; background-color: #333; color: white; border: none; padding: 15px; border-radius: 8px; font-weight: bold; cursor: pointer;
    margin-top: 150px; }
    .category-box{margin-top: 30px;}
</style>
</head>
<body>
    <div class="myHeader"> 
        <span onclick="history.back();">&lt;</span>프로필 수정
    </div>

    <%
        // 컨트롤러에서 넘겨준 유저 정보를 가져옵니다.
        UserDTO user = (UserDTO)request.getAttribute("user");
    %>

    <div class="edit-container">
        <form action="updateProfileController" method="post" enctype="multipart/form-data">
            <div class="profile-preview">
                <%-- 마이페이지에서 성공했던 그 경로 그대로 사용합니다! --%>
                <img src="${pageContext.request.contextPath}<%= user.getProfileImagePath() %>" id="current_profile_img">
            </div>
            <div>            
                <input type="file" name="profileImage" class="file-input">
            </div>

            <section class="category-box">
                <div class="category-content" style="padding: 15px;">
                    <label style="display:block; text-align:left; margin-bottom:5px; font-size:0.9rem; color:#666;">닉네임</label>
                    <input type="text" name="userName" value="<%= user.getName() %>" maxlength="10"
                           style="width:100%; border:none; font-size:1.1rem; font-weight:bold; outline:none;">
                </div>
            </section>
            
            <section class = "category-box">
            	<div class="category-content" style="padding: 15px;">
                    <label style="display:block; text-align:left; margin-bottom:5px; font-size:0.9rem; color:#666;">이메일</label>
                    <input type="text" name="userEmail" value="<%= user.getEmail() %>" 
                           style="width:100%; border:none; font-size:1.1rem; font-weight:bold; outline:none;">
                </div>
            </section>

            <button type="submit" class="save-btn">저장하기</button>
        </form>
    </div>
</body>
<script type="text/javascript">
	function validateForm() {
	    const name = document.getElementsByName("userName")[0].value;
	    const email = document.getElementsByName("userEmail")[0].value;
	    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	    if (name.length > 10) {
	        alert("닉네임은 10글자 이내여야 합니다.");
	        return false;
	    }
	    if (!emailPattern.test(email)) {
	        alert("유효한 이메일 주소를 입력해주세요.");
	        return false;
	    }
	    return true;
	}
	</script>
</html>