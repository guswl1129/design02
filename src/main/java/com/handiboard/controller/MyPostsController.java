package com.handiboard.controller;

import java.io.IOException;
import java.util.List;

import com.handiboard.dao.MyPostsDAO;
import com.handiboard.dto.BoardDTO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class MyPostsController
 */
@WebServlet("/myPostsController")
public class MyPostsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPostsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MyPostsDAO dao = new MyPostsDAO();
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("userId");
		
		List<BoardDTO> list = dao.LoadPosts(id);
		
		request.setAttribute("myPosts", list); //이름, 값
		RequestDispatcher rd = request.getRequestDispatcher("myPosts.jsp");
		rd.forward(request, response);
		
	}

}
