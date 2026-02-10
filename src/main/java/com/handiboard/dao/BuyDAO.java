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
        boolean isSuccess = false;
        
        try {
        	conn = DBConnection.getInstance().getConn();
            conn.setAutoCommit(false); //트랜잭션 시작
            
            // 구매자 포인트 차감
            String sqlBuyer = "UPDATE Users SET user_point = user_point - ? WHERE id =? AND user_point >= ?";
            pstmtBuyer = conn.prepareStatement(sqlBuyer);
            pstmtBuyer.setInt(1, totalPrice);
            pstmtBuyer.setString(2, buyerId);
            pstmtBuyer.setInt(3, totalPrice); // 포인트 부족 방지 체크
            
            int buyerResult = pstmtBuyer.executeUpdate();
            
            if (buyerResult > 0) {
            	// 판매자 수익 증가 및 주문 기록 저장
            	String sqlSeller = "UPDATE Users SET user_point = user_point + (SELECT item_price FROM items WHERE item_no = ?) "
                        + "WHERE id = (SELECT user_id FROM shop_board WHERE shop_no = ?)";
            	
            	String sqlOrder = "INSERT INTO Orders (buyer_id, shop_no, item_no, status, order_date) "
                        + "VALUES (?, ?, ?, 1, NOW())";
            	
            	pstmtSeller = conn.prepareStatement(sqlSeller);
                pstmtOrder = conn.prepareStatement(sqlOrder);
                
                for (int i = 0; i < shopNos.length; i++) {
                    int sNo = Integer.parseInt(shopNos[i]);
                    int iNo = Integer.parseInt(itemNos[i]);

                    // 판매자 수익 증가 세팅
                    pstmtSeller.setInt(1, iNo);
                    pstmtSeller.setInt(2, sNo);
                    pstmtSeller.addBatch(); // 여러 개일 경우 성능을 위해 배치 사용

                    // 주문 기록 삽입 세팅
                    pstmtOrder.setString(1, buyerId);
                    pstmtOrder.setInt(2, sNo);
                    pstmtOrder.setInt(3, iNo);
                    pstmtOrder.addBatch();
                }
                
            	// 배치 실행
                int[] sellerResults = pstmtSeller.executeBatch();
                int[] orderResults = pstmtOrder.executeBatch();
                
                // 모든 처리가 배열 길이만큼 정상 수행되었는지 확인
                if (sellerResults.length == shopNos.length && orderResults.length == shopNos.length) {
                    conn.commit(); // 2. 모든 작업 성공 시 최종 확정
                    isSuccess = true;
                } else {
                    conn.rollback();
                }
            } else {
                conn.rollback(); // 구매자 포인트 부족 시 롤백
            }
        } catch (Exception e) {
        	try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
        	// 자원 반납 (close) - 팀장님 프로젝트의 Close 메서드 호출
            closeAll(pstmtBuyer, pstmtSeller, pstmtOrder, conn);
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

