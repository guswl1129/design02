package com.handiboard.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class BoardDTO {
	private int board_no, view_count, like_count, board_del;
	private String title, name, content, user_id;
	private String date,updated_date;
	private String user_nickname;


	//상대적 시간을 반환하는 메서드 추가
	public String getRelativeDate() {
	    if (this.date == null) return "";
	
	    try {
	        // 1. String을 LocalDateTime으로 변환 (DB 날짜 형식에 맞춰 포맷 지정)
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        LocalDateTime postTime = LocalDateTime.parse(this.date, formatter);
	        LocalDateTime now = LocalDateTime.now();
	
	        // 2. 시간 차이 계산
	        long seconds = ChronoUnit.SECONDS.between(postTime, now);
	        long minutes = ChronoUnit.MINUTES.between(postTime, now);
	        long hours = ChronoUnit.HOURS.between(postTime, now);
	        long days = ChronoUnit.DAYS.between(postTime, now);
	
	        // 3. 조건별 문구 반환
	        if (seconds < 60) return "방금 전";
	        if (minutes < 60) return minutes + "분 전";
	        if (hours < 24) return hours + "시간 전";
	        if (days < 7) return days + "일 전";
	        
	        // 7일 이상은 원래 날짜의 앞부분(yyyy-MM-dd)만 표시
	        return this.date.substring(0, 10);
	        
	    } catch (Exception e) {
	        return this.date; // 변환 실패 시 원본 문자열 반환
	    }
	}
}