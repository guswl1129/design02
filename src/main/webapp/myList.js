//북마크 토글, 장바구니 토글 동작 처리 js
//jsp에서 게시글 번호→js 함수→북마크 토글 서블릿 호출→클라이언트에게 반영

document.addEventListener("DOMContentLoaded", function() {
    const bookmarkBtn = document.querySelector('.bookmark-btn');
    
    if (bookmarkBtn) {
        // dataset을 통해 HTML에 심어진 데이터를 읽어옴
        const errorStatus = bookmarkBtn.dataset.dbError;

        if (errorStatus === "bookmarkError") {
            alert("시스템 오류로 북마크를 사용할 수 없습니다.");
            bookmarkBtn.disabled = true;
            bookmarkBtn.style.opacity = "0.5";
            bookmarkBtn.onclick = null; // 클릭 방지
        }
    }
});

//북마크 토글 메서드
function toggleBookmark(element, boardNo) {
	console.log("[DEBUG] toggleBookmark called", boardNo);
    const icon = element.querySelector('.bookmark-icon');
    
    // 서블릿(/toggleBookmark.do) 호출
    fetch('/handiboard02/toggleBookmark?boardNo=' + boardNo)
        .then(response => response.json())
        .then(data => {
            if (data.result === 1) {
				icon.classList.add('active'); //css에서 png 제어 목적 - 사진에 클래스명 부여
                icon.src = 'book_filled.png'; // 추가됨
            } else if (data.result === 0) {
				icon.classList.remove('active');
                icon.src = 'book_empty.png';  // 해제됨
            } else if (data.result === -2) {
				requireLogin();
            } else if (data.result === -1) {
			    alert("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
							
			}
        });
}

//로그인 후 이용 메서드로 분리
function requireLogin() {
    alert("로그인 후 이용 가능합니다.");
	let path = window.location.pathname + window.location.search;
	//컨텍스트(/handiboard02) 제거해서 /postdetail?... 형태로 만들기
	if (path.startsWith(contextPath)) {
	    path = path.substring(contextPath.length);
	  }
	const currentUrl = encodeURIComponent(path);
	
	const target = contextPath + "/login?prevUrl=" + currentUrl;
	console.log("[DEBUG] requireLogin target:", target);

    location.href = contextPath + "/login?prevUrl=" + currentUrl;
}


