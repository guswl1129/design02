package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.handiboard.dto.BoardDTO;
import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

public class LikeDAO {
	
	// 좋아요
	public int like(BoardDTO dto) {
		int result=0;
		
		String sql="INSERT INTO board_like_user (board_no, user_id) VALUES (?, ?)";
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setInt(1, dto.getBoard_no());
			pstmt.setString(2, dto.getUser_id());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 좋아요 취소
	public int unlike(BoardDTO dto) {
		int result=0;
		
		String sql="DELETE FROM board_like_user WHERE board_no=? AND user_id=?";
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setInt(1, dto.getBoard_no());
			pstmt.setString(2, dto.getUser_id());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
