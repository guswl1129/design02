package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dto.BoardDTO;

@WebServlet("/delete")
public class BoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardDeleteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("delete doGet");
		
		int board_no;
		try {
			board_no=Integer.parseInt(request.getParameter("board_no"));
		} catch (Exception e) {
			System.out.println("invalid board_no format");
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		// 같은 사람인지 확인
		String userId = null;
		HttpSession session = request.getSession(false);
		userId = (String) session.getAttribute("userId");
		
		if (userId == null || board_no <= 0) {
		    response.sendRedirect(request.getContextPath()+"/board");
		    return;
		}

		BoardDAO dao = new BoardDAO();
		BoardDTO dto=dao.getBoard(board_no);
		
		if(userId.equals(dto.getUser_id())) {
			dao.deleteBoard(dto);
		}
		else {
			System.out.println("작성자가 다름");
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}
		
		response.sendRedirect(request.getContextPath() + "/board");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("delete doPost");
	}

}

