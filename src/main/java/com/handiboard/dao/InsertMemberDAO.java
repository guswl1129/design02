package com.handiboard.dao;
// 접속 객체 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

public class InsertMemberDAO {
	// 회원가입 메소드 
	public int insertMember(UserDTO dto) {
		String sql = "INSERT INTO Users (user_id, user_password, user_nickname, user_email) VALUES (?, ?, ?, ?)";
		int result = 0;
		
		try (Connection conn = DBConnection.getInstance().getConn(); // DB 연결하며 접속정보 전달
				PreparedStatement pstmt = conn.prepareStatement(sql);) { // pstmt : DB에 명령을 내리는 주체

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;	// 성공은 1 반환

	}
	public int duplicateCheck(String id){
		String sql="SELECT user_id from Users WHERE user_id= ?";
		try(Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

}
