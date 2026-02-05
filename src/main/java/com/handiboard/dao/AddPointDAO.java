package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.http.HttpSession;

import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

public class AddPointDAO {
	public int AddMoney(String userId, int point) {
		String sql = "Update Users set user_point=? where user_id=?";
		
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, point);
			pstmt.setString(2, userId);
			
			return pstmt.executeUpdate();
		}catch (Exception e) {
		// TODO: handle exception
			return 0;
		}
		

}
	public int updatedPoint(UserDTO dto, String userId) {
		String sql = "select user_point from Users where user_id=?";
		
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setPoint(rs.getInt("user_point"));

			}
			rs.close();
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
}
