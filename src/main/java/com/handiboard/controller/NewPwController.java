package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.handiboard.dao.LoginDAO; // 실제 패키지 경로에 맞게 수정
import com.handiboard.dto.UserDTO; // 실제 패키지 경로에 맞게 수정

import java.io.IOException;

import org.mindrot.bcrypt.BCrypt;


//새 패스워드 설정을 위한 서블릿

@WebServlet("/newPw")
public class NewPwController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewPwController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// userID를 받는다.
		String id = request.getParameter("userId");
		String pw1 = request.getParameter("pw1");
		String pw2 = request.getParameter("pw2");
		
		System.out.println("입력 id : "+id);
		System.out.println("pw1: "+pw1);
		System.out.println("pw2: "+pw2);
		
		if(pw1 !=null && pw1.equals(pw2)) {
			LoginDAO dao = new LoginDAO();
			UserDTO dto = new UserDTO(); 
			
			dto.setId(id);
			String hashedPw = BCrypt.hashpw(pw1, BCrypt.gensalt());
			dto.setPw(hashedPw);
			
	
			if(dao.updatePw(dto)==1) {
				response.sendRedirect("./login.jsp");
			}
		}else {
			System.out.println("비밀번호가 없거나 일치하지 않습니다.");
			response.sendRedirect("./newPw.jsp");
		}
		
		
		
		
	}

}
