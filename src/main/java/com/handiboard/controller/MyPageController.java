package com.handiboard.controller;

import java.io.IOException;

import com.handiboard.dao.MypageDAO;
import com.handiboard.dto.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myPageController")
public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageDAO dao; 
	
    public MyPageController() {
        super();
    }
    
    @Override
    public void init() throws ServletException {
        dao = new MypageDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if(session != null && session.getAttribute("userId") != null ) {
			String userId = (String)session.getAttribute("userId");
			UserDTO userDTO = dao.getUserinfo(userId);
			
			if (userDTO != null) {
		            request.setAttribute("user", userDTO);
		            request.getRequestDispatcher("mypage.jsp").forward(request, response);
		    } else {
		            response.sendRedirect("login.jsp");
		    }			
		}
		else {
			response.sendRedirect("login.jsp");
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}
/**
 *  생성자
 * 	//호출 주체: JVM
	//톰캣이 서블릿 객체를 메모리에 올릴 때 가장 먼저 호출
	//서블릿으로서의 자격을 갖추기 전
	 
	init()
	//호출 주체: 톰캣
	//서블릿에 환경 설정 정보가 세팅된 후, 호출
	//웹 기반인 서블릿은 생성자보다 init() 사용이 권장됨
 * **/
