package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dao.BookmarkDAO;
import com.handiboard.dto.BoardDTO;

@WebServlet("/detail")
public class BoardDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardDetailController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("detail doGet");
		
		request.setCharacterEncoding("UTF-8");
		
		int board_no;
		try {
			board_no=Integer.parseInt(request.getParameter("board_no"));
		} catch (Exception e) {
			System.out.println("invalid board_no format");
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		BoardDAO dao=new BoardDAO();
		
		//북마크 상태 jsp로 전달
        HttpSession session = request.getSession(false);
        int isBookmarked = 0;
        if(session != null && session.getAttribute("userId") != null ) {
        	String userId = (String)session.getAttribute("userId");
        	BookmarkDAO bookmarkDao = new BookmarkDAO();
        	isBookmarked = bookmarkDao.isBookmarked(userId, board_no);
        }
        //북마크 값 전달 + 북마크 상태 불러오기 에러 처리
        if(isBookmarked==-1) {
        	System.out.println("DB 에러 발생: 북마크 상태를 불러오지 못했습니다.");
        	request.setAttribute("isBookmarked", 0);
        	request.setAttribute("dbError", "bookmarkError"); // JSP에 에러 신호 보내기
        } else {
        	request.setAttribute("isBookmarked", isBookmarked);	
        }
		
		// 조회수 증가
		int updatedRows=dao.viewCount(board_no);	// 업데이트된 행 수
		System.out.println("updatedRows: "+updatedRows);
		if(updatedRows==0) {
			// 유효하지 않은 board_no?
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		BoardDTO dto=dao.getBoard(board_no);
		
		if(dto==null) {
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		request.setAttribute("dto", dto);

		RequestDispatcher rd=request.getRequestDispatcher("/postDetail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("detail doPost");
	}
}

