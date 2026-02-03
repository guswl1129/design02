package com.handiboard.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dto.BoardDTO;

@WebServlet("/updateAction")
public class BoardUpdateActionService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardUpdateActionService() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// not used
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("updateAction doPost");
		request.setCharacterEncoding("UTF-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		int board_no=request.getParameter("board_no")!=null?Integer.parseInt(request.getParameter("board_no")):-1;
		
		BoardDTO dto=new BoardDTO();
		dto.setTitle(title);
		dto.setContent(content);
		// Ensure the board number is set so updateBoard can find the row
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