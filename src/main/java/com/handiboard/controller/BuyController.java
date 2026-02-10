package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dao.ShopDAO;
import com.handiboard.dto.OrderDTO;
import com.handiboard.dto.ShopDTO;

@WebServlet("/buy/*")
public class BuyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ShopDAO shopDao = new ShopDAO();
       
    public BuyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = uri.substring(contextPath.length());
		
		// 바로 구매 
		if (command.equals("/buy/buy.do")) {
			int shopNo = Integer.parseInt(request.getParameter("shop_no"));
			
			// 상품 상세 정보 가져오기 
			ShopDTO shop = shopDao.getDetail(shopNo);
			
			// ORderDTO에 정보 옮겨담기 (데이터 규격화를 위함)
			OrderDTO order = new OrderDTO();
		    order.setShop_no(shop.getShop_no());
		    order.setItem_name(shop.getItem_name());
		    order.setItem_price(shop.getItem_price());
		    order.setImg_path(shop.getImg_path());
			
			// 규격을 맞추기 위해 리스트 생성 후 1개만 담기
			List<OrderDTO> buyList = new ArrayList<OrderDTO>();
			buyList.add(order);
			
			// 총 결제 금액 (상품 1개)
			int totalPrice = order.getItem_price();
			
			// 결제 정보 전달
			request.setAttribute("buyList", buyList);
			request.setAttribute("totalPrice", totalPrice);
			
			// 결제 화면 이동 (Forward 방식으로 buy.jsp 화면으로 이동합니다)
			request.getRequestDispatcher("/views/buy/buy.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션 정보 가져오기
		String buyerId = (String)request.getSession().getAttribute("userId");

		// 결제할 상품 리스트
		String[] shopNos = request.getParameterValues("shop_nos");
		int totalPrice = Integer.parseInt(request.getParameter("total_price"));
		
		// DAO에서 트랜잭션 처리 
		//boolean success = buyDAO.executePurchase(userNo, shopNos, totalPrice);
		
		boolean success = false; // 임시
		if (success) {
			response.sendRedirect("success.jsp");
		}
	}

}
