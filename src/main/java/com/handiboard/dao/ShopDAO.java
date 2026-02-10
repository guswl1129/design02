package com.handiboard.dao;
// DB 접속객체 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.ShopDTO;
import com.handiboard.util.DBConnection;

public class ShopDAO {
	// 판매 게시판 리스트 조회
	public List<ShopDTO> getList() {
		List<ShopDTO> list = new ArrayList<>();
		// shop_board와 Users, item 테이블을 JOIN해서 user_id, item_name, item_price 등을 가져옵니다.
		String sql = "SELECT s.*, u.user_id AS writer_id, i.item_name, i.item_price, i.img_path " + 
					" FROM shop_board s " +
					" Join Users u ON s.id = u.id " +
					" Join item i ON s.item_no = i.item_no " +
					" ORDER BY s.shop_no DESC"; // 최신순 정렬 추가 

		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) { // 전달받은 값을 DTO 객체에 저장합니다
				ShopDTO dto = new ShopDTO();
				dto.setShop_no(rs.getInt("shop_no")); // DTO 변수에 가져온 데이터를 저장
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				
				dto.setUser_id(rs.getString("writer_id"));
				
				dto.setReg_date(rs.getString("reg_date"));
				dto.setItem_no(rs.getInt("item_no"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setItem_price(rs.getInt("item_price"));
				dto.setImg_path(rs.getString("img_path"));
				
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 판매글 등록 (아이템 등록 후 판매글 등록)
	// (트랜잭션 + 부분 자동 반납)
	public void createShop(ShopDTO dto) {
		Connection conn = null;
		PreparedStatement pstmtItem = null;
		PreparedStatement pstmtShop = null;

		try {
			conn = DBConnection.getInstance().getConn();
			conn.setAutoCommit(false); // 트랜잭션 시작
			// item 테이블에 아이템정보(이름, 가격)를 먼저 저장
			String sqlItem = "INSERT INTO item(item_name, item_price, img_path) VALUES(?, ?, ?)"; // 수정
			pstmtItem = conn.prepareStatement(sqlItem, Statement.RETURN_GENERATED_KEYS);
			pstmtItem.setString(1, dto.getItem_name());
			pstmtItem.setInt(2, dto.getItem_price());
			pstmtItem.setString(3, dto.getImg_path());
			pstmtItem.executeUpdate();

			// 생성된 item_no 가져오기
			ResultSet rs = pstmtItem.getGeneratedKeys();
			int generatedItemNo = 0;
			if (rs.next()) {
				generatedItemNo = rs.getInt(1);
			}

			// item_no를 사용해서 shop_board에 저장
			String sqlShop = "INSERT INTO shop_board(title, content, id, item_no) VALUES(?, ?, ?, ?)";
			pstmtShop = conn.prepareStatement(sqlShop);
			pstmtShop.setString(1, dto.getTitle()); // SQL문에 들어갈 데이터 (dto)
			pstmtShop.setString(2, dto.getContent());
			pstmtShop.setInt(3, dto.getUser_no()); // 숫자로 된 id(회원번호)
			pstmtShop.setInt(4, generatedItemNo);
			
			pstmtShop.executeUpdate();

			conn.commit(); // 트랜잭션: 확정
		} catch (Exception e) {
			try {
				if (conn != null)
					conn.rollback();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		} finally {
			try {
				// 역순으로 닫기 (아이템용 -> 게시판용 -> 커넥션) 
				if (pstmtItem != null) pstmtItem.close();
				if (pstmtShop != null) pstmtShop.close();
				if (conn != null) {
					conn.setAutoCommit(true); // 다음 사람을 위해 기본값 복구
					conn.close();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	// 게시글 상세 조회 메서드 (상품 상세페이지) 
	public ShopDTO getDetail(int shop_no) {
		ShopDTO dto = null;
		
		// 작성자 아이디(Users), 아이템 정보(item) 를 조인해서 사용자에게 보여줍니다. 
		String sql = "SELECT s.*, u.user_id, i.item_name, i.item_price, i.img_path " +
					" FROM shop_board s " +
					" JOIN Users u ON s.id = u.id " +
					" JOIN item i ON s.item_no = i.item_no " +
					" WHERE s.shop_no = ?";
		
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				) {
			pstmt.setInt(1, shop_no);
			try (ResultSet rs = pstmt.executeQuery()) { // 가져온 데이터를 dto에 저장
				if (rs.next()) {
					dto = new ShopDTO();
					dto.setShop_no(rs.getInt("shop_no"));
	                dto.setTitle(rs.getString("title"));
	                dto.setContent(rs.getString("content"));
	                dto.setItem_name(rs.getString("item_name"));
	                dto.setItem_price(rs.getInt("item_price"));
	                dto.setImg_path(rs.getString("img_path"));
	                dto.setUser_id(rs.getString("user_id"));
	                dto.setReg_date(rs.getString("reg_date"));
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
		
		
	}
	
}


