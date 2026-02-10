package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.handiboard.dao.MyPostsDAO;
import com.handiboard.dto.BoardDTO;

/**
 * Servlet implementation class PostDetailDAO
 */
@WebServlet("/postDetailController")
public class PostDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        int boardNo = Integer.parseInt(request.getParameter("board_no"));
	        String mode = request.getParameter("mode");
	        MyPostsDAO dao = new MyPostsDAO();
	        BoardDTO dto = dao.LoadDetailPosts(boardNo);

	        request.setAttribute("details", dto);
	        if ("edit".equals(mode)) {
	            RequestDispatcher rd = request.getRequestDispatcher("/myEditPost.jsp");
	            rd.forward(request, response);
	        } else {
	            RequestDispatcher rd = request.getRequestDispatcher("/myPostDetail.jsp");
	            rd.forward(request, response);
	        }
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        doGet(request, response); // POST로 와도 동일 처리
	    }
	}