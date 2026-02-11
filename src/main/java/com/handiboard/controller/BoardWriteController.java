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

@WebServlet("/write")
public class BoardWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardWriteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("write doGet");
		RequestDispatcher rd=request.getRequestDispatcher("/writePost.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("write doPost");
		
		request.setCharacterEncoding("UTF-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		
		String userId=null;
		HttpSession session = request.getSession(false);
		
		System.out.println("userId: "+session.getAttribute("userId"));
		
		if (session != null && session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		} else {
			userId = request.getParameter("userId");
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
		dto.setUser_id(userId); // user_id 입력받는 걸로 설정

		
		BoardDAO dao=new BoardDAO();
		dao.createBoard(dto);
		// PRG: 저장 후 리스트 서블릿으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/board");
	}

}