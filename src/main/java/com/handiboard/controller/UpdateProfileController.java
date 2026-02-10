package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.handiboard.dao.MypageDAO;

/**
 * Servlet implementation class UpdateProfileController
 */
@WebServlet("/updateProfileController")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 15    // 15MB
	)
public class UpdateProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfileController() {
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
		HttpSession session = request.getSession(false);
        String userId = (String)session.getAttribute("userId");
        String newName = request.getParameter("userName");
        String newEmail = request.getParameter("userEmail");
        
     // 닉네임 길이 검사 (서버 측)
        if (newName == null || newName.length() > 10 || newName.isEmpty()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('닉네임은 1자 이상 10자 이내여야 합니다.'); history.back();</script>");
            return;
        }
        
     // 서버 측 이메일 정규식 검사
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (newEmail == null || !newEmail.matches(emailRegex)) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('잘못된 이메일 형식입니다.'); history.back();</script>");
            return;
        }
        
     // 1. 서버 내 실제 저장 경로 설정 (webapp/images 폴더)
        String uploadPath = getServletContext().getRealPath("/images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir(); // 폴더가 없으면 생성

        // 2. 파일 데이터 가져오기
        Part filePart = request.getPart("profileImage"); 
        String fileName = filePart.getSubmittedFileName();
        String dbPath = null;

        if (fileName != null && !fileName.isEmpty()) {
            // 파일명 중복 방지를 위해 사용자 ID 등을 활용 (예: user1_avatar.png)
            String saveFileName = userId + "_" + fileName;
            filePart.write(uploadPath + File.separator + saveFileName);
            
            // DB에는 실제 경로가 아닌 웹 접근 경로를 저장합니다.
            dbPath = "/images/" + saveFileName; 
        }
        
        // 1. 파일 업로드 처리 (생략된 경우 기존 경로 유지 로직 필요)
        // 2. DAO를 통해 DB 업데이트
        MypageDAO dao = new MypageDAO();
        boolean isUpdated = dao.updateUserInfo(userId, newName, newEmail,dbPath);
        
        if(isUpdated) {
            // 수정 성공 시 다시 마이페이지로 이동
        	session.setAttribute("userName", newName);
            session.setAttribute("userEmail", newEmail);
            response.sendRedirect("myPage");
        } else {
            // 실패 시 에러 처리
            response.getWriter().println("<script>alert('수정 실패'); history.back();</script>");
        }
    
	}

}
