package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.BoardDTO;
import com.handiboard.dto.UserDTO;
import com.handiboard.util.DBConnection;

public class MyPostsDAO {
	public List<BoardDTO> LoadPosts(String id) {
	    List<BoardDTO> list = new ArrayList<>();
	    String sql = "SELECT board_no, board_title, Date(board_date)AS board_date FROM board WHERE user_id = ?";

	    try (Connection conn = DBConnection.getInstance().getConn();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, id);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                BoardDTO dto = new BoardDTO();
	                dto.setBoard_no(rs.getInt("board_no"));
	                dto.setTitle(rs.getString("board_title"));
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
	
	public BoardDTO LoadDetailPosts(int no) {
	    BoardDTO dto = new BoardDTO();
	    String sql = "SELECT board_title, board_content, board_date, board_like, board_view FROM board WHERE board_no = ?";

	    try (Connection conn = DBConnection.getInstance().getConn();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, no);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                dto.setTitle(rs.getString("board_title"));
	                dto.setContent(rs.getString("board_content"));
	                dto.setDate(rs.getString("board_date"));
	                dto.setLike_count(rs.getInt("board_like"));
	                dto.setView_count(rs.getInt("board_view"));
	            }
	        }
	        System.out.println("DAO 쿼리 실행됨, board_no = " + no);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return dto;
	}


}
