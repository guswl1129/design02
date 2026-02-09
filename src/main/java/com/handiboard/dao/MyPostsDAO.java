package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.BoardDTO;
import com.handiboard.util.DBConnection;

public class MyPostsDAO {
	public List<BoardDTO> LoadPosts(String id) {
	    List<BoardDTO> list = new ArrayList<>();
	    String sql = "SELECT board_content, Date(board_date)AS board_date FROM board WHERE user_id = ?";

	    try (Connection conn = DBConnection.getInstance().getConn();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, id);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                BoardDTO dto = new BoardDTO();
	                dto.setContent(rs.getString("board_content"));
	                dto.setDate(rs.getString("board_date"));
	                list.add(dto);
	            }
	        }
	        System.out.println("DAO 쿼리 실행됨, id = " + id);


	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

}
