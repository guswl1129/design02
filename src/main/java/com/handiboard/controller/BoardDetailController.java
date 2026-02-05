package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.handiboard.dao.BoardDAO;
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
		BoardDTO dto=dao.getBoard(board_no);
		
		if(dto==null) {
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		request.setAttribute("dto", dto);

		RequestDispatcher rd=request.getRequestDispatcher("postDetail.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("detail doPost");
	}
}

