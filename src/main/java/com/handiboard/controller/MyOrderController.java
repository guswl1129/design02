package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.handiboard.dao.MyOrderDAO;
import com.handiboard.dao.MyPostsDAO;
import com.handiboard.dto.OrderDTO;

/**
 * Servlet implementation class MyOrderController
 */
@WebServlet("/myOrderController")
public class MyOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyOrderController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId"); // 세션에 저장된 ID 확인

        if (userId == null) {
            response.sendRedirect("login.jsp"); // 로그인 안 되어있으면 로그인 페이지로
            return;
        }

        MyOrderDAO dao = new MyOrderDAO();
        List<OrderDTO> orderList = dao.loadOrder(userId);

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
