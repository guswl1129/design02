package com.handiboard.controller;

import java.io.IOException;
import java.util.Set;

import com.handiboard.dao.LoginDAO; // 실제 패키지 경로에 맞게 수정
import com.handiboard.dto.UserDTO; // 실제 패키지 경로에 맞게 수정

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//차단 목록을 Set로 관리.Set 자료구조 선택이유: set는 중복이 의미 없는 집합, O(1)
	//상수로 두는 이유: 정책 데이터(보안 정책, 상수 정책)
	Set<String> BLOCKED_URLS = Set.of("/login", "/signup", "/logout");

	public LoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//디버깅 코드
		System.out.println("[GET DEBUG] queryString=" + request.getQueryString());
		System.out.println("[GET DEBUG] prevUrl(param)=" + request.getParameter("prevUrl"));
		System.out.println("[GET DEBUG] prevUrl(session before)=" + request.getSession().getAttribute("prevUrl"));
		
		// 상세 페이지에서 보낸 돌아갈 주소(prevUrl)를 받아서 JSP로 넘겨줌
        String prevUrl = request.getParameter("prevUrl");
        HttpSession session = request.getSession();
        
        if(prevUrl != null && !prevUrl.isEmpty()) {
			    session.setAttribute("prevUrl", prevUrl);
        } else {
            // 파라미터가 없으면 세션에서 꺼내기
            prevUrl = (String) session.getAttribute("prevUrl");
        } //doPost()에서 사용한 후 삭제, null값을 세팅불가? 가능 but 디버깅 불리
        request.setAttribute("prevUrl", prevUrl);
        
        //JSP EL${ }의 탐색 순위 : page → request → session → application
        
        // login.jsp를 화면에 띄움
        request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("post로 요청이 들어옵니다");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		System.out.printf("ID : %s, PW : %s", id, pw);
		
		 HttpSession session = request.getSession();
	     String prevUrl = request.getParameter("prevUrl"); // 히든 필드로 받을 주소
	     if(prevUrl == null|| prevUrl.isEmpty()) { //null인 경우에만 session 저장값으로 업데이트(보험)
				    prevUrl = (String) session.getAttribute("prevUrl");
		}
		
		// index.html, index.htm, index.jsp <-이게 다 없으면 404, tomcat에서 설정
		// 데이터베이스 접속 DBConn.java, LoginDAO.java, LoginDTO.java
		LoginDAO dao = new LoginDAO();
		UserDTO dto = new UserDTO();
		dto.setId(id);
		dto.setPw(pw);

		dao.login(dto);
		System.out.println(dao.login(dto));
		System.out.println(dto.getCount());
		System.out.println(dto.getName());
		
		//디버깅 코드
		System.out.println("[POST DEBUG] contextPath=" + request.getContextPath());
		System.out.println("[POST DEBUG] prevUrl(param)=" + request.getParameter("prevUrl"));
		System.out.println("[POST DEBUG] prevUrl(final)=" + prevUrl);
		
		if (dto.getCount() == 1) {
			System.out.println("로그인 성공");
			// 디스패치 사용
			request.setAttribute("nickname", dto.getName());
			//세션에 저장
			session.setAttribute("user", dto);
			session.setAttribute("userId", dto.getId()); // 로그인한 유저의 아이디를 세션에 저장
			session.setAttribute("userPoint", dto.getPoint()); // 로그인한 유저의 포인트를 세션에 저장
			session.setAttribute("userEmail", dto.getEmail());
			session.setAttribute("userName", dto.getName());
			//더 이상 필요없는 세션값 삭제
			session.removeAttribute("prevUrl"); //성공한 경우 삭제: 로그인 실패한 경우에도 삭제하게 하면 돌아갈 주소를 잃게 됨. 
			//리다이렉트
			 boolean isValid =
			            prevUrl != null
			            && !prevUrl.isEmpty()
			            && prevUrl.startsWith("/") // "/"은 서버 내부 경로 표시, 서버 외부 경로는 //
			            && !prevUrl.startsWith("//")
			            && !BLOCKED_URLS.contains(prevUrl);
		            
		     // [핵심] 돌아갈 주소가 있다면 그곳으로, 없으면 메인으로 리다이렉트
		     //다이렉트할 때, 절대 주소 표시 붙여주기 : request.getContextPath()
		     if (isValid) {
		    	 System.out.println("이전 페이지로 이동");
		          response.sendRedirect(request.getContextPath() + prevUrl); 
		     } else {
		    	 System.out.println("메인 페이지로 이동");
		          response.sendRedirect(request.getContextPath() +"/main"); // 혹은 본인의 메인 주소
		     }
		} else {
			System.out.println("아이디 또는 패스워드 오류");
//			response.sendRedirect("./login.jsp");
			// 로그인 실패: 주소 뒤에 err=1 이라는 신호를 붙임
			response.sendRedirect(request.getContextPath() + "/login?err=1");
		}
	}

}

