package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.handiboard.dto.OrderDTO;
import com.handiboard.util.DBConnection;

public class BuyDAO {
	// 주문 처리 (트랜잭션 적용)
	public boolean processOrder(OrderDTO order, int totalPrice) {
		Connection conn = null;
		PreparedStatement pstmtUser = null;
		PreparedStatement pstmtOrder = null;
		boolean isSuccess = false;

		try {
			conn = DBConnection.getInstance().getConn();
			conn.setAutoCommit(false); // 1. 트랜잭션 시작

			// [작업 A] 유저 포인트 차감
			String sqlUser = "UPDATE Users SET point = point - ? WHERE id = ? AND point >= ?";
			pstmtUser = conn.prepareStatement(sqlUser);
			pstmtUser.setInt(1, totalPrice);
			pstmtUser.setString(2, order.getBuyer_id());
			pstmtUser.setInt(3, totalPrice); // 잔액 부족 체크

			int userResult = pstmtUser.executeUpdate();

			if (userResult > 0) {
				// [작업 B] Orders 테이블에 구매 기록 추가 (status=1: 구매완료)
				String sqlOrder = "INSERT INTO Orders (buyer_id, shop_no, item_no, status, order_date) "
						+ "VALUES (?, ?, ?, 1, NOW())";
				pstmtOrder = conn.prepareStatement(sqlOrder);
				pstmtOrder.setString(1, order.getBuyer_id());
				pstmtOrder.setInt(2, order.getShop_no());
				pstmtOrder.setInt(3, order.getItem_no());

				int orderResult = pstmtOrder.executeUpdate();

				if (orderResult > 0) {
					conn.commit(); // 2. 모든 작업 성공 시 확정
					isSuccess = true;
				} else {
					conn.rollback(); // 주문 실패 시 되돌림
				}
			} else {
				conn.rollback(); // 포인트 부족 시 되돌림
			}

		} catch (Exception e) {
			try {
				if (conn != null)
					conn.rollback();
			} catch (Exception ex) {
			}
			e.printStackTrace();
		} finally {
			// 자원 반납 (close)
		}
		return isSuccess;
	}

}
