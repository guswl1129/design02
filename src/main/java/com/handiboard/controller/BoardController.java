package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dto.BoardDTO;


@WebServlet("/board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데이터베이스에 물어서 데이터 가져오기->dao, dto
		// jsp에 출력->dispatcher??
		BoardDAO dao=new BoardDAO();
		List<BoardDTO> list =dao.getList();
		
		//데이터 첨부하기
		request.setAttribute("list", list);	//이름, 값
		
		RequestDispatcher rd=request.getRequestDispatcher("list.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
