package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.handiboard.dao.LoginDAO; // 실제 패키지 경로에 맞게 수정
import com.handiboard.dto.UserDTO; // 실제 패키지 경로에 맞게 수정

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("post로 요청이 들어옵니다");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		System.out.printf("ID : %s, PW : %s", id, pw);
		// index.html, index.htm, index.jsp <-이게 다 없으면 404, tomcat에서 설정
		// 데이터베이스 접속 DBConn.java, LoginDAO.java, LoginDTO.java
		LoginDAO dao = new LoginDAO();
		UserDTO dto = new UserDTO();
		dto.setId(id);
		dto.setPw(pw);

		dao.login(dto);
		System.out.println(dao.login(dto));
		System.out.println(dto.getCount());
		System.out.println(dto.getName());

		if (dto.getCount() == 1) {
			System.out.println("로그인 성공");
			// 디스패치 사용
			request.setAttribute("nickname", dto.getName());
			
			HttpSession session = request.getSession();
			session.setAttribute("user", dto);
			session.setAttribute("userId", dto.getId()); // 로그인한 유저의 아이디를 세션에 저장
			session.setAttribute("userPoint", dto.getPoint()); // 로그인한 유저의 포인트를 세션에 저장

			RequestDispatcher rd = request.getRequestDispatcher("loginAction.jsp");
			rd.forward(request, response);
		} else {
			System.out.println("아이디 또는 패스워드 오류");
//			response.sendRedirect("./login.jsp");
			// 로그인 실패: 주소 뒤에 err=1 이라는 신호를 붙임
		    response.sendRedirect("login.jsp?err=1");
		}
	}

}

