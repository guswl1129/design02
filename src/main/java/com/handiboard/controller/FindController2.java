package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.handiboard.dao.LoginDAO; // 실제 패키지 경로에 맞게 수정
import com.handiboard.dto.UserDTO; // 실제 패키지 경로에 맞게 수정

import java.io.IOException;
import java.sql.ResultSet;



// 패스워드를 새로 설정하기 위해 아이디, 이메일로 본인인증
@WebServlet("/find2")
public class FindController2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FindController2() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		
		LoginDAO dao = new LoginDAO();
		UserDTO dto = new UserDTO();
		
		dto.setId(id);
		dto.setEmail(email);
		
		dao.findPw(dto);
//		System.out.println(dto.setName());
		
		
		if(dto.getCount()==1) {
			System.out.println("새로운 패스워드를 입력하세요");
			// 어떤 아이디의 비번을 변경할건지 알아야하기 때문에 id도 읽어온다.
			request.setAttribute("userId", dto.getId());
			RequestDispatcher rd = request.getRequestDispatcher("newPw.jsp");
			rd.forward(request, response);
		}else {
			System.out.println("아이디 혹은 이메일이 틀립니다.");
			response.sendRedirect("./find2.jsp");
		}
	}

}
