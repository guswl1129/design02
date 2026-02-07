package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.handiboard.dao.ShopDAO;
import com.handiboard.dto.ShopDTO;

@WebServlet("/shop/*")
public class ShopController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ShopController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// URL 끝부분(Action)을 분석해 해당 기능을 수행 
		String uri = request.getRequestURI();	// 요청을 받아오기 
		String contextPath = request.getContextPath();
		String command = uri.substring(contextPath.length());
		
		ShopDAO dao = new ShopDAO();
		
		if (command.equals("/shop/list.do")) {
			// 판매 목록 조회
			List<ShopDTO> list = dao.getList();
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/shop/list.jsp").forward(request, response);
			
		} else if (command.equals("/shop/write.do")) {
			// 판매 글쓰기 폼으로 이동 
			response.sendRedirect(request.getContextPath() + "/views/shop/write.jsp");
			
		} else if (command.equals("/shop/insert.do")) {
			// 실제 DB 저장 로직 (POST 처리 권장) 
			// 파라미터 받아서 dao.createShop(dto) 호출! 			
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response); // POST 요청도 위 로직에서 함께 처리 
	}

}
