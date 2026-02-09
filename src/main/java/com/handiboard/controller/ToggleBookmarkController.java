package com.handiboard.controller;

import java.io.IOException;

import com.handiboard.dao.BookmarkDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/toggleBookmark")
public class ToggleBookmarkController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ToggleBookmarkController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 1. 응답 형식 먼저 설정 (에러 상황에서도 JSON을 보내기 위함)
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        int result = -1; // 기본값: 에러 발생 시 반환할 값

        try {
            // 2. 파라미터 및 세션 정보 가져오기
            String userId = (String) request.getSession(false).getAttribute("userId");
            String boardNoStr = request.getParameter("boardNo");

            // 로그인이 안 된 경우 처리
            if (userId == null) {
                result = -2; // 로그인 필요 상태 코드 (예시)
            } 
            // 파라미터가 비어있는지 확인
            else if (boardNoStr != null && !boardNoStr.isEmpty()) {
                int boardNo = Integer.parseInt(boardNoStr); // 숫자가 아닐 경우 NumberFormatException 발생
                
                // 3. DAO 호출 (DB 작업)
                BookmarkDAO dao = new BookmarkDAO();
                result = dao.toggleBookmark(userId, boardNo); //0
            }

        } catch (NumberFormatException e) {
            // boardNo가 숫자가 아닌 경우 예외 처리
            System.out.println("잘못된 게시글 번호 형식입니다.");
            e.printStackTrace();
        } catch (Exception e) {
            // 그 외 예기치 못한 모든 에러 처리
            System.out.println("서블릿 실행 중 에러 발생");
            e.printStackTrace();
        } finally {
            // 4. 최종 결과 전송 (성공하든 에러가 나든 클라이언트에 응답)
            response.getWriter().write("{\"result\": " + result + "}");
        }
	
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
