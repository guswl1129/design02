package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.BoardDTO;
import com.handiboard.util.DBConnection;

import jakarta.servlet.http.HttpSession;

public class MyPostsDAO {
	public List<BoardDTO> LoadPosts(String id){
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "SLECT content, date from board where user_id = ?";
		try(Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setContent(rs.getString("board_content"));
				dto.setDate(rs.getString("board_date"));
				list.add(dto);
			}
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println("데이터를 성공적으로 불러오지 못했습니다.");
		}
		return list;
		
		
	}
}
