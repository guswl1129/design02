package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

public class MypageDAO {

	//충전포인트 반환
	public UserDTO getUserinfo(String userId) {
		UserDTO user = new UserDTO();
		
		String sql = "SELECT user_point, user_id,user_nickname  FROM Users WHERE user_id=?";
		try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
				) {
			pstmt.setString(1, userId);
			try(ResultSet rs = pstmt.executeQuery()){
				if (rs.next()) {
	                user.setPoint(rs.getInt("user_point"));
	                user.setId(rs.getString("user_id"));
	                user.setName(rs.getString("user_nickname"));
	            }
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
