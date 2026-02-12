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
import com.handiboard.dto.BoardDTO;

@WebServlet("/update")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardUpdateController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("update doGet");
		
		int board_no;
		try {
			board_no=Integer.parseInt(request.getParameter("board_no"));
		} catch (Exception e) {
			System.out.println("invalid board_no format");
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		BoardDAO dao=new BoardDAO();
		BoardDTO dto=dao.getBoard(board_no);
		
		if(dto==null) {
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		request.setAttribute("dto", dto);
		
		RequestDispatcher rd = request.getRequestDispatcher("/editPost.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("update doPost");
		
		request.setCharacterEncoding("UTF-8");
		
		BoardDTO dto=new BoardDTO();
		
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String user_id=request.getParameter("user_id");
		int board_no=request.getParameter("board_no")!=null?Integer.parseInt(request.getParameter("board_no")):-1;
		
		String userId=null;
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		} else {
			userId = request.getParameter("userId");
		}
		// if still null or empty, cannot proceed - redirect to login or board list
		if (userId == null || userId.trim().isEmpty()) {
			System.out.println("userId is missing; redirecting to login page");
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
//			userId="duck"; // 임시 기본값 설정
		}
		
		// 같은 유저가 맞는지 확인
		if(userId!=null&&userId.equals(user_id)&&board_no > 0) {	// Ensure the BoardController number is set so updateBoard can find the row
			dto.setBoard_no(board_no);
			dto.setTitle(title);
			dto.setContent(content);
			
			BoardDAO dao=new BoardDAO();
			dao.updateBoard(dto);
		} else {
			System.out.println("updateAction: missing or invalid board_no: " + board_no);
			System.out.println("아이디가 달라 수정할 수 없음");
			System.out.println("userId: "+userId);
			System.out.println("user_id: "+user_id);
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		
		// PRG: 저장 후 리스트 서블릿으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/detail?board_no="+board_no);
	}

}