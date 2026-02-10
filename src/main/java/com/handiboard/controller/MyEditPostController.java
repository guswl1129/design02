package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.handiboard.dao.MyPostsDAO;

/**
 * Servlet implementation class MyEditPostController
 */
@WebServlet("/myEditPostController")
public class MyEditPostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyEditPostController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		MyPostsDAO dao = new MyPostsDAO();
		dao.updatePost(board_no, title, content);

		response.sendRedirect("myPostsController");
		
	}

}
