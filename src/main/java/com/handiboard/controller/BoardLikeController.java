package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dao.LikeDAO;
import com.handiboard.dto.BoardDTO;
import com.handiboard.dto.UserDTO;

@WebServlet("/like")
public class BoardLikeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardLikeController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("like doGet");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("like doPost");
		
		LikeDAO likeDao=new LikeDAO();
		BoardDAO dao=new BoardDAO();
		BoardDTO dto=new BoardDTO();
		int res=0;
		int like_stat=0;
		
		int board_no;
		try {
			board_no=Integer.parseInt(request.getParameter("board_no"));
		} catch (Exception e) {
			System.out.println("invalid board_no format");
			response.sendRedirect(request.getContextPath()+"/board");
			return;
		}

		// get user id from session or request parameter
		String userId = null;
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		} else {
			userId = request.getParameter("userId");
		}
		// if still null or empty, cannot proceed - redirect to login or board list
		if (userId == null || userId.trim().isEmpty()) {
			System.out.println("userId is missing; redirecting to login page");
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		// set mandatory dto fields before DAO calls to avoid null insertion
		dto.setBoard_no(board_no);
		dto.setUser_id(userId);

		System.out.println("userId: "+userId);	//:imoony, 글 쓴 사람

		like_stat=likeDao.likeCheck(userId, board_no);	// 뭐가 있으면 1
		
		if(like_stat==0) { 	//좋아요 없음->좋아요
			res=likeDao.like(userId, board_no);
			if (res!=0) {
				System.out.println("liked");
			System.out.println("userId: " + userId);
			dto.setLike_count(1);
			dao.likeBoard(dto);
			}
		} else { 	//좋아요 있음->좋아요 취소
			res=likeDao.unlike(userId, board_no);
			if(res!=0) {
				System.out.println("unliked");
			System.out.println("userId: " + userId);
			dto.setLike_count(-1);
			dao.likeBoard(dto);
			}
		}
		
		dto=dao.getBoard(board_no);
		
		
		System.out.println("like count updated to: " + dto.getLike_count());
		
		response.sendRedirect(request.getContextPath() + "/detail?board_no="+board_no+"&from=like");
	}

}