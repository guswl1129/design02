package com.handiboard.controller;

import java.io.IOException;

import com.handiboard.dto.UserDTO;
import com.handiboard.dao.AddPointDAO;
import com.handiboard.dao.InsertMemberDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class AddMoney
 */
@WebServlet("/addMoney")
public class AddPointController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPointController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("post");
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		int userPoint = (int) request.getSession().getAttribute("userPoint");
		System.out.println("현재 포인트"+userPoint);
		// 선택한 금액
		String coin = request.getParameter("coin");
		int point = Integer.parseInt(coin);
//		int ownPoint = (int) request.getSession().getAttribute("userPoint");
		System.out.println("충전 타래: "+coin);
		
		int sum = userPoint+point;
		
		// 로그인 확인
		if(userId==null) {
			response.sendRedirect("login.jsp");
			System.out.println("로그인 해주세요");
			return;
		}
		AddPointDAO dao = new AddPointDAO();
		UserDTO dto = new UserDTO();
//		request.setAttribute("mycoin", dto.getPoint());
		int result = dao.AddMoney(userId, sum);
		int result2=dao.updatedPoint(dto, userId);// 불러오기
//		dto.getPoint();
		if(result==1&&result2==1) {
			
			System.out.println("충전성공");
			session.setAttribute("userPoint", dto.getPoint());
			request.setAttribute("userPoint", dto.getPoint());
			response.sendRedirect("addMoney.jsp");
			// 타래 값을 바꿔야함
		}else {
			System.out.println("충전실패");
		}
		
//		
	}

}
