package com.handiboard.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dto.BoardDTO;

@WebServlet("/writeAction")
public class BoardWriteActionService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardWriteActionService() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		not used
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("writeAction doPost");
		request.setCharacterEncoding("UTF-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String user_id=request.getParameter("user_id");

		
		BoardDTO dto=new BoardDTO();
		dto.setTitle(title);
		dto.setContent(content);
		// 예외처리(안됨)
		try {
			dto.setUser_id(user_id); // user_id 입력받는 걸로 설정
		} catch (Exception e) {
			dto.setUser_id("duck"); // 예외 발생 시 기본값 설정
		}
		
		BoardDAO dao=new BoardDAO();
		dao.createBoard(dto);
		// PRG: 저장 후 리스트 서블릿으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/board");
	}

}
