package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.bcrypt.BCrypt;

import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

// 데이터베이스 접속 객체
public class LoginDAO {

	// 로그인하는 작업
	public UserDTO login(UserDTO dto) {

		// 특정 사용자의 id(중복x)를 이용해 갯수, 닉네임, 비밀번호를 찾는다.
		String sql = "SELECT count(*) as count, user_id, user_nickname, user_password, user_point FROM Users WHERE user_id=? ";
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, dto.getId()); // 아이디를 읽어온다.
			ResultSet rs = pstmt.executeQuery();
			// 해당 행을 가져온다.
			if (rs.next()) {
				// System.out.println(rs.getInt("count"));
				String hashedPw = rs.getString("user_password"); // 암호화된 패스워드 가져오기

				if (BCrypt.checkpw(dto.getPw(), hashedPw)) { // 비밀번호 검증 전용 메소드(실제 암호, 암호화된 암호), boolean값으로 나온다.

					dto.setCount(rs.getInt("count")); // 1
					dto.setName(rs.getString("user_nickname")); // user의 닉네임을 저장한다.
					dto.setPoint(rs.getInt("user_point"));
					dto.setId(rs.getString("user_id"));
				}

			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public UserDTO findId(UserDTO dto) {
		String sql = "select count(*) as count,user_id from Users where user_nickname=? and user_email=?";
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {

			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				dto.setCount(rs.getInt("count"));
				dto.setId(rs.getString("user_id"));

			}
			rs.close();
		} catch (Exception e) {
		}
		return dto;
	}

	public UserDTO findPw(UserDTO dto) {
		String sql = "select count(*) as count from Users where user_id=? and user_email=?";

		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getEmail());
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				dto.setCount(rs.getInt("count"));
				dto.setName(rs.getString("user_nickname"));

			}
			rs.close();
		} catch (Exception e) {
		}
		return dto;
	}

	public int updatePw(UserDTO dto) {

		String sql = "update Users set user_password=? where user_id = ?";
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {

			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getId());

			return pstmt.executeUpdate(); // 1

		} catch (Exception e) {

			return 0;
		}

	}

}
