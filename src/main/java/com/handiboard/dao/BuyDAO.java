package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.handiboard.dto.OrderDTO;
import com.handiboard.util.DBConnection;

public class BuyDAO {
	
	/**
    * 통합 구매 처리 (트랜잭션)
    * @param buyerId  구매자 ID
    * @param shopNos  구매할 게시글 번호 배열
    * @param itemNos  구매할 아이템 번호 배열
    * @param totalPrice 총 결제 금액
    */
	public boolean executePurchase(String buyerId, String[] shopNos, String[] itemNos, int totalPrice) {
		Connection conn = null;
        PreparedStatement pstmtBuyer = null;
        PreparedStatement pstmtSeller = null;
        PreparedStatement pstmtOrder = null;
        PreparedStatement pstmtGetSeller = null; // 판매자 ID 조회를 위한 객체 추가
        boolean isSuccess = false;
        
        try {
        	conn = DBConnection.getInstance().getConn();
            conn.setAutoCommit(false); //트랜잭션 시작
            
            // 구매자 포인트 차감
            String sqlBuyer = "UPDATE Users SET user_point = user_point - ? WHERE user_id =? AND user_point >= ?";
            pstmtBuyer = conn.prepareStatement(sqlBuyer);
            pstmtBuyer.setInt(1, totalPrice);
            pstmtBuyer.setString(2, buyerId);
            pstmtBuyer.setInt(3, totalPrice); // 포인트 부족 방지 체크
            
            int buyerResult = pstmtBuyer.executeUpdate();
            System.out.println("구매자 포인트 차감 결과 (행 수): " + buyerResult); // 이게 0이면 실패입니다.
            
            if (buyerResult > 0) {
            	// 판매자 수익 증가 (직접 ID 지정)
            	String sqlSeller = "UPDATE Users SET user_point = user_point + "
            			+ "(SELECT item_price FROM item WHERE item_no = ?) "
                        + "WHERE id = ?";
            	
            	// 주문 기록 저장
            	String sqlOrder = "INSERT INTO Orders (buyer_id, shop_no, item_no, status, order_date) "
                        + " VALUES (?, ?, ?, 1, NOW())";
            	
            	// 판매자 ID를 찾기 위한 쿼리
            	String sqlGetSeller = "SELECT id FROM shop_board WHERE shop_no =?";
            	
            	// 쿼리문 데이터 
            	pstmtSeller = conn.prepareStatement(sqlSeller);
                pstmtOrder = conn.prepareStatement(sqlOrder);
                pstmtGetSeller = conn.prepareStatement(sqlGetSeller);
                
                for (int i = 0; i < shopNos.length; i++) {
                    int sNo = Integer.parseInt(shopNos[i]);
                    int iNo = Integer.parseInt(itemNos[i]);

                    // 해당 판매글의 판매자 ID 가져오기
                    pstmtGetSeller.setInt(1, sNo);
                    ResultSet rs = pstmtGetSeller.executeQuery();
                    String sellerId = "";
                    if (rs.next()) {
                    	sellerId = rs.getString("id");
                    }
                    rs.close();
                    
                    if (sellerId.equals("")) {
                    	throw new Exception("판매자 정보를 찾을 수 없습니다. shop_no : " + sNo);
                    }
                    
                    // 판매자 수익 증가 세팅
                    pstmtSeller.setInt(1, iNo);
                    pstmtSeller.setInt(2, Integer.parseInt(sellerId)); // 사용자의 int id
                    pstmtSeller.addBatch(); // 여러 개일 경우 성능을 위해 배치 사용

                    // 주문 기록 삽입 세팅
                    pstmtOrder.setString(1, buyerId);
                    pstmtOrder.setInt(2, sNo);
                    pstmtOrder.setInt(3, iNo);
                    pstmtOrder.addBatch();
                }
                
            	// 배치 실행
                pstmtSeller.executeBatch();
                pstmtOrder.executeBatch();
                
                conn.commit();
                isSuccess = true;
                System.out.println("✅ 결제 및 포인트 정산 최종 성공");
               
             } else {
                	System.out.println("❌ 구매자 포인트 부족 또는 ID 불일치");
                    conn.rollback();
             }
        } catch (Exception e) {
        	System.out.println("🔥 트랜잭션 오류 발생: 롤백합니다.");
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
        	closeAll(pstmtBuyer, pstmtSeller, pstmtOrder, pstmtGetSeller, conn);
		}
           
        
		return isSuccess;
	}
	
	// 자원 반납용 헬퍼 메서드
    private void closeAll(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) try { res.close(); } catch (Exception e) {}
        }
    }
    
    // 사용자 포인트 조회 메서드
    public int getPoint(String userId) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int point = 0;
        
        try {
        	conn = DBConnection.getInstance().getConn();
        	String sql = "SELECT user_point FROM Users WHERE user_id = ?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setString(1, userId);
        	rs = pstmt.executeQuery();
        	
        	if (rs.next()) {
        		point = rs.getInt("user_point");
        	}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        return point;
    }
}

