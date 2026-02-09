//북마크 토글, 장바구니 토글 동작 처리 js
//jsp에서 게시글 번호→js 함수→북마크 토글 서블릿 호출→클라이언트에게 반영

//북마크 토글 메서드
function toggleBookmark(element, boardNo) {
    const icon = element.querySelector('.bookmark-icon');
    
    // 서블릿(/toggleBookmark.do) 호출
    fetch('/handiboard02/toggleBookmark?boardNo=' + boardNo)
        .then(response => response.json())
        .then(data => {
            if (data.result === 1) {
                icon.src = 'book_filled.png'; // 추가됨
            } else if (data.result === 0) {
                icon.src = 'book_empty.png';  // 해제됨
            } else if (data.result === -2) {
                alert("로그인 후 이용 가능합니다.");
				location.href = "login"; // 로그인 페이지로 유도
            } else if (data.result === -1) {
			    alert("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
							
			}
        });
}

//장바구니 토글 메서드 (추가 예정)