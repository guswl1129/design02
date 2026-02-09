package com.handiboard.controller;

import java.io.IOException;
import java.util.List;

import com.handiboard.dao.OrderDAO;
import com.handiboard.dto.OrderDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CartListController", urlPatterns = { "/CartList" })
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO cartDao;
       
    public CartController() {
        super();
    }
    //init()에서 DAO 생성
    @Override
    public void init() throws ServletException {
        cartDao = new OrderDAO();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//현재 로그인된 세션 정보 가져오기
		HttpSession session = request.getSession(false); //false:기존 생성 세션만 처리
		
		//로그인 상태로 분기
		if(session != null && session.getAttribute("userId") != null ) {
			//DAO 메서드 호출: 장바구니 쿼리결과 가져오기 , 반환값= List<ShopDTO>
			String userId = (String)session.getAttribute("userId");
			List<OrderDTO> cartList = cartDao.getOrderList(userId, 1);
			
			//클라이언트로 전송: request에 dao에서 처리한 값 담기
			//저장한 북마크 목록이 없는 경우 DAO에서  값 설정 -> jsp에서 없음 출력 : bookList.isEmpty()
			request.setAttribute("cartList", cartList); 
			request.getRequestDispatcher("cartList.jsp").forward(request, response);
		}
		else {
			response.sendRedirect("login.jsp");
		}	
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}
