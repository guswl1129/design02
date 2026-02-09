<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도안 판매 등록</title>
<style>
    .write-container { width: 600px; margin: 30px auto; font-family: sans-serif; }
    .write-table { width: 100%; border-collapse: collapse; }
    .write-table th, .write-table td { border-bottom: 1px solid #ddd; padding: 15px; }
    .write-table th { width: 20%; background-color: #f9f9f9; text-align: left; }
    .input-field { width: 100%; padding: 8px; box-sizing: border-box; }
    .textarea-field { width: 100%; height: 200px; padding: 8px; box-sizing: border-box; resize: none; }
    .btn-area { margin-top: 20px; text-align: center; }
    .btn { padding: 10px 25px; cursor: pointer; background-color: #333; color: white; border: none; }
    .btn-cancel { background-color: #eee; color: #333; margin-right: 10px; }
</style>
</head>
<body>

<div class="write-container">
    <h2>🎨 새로운 도안 판매 등록</h2>
    
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
                <th>상세 내용</th>
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