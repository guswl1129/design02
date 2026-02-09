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

@WebServlet("/myPostsController")
public class MyPostsController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MyPostsDAO dao = new MyPostsDAO();
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("userId");

        if (id == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<BoardDTO> list = dao.LoadPosts(id);

        System.out.println("세션 ID: " + id);
        System.out.println("불러온 글 수: " + list.size());

        request.setAttribute("myPosts", list);
        RequestDispatcher rd = request.getRequestDispatcher("/myPosts.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
