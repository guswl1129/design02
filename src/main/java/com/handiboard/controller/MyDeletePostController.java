package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.handiboard.dao.MyPostsDAO;
import com.handiboard.dto.BoardDTO;

/**
 * Servlet implementation class DeletePostController
 */
@WebServlet("/myDeletePostController")
public class MyDeletePostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyDeletePostController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		MyPostsDAO dao = new MyPostsDAO();
		dao.deletePost(board_no);
		
		response.sendRedirect("myPostsController");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
