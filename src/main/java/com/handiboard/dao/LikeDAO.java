package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.handiboard.dto.BoardDTO;
import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

public class LikeDAO {
	
	// 좋아요
	public int like(String user_id, int board_no) {
		if (user_id == null || user_id.trim().isEmpty()) {
			System.out.println("LikeDAO.like called with null/empty user_id");
			return 0; // defensive: avoid DB constraint error
		}
		int result=0;
		
		String sql="INSERT INTO board_like_user (board_no, user_id) VALUES (?, ?)";
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setInt(1, board_no);
			pstmt.setString(2, user_id);
			result=pstmt.executeUpdate();	//Error: 1048-23000: Column 'user_id' cannot be null
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 좋아요 취소
	public int unlike(String user_id, int board_no) {
		if (user_id == null || user_id.trim().isEmpty()) {
			System.out.println("LikeDAO.unlike called with null/empty user_id");
			return 0; // defensive
		}
		int result=0;
		
		String sql="DELETE FROM board_like_user WHERE board_no=? AND user_id=?";
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setInt(1, board_no);
			pstmt.setString(2, user_id);
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}