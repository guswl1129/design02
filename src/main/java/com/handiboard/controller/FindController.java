package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


import com.handiboard.dao.LoginDAO; // 실제 패키지 경로에 맞게 수정
import com.handiboard.dto.UserDTO; // 실제 패키지 경로에 맞게 수정

// 아이디를 찾는 서블릿

@WebServlet("/find")
public class FindController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FindController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
		System.out.println("post로 요청이 들어옵니다");
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		
		
		LoginDAO dao = new LoginDAO();
		UserDTO dto = new UserDTO();
		dto.setName(name);
		dto.setEmail(email);
		dao.findId(dto);
		
		
		System.out.println(dao.findId(dto));
		System.out.println(dto.getCount());
		
		if(dto.getCount()==1) {
			System.out.println("아이디를 찾았습니다.");
			// 디스패치 사용
			request.setAttribute("user_id", dto.getId());
			
			RequestDispatcher rd = request.getRequestDispatcher("findId.jsp");
			rd.forward(request, response);
		} else {
			System.out.println("아이디를 찾지 못했습니다.");
			response.sendRedirect("./find.jsp"); //다시 접속하라는 의미

		}
	}

}
