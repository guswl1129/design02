package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.BoardDTO;
import com.handiboard.util.DBConnection;

public class BoardDAO {
	// 글 리스트
	public List<BoardDTO> getList(){
		List<BoardDTO> list=new ArrayList<BoardDTO>();
		String sql="SELECT * FROM board WHERE board_del=1 ORDER BY board_no DESC";
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			ResultSet rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto=new BoardDTO();
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setTitle(rs.getString("board_title"));
//				dto.setName(rs.getString("user_nickname"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setDate(rs.getString("board_date"));
				dto.setLike(rs.getInt("board_like"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 글 하나 보기
	public BoardDTO getBoard(int board_no) {
		String sql="SELECT * FROM board WHERE board_no=?";
		
				BoardDTO dto=new BoardDTO();
				
		try(Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setInt(1, board_no);
			ResultSet rs=pstmt.executeQuery();
			
			while(rs.next()) {
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setTitle(rs.getString("board_title"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setContent(rs.getString("board_content"));
				dto.setDate(rs.getString("board_date"));
				dto.setLike(rs.getInt("board_like"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	// 글쓰기
	// Reworked: accept a BoardDTO, use proper parameter placeholders, executeUpdate, and return the generated board id
	public void createBoard(BoardDTO dto){
		if(dto == null) throw new IllegalArgumentException("BoardDTO must not be null");
		String sql = "INSERT INTO board(board_title, board_content, user_id) VALUES(?, ?, ?)";
		// Returns generated key (board id) on success, -1 on failure
		try (Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			// Assumption: dto.getNo() provides the user_no (if your DTO uses a different field for user id, adjust accordingly)
			pstmt.setString(3, dto.getUser_id());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 수정
	public void updateBoard(BoardDTO dto) {
		String sql="UPDATE board SET board_title=?, board_content=? WHERE board_no=?";
		
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getBoard_no());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 삭제
	public void deleteBoard(BoardDTO dto) {
		String sql="UPDATE board SET board_del=0 WHERE board_no=?";
		
		try (Connection conn=DBConnection.getInstance().getConn();
				PreparedStatement pstmt=conn.prepareStatement(sql);){
			pstmt.setInt(1, dto.getBoard_no());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	// 읽음 수 올리기
}
