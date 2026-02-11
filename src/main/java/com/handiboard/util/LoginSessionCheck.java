package com.handiboard.util;


import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.UserDTO;

@WebFilter(
			filterName = "LoginSessionCheck",
	urlPatterns = { "/write","/update","/delete","/like" }
)
public class LoginSessionCheck extends HttpFilter implements Filter {
    
    public LoginSessionCheck() {
        super();
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		System.out.println("URI = " + ((HttpServletRequest) request).getRequestURI());
		System.out.println("Session = " + ((HttpServletRequest) request).getSession(false));


		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		HttpSession session=req.getSession(false);
		
		if(session!=null&&session.getAttribute("userId")!=null) {
			chain.doFilter(request, response);
		} else {
			session.setAttribute("message", "로그인이 필요합니다.");
			res.sendRedirect(req.getContextPath()+"/login.jsp");
			return;
		}
		// pass the request along the filter chain
		
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
