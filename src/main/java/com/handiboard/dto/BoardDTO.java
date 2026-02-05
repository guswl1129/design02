package com.handiboard.dto;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class BoardDTO {
	private int board_no, like_count;
	private String title, name, content, user_id;
	private String date;
}
