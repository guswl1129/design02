package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.mindrot.bcrypt.BCrypt;

import com.handiboard.dto.UserDTO;

import com.handiboard.dao.InsertMemberDAO;


@WebServlet("/join")
public class JoinController extends HttpServlet {
	 
	private static final long serialVersionUID = 1L;
       
    public JoinController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("join.jsp");
		rd.forward(request, response);
	
	}

	// 데이터베이스 연결 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 설정 
		request.setCharacterEncoding("UTF-8");
		
		// 파라미터 수집
		String userid = request.getParameter("userid");
		String userpw = request.getParameter("userpw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		// BCrypt 암호화 
		// BCrypt.hashpw(비밀번호, 솔트) 
		// BCrypt.getsalt() : 암호화를 강력하게 하는 무작위 값 생성
		String encryptedPw = BCrypt.hashpw(userpw, BCrypt.gensalt());
		// 암호화된 문자열을 저장 -> dto에 담아 데이터베이스에 전달 
		
		// DTO에 담기 
		UserDTO dto = new UserDTO();
		dto.setId(userid);
		dto.setPw(encryptedPw);
		dto.setName(name);
		dto.setEmail(email);
		
		// DAO 호출
		InsertMemberDAO dao = new InsertMemberDAO();
		int result = dao.insertMember(dto);
		
		// result 결과 처리 
		if (result > 0) {
			response.sendRedirect("joinOk.jsp?success=1"); // 가입 성공 시 가입 성공 페이지로 
		} else {
			response.sendRedirect("join.jsp?error=1"); // 가입 실패 시 다시 회원가입 페이지로 
			
		}
		
		
		
	
	}

}
