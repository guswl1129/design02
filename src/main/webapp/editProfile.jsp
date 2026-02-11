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
    margin-top: 60px; }
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
        <form action="updateProfileController" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
            <div class="profile-preview">
                <%-- 마이페이지에서 성공했던 그 경로 그대로 사용합니다! --%>
                <img src="${pageContext.request.contextPath}<%= user.getProfileImagePath() %>" id="current_profile_img">
            </div>
            <div>            
                <input type="file" name="profileImage" class="file-input">
            </div>
            
            <section class = "category-box">
            	<div class="category-content" style="padding: 15px;">
                    <label style="display:block; text-align:left; margin-bottom:5px; font-size:0.9rem; color:#666;">아이디(기본)</label>
                    <input type="text" name="userId" value="<%= user.getId() %>" readonly
                           style="width:100%; border:none; font-size:1.1rem; outline:none; cursor:default;">
                </div>
            </section>

            <section class="category-box">
                <div class="category-content" style="padding: 15px;">
                    <label style="display:block; text-align:left; margin-bottom:5px; font-size:0.9rem; color:#666;">닉네임</label>
                    <input type="text" name="userName" value="<%= user.getName() %>" maxlength="10" placeholder="10자 이내로 입력하세요"
                           style="width:100%; border:none; font-size:1.1rem; font-weight:bold; outline:none;">
                </div>
            </section>
            
            
            <section class = "category-box">
            	<div class="category-content" style="padding: 15px;">
                    <label style="display:block; text-align:left; margin-bottom:5px; font-size:0.9rem; color:#666;">이메일</label>
                    <input type="text" name="userEmail" value="<%= user.getEmail() %>" placeholder="example@domain.com"
                           style="width:100%; border:none; font-size:1.1rem; font-weight:bold; outline:none;">
                </div>
            </section>
            
            

            <button type="submit" class="save-btn">저장하기</button>
        </form>
    </div>
</body>
<script type="text/javascript">
	function validateForm() {
	    const name = document.querySelector('input[name="userName"]').value.trim();
	    const namePattern = /^[a-zA-Z0-9가-힣]{2,10}$/;
	    const email = document.querySelector('input[name="userEmail"]').value.trim();
	    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	    // 1. 닉네임 길이 체크
	    if (name.length === 0) {
	        alert("닉네임을 입력해주세요.");
	        return false;
	    }
	    
	        // 닉네임 검사
	     if (!namePattern.test(name)) {
	            alert("닉네임은 한글, 영문, 숫자 조합으로 2~10자 이내로 입력해주세요. (특수문자/공백 제외)");
	            return false;
	        }

	    
	    if (!emailPattern.test(email)) {
	        alert("올바른 이메일 형식이 아닙니다. (예: example@domain.com)");
	        return false;
	    }
	
	    return true;
	}
</script>
</html>