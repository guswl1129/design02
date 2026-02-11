<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타래 충전</title>
<style>
    /* 전체 배경 및 레이아웃 */
    body {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        background-color: #f8f9fa; /* 연한 회색 배경 */
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }

    /* 상단 헤더 (디자인 통일) */
    .myHeader {
        width: 100%;
        max-width: 450px;
        background-color: #ffffff;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-sizing: border-box;
        border-bottom: 1px solid #eee;
        font-weight: bold;
        font-size: 1.1rem;
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .myHeader a {
        text-decoration: none;
        color: #333;
        font-size: 1.2rem;
        padding: 5px;
    }

    /* 메인 컨테이너 */
    .wrap {
        width: 100%;
        max-width: 450px;
        background-color: #ffffff;
        min-height: calc(100vh - 56px);
        padding: 30px 20px;
        box-sizing: border-box;
        text-align: center;
    }

    /* 보유 코인 박스 */
    .mycoin {
        background-color: #f3e8ff; /* 아주 연한 보라 */
        border-radius: 12px;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        border: 1px solid #e9d5ff;
    }

    .mycoin .label {
        font-size: 0.95rem;
        color: #6b21a8; /* 진한 보라 */
        font-weight: 600;
    }

    .mycoin .amount {
        font-size: 1.2rem;
        font-weight: 800;
        color: #7e22ce;
    }

    /* 충전 선택 그리드 (기존 유지 및 디자인 강화) */
    .payment-select {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px; /* 간격 최적화 */
        margin-bottom: 30px;
    }

    .coinbox {
        background-color: #ffffff;
        border: 2px solid #f3f4f6;
        border-radius: 12px;
        padding: 20px 10px;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .coinbox:hover {
        border-color: #d8b4fe;
        background-color: #faf5ff;
    }

    .coinbox.selected {
        border-color: #a855f7; /* 포인트 보라 */
        background-color: #f3e8ff;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(168, 85, 247, 0.1);
    }

    .coin {
        font-size: 1.1rem;
        font-weight: 700;
        color: #333;
    }

    .money {
        font-size: 0.9rem;
        color: #888;
    }

    .coinbox.selected .coin { color: #7e22ce; }
    .coinbox.selected .money { color: #a855f7; }

    /* 충전 버튼 */
    .charge-btn {
        width: 100%;
        padding: 16px;
        border: none;
        border-radius: 12px;
        background-color: #a855f7;
        color: white;
        font-size: 1.1rem;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s;
        margin-top: 80px;
    }

    .charge-btn:hover {
        background-color: #9333ea;
    }

    .charge-btn:disabled {
        background-color: #e5e7eb;
        color: #9ca3af;
        cursor: not-allowed;
    }
</style>
</head>
<body>

    <div class="myHeader">
        <span>타래 충전</span>
        <a href="myPage">✕</a>
    </div>
	
    <div class="wrap">
        <div class="mycoin">
            <span class="label">나의 보유 타래</span>
            <span id="myCoin" class="amount">${userPoint} 타래</span>  
        </div>

        <form action="./addPoint" method="post" id="chargeForm">
            <input type="hidden" name="coin" id="selectedMoneyInput" value="">
            
            <div class="payment-select">
                <div class="coinbox" onclick="setValue(1000, 1, this)">
                    <span class="coin">1타래</span>
                    <span class="money">1,000원</span>
                </div>
                <div class="coinbox" onclick="setValue(3000, 3, this)">
                    <span class="coin">3타래</span>
                    <span class="money">3,000원</span>
                </div>
                <div class="coinbox" onclick="setValue(5000, 5, this)">
                    <span class="coin">5타래</span>
                    <span class="money">5,000원</span>
                </div>
                <div class="coinbox" onclick="setValue(10000, 10, this)">
                    <span class="coin">10타래</span>
                    <span class="money">10,000원</span>
                </div>
                <div class="coinbox" onclick="setValue(30000, 30, this)">
                    <span class="coin">30타래</span>
                    <span class="money">30,000원</span>
                </div>
                <div class="coinbox" onclick="setValue(50000, 50, this)">
                    <span class="coin">50타래</span>
                    <span class="money">50,000원</span>
                </div>
            </div>

            <button type="submit" class="charge-btn" id="chargeBtn" disabled>충전하기</button>
        </form>
    </div>

<script>
    const chargeBtn = document.getElementById('chargeBtn');
    let selectedAmount = 0;
    let selectedCoin = 0;

    function setValue(money, coin, element) {
        // 모든 박스에서 selected 제거
        const coinBoxes = document.querySelectorAll('.coinbox');
        coinBoxes.forEach(box => box.classList.remove('selected'));
        
        // 클릭한 박스에 selected 추가
        element.classList.add('selected');
        
        // 값 저장
        document.getElementById("selectedMoneyInput").value = coin;
        selectedAmount = money;
        selectedCoin = coin;
        
        // 버튼 활성화
        chargeBtn.disabled = false;
    }

    // 폼 제출 시 알림창 띄우기
    document.getElementById('chargeForm').onsubmit = function() {
        return confirm(selectedAmount.toLocaleString() + "원을 결제하고 " + selectedCoin + "타래를 충전하시겠습니까?");
    };
</script>
</body>
</html>