package com.handiboard.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.handiboard.dao.BoardDAO;
import com.handiboard.dto.BoardDTO;
import com.handiboard.util.PagingResult;
import com.handiboard.util.PagingVO;


@WebServlet("/board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데이터베이스에 물어서 데이터 가져오기->dao, dto
		// jsp에 출력->dispatcher
		BoardDAO dao=new BoardDAO();
		
		// 페이징
		int page=parseIntOrDefault(request.getParameter("page"), 1);
		int pageSize=parseIntOrDefault(request.getParameter("pageSize"), 10);
		// 페이징 객체 생성
		PagingVO pVO=new PagingVO(page,pageSize);
		// 페이지 단위 글 리스트 가져오기
		List<BoardDTO>pList=dao.getPageList(pVO.getLimit(),pVO.getOffset());
		int totalCount=dao.getAllCount();
		
		//데이터 첨부하기(board)
		request.setAttribute("list", pList);	//이름, 값
		
		// 페이징 결과 객체 생성
		PagingResult<BoardDTO> result=new PagingResult<BoardDTO>(pList, page, pageSize, totalCount, 5);	// 블록 크기 5
		request.setAttribute("pagingResult", result); 
		
		// 보냄
		RequestDispatcher rd=request.getRequestDispatcher("/mainBoard.jsp");
		rd.forward(request, response);
	}

	private int parseIntOrDefault(String parameter, int i) {
		try {
			return Integer.parseInt(parameter);
		} catch (Exception e) {
			return i;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
