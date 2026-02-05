package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.handiboard.dao.MypageDAO;

@WebServlet("/bookmarkController")
public class BookmarkController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageDAO dao;
	
    public BookmarkController() {
        super();
    }
    //init()에서 DAO 생성
    @Override
    public void init() throws ServletException {
        dao = new MypageDAO();
    }    

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//현재 로그인된 세션 정보 가져오기
			//세션 기록으로 로그인 여부 확인
		
		//DAO 메서드 호출: 북마크 쿼리결과 가져오기
			//필요한 게시글 정보: board_title, board_like, 
			//반환값 ArrayList<BoardDTO>
		
		//request에 dao에서 처리한 값 담기
		request.setAttribute(LEGACY_DO_HEAD, response);
		//하위 페이지로 기존 request, response 보내기
		request.getRequestDispatcher("bookmarkList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}
