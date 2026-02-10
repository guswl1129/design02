package com.handiboard.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.handiboard.dao.ShopDAO;
import com.handiboard.dto.ShopDTO;

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 15    // 15MB
	)

@WebServlet("/shop/*")
public class ShopController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ShopDAO dao = new ShopDAO();
       
    public ShopController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// URL 끝부분(Action)을 분석해 해당 기능을 수행 
		String uri = request.getRequestURI();	// 요청을 받아오기 
		String contextPath = request.getContextPath();
		String command = uri.substring(contextPath.length());
		
		
		// 단순 페이지 이동과 조회 
		if (command.equals("/shop/list.do")) {
			// 판매 목록 조회 메소드 호출 
			list(request, response);
			
		} else if (command.equals("/shop/write.do")) {
			// 판매 글쓰기 폼으로 이동 
			response.sendRedirect(request.getContextPath() + "/views/shop/write.jsp");
			
		} else if (command.equals("/shop/insert.do")) {
			// 파일 업로드 처리는 내용이 길어서 별도 메서드로 호출!
			insert(request, response);
			
			// 파라미터 받아서 dao.createShop(dto) 호출! 	 
		} else if (command.equals("/shop/detail.do")) {
			int shop_no =  Integer.parseInt(request.getParameter("shop_no"));
			ShopDTO dto = dao.getDetail(shop_no);
			
			if (dto != null) {
				request.setAttribute("shop", dto);
				request.getRequestDispatcher("/views/shop/detail.jsp").forward(request, response);
			} else {
				response.sendRedirect("list.do"); // 정보가 없으면 목록으로 돌아가기
			}
		}
		
	}
	
	// 목록 조회 기능
	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<ShopDTO> list = dao.getList();
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/shop/list.jsp").forward(request, response);
	}
	
	// 실제 DB 저장 로직 (POST 처리 권장) 
	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 파일이 저장될 서버의 물리적 경로 설정
        // 프로젝트 내부 resources/upload 경로를 찾는 코드입니다.
		String savePath = request.getServletContext().getRealPath("/resources/upload");
		
		// 저장할 폴더가 없는 경우(에러가 날 수 있으니) 
		java.io.File uploadDir = new java.io.File(savePath);
		if (!uploadDir.exists()) uploadDir.mkdir();
		
		try {
			// Part 객체 사용 (파일을 처리하는 객체) 
			// write.jsp의 <input type="file" name="img_file"> 과 이름이 같아야 함
			jakarta.servlet.http.Part part = request.getPart("img_file");
			String fileName = part.getSubmittedFileName(); // 실제 파일명
			
			// 파일이 있을 경우에만 서버 하드디스크에 저장
			if (fileName != null && !fileName.isEmpty()) {
				part.write(savePath + java.io.File.separator + fileName);
				
			}
			
			// 데이터를 dto로 저장하기 
			ShopDTO dto = new ShopDTO();
			dto.setTitle(request.getParameter("title"));
			dto.setContent(request.getParameter("content"));
            dto.setItem_name(request.getParameter("item_name"));
            //dto.setItem_price(Integer.parseInt(request.getParameter("item_price")));
            // 숫자로 변환할 때 값이 비어있으면 에러 나니까 체크!
            String priceStr = request.getParameter("item_price");
            dto.setItem_price(priceStr != null ? Integer.parseInt(priceStr) : 0);
            
            // 세션에서 현재 로그인한 유저의 번호를 가져와야 합니다. (지금은 임시로 1번)
            // dto.setUser_no( (int)request.getSession().getAttribute("user_no") );
            dto.setUser_no(1); // 임시 유저 번호 1번
            
            // DB에는 파일 이름만 저장 
            dto.setImg_path(fileName);
			
            // DB 저장
            dao.createShop(dto);
            
            // 완료 후 목록 페이지로 다시 이동
            response.sendRedirect("list.do");
            
		} catch (Exception e) {
			e.printStackTrace();
            response.sendRedirect("write.do?error=file"); // 에러 시 다시 쓰기 페이지로
        }
		
		// 저장 확인
		System.out.println("파일 저장 경로: " + savePath);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response); 
	}

}
