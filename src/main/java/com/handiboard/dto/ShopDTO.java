package com.handiboard.dto;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class ShopDTO {
	// shop_board 테이블 
	private int shop_no; // 판매 게시판 글 번호
	private String title;
	private String content;
	private int user_id;
	private String reg_date;

	// 외래키 및 Join 데이터 
	// item 테이블
	private int item_no;
	private String item_name;
	private int item_price; 
}