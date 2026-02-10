package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.handiboard.dao.MypageDAO;
import com.handiboard.dto.UserDTO;

/**
 * Servlet implementation class EditProfileController
 */
@WebServlet("/editProfileController")
public class EditProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if(session != null && session.getAttribute("userId") != null) {
            String userId = (String)session.getAttribute("userId");
            MypageDAO dao = new MypageDAO();
            UserDTO userDTO = dao.getUserinfo(userId); // DB에서 유저 정보 조회
            
            
            if (userDTO != null) {
            	request.setAttribute("userEmail", userDTO.getEmail());
                request.setAttribute("user", userDTO); // 'user'라는 이름으로 데이터를 담음
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
