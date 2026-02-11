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
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		int board_no=request.getParameter("board_no")!=null?Integer.parseInt(request.getParameter("board_no")):-1;
		
		String userId=null;
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user_id") != null) {
			userId = (String) session.getAttribute("user_id");
		} else {
			userId = request.getParameter("user_id");
		}
		// if still null or empty, cannot proceed - redirect to login or board list
		if (userId == null || userId.trim().isEmpty()) {
			System.out.println("user_id is missing; redirecting to login page");
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
//			userId="duck"; // 임시 기본값 설정
		}
		
		BoardDTO dto=new BoardDTO();
		dto.setTitle(title);
		dto.setContent(content);
		// Ensure the BoardController number is set so updateBoard can find the row
		if(board_no > 0) {
			dto.setBoard_no(board_no);
		} else {
			System.out.println("updateAction: missing or invalid board_no: " + board_no);
		}
		
		BoardDAO dao=new BoardDAO();
		dao.updateBoard(dto);
		// PRG: 저장 후 리스트 서블릿으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/detail?board_no="+board_no);
	}

}