<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도안 판매 등록</title>
<style>
    body {
        background-color: #fcfcfc;
        font-family: 'Pretendard', sans-serif;
        margin: 0;
    }

    .write-container { 
        max-width: 700px; 
        margin: 60px auto; 
        background: #fff;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        border: 1px solid #f0f0f0;
    }

    h2 { 
        color: #4A5D45; 
        font-size: 26px; 
        margin-bottom: 30px; 
        text-align: center;
    }

    .write-table { width: 100%; border-collapse: collapse; }
    
    .write-table th, .write-table td { 
        padding: 18px 10px; 
        border-bottom: 1px solid #f7f7f7; 
    }

    .write-table th { 
        width: 25%; 
        color: #666; 
        font-size: 15px;
        text-align: left; 
        font-weight: 600;
    }

    /* 입력창 공통 스타일 */
    .input-field, .textarea-field { 
        width: 100%; 
        padding: 12px 15px; 
        border: 1px solid #ddd; 
        border-radius: 10px; 
        box-sizing: border-box; 
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .input-field:focus, .textarea-field:focus {
        border-color: #B2C9AB;
        outline: none;
        box-shadow: 0 0 0 3px rgba(178, 201, 171, 0.1);
    }

    .textarea-field { 
        height: 250px; 
        resize: none; 
        line-height: 1.6;
    }

    /* 파일 업로드 커스텀 느낌 */
    input[type="file"] {
        font-size: 14px;
        color: #888;
    }

    /* 버튼 영역 */
    .btn-area { 
        margin-top: 40px; 
        display: flex;
        gap: 15px;
        justify-content: center;
    }

    .btn { 
        padding: 15px 40px; 
        border-radius: 12px;
        font-size: 16px; 
        font-weight: bold;
        cursor: pointer; 
        border: none;
        transition: all 0.3s ease;
    }

    /* 등록하기 버튼 (연녹색 강조) */
    .btn-submit { 
        background-color: #B2C9AB; 
        color: white; 
        flex: 2;
    }

    .btn-submit:hover { 
        background-color: #9eb697; 
        transform: translateY(-2px);
    }

    /* 취소 버튼 */
    .btn-cancel { 
        background-color: #f4f4f4; 
        color: #888; 
        flex: 1;
    }

    .btn-cancel:hover { 
        background-color: #e9e9e9; 
    }

    /* 가격 입력칸 옆에 단위 표시 (선택사항) */
    .price-wrapper {
        position: relative;
        display: flex;
        align-items: center;
    }
    .price-wrapper::after {
        content: ' 포인트';
        margin-left: 10px;
        font-size: 14px;
        color: #999;
    }
</style>
</head>
<body>

	<%-- 상단 네비바 포함 --%>
	<%@ include file="/nav.jsp" %>
	
	<div class="write-container">
	    <h2>새로운 도안 판매 등록</h2>
	    
	    <form action="writeProcess.do" method="post" enctype="multipart/form-data">
	        <table class="write-table">
	            <tr>
	                <th>게시글 제목</th>
	                <td><input type="text" name="title" class="input-field" placeholder="제목을 입력하세요" required></td>
	            </tr>
	            <tr>
	                <th>도안 이름</th>
	                <td><input type="text" name="item_name" class="input-field" placeholder="판매할 아이템 명" required></td>
	            </tr>
	            <tr>
	                <th>판매 가격</th>
	                <td><input type="number" name="item_price" class="input-field" placeholder="숫자만 입력하세요" required></td>
	            </tr>
	            <tr>
	                <th>도안 이미지</th>
	                <td><input type="file" name="img_file" accept="image/*" required></td>
	            </tr>
	            <tr>
	                <th>상세 설명</th>
	                <td><textarea name="content" class="textarea-field" placeholder="도안에 대한 설명을 입력하세요"></textarea></td>
	            </tr>
	        </table>
	        
	        <div class="btn-area">
	            <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
	            <button type="submit" class="btn">등록하기</button>
	        </div>
	    </form>
	</div>

</body>
</html>