package com.handiboard.util;

import com.handiboard.dao.BoardDAO;

public class PagingVO {

	private final int page;
	private final int pageSize;
	
	public PagingVO(int page, int pageSize) {
		this.page = (page<=0)?1:page;
		this.pageSize = (pageSize<=0)?10:pageSize;
	}
	public int getPage() {
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	public int getOffset() {
		return (page-1)*pageSize;
	}
	public int getLimit() {
		return pageSize;
	}
}
