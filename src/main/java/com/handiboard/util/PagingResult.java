package com.handiboard.util;

import java.util.List;

public class PagingResult<T> {
	private final List<T> list;
	private final int page;
	private final int pageSize;
	private final int totalCount;
	private final int totalPages;
	private final int startPage;
	private final int endPage;
	private final boolean hasPrevious;
	private final boolean hasNext;
	
	public PagingResult(List<T> list, int page, int pageSize, int totalCount, int blockSize) {
		this.list = list;	//현재 페이지 리스트
		this.page = page;	//현재 페이지
		this.pageSize = pageSize;	//페이지당 글 개수
		this.totalCount = totalCount;	//전체 글 개수
		this.totalPages = (int)Math.ceil((double)totalCount/pageSize);	//전체 페이지 수
		int currentBlock=(int)Math.ceil((double)page/blockSize);	//현재 블록
		this.startPage = (currentBlock - 1) * blockSize + 1;	//	this.startPage = ((page-1)/pageSize)*pageSize + 1;/this.startPage = (currentBlock - 1) * blockSize + 1;	//블록 시작 페이지
		this.endPage = Math.min(startPage + blockSize - 1, totalPages);	//this.endPage = Math.min(startPage + pageSize - 1, totalPages);/this.endPage = Math.min(startPage + blockSize - 1, totalPages);	//블록 끝 페이지
		this.hasPrevious = startPage > 1;
		this.hasNext = endPage < totalPages;
	}
	
	public List<T> getList() {
		return list;
	}
	public int getPage() {
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public boolean isHasPrevious() {
		return hasPrevious;
	}
	public boolean isHasNext() {
		return hasNext;
	}
}
