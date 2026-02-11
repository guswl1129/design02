package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dao.BuyDAO;
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
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = uri.substring(contextPath.length());
		
		// 결제 페이지 진입 (바로구매/장바구니 통합)
		if (command.equals("/buy/buy.do")) {
			// 세션에서 로그인한 유저 ID 가져오기
			String userId = (String)request.getSession().getAttribute("userId");
			
			// BuyDAO 객체 생성
			BuyDAO buyDao = new BuyDAO();
			// DB에서 최신 포인트 조회
			int userPoint = buyDao.getPoint(userId);
			// JSP에서 쓸 수 있도록 request에 담기
			request.setAttribute("userPoint", userPoint);
			
			System.out.println("userPoint 조회 시도--------------------");
			System.out.println("userId : " + userId);
			System.out.println("userPoint : " + userPoint);
			
			
			// 파라미터를 배열로 받습니다.
			String[] shopNoArray = request.getParameterValues("shop_no");
			
			List<OrderDTO> buyList = new ArrayList<OrderDTO>();
			int totalPrice = 0;
			
			if (shopNoArray != null) {
                for (String no : shopNoArray) {
                    int id = Integer.parseInt(no);
                    ShopDTO shop = shopDao.getDetail(id); // 상품 상제정보 가져오기 
                    
                    if (shop != null) {
                        // OrderDTO로 규격화 (결제창에 필요한 최소 정보들)
                        OrderDTO order = new OrderDTO();
                        order.setShop_no(shop.getShop_no());
                        order.setItem_no(shop.getItem_no());   // DB 저장 시 필수
                        order.setItem_name(shop.getItem_name());
                        order.setItem_price(shop.getItem_price());
                        order.setImg_path(shop.getImg_path());
                        
                        order.setSeller_id(shop.getUser_no());   // Shop의 글쓴이가 Order의 판매자가 됨
                        order.setSeller_name(shop.getUser_id()); // Shop의 작성자ID가 Order의 판매자이름이 됨
                        
                        buyList.add(order);
                        totalPrice += shop.getItem_price(); // 총액 누적
                    }
                }
            }
			
			// 데이터를 담아 buy.jsp로 전달
            request.setAttribute("buyList", buyList);
            request.setAttribute("totalPrice", totalPrice);
            // 결제 화면 이동 (Forward 방식으로 buy.jsp 화면으로 이동합니다)
            request.getRequestDispatcher("/views/buy/buy.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 설정 (한글 깨짐 방지)
	    request.setCharacterEncoding("UTF-8");
		
		// 실제 결제 로직 (buy.jsp에서 결제 버튼 클릭 시)
	    // 세션에서 구매자 아이디 가져오기
		String buyerId = (String)request.getSession().getAttribute("userId");
		if (buyerId == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		
		// buy.jsp의 파라미터 받기 (배열)  
		String[] shopNos = request.getParameterValues("shop_nos");
		String[] itemNos = request.getParameterValues("item_nos");
		int totalPrice = Integer.parseInt(request.getParameter("total_price"));
		
		// BuyDAO 호출 (트랜잭션: 포인트 차감, 판매자 수익 증가, 구매 기록 저장) 
		// 구매 로직 실행
        BuyDAO buyDao = new BuyDAO();
        
        // 복수 구매를 처리하기 위해 DAO에 배열을 그대로 넘김. -> 복수 구매 ? 
        boolean success = buyDao.executePurchase(buyerId, shopNos, itemNos, totalPrice);
		
		
		// 결과에 따라 페이지 이동
		if (success) {
			// 결제 완료 후 세션 포인트 갱신 (선택 사항: DB 재조회 대신 계산으로 처리)
	        Integer currentPoint = (Integer)request.getSession().getAttribute("userPoint");
			if(currentPoint != null) {
	            request.getSession().setAttribute("userPoint", currentPoint - totalPrice);
	        }
			
			// 성공 페이지로 이동
			response.sendRedirect(request.getContextPath() + "/buy/success.do");
			
		} else {
			// 실패 처리
			response.setContentType("text/html; charset=UTF-8");
	        response.getWriter().println("<script>alert('결제 실패: 포인트가 부족하거나 오류가 발생했습니다.'); history.back();</script>");
		}
	}

}
