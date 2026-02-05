<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코인 충전 페이지</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .wrap {
        text-align: center;
        margin-top: 50px;
    }
    .content {
        background-color: #E1BFFF;
        border-radius: 15px;
        width: 400px;
        margin: 0 auto;
        padding: 20px;
    }
    .mycoin {
        font-size: 20px;
        margin-bottom: 20px;
        display: flex; /* 요소들을 가로로 배치 */
        gap: 150px;
        background-color: #D6A3FF;
        border-radius: 15px;
        margin-top:10px;
        padding: 20px; /*글씨와 박스 사이의 간격*/
    	justify-content: space-between; /* 양 끝으로 밀어내기 */
    	align-items: center;
    	with: 100%;
    }
    .mycoin span {
        font-weight: bold;
        color: #666666;
        
    }
    .label{
    
    white-space: nowrap;
    
    }
    .amount{
    white-space: nowrap;
    }
    .payment-select {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 30px;
    }
    .coinbox {
        background-color: white;
        border-radius: 10px;
        padding: 15px;
        cursor: pointer;
        border: 2px solid transparent;
        transition: 0.2s;
    }
    .coinbox:hover { /*버튼을 눌렀을때*/
        border-color: #3498db;
        background-color: #ecf6fd;
    }
    .coinbox.selected {
        border-color: #2980b9;
        background-color: #d6ecff;
    }
    .coin {
        display: block;
        font-size: 18px;
        font-weight: bold;
    }
    .money {
        color: #555;
    }
    .charge-btn {
        margin-top: 20px;
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        background-color: #3498db;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }
    .charge-btn:disabled {
        background-color: #aaa;
        cursor: not-allowed;
    }
</style>
</head>
<body>
<div class="wrap">
    <div class="header">
        <h1>타래 충전</h1>
    </div>

    <div class="content">
        <div class="mycoin">
            <span class="label">나의 보유 타래</span>
            <span id="myCoin" class="amount">${userPoint} 타래</span>  
        </div>
	<br><br><br>
        <form action="./addMoney" method="post">
	        <div class="payment-select-wrap">
	            <div class="payment-select">
	            	
	                <input type="hidden" name="coin" id="selectedMoney" value="">
	                <div class="coinbox" onclick="setValue(1000,1)">
	                    <span class="coin">1타래</span>
	                    <span class="money">1000원</span>
	                </div>
	                <div class="coinbox" onclick="setValue(3000,3)">
	                    <span class="coin">3타래</span>
	                    <span class="money">3000원</span>
	                </div>
	                <div class="coinbox" onclick="setValue(5000,5)">
	                    <span class="coin">5타래</span>
	                    <span class="money">5000원</span>
	                </div>
	                <div class="coinbox" onclick="setValue(10000,10)">
	                    <span class="coin">10타래</span>
	                    <span class="money">10000원</span>
	                </div>
	                <div class="coinbox" onclick="setValue(30000,30)">
	                    <span class="coin">30타래</span>
	                    <span class="money">30000원</span>
	                </div>
	                <div class="coinbox" onclick="setValue(50000,50)">
	                    <span class="coin">50타래</span>
	                    <span class="money">50000원</span>
	                </div>
	                
	            </div>
		<br><br>
	        </div>
	        <button class="charge-btn" id="chargeBtn" disabled>충전하기</button>
	</form>
</div></div>

<script>
/*
 * 1. 금액 버튼을 누르면 누른 상태로 유지 되어야한다.
   2. 금액 버튼을 눌러야만 충전하기 버튼이 눌린다.
   3. value 값을 서블릿에 전달해야한다.
 */
 	
    const coinBoxes = document.querySelectorAll('.coinbox'); /*.coinbox를 모두 모아 담는다.*/
    const chargeBtn = document.getElementById('chargeBtn'); /*충전하기 버튼 가져오기*/
    let selectedMoney = 0; //어떤 금액을 선택했는지 저장할 공간

    coinBoxes.forEach(box => { //모든 상자
        box.addEventListener('click', () => {
            coinBoxes.forEach(b => b.classList.remove('selected'));
            box.classList.add('selected'); //해당 slected를 붙여버린다.
            
        });
    });
    function setValue(money,coin){
    	//input가져오기(id이용)
    	const hiddenInput = document.getElementById("selectedMoney");
    	// value에 금액 저장하기
    	hiddenInput.value = coin;
    	selectedMoney = money; // 만약 얼마 들었는지 구현하려면 이 변수를 이용한다.
    	
    	chargeBtn.disabled = false;
	chargeBtn.addEventListener('click', () => {
		
	        alert(selectedMoney+"원 결제 완료!"+"\n"+coin+" 타래를 충전합니다.");
	        
	 });
    }
   
</script>
</body>
</html>
