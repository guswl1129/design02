package com.handiboard.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDTO {
	//주문 정보
	private int order_no; //주문고유번호
    private String buyer_id; //구매자 ID
    private int status; //주문상태(0: 장바구니, 1: 구매완료)
    //장바구니 담은 날짜 / 주문 일시
    private String order_date; 
    //판매글 정보
    private int shop_no;
    private String shop_title;
    //아이템 정보
    private int item_no;
    private String item_name;
    private int item_price;
    private String img_path;
    //판매자 정보
    private int seller_id;      // 판매자 고유 번호
    private String seller_name; // 판매자 이름 또는 아이디
}
