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
		
		int like_stat=0;
		LikeDAO likeDao=new LikeDAO();
		BoardDAO dao=new BoardDAO();
		BoardDTO dto=new BoardDTO();
		int res=0;
		
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
		if (session != null && session.getAttribute("user_id") != null) {
			userId = (String) session.getAttribute("user_id");
		} else {
			userId = request.getParameter("user_id");
		}
//		// if still null, cannot proceed
//		if (userId == null || userId.isEmpty()) {
//			System.out.println("user_id is missing; redirecting to board");
//			response.sendRedirect(request.getContextPath()+"/board");
//			return;
//		}

		// set mandatory dto fields before DAO calls to avoid null insertion
		dto.setBoard_no(board_no);
		dto.setUser_id(userId);

		if(like_stat==0) { 	//좋아요 없음->좋아요
			res=likeDao.like(dto); 	//LikeDTO를 만들 것인지 그냥 쓰여 있는 대로 매개변수를 넣을 것인지
			if(res!=0) {
				System.out.println("liked");
				System.out.println("user_id: " + dto.getUser_id());
				dto.setLike_count(1);
				dao.likeBoard(dto);
				like_stat=1;
			} else {
				System.out.println("like failed");
			}
		} else { 	//좋아요 있음->좋아요 취소
			res=likeDao.unlike(dto);
			if(res!=0) {
				System.out.println("unliked");
				System.out.println("user_id: " + dto.getUser_id());
				dto.setLike_count(-1);
				dao.likeBoard(dto);
				like_stat=0;
			} else {
				System.out.println("unlike failed");
			}
		}
		
//		int like=request.getParameter("like")!=null?Integer.parseInt(request.getParameter("like")):-1;
		
//		dto.setBoard_no(board_no);
//		dto.setLike_count(like);
		
		dto=dao.getBoard(board_no);
		
		
		System.out.println("like count updated to: " + dto.getLike_count());	//이제 숫자는 제대로 뜨는데 눌러도 아무것도 안됨
		
		response.sendRedirect(request.getContextPath() + "/detail?board_no="+board_no);
//		RequestDispatcher rd=request.getRequestDispatcher("detail.jsp");
//		rd.forward(request, response);
	}

}
