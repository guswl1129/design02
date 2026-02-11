package com.handiboard.controller;

import java.io.IOException;

import com.handiboard.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class InCartController
 */
@WebServlet("/inCart")
public class InCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;
       
    public InCartController() {
        super();
    }
    
    //init()에서 DAO 생성
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
    /**jsp에서 할일 1)
     * <form></form> 태그 이용해서 페이지별로 분기하기
     * 
     * <form action="/inCart" method="post">
    		<input type="hidden" name="shop_no" value="${post.shop_no}">
    		<input type="hidden" name="from" value="detail">
    		<button type="submit">장바구니 담기</button>
	    </form>
	    
	    <form action="/cart/toggle" method="post">
    		<input type="hidden" name="shop_no" value="${item.shop_no}">
    		<input type="hidden" name="from" value="cart">
    		<button type="submit">삭제하기</button>
		</form>
		
     * jsp에서 할일 2) msg로 오류 상태 분류하기
     *
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 1. 현재 로그인된 세션 정보 가져오기
	    HttpSession session = request.getSession(false); 
	    
	    // 2. 로그인 상태로 분기 
	    if(session != null && session.getAttribute("userId") != null ) {
	        
	        // 데이터 파라미터 수집
	        String userId = (String)session.getAttribute("userId");
	        int shopNo = Integer.parseInt(request.getParameter("shop_no"));
	        int itemNo = Integer.parseInt(request.getParameter("item_no"));
	        
	        String from = request.getParameter("from"); // 호출 위치 구분 ("detail" 또는 "cart")
	        
	        int result = -1;
	        
	        // [1번째 경우] 판매글 본문에서 클릭한 경우
	        if ("detail".equals(from)) {
	            // 이미 장바구니에 존재하는지 먼저 확인 (isInCart)
	            int cartStatus = orderDAO.isInCart(userId, shopNo);
	            
	            if (cartStatus == 1) {
	                // 이미 존재함: 경고 메시지와 함께 본문으로 리다이렉트
	                response.sendRedirect(request.getContextPath() + "/shop/detail.do?shop_no=" + shopNo + "&msg=already_exists");
	                return;
	            } else if (cartStatus == 0) {
	                // 존재하지 않음: 토글(등록) 메서드 호출
	                result = orderDAO.insertInCart(userId, shopNo, itemNo);
	                if (result == 1) {
	                    response.sendRedirect(request.getContextPath() + "/shop/detail.do?shop_no=" + shopNo + "&msg=add_success");
	                } else if(result==-1){
	                    handleError(response, result, "/detail.do?shop_no=" + shopNo);
	                } 
	            } else if(cartStatus==2){
                	response.sendRedirect(request.getContextPath() + "/shop/detail.do?shop_no=" + shopNo + "&msg=already_purchased");
                } else {
	                // DB 에러 (-1)
	                handleError(response, -1, request.getContextPath() + "/shop/detail.do?shop_no=" + shopNo);
	            }
	        } 
	        
	        // [2번째 경우] 장바구니 페이지에서 클릭한 경우 (해제)
	        else if ("cart".equals(from)) {
	            result = orderDAO.toggleInCart(userId, shopNo, itemNo);
	            if (result == 1) {
	                // 성공적으로 해제됨: 장바구니 목록으로 다시 이동
	                response.sendRedirect(request.getContextPath() + "/CartList?msg=remove_success");
	            } else {
	                handleError(response, result, request.getContextPath() + "/CartList");
	            }
	        }
	    }
	    else {
	        // 로그인 상태가 아니면 로그인 페이지로 리다이렉트
	    	// 현재 페이지의 주소를 가져와서 로그인 페이지로 전달
	        response.sendRedirect("login.jsp");
	    }
	}

	// 에러 상황에 따른 리다이렉트 공통 메서드
	private void handleError(HttpServletResponse response, int result, String redirectPath) throws IOException {
	    if (result == 0) {
	        response.sendRedirect(redirectPath + "&msg=invalid_shop"); //유효하지 않은 shop_no
	    } else {
	        response.sendRedirect(redirectPath + "&msg=db_error"); //db 오류
	    }
	}

}
