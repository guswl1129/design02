package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.BoardDTO;
import com.handiboard.util.DBConnection;

public class BookmarkDAO {
	//북마크 불러오기 메서드
	public List<BoardDTO> getBookmarkList(String userID) {
		List<BoardDTO> bookList=new ArrayList<BoardDTO>();
		
		//sql문
		String sql = "SELECT author_id, board_date, board_title, board_content, board_like, board_no"
				+ " FROM v_user_bookmarks"
				+ " WHERE bookmarked_by = ?"
				+ " ORDER BY board_date DESC";
		//커넥션 객체 생성 , (sql문+커넥션 객체)-> 전송 객체로 조립=pstmt
		try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
				) {
			pstmt.setString(1, userID); //pstmt 세팅
			//pstmt로 쿼리결과 받아오기
			try(ResultSet rs = pstmt.executeQuery()){
				//쿼리결과 list에 반복문으로 저장
				while(rs.next()) {
					BoardDTO boardDto = new BoardDTO(); //객체 참조 따라서 매번 생성
					boardDto.setBoard_no(rs.getInt("board_no"));
				    boardDto.setTitle(rs.getString("board_title"));
				    boardDto.setContent(rs.getString("board_content"));
				    boardDto.setLike_count(rs.getInt("board_like"));
				    boardDto.setDate(rs.getString("board_date"));
				    boardDto.setUser_id(rs.getString("author_id"));
				    
				    bookList.add(boardDto);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookList;
	}
	
	//북마크 등록 및 해제하기
	//북마크 버튼 클릭시 토글 메소드
	public int toggleBookmark(String userId, int boardNo) {
	    int isNowBookmarked = -1; //기본값 : 에러
	    int currentStatus = this.isBookmarked(userId, boardNo); //2번 호출은 DB 커넥션을 2번 발생
	    
	    // 1. 상태 확인 (이미 기존 메서드가 있다면 재사용)
	    if (currentStatus==1) {
	        // 2. 존재하면 삭제
	        if (this.deleteBookmark(userId, boardNo) > 0) { //
	        	isNowBookmarked = 0; //북마크 삭제
	        }
	    } else if(currentStatus==0) {
	        // 3. 없으면 추가
	        if (this.insertBookmark(userId, boardNo) > 0) { 
	        	isNowBookmarked = 1; //북마크 추가
	        }
	    }
	    return isNowBookmarked; //0이면 북마크 없음. 1이면 북마크 있음. -1이면 DB 에러
	}
	
	//북마크 상태 검사 메소드
	public int isBookmarked(String userId, int boardNo) {
	    String sql = "SELECT COUNT(*) AS count FROM bookmark WHERE user_id = ? AND board_no = ?";
	    int result = -1;
		try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
				) {
			pstmt.setString(1, userId);
			pstmt.setInt(2, boardNo);
			try(ResultSet rs = pstmt.executeQuery()){
				 //실행 결과가 1이면 1(북마크 있음), 0이면 0(북마크 없음) 반환
				if(rs.next()) {
					result = (rs.getInt("count")==1) ? 1 : 0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result; 
	}
	
	//북마크 추가 메소드
	public int insertBookmark(String userId, int boardNo) {
	    String sql = "INSERT INTO bookmark (user_id, board_no) VALUES (?, ?)";
	    int result = -1;
	    try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
					) {
				pstmt.setString(1, userId);
				pstmt.setInt(2, boardNo);
				result = pstmt.executeUpdate();
					 
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    return result;
	}
	
	//북마크 삭제 메소드
	public int deleteBookmark(String userId, int boardNo) {
	    String sql = "DELETE FROM bookmark WHERE user_id = ? AND board_no = ?";
	    // ... executeUpdate() 실행
	    int result = -1;
	    try(Connection conn = DBConnection.getInstance().getConn();
			PreparedStatement pstmt = conn.prepareStatement(sql);
					) {
				pstmt.setString(1, userId);
				pstmt.setInt(2, boardNo);
				result = pstmt.executeUpdate();
					 
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    return result;
	}
	
	
	
}
