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
		
		String sql = "SELECT user_point, user_id,user_nickname,profile_image_path,user_email  FROM Users WHERE user_id=?";
		try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
				) {
			pstmt.setString(1, userId);
			try(ResultSet rs = pstmt.executeQuery()){
				if (rs.next()) {
	                user.setPoint(rs.getInt("user_point"));
	                user.setId(rs.getString("user_id"));
	                user.setName(rs.getString("user_nickname"));
	                user.setProfileImagePath(rs.getString("profile_image_path"));
	                user.setEmail(rs.getString("user_email"));
	                
	            }
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	public boolean updateUserInfo(String userId, String newName, String newEmail, String profilePath) {
	    String sql = "UPDATE Users SET user_nickname = ?, user_email = ?, " +
	                 "profile_image_path = COALESCE(?, profile_image_path) " +
	                 "WHERE user_id = ?";

	    try (Connection conn = DBConnection.getInstance().getConn(); 
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setString(1, newName);      // 새로운 닉네임
	        pstmt.setString(2, newEmail);     // 새로운 이메일
	        pstmt.setString(3, profilePath);  // 새로운 사진 경로 (null 허용)
	        pstmt.setString(4, userId);       // 고유 아이디 (찾기용)

	        return pstmt.executeUpdate() > 0; // 성공 여부 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}
