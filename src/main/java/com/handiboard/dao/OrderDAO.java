package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.OrderDTO;
import com.handiboard.util.DBConnection;

public class OrderDAO {
	//장바구니/구매 목록 불러오기 메서드
	public List<OrderDTO> getOrderList(String userID, int status) {
		List<OrderDTO> cartList=new ArrayList<OrderDTO>();
		
		//sql문
		String sql = "SELECT * FROM v_order_info WHERE buyer_id = ? AND status = ? ORDER BY order_date DESC";
		//커넥션 객체 생성 , (sql문+커넥션 객체)-> 전송 객체로 조립=pstmt
		try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
				) {
			
			pstmt.setString(1, userID);
			pstmt.setInt(2, status);
	        
			//pstmt로 쿼리결과 받아오기
			try(ResultSet rs = pstmt.executeQuery()){
				//쿼리결과 list에 반복문으로 저장
				while(rs.next()) {
					OrderDTO dto = new OrderDTO(); //객체 참조 따라서 매번 생성
					dto.setOrder_no(rs.getInt("order_no"));
	                dto.setBuyer_id(rs.getString("buyer_id"));
	                dto.setStatus(rs.getInt("status"));
	                dto.setOrder_date(rs.getString("order_date"));
	                dto.setShop_no(rs.getInt("shop_no"));
	                dto.setShop_title(rs.getString("shop_title"));
	                dto.setSeller_id(rs.getInt("seller_id"));
	                dto.setSeller_name(rs.getString("seller_name"));
	                dto.setItem_no(rs.getInt("item_no"));
	                dto.setItem_name(rs.getString("item_name"));
	                dto.setItem_price(rs.getInt("item_price"));
	                dto.setImg_path(rs.getString("img_path"));
					
				    cartList.add(dto);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cartList;
	}
	
	//장바구니 등록 및 해제하기
	//장바구니 버튼 클릭시 토글 메소드
	//장바구니 상태 검사 메소드
	// 장바구니 상태 검사 메소드 (status 0: 장바구니 담김 상태)
	public int isInCart(String userId, int shopNo) {
	    // 이미 결제 완료(status=1)된 것이 아니라, 장바구니(status=0)에 있는지 확인
	    String sql = "SELECT COUNT(*) AS count FROM Orders WHERE buyer_id = ? AND shop_no = ? AND status = 0";
	    int result = -1;
	    
	    try (Connection conn = DBConnection.getInstance().getConn();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, shopNo);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                // 결과가 있으면 1(장바구니에 있음), 없으면 0(없음) 반환
	                result = (rs.getInt("count") >= 1) ? 1 : 0;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result; 
	}
	//장바구니 추가 메소드
	//장바구니 삭제 메소드
}
